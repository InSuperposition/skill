# Git Worker Mode - Execution Mode

## Overview

Git Worker Mode is the **execution mode** of the git-skill. In this mode, the skill actively executes git commands with comprehensive safety checks, pre-flight validation, and automatic backups.

**Safety is the absolute top priority in Worker Mode.**

## When to Use Worker Mode

Use Worker Mode when you need:

- **Execution** of git commands with safety checks
- **Automated operations** with validation
- **Complex workflows** executed reliably
- **Safety nets** for risky operations
- **Verification** of results after execution

## Mode Activation

Worker Mode is activated by user/agent requests that indicate execution intent:

### Trigger Phrases

- "Create..."
- "Delete..."
- "Rebase..."
- "Merge..."
- "Clean up..."
- "Remove..."
- "Execute..."
- "Run..."
- "Perform..."

### Examples

- "Create a worktree for feature/auth"
- "Rebase this branch onto main"
- "Clean up merged branches"
- "Run a health check on this repository"

## Safety Levels

Worker Mode implements multi-level safety checks based on operation risk:

### Level 1: Safe Operations

**Risk**: Minimal - read-only or easily reversible

**Operations**:

- `git status`
- `git log`
- `git diff`
- `git branch --list`
- `git worktree list`
- `git remote -v`
- `git reflog`

**Safety Measures**:

- No confirmation required
- No pre-flight checks needed
- Immediate execution

### Level 2: Low-Risk Operations

**Risk**: Low - modifies working directory but not history

**Operations**:

- `git checkout` (existing branch)
- `git worktree add` (new worktree)
- `git stash`
- `git branch` (create new branch)
- `git fetch`

**Safety Measures**:

- Pre-flight check: verify repository state
- Auto-stash uncommitted changes if needed
- Single confirmation for batch operations
- Verify results after execution

**Example**:

```text
User: "Create a worktree for feature/auth"

Worker Mode:
*Pre-flight checks*:
- ✓ Repository is clean
- ✓ Branch feature/auth exists
- ✓ No conflicting worktree paths

*Executing*:
git worktree add ../feature-auth feature/auth

*Verification*:
✓ Worktree created successfully at: ../feature-auth
✓ Checked out to: feature/auth
```

### Level 3: Medium-Risk Operations

**Risk**: Medium - modifies local history or repository structure

**Operations**:

- `git commit`
- `git rebase` (local unpushed commits)
- `git merge`
- `git branch -d` (delete merged branch)
- `git worktree remove`
- `git clean -fd`

**Safety Measures**:

- Comprehensive pre-flight checks
- Protected branch detection
- Automatic backup (branch or stash)
- Explicit confirmation required
- Detailed result reporting

**Example**:

```text
User: "Rebase feature/auth onto main"

Worker Mode:
*Pre-flight checks*:
- ✓ Current branch: feature/auth
- ✓ No uncommitted changes
- ✓ Branch has not been pushed (safe to rebase)
- ✓ Target branch 'main' is up to date

*Creating safety backup*:
git branch backup/feature-auth-2025-12-09

*Confirm operation*:
About to rebase feature/auth onto main (15 commits)
Backup branch created: backup/feature-auth-2025-12-09
Proceed with rebase? [y/N]

*Executing* (after confirmation):
git rebase main

*Verification*:
✓ Rebase completed successfully
✓ 15 commits replayed
✓ No conflicts
✓ Backup available at: backup/feature-auth-2025-12-09
```

### Level 4: High-Risk Operations

**Risk**: High - modifies published history or irreversible changes

**Operations**:

- `git push --force`
- `git reset --hard`
- `git rebase` (published commits)
- `git branch -D` (force delete)
- `git clean -fdx`
- `git reflog expire`

**Safety Measures**:

- Multi-level confirmation required
- Detailed impact analysis
- Automatic backup creation
- Protected branch enforcement
- Clear warning messages
- Recovery instructions provided

**Example**:

```text
User: "Force push this branch"

Worker Mode:
*Pre-flight checks*:
- ✓ Current branch: feature/auth
- ⚠ Branch has been pushed to remote
- ⚠ This will rewrite published history

*Protected branch check*:
- ✓ Not a protected branch (main/master/develop)

*Impact analysis*:
- Remote commits that will be overwritten: 3
- Local commits to push: 5
- Other users may be affected if they pulled this branch

*Creating safety backup*:
git branch backup/feature-auth-force-push-2025-12-09

*Multi-level confirmation*:
⚠ WARNING: Force push will rewrite published history
⚠ Other team members working on this branch will need to reset
⚠ This operation cannot be easily undone on the remote

Are you absolutely sure you want to force push? Type 'force push' to confirm:

*Executing* (after explicit confirmation):
git push --force-with-lease origin feature/auth

*Verification*:
✓ Force push completed
✓ 5 commits pushed
✓ Backup available at: backup/feature-auth-force-push-2025-12-09

*Recovery instructions*:
If you need to undo this force push:
  git push --force origin backup/feature-auth-force-push-2025-12-09:feature/auth
```

### Level 5: Critical Operations

**Risk**: Critical - potential data loss or severe repository impact

**Operations**:

- `git push --force` to main/master
- `git reset --hard` on shared branches
- `git clean -fdx` with untracked important files
- `git gc --aggressive --prune=now`
- Submodule deinit with local changes

**Safety Measures**:

- Multiple explicit confirmations
- Team notification recommended
- Full repository backup suggested
- Recovery plan provided before execution
- Requires typing exact operation name
- Cannot be batch-executed

**Example**:

```text
User: "Force push to main"

Worker Mode:
*Pre-flight checks*:
- ⚠ Current branch: main
- ⚠ Branch is protected
- ⚠ This is a shared branch with multiple contributors

*Critical operation warning*:
🛑 CRITICAL: You are attempting to force push to 'main'
🛑 This will affect all team members
🛑 This may break CI/CD pipelines
🛑 This should only be done in emergency situations with team approval

*Required actions before proceeding*:
1. Notify all team members
2. Ensure no one else is pushing to main
3. Have a recovery plan
4. Consider alternatives (revert commits instead)

*Alternative recommendation*:
Instead of force pushing, consider:
  git revert <problematic-commits>
  git push origin main

Do you want to proceed with the safer alternative? [Y/n]

*If user insists on force push*:
Type the full branch name 'main' to confirm force push:

*After typing 'main'*:
Type 'I UNDERSTAND THE RISKS' to proceed:

*Executing* (only after both confirmations):
[Proceeds with extreme caution]
```

## Pre-Flight Checks

Before executing operations, Worker Mode performs comprehensive checks:

### Repository State Checks

1. **Working Directory Status**
   - Uncommitted changes detection
   - Untracked files detection
   - Merge/rebase in progress detection
   - Conflict detection

2. **Branch Status**
   - Current branch identification
   - Tracking branch status
   - Ahead/behind remote status
   - Protected branch detection

3. **Remote Status**
   - Remote connectivity check
   - Fetch status (up to date?)
   - Push/pull requirements

### Operation-Specific Checks

Different operations require different pre-flight checks:

**For Rebase**:

- Uncommitted changes (will auto-stash if configured)
- Branch has not been pushed (or explicit override)
- Target branch exists and is up to date
- No ongoing rebase/merge

**For Force Push**:

- Branch protection status
- Remote existence
- Impact analysis (commits to be overwritten)
- Team notification requirements

**For Branch Deletion**:

- Branch merge status
- Unmerged commits detection
- Remote branch existence
- Backup creation

**For Worktree Operations**:

- Path conflicts
- Branch availability
- Submodule status
- Disk space (for new worktrees)

## Automatic Backups

Worker Mode automatically creates backups for risky operations:

### Backup Types

1. **Branch Backups**

   ```bash
   git branch backup/<original-branch>-<operation>-<date>
   ```

   Created before:
   - Rebase operations
   - Reset operations
   - Force operations

2. **Stash Backups**

   ```bash
   git stash push -m "Auto-backup before <operation>"
   ```

   Created before:
   - Checkout with uncommitted changes
   - Rebase with auto-stash
   - Clean operations

3. **Tag Backups**

   ```bash
   git tag backup/<operation>-<date>
   ```

   Created before:
   - Major history rewrites
   - Submodule operations
   - Repository cleanup

### Backup Retention

- Backups are **never automatically deleted**
- User/agent can manually clean up backups
- Backup branches clearly named with date and operation
- Recovery instructions always provided

## Execution Workflow

### Standard Execution Flow

1. **Parse Request**
   - Identify operation type
   - Extract parameters
   - Determine safety level

2. **Pre-Flight Checks**
   - Run all relevant checks
   - Report any issues
   - Abort if critical issues found

3. **Safety Backup**
   - Create appropriate backup (if needed)
   - Verify backup creation

4. **Confirmation** (if required)
   - Present operation summary
   - Show impact analysis
   - Request explicit confirmation

5. **Execute Operation**
   - Run git command(s)
   - Monitor for errors
   - Handle conflicts/issues

6. **Verification**
   - Verify operation completed successfully
   - Check repository state
   - Report detailed results

7. **Recovery Information**
   - Provide undo instructions
   - Reference backup locations
   - Link to relevant documentation

### Error Handling

If an operation fails:

1. **Immediate Halt**
   - Stop execution immediately
   - Preserve current state

2. **Error Analysis**
   - Identify error type
   - Assess impact
   - Determine recovery path

3. **Auto-Recovery** (when safe)
   - Restore from backup
   - Reset to safe state
   - Report actions taken

4. **User Guidance**
   - Explain what went wrong
   - Provide recovery options
   - Offer alternative approaches

**Example**:

```text
*Executing rebase*:
git rebase main

⚠ Rebase failed with conflicts in:
  - src/auth.js
  - src/config.js

*Auto-recovery*:
git rebase --abort
✓ Repository restored to pre-rebase state

*Recovery options*:
1. Resolve conflicts manually:
   git rebase main
   # Fix conflicts in src/auth.js and src/config.js
   git add <fixed-files>
   git rebase --continue

2. Use merge instead:
   git merge main

3. Restore from backup:
   git reset --hard backup/feature-auth-2025-12-09

Which approach would you prefer?
```

## Protected Branches

Worker Mode enforces protection for critical branches:

### Detection Methods

1. **Conventional Names**
   - main
   - master
   - develop
   - production
   - release/*
   - hotfix/*

2. **Remote Platform API** (when available)
   - GitHub protected branches
   - GitLab protected branches
   - Bitbucket branch restrictions

3. **User Configuration**
   - Custom protection rules
   - Project-specific settings

### Protection Levels

**Read-Only Operations**: Always allowed

**Standard Operations**: Allowed with confirmation

- Merges into protected branches
- Regular pushes

**Restricted Operations**: Require elevated confirmation

- Force pushes
- Direct commits
- Branch deletion

**Forbidden Operations**: Blocked entirely (unless override)

- Force push without --force-with-lease
- Rebase of published commits
- History rewrites

## Batch Operations

Worker Mode can execute multiple operations in sequence:

### Batch Execution Rules

1. **Safety First**
   - Each operation gets individual safety checks
   - Failure of one operation halts the batch
   - Rollback strategy for batch failures

2. **Confirmation Strategy**
   - Single confirmation for multiple low-risk operations
   - Individual confirmation for each high-risk operation
   - Batch summary before execution

3. **Progress Reporting**
   - Clear progress indicators
   - Success/failure for each step
   - Cumulative results

**Example**:

```text
User: "Clean up all merged branches"

Worker Mode:
*Analyzing branches*:
Found 12 merged branches:
  - feature/old-auth (merged 30 days ago)
  - feature/payment-flow (merged 15 days ago)
  - bugfix/login-issue (merged 7 days ago)
  [... 9 more]

*Safety checks*:
- ✓ All branches have been merged to main
- ✓ All branches have been pushed to remote
- ✓ Backups can be recovered from remote

*Batch operation summary*:
About to delete 12 local branches
Proceed? [y/N]

*Executing*:
[1/12] Deleting feature/old-auth... ✓
[2/12] Deleting feature/payment-flow... ✓
[3/12] Deleting bugfix/login-issue... ✓
...
[12/12] Deleting feature/xyz... ✓

*Results*:
✓ Successfully deleted 12 branches
✓ All branches still available on remote
✓ To recover: git checkout -b <branch-name> origin/<branch-name>
```

## Result Reporting

Worker Mode provides comprehensive result reporting:

### Success Reporting

- Operation summary
- Changes made
- Files affected
- Next steps (if any)
- Backup locations
- Recovery instructions

### Failure Reporting

- Error description
- Root cause (when identifiable)
- Repository state (safe/needs attention)
- Recovery options
- Alternative approaches

## Version Awareness

Worker Mode adapts to your git version:

- Uses version-appropriate commands
- Warns about unavailable features
- Suggests upgrades when beneficial
- Provides version-specific flags

**Example**:

```text
User: "Use --force-with-lease for push"

Worker Mode (git < 2.38.0):
⚠ Your git version (2.35.1) does not support --force-if-includes
⚠ This flag was introduced in git 2.30.0 and enhanced in 2.38.0
⚠ Consider upgrading for safer force-push operations

*Options*:
1. Upgrade git to use this enhanced safety feature
2. Use --force-with-lease (available, but less safe than --force-if-includes)
3. Cancel operation

Which option do you prefer?
```

## Transitioning to Guide Mode

If you need explanation instead of execution, Worker Mode will suggest switching:

> "Would you like me to explain this operation first? I can switch to Guide Mode."

## Optional: Git Notes for Operation Tracking

Worker Mode **can optionally** use git notes to track operations, but **ONLY with explicit user permission**.

### Permission Required

Git notes modify the repository (create commits in notes refs). Worker Mode **MUST**:

1. **Request permission** before using git notes:

   ```text
   Worker Mode: "Operation complete. Would you like me to record metadata
                about this operation in git notes? This will create a commit
                in refs/notes/ai-agent but won't affect your working directory
                or commit history."

   User: "Yes" or "No"
   ```

2. **Never assume permission** - each use requires approval or session-level opt-in

3. **Respect preferences**:
   - User says "no" → Skip notes entirely
   - User says "always for this session" → Remember for session
   - User says "never" → Disable notes feature completely

### What Gets Recorded (If Permitted)

When user approves notes tracking, Worker Mode can record:

```bash
# Example: After creating a worktree
git notes --ref=skill-git add -m '{
  "timestamp": "2025-12-11T10:30:00Z",
  "operation": "worktree-add",
  "safety_level": 2,
  "details": {
    "path": "../feature-auth",
    "branch": "feature/auth"
  },
  "user_approved": true
}' HEAD
```

### Benefits of Notes Tracking

- **Audit trail** of operations performed
- **Context preservation** across sessions
- **Decision tracking** for complex workflows
- **Quality metrics** and success rates
- **Non-intrusive** - doesn't modify commits or working directory

### When to Offer Notes

Only offer notes tracking for **significant operations**:

- ✅ Worktree creation/removal
- ✅ Rebases and merges
- ✅ Branch operations
- ✅ Complex multi-step workflows
- ❌ Simple read-only operations (status, log, diff)

See [NOTES.md](NOTES.md) for complete git notes documentation.

---

## Permission Model

**CRITICAL PRINCIPLE**: Worker Mode **NEVER** modifies the repository without explicit user permission.

### Operations Requiring Permission

**ALL** repository-modifying operations require permission:

- ✅ Creating/deleting branches
- ✅ Creating/removing worktrees
- ✅ Committing changes
- ✅ Rebasing/merging
- ✅ Pushing to remote
- ✅ **Adding/editing git notes**
- ✅ Any operation that changes .git/ contents

### Read-Only Operations (No Permission)

These operations don't require permission:

- ⚪ `git status`
- ⚪ `git log`
- ⚪ `git diff`
- ⚪ `git show`
- ⚪ `git branch --list`
- ⚪ `git notes show` (read-only)

### Permission Patterns

**Single operation**:

```text
Worker: "May I create a worktree at ../feature-auth?"
User: "Yes"
Worker: *creates worktree*
```

**Batch operation**:

```text
Worker: "May I delete these 12 merged branches?"
User: "Yes"
Worker: *deletes all branches with progress updates*
```

**Session-level**:

```text
Worker: "This workflow involves multiple operations. May I proceed with
         automatic execution for this session?"
User: "Yes, proceed automatically"
Worker: *executes all steps, reporting progress*
```

---

## See Also

- [GUIDE.md](GUIDE.md) - Advisory mode for explanations
- [SAFETY.md](SAFETY.md) - Detailed safety protocols
- [NOTES.md](NOTES.md) - Git notes for operation tracking
- [WORKTREES.md](WORKTREES.md) - Worktree operations
- [SUBMODULES.md](SUBMODULES.md) - Submodule operations
- [REFLOG.md](REFLOG.md) - Recovery procedures
- [REBASE.md](REBASE.md) - Rebase workflows
- [CONFIG.md](CONFIG.md) - Configuration settings
- [HEALTH.md](HEALTH.md) - Health checks
