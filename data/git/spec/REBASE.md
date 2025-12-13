# Rebase Mastery - Clean History Maintenance

## Overview

Rebasing is the art of maintaining a clean, linear git history. When done safely, it makes projects easier to understand, review, and debug.

**Golden Rule**: Never rebase commits that have been pushed to shared branches.

## Rebase vs Merge vs Squash

### Rebase

**What**: Replay commits on top of another branch

```bash
git rebase main
```

**Result**:

```text
Before:
      C---D  feature
     /
A---B---E---F  main

After:
              C'--D'  feature
             /
A---B---E---F  main
```

**Benefits**:

- Linear history (easier to follow)
- Cleaner git log
- Easier to bisect
- No merge commits

**Trade-offs**:

- Rewrites history (dangerous if published)
- Can complicate conflict resolution
- Loses branch context

### Merge

**What**: Combine two branches with a merge commit

```bash
git merge feature
```

**Result**:

```text
      C---D  feature
     /     \
A---B---E---F---M  main
```

**Benefits**:

- Preserves complete history
- Shows branch structure
- Safe for published branches
- Clear feature boundaries

**Trade-offs**:

- Cluttered history with many branches
- Harder to follow linear development
- Merge commits can accumulate

### Squash Merge

**What**: Combine all commits into one when merging

```bash
git merge --squash feature
git commit -m "Add feature"
```

**Result**:

```text
      C---D  feature (remains separate)
     /
A---B---E---F---S  main
              (S = squashed C+D)
```

**Benefits**:

- Single commit on main branch
- Clean main history
- Easy to revert entire feature

**Trade-offs**:

- Loses individual commit history
- Hard to review what changed when
- Feature branch becomes stale

## When to Use Each

### Use Rebase When

- Integrating feature branch with updated main (before merging)
- Cleaning up local commit history
- Working on unpublished branches
- You want linear history

```bash
# Update feature branch with latest main
git checkout feature/auth
git rebase main
```

### Use Merge When

- Integrating feature into main/master
- Branch has been published/shared
- You want to preserve branch structure
- Working with team members on same branch

```bash
# Integrate feature into main
git checkout main
git merge feature/auth
```

### Use Squash Merge When

- Feature has messy commit history
- Want single commit on main
- Feature commits are WIP/fixups
- Main branch should be very clean

```bash
# Squash merge feature
git checkout main
git merge --squash feature/auth
git commit -m "Add authentication feature

Includes:
- Login form
- Session management
- Password hashing
"
```

## Interactive Rebase

The most powerful rebase feature - edit commit history interactively.

### Basic Interactive Rebase

```bash
# Rebase last 5 commits
git rebase -i HEAD~5

# Rebase since divergence from main
git rebase -i main
```

**Editor opens**:

```text
pick abc1234 Add login form
pick def5678 Fix typo
pick ghi9012 Add password validation
pick jkl3456 Update dependencies
pick mno7890 Fix linting

# Commands:
# p, pick = use commit
# r, reword = use commit, but edit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like squash, but discard commit message
# d, drop = remove commit
```

### Interactive Rebase Commands

#### Pick (p)

Use commit as-is:

```text
pick abc1234 Add login form
```

#### Reword (r)

Change commit message:

```text
reword abc1234 Add login form
```

Git will pause to let you edit the message.

#### Edit (e)

Stop to make changes:

```text
edit abc1234 Add login form
```

**Workflow**:

```bash
# Git pauses here
# Make changes
git add changed-file
git commit --amend
git rebase --continue
```

#### Squash (s)

Combine with previous commit, edit combined message:

```text
pick abc1234 Add login form
squash def5678 Fix typo
```

**Result**: One commit with combined message.

#### Fixup (f)

Combine with previous commit, discard this message:

```text
pick abc1234 Add login form
fixup def5678 Fix typo
```

**Result**: One commit with first commit's message.

#### Drop (d)

Remove commit entirely:

```text
drop abc1234 Add login form
```

Or just delete the line.

### Reordering Commits

Change order by reordering lines:

```text
Before:
pick abc1234 Add login form
pick def5678 Add password validation
pick ghi9012 Update dependencies

After:
pick ghi9012 Update dependencies
pick abc1234 Add login form
pick def5678 Add password validation
```

**Warning**: Can cause conflicts if commits depend on each other.

## Autosquash Workflow

Automatically fixup commits during rebase.

### Setup

```bash
# Enable autosquash
git config --global rebase.autoSquash true
```

### Creating Fixup Commits

```bash
# Make a change that fixes commit abc1234
git add fixed-file
git commit --fixup=abc1234

# Or use HEAD~N
git commit --fixup=HEAD~3
```

**Commit message**: `fixup! Original commit message`

### Rebasing with Autosquash

```bash
# Autosquash automatically enabled
git rebase -i main

# Or explicitly
git rebase -i --autosquash main
```

**Result**: Fixup commits automatically moved and marked:

```text
pick abc1234 Original commit message
fixup def5678 fixup! Original commit message
```

### Amend Commits

Similar to fixup, but lets you edit:

```bash
git commit --squash=abc1234
```

## Safety-First Rebase

### Pre-Rebase Checklist

1. **Create backup branch**:

   ```bash
   git branch backup/feature-auth-before-rebase
   ```

2. **Ensure working directory is clean**:

   ```bash
   git status
   # or enable auto-stash
   git config rebase.autoStash true
   ```

3. **Verify branch hasn't been published**:

   ```bash
   git branch -r --contains HEAD
   # Should not show origin/feature-auth
   ```

4. **Fetch latest remote**:

   ```bash
   git fetch origin
   ```

### During Rebase

#### Handling Conflicts

```bash
# Conflict occurs
git status  # See conflicting files

# Resolve conflicts manually
vim conflicting-file

# Mark as resolved
git add conflicting-file

# Continue rebase
git rebase --continue

# Or skip this commit
git rebase --skip

# Or abort entirely
git rebase --abort
```

#### Checking Progress

```bash
# See current rebase status
cat .git/rebase-merge/git-rebase-todo

# See which commit is being applied
git log -1 REBASE_HEAD
```

### Post-Rebase Verification

```bash
# Verify history looks correct
git log --oneline --graph

# Compare with backup
git diff backup/feature-auth-before-rebase

# Run tests
make test

# If problems found
git reset --hard backup/feature-auth-before-rebase
```

## Advanced Rebase Techniques

### Rebase onto Different Base

```bash
# Rebase feature onto develop instead of main
git rebase --onto develop main feature
```

**Diagram**:

```text
Before:
    E---F  feature
   /
  C---D  main
 /
A---B---G  develop

After (git rebase --onto develop main feature):
        E'--F'  feature
       /
A---B---G  develop
```

### Rebase with Exec

Run command after each commit:

```bash
git rebase -i --exec "make test" main
```

**Use case**: Ensure each commit passes tests.

### Rebase and Preserve Merges

```bash
# Old way (deprecated)
git rebase -i --preserve-merges main

# New way
git rebase -i --rebase-merges main
```

**Warning**: Complex - prefer avoiding merges in feature branches.

## Common Rebase Pitfalls

### Pitfall 1: Rebasing Published Commits

**Problem**: Rebased branch that others have pulled

**Consequence**: Team members' branches diverge

**Solution**: Don't do it! Or coordinate with team:

```bash
# If you must, use --force-with-lease
git push --force-with-lease origin feature/auth

# Team members must reset:
git fetch origin
git reset --hard origin/feature/auth
```

### Pitfall 2: Complex Conflict Resolution

**Problem**: Too many conflicts during rebase

**Solution**:

```bash
# Abort and use merge instead
git rebase --abort
git merge main

# Or rebase in smaller chunks
git rebase HEAD~10    # Rebase last 10 commits
# Fix conflicts
git rebase main       # Then rebase onto main
```

### Pitfall 3: Losing Work

**Problem**: Made mistakes during interactive rebase

**Solution**:

```bash
# Find old state in reflog
git reflog

# Reset to before rebase
git reset --hard HEAD@{before-rebase}
```

**Prevention**: Always create backup branch first!

### Pitfall 4: Duplicate Commits

**Problem**: Commits appear twice after rebase

**Cause**: Rebased already-merged commits

**Solution**:

```bash
# Use merge instead for this scenario
git merge main

# Or interactive rebase and drop duplicates
git rebase -i main
# Mark duplicates with 'drop'
```

## Rebase Workflows

### Workflow 1: Feature Branch Updates

Keep feature branch up to date with main:

```bash
# On feature branch
git fetch origin
git rebase origin/main

# If conflicts, resolve and:
git rebase --continue

# Force push to update remote feature branch
git push --force-with-lease origin feature/auth
```

### Workflow 2: Clean Up Before Merge

Polish commits before merging to main:

```bash
# Interactive rebase to clean up
git rebase -i main

# Squash WIP commits
# Reword unclear messages
# Drop debug commits

# Verify result
git log --oneline main..HEAD

# Merge to main
git checkout main
git merge feature/auth --no-ff
```

### Workflow 3: Split Large Commit

Break one commit into multiple:

```bash
# Interactive rebase
git rebase -i HEAD~1

# Mark commit for edit
edit abc1234 Large commit

# Reset but keep changes
git reset HEAD^

# Stage and commit in pieces
git add file1 file2
git commit -m "Part 1: Add feature X"

git add file3
git commit -m "Part 2: Update tests"

# Continue rebase
git rebase --continue
```

### Workflow 4: Sync with Upstream (Open Source)

Update fork with upstream changes:

```bash
# Add upstream remote
git remote add upstream https://github.com/original/repo.git

# Fetch upstream
git fetch upstream

# Rebase your work onto upstream
git rebase upstream/main

# Push to your fork
git push --force-with-lease origin main
```

## Rebase in Worker Mode

Worker Mode provides safe, guided rebasing:

```text
User: "Rebase feature/auth onto main"

Worker Mode:
*Pre-flight checks*:
- ✓ Current branch: feature/auth
- ✓ Working directory clean
- ⚠ Branch has been pushed to origin
- ✓ Target branch 'main' is up to date

*Warning*:
This branch has been published. Rebasing will rewrite history.
Team members will need to reset their local branches.

*Creating safety backup*:
git branch backup/feature-auth-rebase-2025-12-09

*Rebase summary*:
- Commits to rebase: 15
- Target: main (abc1234)
- Backup: backup/feature-auth-rebase-2025-12-09

Proceed with rebase? [y/N] y

*Executing*:
git rebase main

*Conflict detected*:
Conflicts in: src/auth.js

Please resolve conflicts, then:
  git add src/auth.js
  git rebase --continue

Or abort:
  git rebase --abort
```

## Best Practices

1. **Always create backup branch** before rebasing
2. **Never rebase published commits** without team coordination
3. **Keep commits atomic** - one logical change per commit
4. **Write good commit messages** - they'll be in history
5. **Test after rebase** - ensure nothing broke
6. **Use --force-with-lease** not --force for pushes
7. **Communicate with team** when rebasing shared branches

## See Also

- [REFLOG.md](REFLOG.md) - Recover from rebase mistakes
- [SAFETY.md](SAFETY.md) - Rebase safety protocols
- [WORKER.md](WORKER.md) - Automated safe rebasing
- Official docs: `submodules/git/git/Documentation/git-rebase.adoc`
