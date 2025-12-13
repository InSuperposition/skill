# Reflog & Recovery - Expert Crisis Management

## Overview

The reflog (reference log) is git's safety net - a chronological record of where HEAD and branch references have pointed. It's your lifeline for recovering from mistakes.

**Key Insight**: Nearly every "lost" commit can be recovered from the reflog if you act within the retention window (default: 90 days).

## What is Reflog?

The reflog records every time HEAD moves:

- Commits
- Checkouts
- Rebases
- Resets
- Merges
- Cherry-picks
- Any operation that changes HEAD

Each entry includes:

- Commit hash
- Previous position
- Operation that caused the change
- Timestamp

## Viewing Reflog

### Basic Reflog

```bash
# Show reflog for current branch
git reflog

# Show reflog for specific branch
git reflog show feature/auth

# Show reflog for all references
git reflog show --all
```

**Output format**:

```text
abc1234 HEAD@{0}: commit: Add authentication feature
def5678 HEAD@{1}: rebase finished: returning to refs/heads/feature/auth
ghi9012 HEAD@{2}: rebase: Add login form
jkl3456 HEAD@{3}: rebase: checkout main
mno7890 HEAD@{4}: commit: WIP on login
```

### Detailed Reflog

```bash
# Show full commit hashes
git reflog --no-abbrev

# Show reflog with relative dates
git reflog --relative-date

# Show reflog with detailed info
git reflog show --pretty=fuller

# Show only last N entries
git reflog -10
```

### Search Reflog

```bash
# Find entries matching pattern
git reflog --grep="rebase"

# Find entries for specific file
git log --all --full-history --oneline -- path/to/file

# Find dangling commits
git fsck --lost-found
```

## Common Recovery Scenarios

### Scenario 1: Undo `git reset --hard`

**Problem**: Accidentally ran `git reset --hard HEAD~3` and lost work

**Solution**:

```bash
# 1. View reflog to find lost commits
git reflog

# Output shows:
# abc1234 HEAD@{0}: reset: moving to HEAD~3
# def5678 HEAD@{1}: commit: Important work (LOST)
# ghi9012 HEAD@{2}: commit: More work (LOST)
# jkl3456 HEAD@{3}: commit: Previous work (LOST)

# 2. Reset to the commit before the reset
git reset --hard HEAD@{1}
# Or use the hash:
git reset --hard def5678

# 3. Verify recovery
git log --oneline -3
```

**Prevention**: Always create backup branch before reset:

```bash
git branch backup-before-reset
git reset --hard HEAD~3
```

### Scenario 2: Recover Deleted Branch

**Problem**: Accidentally deleted a branch with `git branch -D feature/auth`

**Solution**:

```bash
# 1. Find the branch in reflog
git reflog show --all | grep "feature/auth"

# Or search for branch deletion
git reflog | grep "checkout: moving from feature/auth"

# Output:
# abc1234 HEAD@{5}: checkout: moving from feature/auth to main

# 2. Recreate the branch at that commit
git branch feature/auth abc1234

# Or use HEAD@{N} directly
git branch feature/auth HEAD@{5}

# 3. Verify recovery
git log feature/auth --oneline -3
```

### Scenario 3: Recover from Bad Rebase

**Problem**: Rebase went wrong, conflicts were resolved incorrectly

**Solution**:

```bash
# 1. Find the state before rebase
git reflog

# Output:
# abc1234 HEAD@{0}: rebase finished: returning to refs/heads/feature/auth
# def5678 HEAD@{1}: rebase: commit message 1
# ...
# xyz9999 HEAD@{10}: rebase: checkout main
# pre1234 HEAD@{11}: commit: Last commit before rebase (TARGET)

# 2. Reset to before rebase started
git reset --hard HEAD@{11}
# Or:
git reset --hard pre1234

# 3. Optionally create backup of bad rebase
git branch backup-bad-rebase HEAD@{0}
```

**Alternative - During rebase**:

```bash
# If you notice problems during rebase
git rebase --abort
```

### Scenario 4: Recover Commit After Amend

**Problem**: Amended a commit and lost the original version

**Solution**:

```bash
# 1. Find the commit before amend
git reflog

# Output:
# abc1234 HEAD@{0}: commit (amend): Updated commit message
# def5678 HEAD@{1}: commit: Original commit message (LOST)

# 2. View the original commit
git show HEAD@{1}

# 3. Create branch at original commit (if needed)
git branch recover-original HEAD@{1}

# 4. Or cherry-pick specific changes
git cherry-pick HEAD@{1}
```

### Scenario 5: Recover Stashed Work

**Problem**: Accidentally dropped a stash

**Solution**:

```bash
# 1. Find dropped stash in reflog
git reflog show stash

# Or search all reflog
git fsck --unreachable | grep commit | cut -d ' ' -f3 | xargs git log --oneline --no-walk

# 2. Once found, apply the stash
git stash apply <hash>

# Or create a branch from it
git branch recover-stash <hash>
```

### Scenario 6: Recover After `git clean -fdx`

**Problem**: Ran `git clean -fdx` and removed important untracked files

**Bad News**: Untracked files are NOT in git's history and CANNOT be recovered from reflog

**Lesson**: Always dry-run first:

```bash
git clean -fdx --dry-run  # See what would be deleted
git clean -fdn            # Same, shorter
```

**Possible Recovery**:

- File system backups (Time Machine, Windows Shadow Copies)
- IDE local history
- Recently opened files in editor

### Scenario 7: Recover Rebased Commits on Published Branch

**Problem**: Rebased a published branch, team members are affected

**Solution 1 - You haven't pushed yet**:

```bash
# Reset to before rebase
git reflog
git reset --hard HEAD@{before-rebase}
```

**Solution 2 - Already pushed (affects team)**:

```bash
# 1. Find state before rebase
git reflog
original_commit=$(git rev-parse HEAD@{before-rebase})

# 2. Force push back to original (TEAM COORDINATION REQUIRED!)
git push --force origin feature/auth $original_commit:feature/auth

# 3. Notify team to reset their local branches
```

**Better Solution - Revert the rebase**:

```bash
# Create revert commits instead of force push
git revert --no-commit HEAD~N..HEAD
git commit -m "Revert rebased commits"
git push origin feature/auth
```

## Advanced Reflog Techniques

### Reflog for Specific Operations

```bash
# Find all rebase operations
git reflog | grep rebase

# Find all merge operations
git reflog | grep merge

# Find all reset operations
git reflog | grep reset

# Find when you were on a specific branch
git reflog | grep "checkout: moving.*to feature/auth"
```

### Date-Based Recovery

```bash
# Show commits from 2 days ago
git reflog show HEAD@{2.days.ago}

# Show commits from yesterday
git reflog show HEAD@{yesterday}

# Show commits from specific date
git reflog show HEAD@{2025-12-01}

# Show commits from specific time
git reflog show HEAD@{2025-12-09.14:30:00}
```

### Reflog with Patches

```bash
# Show reflog with diffs
git reflog -p

# Show reflog with stat
git reflog --stat

# Show reflog with specific file
git reflog --all -- path/to/file
```

### Cross-Branch Recovery

```bash
# Find a commit that was on any branch
git reflog --all --grep="commit message"

# See where all branches have been
git reflog show --all

# Find commits that are now unreachable
git fsck --lost-found
```

## Reflog Retention Policies

### Default Retention

```bash
# Reachable commits: 90 days (default)
git config gc.reflogExpire 90

# Unreachable commits: 30 days (default)
git config gc.reflogExpireUnreachable 30
```

### Extend Retention

```bash
# Keep reflog entries longer
git config --global gc.reflogExpire 180
git config --global gc.reflogExpireUnreachable 60

# Never expire reflog (not recommended - wastes space)
git config --global gc.reflogExpire never
```

### Manual Reflog Management

```bash
# Expire old reflog entries now
git reflog expire --expire=30.days.ago --all

# Expire unreachable entries
git reflog expire --expire-unreachable=now --all

# Run garbage collection
git gc --prune=now
```

**Warning**: Don't expire reflog aggressively - it's your safety net!

## Prevention Strategies

### Always Create Backups

Before risky operations:

```bash
# Create backup branch
git branch backup/feature-auth-$(date +%Y%m%d)

# Create backup tag
git tag backup-$(date +%Y%m%d-%H%M%S)
```

### Use Dry-Run

```bash
# Test clean operation
git clean -fd --dry-run

# Test filter-branch
git filter-branch --tree-filter '...' --dry-run

# Test rebase
git rebase --interactive --dry-run main  # Not a real flag - use branch backup instead
```

### Enable Auto-Stash

```bash
# Automatically stash before rebase
git config --global rebase.autoStash true
```

### Use --force-with-lease

```bash
# Safer force push
git push --force-with-lease origin feature/auth
```

## Reflog in Worker Mode

Worker Mode provides guided recovery:

```text
User: "I accidentally reset hard and lost my commits"

Worker Mode:
*Analyzing reflog*:
git reflog --no-abbrev -20

Found recent reset operation:
  HEAD@{0}: reset: moving to HEAD~3 (2 minutes ago)
  HEAD@{1}: commit: Add authentication (LOST)
  HEAD@{2}: commit: Add login form (LOST)
  HEAD@{3}: commit: Update dependencies (LOST)

Lost commits:
  - abc1234: Add authentication
  - def5678: Add login form
  - ghi9012: Update dependencies

*Recovery options*:

1. Reset to before the hard reset (recommended):
   git reset --hard HEAD@{1}
   (Recovers all 3 commits)

2. Cherry-pick specific commits:
   git cherry-pick abc1234
   (Recover individual commit)

3. Create branch at lost commit:
   git branch recovery HEAD@{1}
   (Inspect before recovering)

Which option would you prefer? [1-3]
```

## Emergency Recovery Checklist

When disaster strikes:

1. **DON'T PANIC** - Reflog likely has your commits
2. **DON'T RUN MORE COMMANDS** - Might overwrite reflog
3. **View reflog immediately**: `git reflog`
4. **Find your lost commits** - Look for operation that caused loss
5. **Create recovery branch**: `git branch recovery HEAD@{N}`
6. **Verify recovery**: `git log recovery`
7. **If recovered, integrate back**: Merge or cherry-pick
8. **If not recovered, check fsck**: `git fsck --lost-found`

## Limitations

Reflog CANNOT recover:

- **Untracked files** (never added to git)
- **Unstaged changes** (not committed)
- **Stashes older than reflog retention** (expired)
- **Commits older than reflog expiry** (default: 90 days)
- **Repository deleted entirely** (no .git directory)

## See Also

- [SAFETY.md](SAFETY.md) - Prevention is better than cure
- [WORKER.md](WORKER.md) - Automated recovery guidance
- [REBASE.md](REBASE.md) - Safe rebase practices
- Official docs: `submodules/git/git/Documentation/git-reflog.adoc`
