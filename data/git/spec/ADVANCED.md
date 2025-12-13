# Advanced Git Features - On-Demand Expertise

## Overview

Advanced git features provide powerful capabilities for specific scenarios. These features are available **on-demand** - the skill provides expert guidance when requested, but doesn't proactively suggest them.

**Philosophy**: Use advanced features only when you need them. Start simple.

## Sparse Checkout

**What**: Check out only subset of files from repository

**Use Case**: Large repositories where you only need specific directories

### Basic Sparse Checkout

```bash
# Clone with no files checked out
git clone --no-checkout --filter=blob:none <url>
cd repo

# Enable sparse checkout
git sparse-checkout init --cone

# Specify directories to include
git sparse-checkout set src/auth tests/auth

# Checkout with only specified paths
git checkout main
```

**Result**: Only `src/auth/` and `tests/auth/` directories checked out.

### Cone Mode vs Non-Cone Mode

**Cone Mode** (recommended, faster):

```bash
# Work with directories
git sparse-checkout set src/frontend src/backend
```

**Non-Cone Mode** (flexible, slower):

```bash
git sparse-checkout init --no-cone

# Use patterns
echo 'src/*/tests/' >> .git/info/sparse-checkout
echo '!src/legacy/' >> .git/info/sparse-checkout
git sparse-checkout reapply
```

### Sparse Checkout with Worktrees

Different worktrees can have different sparse patterns:

```bash
# Main worktree: Full checkout
my-repo/ (all files)

# Frontend worktree: Only frontend code
git worktree add --no-checkout ../frontend-work feature/ui
cd ../frontend-work
git sparse-checkout set src/frontend
git checkout feature/ui

# Backend worktree: Only backend code
git worktree add --no-checkout ../backend-work feature/api
cd ../backend-work
git sparse-checkout set src/backend
git checkout feature/api
```

### When to Use Sparse Checkout

**Use when**:

- Repository is very large (> 1GB)
- You only work on specific components
- Build tools support sparse checkout
- Clone time is excessive

**Don't use when**:

- Repository is small
- You need cross-component refactoring
- Build requires all files
- Team doesn't use it (confusion risk)

## Partial Clone

**What**: Clone repository without downloading all objects

**Use Case**: Massive repositories, CI/CD pipelines, quick exploration

### Blobless Clone

Clone without blob objects (file contents):

```bash
git clone --filter=blob:none <url>
```

**What's included**:

- Complete commit history
- Tree objects
- Blobs downloaded on-demand

**Use case**: Quick clone for code review, statistics

### Treeless Clone

Clone with only commits:

```bash
git clone --filter=tree:0 <url>
```

**What's included**:

- Only commit objects
- Trees and blobs downloaded on-demand

**Use case**: CI/CD pipelines (check out specific commit)

### Shallow Clone

Clone with limited history:

```bash
# Clone with only last commit
git clone --depth 1 <url>

# Clone with last 10 commits
git clone --depth 10 <url>

# Clone since specific date
git clone --shallow-since=2024-01-01 <url>
```

**Limitations**:

- Cannot push commits
- Cannot fetch full history later (easily)
- Some operations fail

**Use case**: Deployment, one-time builds

### Combining Filters

```bash
# Shallow clone + blobless
git clone --depth 1 --filter=blob:none <url>

# Best for CI/CD
git clone --depth 1 --single-branch --branch=main <url>
```

## Git LFS (Large File Storage)

**What**: Store large files outside git repository

**Use Case**: Binary assets, datasets, media files

### Installing LFS

```bash
# Install LFS extension
git lfs install

# Install for specific repository
git lfs install --local
```

### Tracking Files

```bash
# Track all PSD files
git lfs track "*.psd"

# Track files in specific directory
git lfs track "assets/**"

# View tracked patterns
git lfs track
```

**Creates**: `.gitattributes` file with patterns

### LFS Workflow

```bash
# Add large file (automatically handled by LFS)
git add large-file.psd
git commit -m "Add design file"
git push

# Clone repository with LFS
git clone <url>
cd repo
git lfs pull  # Download LFS objects

# Or clone with LFS automatically
git lfs clone <url>
```

### LFS Commands

```bash
# List LFS files
git lfs ls-files

# Check LFS status
git lfs status

# Fetch LFS objects
git lfs fetch

# Pull LFS objects
git lfs pull

# Push LFS objects
git lfs push origin main

# Prune old LFS objects
git lfs prune
```

### Migrating to LFS

```bash
# Migrate existing files to LFS
git lfs migrate import --include="*.psd,*.zip"

# Include everything above size
git lfs migrate import --above=100MB

# Migrate and rewrite history
git lfs migrate import --include="*.psd" --everything
```

### When to Use LFS

**Use when**:

- Files > 50MB
- Binary files that change frequently
- Media files (images, videos, audio)
- Datasets, ML models
- Build artifacts in repository

**Don't use when**:

- Files < 10MB (normal git works fine)
- Text files (git handles well)
- Files rarely change (vendoring okay)
- Hosting doesn't support LFS

## Hooks & Automation

**What**: Scripts that run automatically on git events

**Use Case**: Enforce policies, automate tasks, integrate tools

### Client-Side Hooks

Located in `.git/hooks/`:

#### pre-commit

Run before commit is created:

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Run linter
npm run lint || exit 1

# Run tests
npm test || exit 1

echo "✓ Pre-commit checks passed"
```

**Use case**: Linting, formatting, quick tests

#### prepare-commit-msg

Modify commit message template:

```bash
#!/bin/bash
# .git/hooks/prepare-commit-msg

# Add issue number to commit message
BRANCH=$(git rev-parse --abbrev-ref HEAD)
ISSUE=$(echo $BRANCH | grep -oP '(?<=issue-)\d+')

if [ -n "$ISSUE" ]; then
  echo "#$ISSUE $(cat $1)" > $1
fi
```

**Use case**: Auto-add ticket numbers, enforce format

#### commit-msg

Validate commit message:

```bash
#!/bin/bash
# .git/hooks/commit-msg

# Enforce conventional commits
if ! head -1 "$1" | grep -qE "^(feat|fix|docs|style|refactor|test|chore):"; then
  echo "Error: Commit message must start with type (feat|fix|docs|...)"
  exit 1
fi
```

**Use case**: Enforce commit message conventions

#### pre-push

Run before push:

```bash
#!/bin/bash
# .git/hooks/pre-push

# Run full test suite
npm run test:all || exit 1

# Check for TODOs on main branch
if [ "$(git rev-parse --abbrev-ref HEAD)" = "main" ]; then
  if git grep -n 'TODO'; then
    echo "Error: Cannot push TODOs to main branch"
    exit 1
  fi
fi
```

**Use case**: Full tests, branch protection

### Server-Side Hooks

Located on git server (e.g., `.git/hooks/` on bare repo):

- **pre-receive**: Before refs are updated
- **update**: Per ref update
- **post-receive**: After refs are updated

**Use case**: CI/CD triggers, deployment, notifications

### Hook Frameworks

#### pre-commit framework

Popular Python-based hook manager:

```bash
# Install
pip install pre-commit

# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml <<EOF
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
        args: ['--maxkb=1000']
EOF

# Install hooks
pre-commit install
```

#### Husky (Node.js)

```bash
# Install
npm install --save-dev husky

# Initialize
npx husky-init

# Add hook
npx husky add .husky/pre-commit "npm test"
```

### When to Use Hooks

**Use when**:

- Enforce code quality standards
- Automate repetitive tasks
- Integrate with CI/CD
- Prevent common mistakes

**Don't use when**:

- Slow hooks (> 10 seconds) - use CI instead
- Complex logic better in CI
- Not all team members can run hooks

## Bisect - Binary Search for Bugs

**What**: Automatically find which commit introduced a bug

**Use Case**: Regression hunting

### Basic Bisect

```bash
# Start bisect
git bisect start

# Mark current commit as bad
git bisect bad

# Mark known good commit
git bisect good v1.0.0

# Git checks out middle commit
# Test it
npm test

# If test passes:
git bisect good

# If test fails:
git bisect bad

# Git continues binary search
# Repeat until found

# When done:
git bisect reset
```

### Automated Bisect

```bash
# Start bisect
git bisect start HEAD v1.0.0

# Provide test script
git bisect run npm test

# Git automatically bisects
# Finds first bad commit
```

**Test script requirements**:

- Exit code 0 = good
- Exit code 1-127 (except 125) = bad
- Exit code 125 = skip this commit

### Bisect in Worktree

Run bisect in dedicated worktree:

```bash
# Create bisect worktree
git worktree add ../bisect-session main

cd ../bisect-session
git bisect start
git bisect bad
git bisect good v1.0.0
git bisect run ./test.sh

# Meanwhile, main worktree unaffected
```

### When to Use Bisect

**Use when**:

- Known good and bad commits
- Reproducible bug
- Fast test (< 1 minute per commit)
- Many commits between good and bad

**Don't use when**:

- Bug not reproducible
- Very slow tests (hours)
- Flaky tests
- Few commits (manual check faster)

## Filter-Repo (History Rewriting)

**What**: Rewrite repository history (replacement for filter-branch)

**Warning**: Destructive - always backup first!

### Installing

```bash
# macOS
brew install git-filter-repo

# Linux
pip install git-filter-repo
```

### Remove Sensitive Data

```bash
# Remove file from all history
git filter-repo --path secrets.txt --invert-paths

# Remove multiple files
git filter-repo --path-glob '*.key' --invert-paths
```

### Rewrite Paths

```bash
# Move everything into subdirectory
git filter-repo --to-subdirectory-filter my-component

# Rename directory
git filter-repo --path-rename old-name:new-name
```

### Shrink Repository

```bash
# Remove large files from history
git filter-repo --strip-blobs-bigger-than 10M
```

### Safety with Filter-Repo

```bash
# 1. Create backup
git clone --mirror . ../backup.git

# 2. Run filter-repo on clone
git clone ../backup.git working-copy
cd working-copy
git filter-repo <options>

# 3. Verify result
# 4. Force push to update remote (coordinate with team!)
```

## Git Attributes

**What**: Per-path configuration in `.gitattributes`

### Common Attributes

```bash
# .gitattributes file

# Diff binary files as text (e.g., PDFs)
*.pdf diff=pdf

# Mark as binary (no diff)
*.exe binary

# Normalize line endings
* text=auto
*.sh text eol=lf
*.bat text eol=crlf

# LFS tracking
*.psd filter=lfs diff=lfs merge=lfs -text

# Merge driver
database.db merge=ours

# Linguist overrides (GitHub language stats)
docs/** linguist-documentation
vendor/** linguist-vendored
*.js linguist-language=JavaScript
```

## Archive & Bundle

### Git Archive

Export repository snapshot:

```bash
# Create tarball of main branch
git archive --format=tar.gz --output=project.tar.gz main

# Create zip
git archive --format=zip --output=project.zip main

# Archive specific directory
git archive --format=tar.gz main:src > src.tar.gz
```

### Git Bundle

Create single-file repository:

```bash
# Create bundle
git bundle create repo.bundle --all

# Clone from bundle
git clone repo.bundle repo-from-bundle

# Fetch from bundle
git bundle verify repo.bundle
git fetch repo.bundle main:main
```

**Use case**: Transfer repository via USB, email, or offline

## See Also

- [WORKTREES.md](WORKTREES.md) - Sparse checkout with worktrees
- [SUBMODULES.md](SUBMODULES.md) - Advanced submodule patterns
- [HEALTH.md](HEALTH.md) - Detect when to use advanced features
- Official docs: `submodules/git/git/Documentation/`
