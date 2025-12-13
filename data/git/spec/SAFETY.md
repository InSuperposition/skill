# Safety Protocols - Absolute Top Priority

## Overview

Safety is the **absolute top priority** in Worker Mode. This document defines comprehensive safety protocols for all git operations.

**Core Principle**: **No operation should risk data loss without explicit user consent and backup creation.**

## Safety Levels

Git operations are classified into five safety levels, each with escalating protections:

### Level 1: Safe (Read-Only)

**Risk**: None - operations don't modify repository

**Operations**:

- `git status`
- `git log`
- `git diff`
- `git show`
- `git branch --list`
- `git remote -v`
- `git reflog`
- `git worktree list`

**Protections**:

- None needed
- Execute immediately
- No confirmations required

### Level 2: Low-Risk (Local Modifications)

**Risk**: Minimal - modifies working directory but not history

**Operations**:

- `git checkout` (existing branch)
- `git switch`
- `git stash`
- `git branch` (create)
- `git fetch`
- `git worktree add`

**Protections**:

- Pre-flight check: Verify repository state
- Auto-stash uncommitted changes (if configured)
- Single confirmation for batch operations

### Level 3: Medium-Risk (Local History)

**Risk**: Medium - modifies local history or structure

**Operations**:

- `git commit`
- `git merge`
- `git rebase` (unpushed commits)
- `git branch -d` (merged branches)
- `git worktree remove`
- `git clean -fd`

**Protections**:

- Comprehensive pre-flight checks
- Protected branch detection
- Automatic backup creation
- Explicit confirmation required
- Detailed result reporting

### Level 4: High-Risk (Published History)

**Risk**: High - affects published commits or irreversible changes

**Operations**:

- `git push --force`
- `git reset --hard`
- `git rebase` (published commits)
- `git branch -D` (force delete)
- `git clean -fdx`

**Protections**:

- Multi-level confirmation required
- Impact analysis
- Automatic backup creation
- Protected branch enforcement
- Recovery instructions provided

### Level 5: Critical (Team Impact)

**Risk**: Critical - affects entire team or potential data loss

**Operations**:

- `git push --force` to main/master
- `git reset --hard` on shared branches
- `git reflog expire`
- `git gc --aggressive --prune=now`
- Submodule deinit with local changes

**Protections**:

- Multiple explicit confirmations
- Require typing exact operation name
- Team notification recommended
- Full recovery plan required
- Cannot be batch-executed

## Pre-Flight Checks

### Repository State Checks

Before any operation, verify repository state:

#### Working Directory Status

```bash
# Check for uncommitted changes
git status --porcelain

# Issues to detect:
# - Uncommitted changes (M, A, D flags)
# - Untracked files (? flag)
# - Merge/rebase in progress
# - Conflicts (U flag)
```

**Actions**:

- Level 1-2: Report but allow
- Level 3+: Auto-stash or require clean state

#### Branch Status

```bash
# Identify current branch
git rev-parse --abbrev-ref HEAD

# Check tracking status
git rev-parse --abbrev-ref --symbolic-full-name @{u}

# Check ahead/behind status
git rev-list --left-right --count HEAD...@{u}
```

**Actions**:

- Detect protected branches (main, master, develop, etc.)
- Warn if branch is behind remote
- Check for unpushed commits

#### Remote Status

```bash
# Verify remote connectivity
git ls-remote --heads origin

# Check fetch status
git fetch --dry-run

# Verify tracking branches exist
git branch -vv
```

**Actions**:

- Warn if remote unreachable
- Suggest fetch if out of date
- Detect diverged branches

### Operation-Specific Checks

#### Rebase Pre-Flight

> **For comprehensive rebase safety protocols, workflows, and best practices, see [REBASE.md](REBASE.md#L1)**

```bash
# 1. Check working directory is clean
test -z "$(git status --porcelain)" || echo "Uncommitted changes"

# 2. Verify branch hasn't been pushed
git branch -r --contains HEAD | grep -q origin && echo "Published commits"

# 3. Verify target branch exists
git rev-parse --verify target-branch

# 4. Check for ongoing rebase
test -d .git/rebase-merge && echo "Rebase in progress"
```

**Actions**:

- Auto-stash if configured and uncommitted changes exist
- Warn if rebasing published commits
- Abort if rebase already in progress
- Create backup branch before proceeding

#### Force Push Pre-Flight

```bash
# 1. Verify branch is not protected
is_protected_branch current-branch

# 2. Analyze impact
git rev-list origin/current-branch..HEAD --count  # New commits
git rev-list HEAD..origin/current-branch --count  # Commits to overwrite

# 3. Check for other users
git log --all --format='%an' | sort -u  # List all authors
```

**Actions**:

- Block if protected branch (unless override)
- Show commits that will be overwritten
- Warn if other users have contributed
- Require multi-level confirmation

#### Branch Deletion Pre-Flight

```bash
# 1. Check if branch is merged
git branch --merged main | grep -q target-branch

# 2. Check for unmerged commits
git log main..target-branch --oneline

# 3. Check if branch is pushed
git branch -r | grep -q origin/target-branch
```

**Actions**:

- Safe to delete if merged
- Warn if unmerged commits exist
- Suggest backup before force delete
- Check if remote branch should also be deleted

#### Clean Pre-Flight

```bash
# 1. List files to be removed
git clean -fd --dry-run

# 2. Check for important untracked files
# - .env files
# - *.log files
# - credentials files
# - build artifacts (may want to keep)
```

**Actions**:

- Show files that will be removed
- Warn about potentially important files
- Require explicit confirmation
- Suggest `git clean -n` for dry-run first

## Automatic Backups

### Backup Types

#### Branch Backups

**When**: Before destructive history operations

```bash
# Create timestamped backup branch
BACKUP_NAME="backup/$(git rev-parse --abbrev-ref HEAD)-$(date +%Y-%m-%d-%H%M%S)"
git branch "$BACKUP_NAME"
```

**Operations triggering branch backup**:

- Rebase
- Reset
- Force operations
- Branch deletion (if unmerged)

#### Stash Backups

**When**: Before operations that might conflict with local changes

```bash
# Create descriptive stash
git stash push -m "Auto-backup before rebase at $(date +%Y-%m-%d-%H%M%S)"
```

**Operations triggering stash backup**:

- Checkout with uncommitted changes
- Merge with uncommitted changes
- Rebase with auto-stash enabled

#### Tag Backups

**When**: Before major repository operations

```bash
# Create backup tag
TAG_NAME="backup-$(date +%Y-%m-%d-%H%M%S)"
git tag "$TAG_NAME"
```

**Operations triggering tag backup**:

- Repository cleanup (gc, prune)
- Submodule deinit
- Major refactoring operations

### Backup Verification

After creating backup, verify it exists:

```bash
# Verify branch backup
git rev-parse --verify "$BACKUP_NAME"

# Verify stash backup
git stash list | head -1

# Verify tag backup
git tag | grep "$TAG_NAME"
```

If verification fails, **abort operation**.

### Backup Retention

- Backups are **never automatically deleted**
- User can manually clean up old backups
- Suggest cleanup when disk space is low
- Document backup creation in operation output

## Protected Branches

### Detection Methods

#### Method 1: Conventional Names

Hardcoded list of common protected branches:

```bash
PROTECTED_BRANCHES=(
  "main"
  "master"
  "develop"
  "development"
  "production"
  "staging"
  "release/*"
  "hotfix/*"
)
```

#### Method 2: Platform API

Query hosting platform for protected branches:

**GitHub**:

```bash
gh api repos/:owner/:repo/branches --jq '.[] | select(.protected==true) | .name'
```

**GitLab**:

```bash
curl --header "PRIVATE-TOKEN: $TOKEN" \
  "https://gitlab.com/api/v4/projects/:id/protected_branches" | \
  jq -r '.[].name'
```

#### Method 3: User Configuration

Allow users to define protected branches:

```bash
# Global protection
git config --global skill.protected-branches "main,master,production"

# Per-repository protection
git config skill.protected-branches "main,develop,staging"
```

### Protection Levels

#### Read-Only Operations

Always allowed on protected branches:

- `git status`, `git log`, `git diff`
- `git fetch`
- `git branch --list`

#### Standard Operations

Allowed with confirmation:

- `git merge` into protected branch
- `git push` (regular, not force)
- `git commit` directly to protected branch (with warning)

#### Restricted Operations

Require elevated confirmation:

- `git push --force-with-lease`
- Direct commits to protected branch
- `git branch -d` (if protected branch)

#### Forbidden Operations

Blocked by default (require explicit override):

- `git push --force` (without --force-with-lease)
- `git reset --hard` on protected branch
- `git rebase` of published protected branch commits

### Override Mechanism

For emergency situations:

```bash
# Require explicit override flag
git-skill --override-protection push --force origin main

# With multi-level confirmation
```

## Confirmation Strategies

### Single Confirmation (Level 2-3)

Simple yes/no prompt:

```text
About to create worktree at ../feature-auth
Proceed? [y/N]
```

### Detailed Confirmation (Level 4)

Show impact and require explicit confirmation:

```text
⚠ WARNING: Force push will rewrite published history

Impact analysis:
- Commits to be overwritten: 3
- New commits to push: 5
- Other contributors affected: 2 (alice, bob)

Backup created: backup/feature-auth-2025-12-09-143022

Type 'force push' to confirm:
```

### Multi-Level Confirmation (Level 5)

Multiple explicit confirmations required:

```text
🛑 CRITICAL: You are attempting to force push to 'main'

This will affect the entire team and may break CI/CD.

Step 1: Verify this is necessary
Are you authorized to force push to main? [yes/NO]

Step 2: Confirm you understand the risks
Type the branch name 'main' to confirm:

Step 3: Final confirmation
Type 'I UNDERSTAND THE RISKS' to proceed:
```

### Batch Confirmation

For multiple operations:

```text
About to delete 12 merged branches:
  - feature/old-auth (merged 30 days ago)
  - feature/payment-flow (merged 15 days ago)
  [... 10 more]

All branches have been safely merged to main.

Proceed with batch deletion? [y/N]
```

## Error Handling

### Error Detection

Monitor command exit codes and output:

```bash
git rebase main
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  # Error occurred
  handle_error
fi
```

### Auto-Recovery

For recoverable errors, automatically restore safe state:

```text
⚠ Rebase failed with conflicts

*Auto-recovery*:
git rebase --abort
✓ Repository restored to pre-rebase state

*Next steps*:
1. Resolve conflicts manually
2. Use merge instead of rebase
3. Restore from backup: backup/feature-auth-2025-12-09
```

### Manual Recovery

For complex errors, provide clear recovery instructions:

```text
❌ Push failed: rejected (non-fast-forward)

*Diagnosis*:
Remote has commits you don't have locally.

*Recovery options*:

1. Pull and merge (safest):
   git pull origin main
   git push origin main

2. Pull and rebase (cleaner history):
   git pull --rebase origin main
   git push origin main

3. Force push (DANGEROUS - only if you're sure):
   git push --force-with-lease origin main

*Backup available*:
  Branch: backup/main-2025-12-09-143022

Which option do you prefer?
```

### Error Escalation

For critical errors:

1. Halt all operations immediately
2. Create emergency backup
3. Document error state
4. Provide detailed diagnostics
5. Offer expert assistance

## Recovery Instructions

Every risky operation includes recovery instructions:

### Undo Commit

```text
✓ Committed successfully: abc1234

*To undo this commit*:
  git reset --soft HEAD~1  (keep changes staged)
  git reset HEAD~1         (keep changes unstaged)
  git reset --hard HEAD~1  (discard changes)
```

### Undo Merge

```text
✓ Merged feature/auth into main

*To undo this merge*:
  git reset --hard ORIG_HEAD
  # Or use backup: backup/main-pre-merge
```

### Undo Rebase

```text
✓ Rebase completed successfully

*To undo this rebase*:
  git reset --hard backup/feature-auth-2025-12-09

*Or use reflog*:
  git reflog
  git reset --hard HEAD@{N}  (where N is before rebase)
```

### Undo Force Push

```text
✓ Force pushed to origin/feature-auth

*To undo this force push*:
  git push --force origin backup/feature-auth-2025-12-09:feature-auth

⚠ Warning: Others who pulled the force-pushed version will need to reset
```

## Conflict Prevention

### Lock Detection

Check for concurrent operations:

```bash
# Check for lock files
if [ -f .git/index.lock ]; then
  echo "Another git operation is in progress"
  exit 1
fi
```

### Remote Lock (if supported)

For critical branches, use remote locking:

```bash
# Lock branch during operation (platform-specific)
gh api repos/:owner/:repo/branches/:branch/protection \
  --method PUT --field required_status_checks=null
```

## Safety Configuration

### Recommended Safety Settings

```bash
# Prevent accidental commits to wrong branch
git config --global init.defaultBranch main

# Require explicit push destination
git config --global push.default simple

# Warn before pushing submodules
git config --global push.recurseSubmodules check

# Enable auto-stash for rebase
git config --global rebase.autoStash true

# Enable fsck during fetch
git config --global fetch.fsckObjects true

# Prune deleted remote branches
git config --global fetch.prune true
```

### Worker Mode Safety Defaults

```bash
# Enable all safety checks by default
git config --global skill.safety.pre-flight true
git config --global skill.safety.auto-backup true
git config --global skill.safety.protected-branches true

# Confirmation levels (1-5)
git config --global skill.safety.confirmation-level 3

# Protected branch patterns
git config --global skill.safety.protected "main,master,develop,production"
```

## Audit Trail

Log all operations for accountability:

```bash
# Log format
TIMESTAMP | OPERATION | USER | BRANCH | RESULT | BACKUP

# Example
2025-12-09 14:30:22 | rebase main | alice | feature/auth | success | backup/feature-auth-20251209-143022
```

### Log Location

```bash
.git/skill-audit.log  # Per-repository log
~/.config/git-skill/audit.log  # Global log (if configured)
```

## See Also

- [WORKER.md](WORKER.md) - Execution mode with safety levels
- [REFLOG.md](REFLOG.md) - Recovery from mistakes
- [HEALTH.md](HEALTH.md) - Proactive health checks
- [CONFIG.md](CONFIG.md) - Safety configuration settings
