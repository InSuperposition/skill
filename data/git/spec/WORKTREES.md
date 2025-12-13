# Git Worktrees - Master-Level Expertise

## Overview

Git worktrees allow you to have **multiple working directories** attached to a single repository. This is one of the most powerful yet underutilized features in git.

**This skill uses worktrees itself** - the `version/` directory demonstrates worktree workflows in practice!

> **Note:** Worktrees were introduced in git v2.5.0 (July 2015). This skill requires git v2.5+ to function. When creating worktrees to reference older git versions for documentation purposes, the skill will check if those versions support the features being investigated.

## What Are Worktrees?

### Traditional Git Workflow

```text
my-repo/
├── .git/
├── src/
├── tests/
└── README.md

# To work on different branches:
git checkout feature-a    # Switch entire working directory
git checkout feature-b    # Switch again
git checkout main        # Switch back
```

**Problem**: You can only work on one branch at a time in a single directory.

### Worktree Workflow

```text
my-repo/              (main working directory - main branch)
├── .git/
├── src/
├── tests/
└── README.md

../feature-a/         (worktree - feature-a branch)
├── .git             (file pointing to my-repo/.git)
├── src/
├── tests/
└── README.md

../feature-b/         (worktree - feature-b branch)
├── .git
├── src/
├── tests/
└── README.md
```

**Benefit**: Work on multiple branches simultaneously without switching!

## Core Concepts

### Shared Repository

- All worktrees share the same `.git` directory
- All worktrees share the same refs (branches, tags, commits)
- All worktrees share the same object database
- Each worktree has its own working directory and index

### Linked Worktrees

- Main worktree: Original repository checkout
- Linked worktrees: Additional working directories
- Linked worktrees store metadata in `.git/worktrees/<name>/`

### Branch Rules

- Each worktree checks out a different branch (enforced by git)
- Cannot checkout the same branch in multiple worktrees simultaneously
- Detached HEAD is allowed in multiple worktrees

## Basic Operations

### Creating Worktrees

**Create worktree from existing branch**:

```bash
git worktree add ../feature-auth feature/auth
```

**Create worktree with new branch**:

```bash
git worktree add ../feature-new -b feature/new-feature
```

**Create worktree from remote branch**:

```bash
git worktree add ../hotfix origin/hotfix/urgent-fix
```

**Create worktree in detached HEAD**:

```bash
git worktree add ../review abc1234
```

### Listing Worktrees

```bash
# Basic list
git worktree list

# Detailed information
git worktree list --porcelain
```

### Removing Worktrees

**Safe removal** (worktree must be clean):

```bash
git worktree remove ../feature-auth
```

**Force removal** (discard changes):

```bash
git worktree remove --force ../feature-auth
```

**Remove deleted worktree reference**:

```bash
git worktree prune
```

### Moving Worktrees

```bash
# Move the directory
mv ../feature-auth ../renamed-feature

# Update git's records
git worktree repair ../renamed-feature
```

## Complete Workflow Patterns

### Pattern 1: Parallel Feature Development

**Use Case**: Work on multiple features simultaneously without context switching

```bash
# Setup
git worktree add ../feature-auth feature/auth
git worktree add ../feature-payments feature/payments

# Work in different terminals/IDEs
Terminal 1: cd ../feature-auth && code .
Terminal 2: cd ../feature-payments && code .

# Cleanup
git worktree remove ../feature-auth
git worktree remove ../feature-payments
```

**Benefits**:

- No stashing required when switching contexts
- Run tests in one worktree while coding in another
- Different IDE/editor state for each feature
- Compare implementations side-by-side

### Pattern 2: Hotfix Workflow

**Use Case**: Emergency fix needed while working on feature

```bash
# Currently working on feature branch
# Emergency issue reported!

# Create hotfix worktree
git worktree add ../hotfix -b hotfix/urgent-fix main

# Work on hotfix in separate directory
cd ../hotfix
# Fix the issue, test, commit

# Push hotfix
git push origin hotfix/urgent-fix

# Return to feature work (unchanged!)
cd ../my-repo

# Cleanup after hotfix merged
git worktree remove ../hotfix
```

**Benefits**:

- Feature work remains untouched
- No stashing or committing incomplete work
- Hotfix gets full attention in clean environment
- Easy context switch back to feature

### Pattern 3: Code Review Workflow

**Use Case**: Review pull requests without affecting your current work

```bash
# Create review worktree from PR branch
git fetch origin pull/123/head:pr-123
git worktree add ../review-pr-123 pr-123

# Review in separate environment
cd ../review-pr-123
# Test, explore, leave comments

# Cleanup after review
cd -
git worktree remove ../review-pr-123
git branch -d pr-123
```

**Benefits**:

- Review code in isolation
- Run tests without affecting your work
- Make experimental changes safely
- Easy comparison with your current work

### Pattern 4: CI/Testing Workflow

**Use Case**: Run tests in clean environment while continuing development

```bash
# Create test worktree
git worktree add ../test-env main

# Run tests in background
cd ../test-env
make test &

# Continue development
cd ../my-repo
# Keep working while tests run

# Check results
cd ../test-env
# Review test output

# Cleanup
cd ../my-repo
git worktree remove ../test-env
```

**Benefits**:

- Tests run in isolated environment
- Development continues uninterrupted
- Reproducible test conditions
- Multiple test configurations possible

### Pattern 5: Multi-Version Support

**Use Case**: Maintain multiple release versions simultaneously

```bash
# Current development
my-repo/          (main branch - v2.0 development)

# Support branches
../v1.9-support/  (v1.9.x maintenance)
../v1.8-support/  (v1.8.x security fixes)

# Create support worktrees
git worktree add ../v1.9-support release/v1.9
git worktree add ../v1.8-support release/v1.8

# Apply security fix to all versions
cd ../v1.8-support
# Apply fix, test, commit, push

cd ../v1.9-support
# Apply fix, test, commit, push

cd ../my-repo
# Merge fix into main if applicable
```

**Benefits**:

- Simultaneous multi-version maintenance
- Easy cherry-picking between versions
- Separate build artifacts per version
- Clear version isolation

## Advanced Workflows

### Worktrees with Sparse Checkout

**Use Case**: Large repository - only checkout needed files in worktree

```bash
# Create worktree with sparse checkout
git worktree add --no-checkout ../sparse-feature feature/big-repo-work
cd ../sparse-feature

# Enable sparse checkout
git sparse-checkout init --cone

# Specify directories to include
git sparse-checkout set src/auth tests/auth

# Checkout with only specified paths
git checkout feature/big-repo-work
```

**Benefits**:

- Faster worktree creation for large repos
- Reduced disk usage
- Focused development environment
- Each worktree can have different sparse patterns

### Worktrees with Different Sparse Patterns

```bash
# Main repo: Full checkout
my-repo/

# Frontend worktree: Only frontend code
git worktree add --no-checkout ../frontend-work feature/ui
cd ../frontend-work
git sparse-checkout set src/frontend tests/frontend
git checkout feature/ui

# Backend worktree: Only backend code
git worktree add --no-checkout ../backend-work feature/api
cd ../backend-work
git sparse-checkout set src/backend tests/backend
git checkout feature/api
```

### Worktrees for Bisect Operations

**Use Case**: Find regression while continuing development

```bash
# Start bisect in dedicated worktree
git worktree add ../bisect-session main
cd ../bisect-session

git bisect start
git bisect bad HEAD
git bisect good v1.0.0

# Git will checkout commits to test
# Test each commit
git bisect good  # or bad

# Continue until regression found
# Meanwhile, main worktree remains on your feature branch

# Cleanup
cd ../my-repo
git worktree remove ../bisect-session
```

## Worktrees + Submodules

### Challenge: Submodule State Divergence

**Problem**: Worktrees share the same repository, but submodules are **per-worktree**.

```bash
my-repo/
├── .git/
├── submodule-a/      # Checked out to commit abc123
└── README.md

../feature-worktree/
├── .git -> ../my-repo/.git
├── submodule-a/      # Might be at different commit def456!
└── README.md
```

### Solution 1: Initialize Submodules in Each Worktree

```bash
# Create worktree
git worktree add ../feature-auth feature/auth

# Initialize submodules in new worktree
cd ../feature-auth
git submodule update --init --recursive
```

### Solution 2: Automatic Submodule Handling (Worker Mode)

When Worker Mode creates worktrees with submodules:

```text
*Creating worktree*:
git worktree add ../feature-auth feature/auth

*Detecting submodules*:
Found 2 submodules in this repository

*Initializing submodules*:
cd ../feature-auth
git submodule update --init --recursive

✓ Worktree created with submodules initialized
⚠ Remember: Submodule state is per-worktree
```

### Solution 3: Shared Submodule Checkouts (Advanced)

**Warning**: Experimental - not officially supported

```bash
# Use --reference to share submodule objects
git -C submodule-a worktree add ../../feature-worktree/submodule-a <commit>
```

**Not recommended** - can lead to complex state issues.

### Submodule Best Practices with Worktrees

1. **Always initialize submodules** after creating worktree
2. **Be aware** each worktree can have different submodule commits
3. **Update submodules** independently in each worktree
4. **Document** expected submodule state for each branch
5. **Use automation** (Worker Mode) to handle submodule init

## Common Pitfalls & Solutions

### Pitfall 1: Forgetting to Remove Worktrees

**Problem**: Worktrees accumulate, waste disk space

**Solution**:

```bash
# List all worktrees
git worktree list

# Find stale worktrees (no recent commits)
git worktree list | while read path branch commit; do
  last_commit_date=$(git -C "$path" log -1 --format=%cd --date=short 2>/dev/null)
  echo "$path - Last commit: $last_commit_date"
done

# Remove stale worktrees
git worktree remove ../stale-feature
```

**Automation** (Worker Mode):

```text
User: "Clean up stale worktrees"

Worker Mode:
*Analyzing worktrees*:
Found 5 worktrees:
  - ../feature-old (no commits in 45 days) [stale]
  - ../feature-current (committed 2 days ago)
  - ../review-pr-123 (no commits in 10 days) [stale]

*Confirmation*:
Remove 2 stale worktrees? [y/N]
```

### Pitfall 2: Trying to Checkout Same Branch

**Problem**: Cannot checkout same branch in multiple worktrees

```bash
# In main repo
git checkout feature/auth

# Try to create worktree
git worktree add ../other feature/auth
# Error: 'feature/auth' is already checked out at '/path/to/main-repo'
```

**Solution**: Use detached HEAD or different branch

```bash
# Option 1: Detached HEAD at same commit
git worktree add ../other-work feature/auth
# Creates detached HEAD at feature/auth commit

# Option 2: Create new branch
git worktree add ../new-work -b feature/auth-v2 feature/auth
```

### Pitfall 3: Deleting Worktree Directory Manually

**Problem**: Deleted worktree directory but git still tracks it

```bash
rm -rf ../old-worktree  # Manual deletion

git worktree list
# Still shows ../old-worktree (but path doesn't exist!)
```

**Solution**: Prune stale references

```bash
git worktree prune
```

**Better**: Always use `git worktree remove`

```bash
git worktree remove ../old-worktree
```

### Pitfall 4: Moving Repository with Worktrees

**Problem**: Moved repository - worktrees now point to wrong location

```bash
# Original structure
/home/user/projects/my-repo/
/home/user/projects/feature-a/

# After moving
/home/user/dev/my-repo/      # Moved here
/home/user/projects/feature-a/  # Still here - now broken!
```

**Solution**: Repair worktrees

```bash
cd /home/user/dev/my-repo
git worktree repair /home/user/projects/feature-a
```

Or move worktrees with repo:

```bash
mv /home/user/projects /home/user/dev/
cd /home/user/dev/my-repo
git worktree list  # Automatically updated
```

### Pitfall 5: Worktree with Uncommitted Changes

**Problem**: Removing worktree with uncommitted work

```bash
git worktree remove ../feature-auth
# Error: '../feature-auth' contains modified or untracked files
```

**Solution 1**: Force remove (loses changes!)

```bash
git worktree remove --force ../feature-auth
```

**Solution 2**: Commit or stash first

```bash
cd ../feature-auth
git add .
git commit -m "WIP: Save before removing worktree"
# or
git stash push -m "Work from worktree"

cd ../main-repo
git worktree remove ../feature-auth
```

## Performance Considerations

### Disk Usage

- Worktrees share object database (efficient!)
- Each worktree has separate working directory (uses disk space)
- Use sparse checkout for large repos to minimize disk usage

**Example**:

```text
Repository size: 1 GB (.git)
Working directory: 500 MB

Traditional clones:
  repo-1: 1.5 GB
  repo-2: 1.5 GB
  repo-3: 1.5 GB
  Total: 4.5 GB

Worktrees:
  main-repo: 1.5 GB (.git + working dir)
  worktree-1: 500 MB (working dir only)
  worktree-2: 500 MB (working dir only)
  Total: 2.5 GB (savings: 2 GB)
```

### Worktree Creation Speed

- Fast: Worktrees created instantly (no cloning)
- Sparse checkout: Even faster for large repos
- Submodules: Slower (must initialize separately)

### Git Operations

- Operations in one worktree don't affect others
- Fetch/push: Affects all worktrees (shared refs)
- Checkout: Per-worktree operation
- Rebase/merge: Per-worktree (but updates shared refs)

## Cleanup Strategies

### Manual Cleanup

```bash
# List all worktrees
git worktree list

# Remove specific worktree
git worktree remove ../feature-done

# Prune deleted worktrees
git worktree prune
```

### Automated Cleanup (Worker Mode)

```text
User: "Clean up old worktrees"

Worker Mode:
*Analyzing worktrees*:

Active worktrees (recent activity):
  - my-repo (main) - 2 hours ago
  - ../feature-auth - 1 day ago

Stale worktrees (no activity > 30 days):
  - ../old-feature - 45 days ago (merged to main)
  - ../abandoned-work - 60 days ago (not merged)

*Recommendations*:
1. Remove merged worktrees: safe
2. Review unmerged worktrees before removal

Proceed with cleanup? [y/N]
```

### Cleanup Criteria

**Safe to Remove**:

- Branch has been merged
- No uncommitted changes
- No unmerged commits
- Inactive for > 30 days

**Requires Review**:

- Unmerged commits
- Uncommitted changes
- Active within 30 days
- Important feature work

## Integration with Other Tools

### IDE Integration

Most IDEs support worktrees:

- **VS Code**: Treats each worktree as separate workspace
- **IntelliJ**: Opens each worktree in separate window
- **Vim/Emacs**: Works seamlessly (just cd to worktree)

### CI/CD Integration

```bash
# In CI pipeline - use worktrees for multi-version testing
git worktree add ../test-v1.9 release/v1.9
git worktree add ../test-v2.0 main

# Run tests in parallel
cd ../test-v1.9 && make test &
cd ../test-v2.0 && make test &
wait
```

### Build Systems

```bash
# Build different branches simultaneously
git worktree add ../build-prod production
git worktree add ../build-staging staging

cd ../build-prod && make build &
cd ../build-staging && make build &
```

## Real-World Use Case: This Skill

This git-skill demonstrates worktree usage:

```bash
git-skill/
├── .git/
├── SKILL.md
├── submodules/git/git/          (submodule - git source)
└── version/
    ├── .gitignore
    └── v2.40.0/       (worktree - created when comparing versions)

# When skill needs to compare git versions:
git -C submodules/git/git worktree add ../version/v2.40.0 v2.40.0

# Access old documentation
cat version/v2.40.0/Documentation/git-worktree.adoc

# Cleanup after comparison
git -C submodules/git/git worktree remove ../version/v2.40.0
```

**This is meta-circular excellence!** The skill uses worktrees to teach worktrees.

## See Also

- [SUBMODULES.md](SUBMODULES.md) - Submodule + worktree integration
- [ADVANCED.md](ADVANCED.md) - Sparse checkout with worktrees
- [WORKER.md](WORKER.md) - Automated worktree operations
- Official docs: `submodules/git/git/Documentation/git-worktree.adoc` (version-specific)
