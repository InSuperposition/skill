# Repository Health Monitoring

## Overview

Repository health checks ensure your git repository remains efficient, clean, and maintainable. Health checks run in the background during skill activation and surface critical issues only.

## Health Check Behavior

### Background Execution

During skill initialization:

- Health checks run **in the background**
- Don't block user operations
- Complete within seconds for most repositories
- Results cached for 24 hours

### Issue Reporting

- **Critical issues only** surfaced automatically
- **Full report** available on-demand
- **Actionable recommendations** provided
- **No overwhelming details** unless requested

### On-Demand Reports

```bash
User: "Run a health check on this repository"

# Full detailed report with all findings
```

## Health Check Categories

### 1. Repository Bloat

**What**: Large files and objects consuming excessive disk space

**Checks**:

```bash
# Find largest objects in repository
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  awk '/^blob/ {print substr($0,6)}' | \
  sort -nk2 | \
  tail -20

# Repository size
du -sh .git
```

**Critical indicators**:

- `.git` directory > 1GB (warning)
- Single files > 100MB (consider Git LFS)
- Binary files in history (can't be compressed well)

**Recommendations**:

```text
⚠ Large repository detected (.git: 2.3 GB)

Largest files:
  1. assets/video.mp4 (450 MB)
  2. build/app.exe (180 MB)
  3. data/dataset.csv (120 MB)

Recommendations:
  - Use Git LFS for large binary files
  - Add build/ to .gitignore
  - Use git filter-repo to remove large files from history
```

### 2. Branch Hygiene

**What**: Stale, merged, or abandoned branches cluttering repository

**Checks**:

```bash
# List merged branches
git branch --merged main | grep -v "^\* main"

# List remote branches that no longer exist
git remote prune origin --dry-run

# List branches with no commits in last N days
for branch in $(git branch | sed 's/^..//'); do
  last_commit=$(git log -1 --format=%ct $branch)
  now=$(date +%s)
  age=$(( ($now - $last_commit) / 86400 ))
  if [ $age -gt 90 ]; then
    echo "$branch: $age days old"
  fi
done
```

**Critical indicators**:

- > 50 merged branches not deleted
- > 20 branches with no activity in 90+ days
- Branches with names like `tmp`, `test`, `backup`

**Recommendations**:

```text
✓ Branch hygiene check:

Merged branches (safe to delete):
  - feature/old-auth (merged 60 days ago)
  - bugfix/login-error (merged 45 days ago)
  - feature/payment-v1 (merged 120 days ago)
  Total: 23 branches

Stale branches (no activity > 90 days):
  - experiment/new-ui (150 days inactive)
  - wip/refactor (200 days inactive)
  Total: 8 branches

Recommendations:
  - Delete merged branches: git branch -d <branch>
  - Review stale branches for archival
  - Run: git remote prune origin
```

### 3. Commit Quality

**What**: Commit message quality and patterns

**Checks**:

```bash
# Analyze commit messages
git log --pretty=format:"%s" --since="3 months ago" | \
  awk '{print length}' | \
  sort -n | \
  tail -1  # Longest message

git log --pretty=format:"%s" --since="3 months ago" | \
  grep -E "^(wip|WIP|fix|tmp)" | \
  wc -l  # Poor commit messages

# Large commits
git log --all --pretty=format:"%H" --since="3 months ago" | \
  while read commit; do
    files=$(git diff-tree --no-commit-id --numstat -r $commit | wc -l)
    if [ $files -gt 50 ]; then
      echo "$commit: $files files"
    fi
  done
```

**Critical indicators**:

- > 20% commits with poor messages (WIP, fix, tmp)
- Commits touching > 100 files regularly
- Very short commit messages (< 10 chars)

**Recommendations**:

```text
ℹ Commit quality analysis:

Recent commits (last 3 months):
  - Total commits: 234
  - Poor commit messages: 45 (19%)
    Examples: "wip", "fix", "tmp fix", "update"
  - Large commits (>50 files): 8
  - Average commit size: 12 files

Recommendations:
  - Use descriptive commit messages
  - Break large commits into smaller logical units
  - Consider commit message template
```

### 4. Remote Sync Status

**What**: Divergence between local and remote repositories

**Checks**:

```bash
# Fetch latest remote info
git fetch --all --quiet

# Check each branch
git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads/ | \
  while read local remote; do
    if [ -n "$remote" ]; then
      ahead=$(git rev-list --count $remote..$local)
      behind=$(git rev-list --count $local..$remote)
      if [ $ahead -ne 0 ] || [ $behind -ne 0 ]; then
        echo "$local: ahead $ahead, behind $behind"
      fi
    fi
  done

# Unpushed local branches
git branch -vv | grep -v "\[origin"
```

**Critical indicators**:

- Branches > 20 commits behind remote
- > 5 unpushed local branches
- Diverged branches (both ahead and behind)

**Recommendations**:

```text
⚠ Sync status warnings:

Branches behind remote:
  - main: 15 commits behind origin/main
  - develop: 8 commits behind origin/develop

Branches ahead of remote:
  - feature/auth: 5 commits ahead (unpushed work)

Unpushed local branches:
  - experiment/new-feature (no remote tracking)
  - tmp/debugging (no remote tracking)

Recommendations:
  - Pull latest changes: git pull origin main
  - Push unpushed work: git push origin feature/auth
  - Consider deleting tmp/ branches
```

### 5. Submodule Health

**What**: Submodule state and consistency

**Checks**:

```bash
# Check submodule status
git submodule status

# Detect detached HEAD in submodules
git submodule foreach 'git symbolic-ref -q HEAD || echo "Detached: $name"'

# Check for uncommitted changes in submodules
git submodule foreach --quiet 'test -n "$(git status --porcelain)" && echo "$name has uncommitted changes"'

# Check if submodule remotes are accessible
git submodule foreach 'git ls-remote --exit-code origin >/dev/null 2>&1 || echo "$name: remote unreachable"'
```

**Critical indicators**:

- Submodules with uncommitted changes
- Submodules in detached HEAD (if unexpected)
- Unreachable submodule remotes
- Submodule version mismatches across worktrees

**Recommendations**:

```text
ℹ Submodule health:

Submodules status:
  ✓ vendor/lib-a: clean, on main branch
  ⚠ vendor/lib-b: detached HEAD at abc123 (normal for pinned version)
  ⚠ plugins/plugin-x: uncommitted changes detected

Recommendations:
  - Commit changes in plugins/plugin-x
  - Document why vendor/lib-b is pinned to abc123
```

### 6. Worktree Health

**What**: Worktree state and cleanup opportunities

**Checks**:

```bash
# List all worktrees
git worktree list

# Detect stale worktrees
git worktree list --porcelain | \
  awk '/^worktree / {path=$2} /^branch / {branch=$2; print path, branch}'

# Check for unreferenced worktrees
git worktree prune --dry-run
```

**Critical indicators**:

- Worktrees with uncommitted changes
- Worktrees on merged branches (cleanup candidates)
- Missing worktree directories (need pruning)

**Recommendations**:

```text
ℹ Worktree health:

Active worktrees:
  - /path/to/main-repo (main) - active
  - /path/to/feature-auth (feature/auth) - 2 days old
  - /path/to/old-feature (feature/old) - 60 days old, merged ⚠

Recommendations:
  - Remove merged worktree: git worktree remove /path/to/old-feature
  - Prune stale references: git worktree prune
```

### 7. Configuration Health

**What**: Git configuration issues and missing best practices

**Checks**:

```bash
# Check for required safety settings
git config push.default
git config pull.rebase
git config fetch.prune

# Check user identity
git config user.name
git config user.email

# Platform-specific settings
uname=$(uname)
if [ "$uname" = "Darwin" ]; then
  git config credential.helper | grep -q osxkeychain || echo "Missing macOS credential helper"
fi
```

**Critical indicators**:

- Missing user.name or user.email
- No push.default configured
- Missing safety settings

**Recommendations**:

See [CONFIG.md](CONFIG.md) for detailed configuration recommendations.

### 8. Repository Corruption

**What**: Detect and prevent repository corruption

**Checks**:

```bash
# Run fsck (quick check)
git fsck --quick

# Check for pack file issues
git verify-pack -v .git/objects/pack/*.idx

# Check reflog integrity
git reflog expire --expire=now --all --dry-run
```

**Critical indicators**:

- Broken links in repository
- Corrupted pack files
- Missing objects

**Recommendations**:

```text
⚠ CRITICAL: Repository corruption detected

Errors:
  - missing blob abc1234
  - broken link from tree def5678

Immediate actions:
  1. Create backup: git clone --mirror . ../backup
  2. Attempt auto-repair: git fsck --full
  3. If unrecoverable, restore from backup
  4. Contact administrator if on shared repository
```

## Health Check Execution

### Background Check

Runs automatically when skill activates:

```text
*Running background health check...*

✓ Repository size: 234 MB (healthy)
✓ Branch hygiene: 3 merged branches (minor cleanup opportunity)
✓ Sync status: All branches up to date
✓ No critical issues detected

Full report: "Run a health check on this repository"
```

### Full On-Demand Check

```text
User: "Run a health check on this repository"

Worker Mode:
*Comprehensive health check*:

1. Repository Bloat: ✓ Healthy
   - .git size: 234 MB
   - Largest file: 15 MB (acceptable)

2. Branch Hygiene: ⚠ Attention needed
   - 12 merged branches (safe to delete)
   - 5 stale branches (>90 days inactive)

3. Commit Quality: ✓ Good
   - Average commit message length: 45 chars
   - Only 8% poor commit messages

4. Remote Sync: ✓ Synced
   - All tracked branches up to date
   - 2 unpushed local branches (expected)

5. Submodules: ✓ Healthy
   - All submodules initialized
   - No uncommitted changes

6. Worktrees: ℹ Info
   - 2 active worktrees
   - 1 cleanup candidate

7. Configuration: ⚠ Missing recommendations
   - Safety settings incomplete (see CONFIG.md)

8. Integrity: ✓ No corruption detected

Overall: 🟢 Repository is healthy with minor maintenance opportunities

Recommended actions:
  1. Delete merged branches (saves disk space)
  2. Review stale branches for archival
  3. Apply recommended safety configurations
```

## Automated Health Actions

### Safe Automatic Actions

Worker Mode can automatically fix safe issues:

```text
User: "Fix repository health issues"

Worker Mode:
*Analyzing safe automatic fixes*:

Safe to auto-fix:
  - Prune deleted remote branches (12 refs)
  - Remove merged local branches (5 branches)
  - Clean up stale worktree references (1 ref)

Apply automatic fixes? [y/N]

*Applying fixes*:
  git remote prune origin  ✓
  git branch -d feature/old-1 feature/old-2 ... ✓
  git worktree prune  ✓

*Results*:
  - Disk space freed: 45 MB
  - Branch count reduced: 23 → 18
  - Repository cleaner and more maintainable
```

### Manual Actions Required

Some issues require manual intervention:

```text
Manual actions required:

1. Large files in history:
   - Review: assets/video.mp4 (450 MB)
   - Consider Git LFS or removal from history

2. Uncommitted changes in submodules:
   - plugins/plugin-x has local modifications
   - Commit or discard changes

3. Configuration improvements:
   - Apply safety settings from CONFIG.md
```

## Health Monitoring Schedule

### Initial Check

On skill activation (background, non-blocking)

### Periodic Checks

- **Daily**: Quick check (if repository actively used)
- **Weekly**: Full check (all categories)
- **On-demand**: User-requested detailed analysis

### Trigger Events

Automatic health check after:

- Large operations (rebase, merge, cleanup)
- Submodule updates
- Worktree creation/removal
- Configuration changes

## Health Score

Overall repository health score (0-100):

```text
Repository Health Score: 85/100

Breakdown:
  - Bloat (20 points): 20/20 ✓
  - Branches (20 points): 15/20 ⚠
  - Commits (15 points): 15/15 ✓
  - Sync (15 points): 15/15 ✓
  - Config (15 points): 10/15 ⚠
  - Integrity (15 points): 15/15 ✓

Score interpretation:
  90-100: Excellent
  75-89: Good (minor improvements possible)
  60-74: Fair (attention recommended)
  < 60: Poor (action required)
```

## See Also

- [CONFIG.md](CONFIG.md) - Configuration recommendations for better health
- [SAFETY.md](SAFETY.md) - Safety checks prevent health issues
- [WORKER.md](WORKER.md) - Automated health fixes
- [ADVANCED.md](ADVANCED.md) - Advanced optimization techniques
