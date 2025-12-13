# Git Configuration Recommendations

## Overview

Git configuration follows a strict priority hierarchy:

1. **Safety** (absolute top priority)
2. **Quality of Life** (usability improvements)
3. **Performance** (optimization)
4. **Optional Features** (user-driven: signing, credentials)

## Configuration Timing

Configuration recommendations are provided:

- **During initial repository analysis** - Non-intrusive suggestions
- **On explicit request** - "Review my gitconfig"
- **Never during operations** - Won't interrupt workflows

## Configuration Levels

### System Level

```bash
# Affects all users on the system
git config --system <setting>

# Location: /etc/gitconfig
```

**Rarely used** - requires admin access

### Global Level

```bash
# Affects all repositories for current user
git config --global <setting>

# Location: ~/.gitconfig or ~/.config/git/config
```

**Most common** - use for user preferences

### Local Level

```bash
# Affects only current repository
git config --local <setting>

# Location: .git/config
```

**Project-specific** - use for repository-specific settings

### Priority Order

Local > Global > System

## Safety Settings (Priority 1)

**These settings prevent accidental data loss and bad practices.**

### Push Safety

```bash
# Only push current branch to matching remote branch
git config --global push.default simple

# Warn if pushing submodules without pushing their changes
git config --global push.recurseSubmodules check

# Even better: Auto-push submodules when needed
git config --global push.recurseSubmodules on-demand

# Follow tags when pushing (safer than separate tag pushes)
git config --global push.followTags true
```

**Rationale**:

- `push.default simple`: Prevents accidentally pushing all branches
- `push.recurseSubmodules check`: Prevents broken submodule references
- `push.followTags`: Ensures annotated tags are pushed with commits

### Pull Safety

```bash
# Rebase instead of merge when pulling (cleaner history)
git config --global pull.rebase true

# Alternatively, only fast-forward (safest)
git config --global pull.ff only
```

**Rationale**:

- Avoids merge commits in local history
- Makes git log cleaner and easier to bisect
- Use `pull.ff only` if you want to require explicit merge/rebase decisions

### Fetch Safety

```bash
# Automatically prune deleted remote branches
git config --global fetch.prune true

# Enable fsck during fetch (detect corruption)
git config --global fetch.fsckObjects true
```

**Rationale**:

- `fetch.prune`: Keeps local remote-tracking branches in sync
- `fetch.fsckObjects`: Early detection of repository corruption

### Rebase Safety

```bash
# Automatically stash before rebase
git config --global rebase.autoStash true

# Automatically move fixup commits during interactive rebase
git config --global rebase.autoSquash true
```

**Rationale**:

- `rebase.autoStash`: Prevents "cannot rebase: you have unstaged changes"
- `rebase.autoSquash`: Makes fixup workflow easier

### Core Safety

```bash
# Set default branch name for new repositories
git config --global init.defaultBranch main

# Handle line endings correctly (platform-specific)
# macOS/Linux:
git config --global core.autocrlf input
# Windows:
git config --global core.autocrlf true

# Prevent case-sensitivity issues on case-insensitive filesystems
git config --global core.ignoreCase true  # macOS/Windows default
```

**Rationale**:

- `init.defaultBranch main`: Modern standard, avoids legacy 'master'
- `core.autocrlf`: Prevents line ending chaos in cross-platform teams
- `core.ignoreCase`: Matches filesystem behavior

### Merge Safety

```bash
# Enable rerere (reuse recorded resolution)
git config --global rerere.enabled true

# Auto-update index after resolving conflicts
git config --global rerere.autoUpdate true

# Prevent fast-forward merges (keep branch structure visible)
git config --global merge.ff false  # Optional - team preference
```

**Rationale**:

- `rerere`: Remembers conflict resolutions (huge time-saver)
- `merge.ff false`: Preserves feature branch structure (team preference)

## Quality of Life Settings (Priority 2)

**These settings improve daily git usage.**

### Color Output

```bash
# Enable color output for better readability
git config --global color.ui auto

# Specific color customizations (optional)
git config --global color.status.changed "yellow bold"
git config --global color.status.untracked "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.old "red bold"
```

### Helpful Aliases

```bash
# Status shortcuts
git config --global alias.st status
git config --global alias.s "status --short"

# Branch management
git config --global alias.br branch
git config --global alias.bra "branch --all"
git config --global alias.brm "branch --merged"

# Commit shortcuts
git config --global alias.ci commit
git config --global alias.ca "commit --amend"
git config --global alias.cane "commit --amend --no-edit"

# Checkout shortcuts
git config --global alias.co checkout
git config --global alias.cob "checkout -b"

# Log visualization
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lga "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Creset %s' --date=short"

# Diff helpers
git config --global alias.df diff
git config --global alias.dfs "diff --staged"
git config --global alias.dfw "diff --word-diff"

# Worktree shortcuts
git config --global alias.wt worktree
git config --global alias.wtl "worktree list"
git config --global alias.wta "worktree add"
git config --global alias.wtr "worktree remove"

# Submodule shortcuts
git config --global alias.sm submodule
git config --global alias.smu "submodule update --init --recursive"
git config --global alias.smr "submodule update --remote --merge"

# Stash shortcuts
git config --global alias.sl "stash list"
git config --global alias.sp "stash pop"
git config --global alias.sa "stash apply"

# Show last commit
git config --global alias.last "log -1 HEAD --stat"

# Undo last commit (keep changes)
git config --global alias.undo "reset --soft HEAD~1"

# List contributors
git config --global alias.contributors "shortlog --summary --numbered --email"

# Find branches containing commit
git config --global alias.fb "!f() { git branch --all --contains \$1; }; f"

# Delete merged branches (except main/master/develop)
git config --global alias.cleanup "!git branch --merged | grep -v '\\*\\|main\\|master\\|develop' | xargs -n 1 git branch -d"
```

### Diff and Merge Tools

```bash
# Set default editor (choose one)
git config --global core.editor "vim"
git config --global core.editor "nano"
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "subl -n -w"    # Sublime Text

# Set diff tool (examples)
git config --global diff.tool vimdiff
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'

# Set merge tool (examples)
git config --global merge.tool vimdiff
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Don't create .orig backup files after merge
git config --global mergetool.keepBackup false
```

### Display Settings

```bash
# Show submodule summary in status
git config --global status.submoduleSummary true

# Show branch and tracking info in prompt
git config --global status.showStash true

# Show renames in diffs
git config --global diff.renames true

# Use better diff algorithm
git config --global diff.algorithm histogram

# Show submodule diff in log format
git config --global diff.submodule log

# Limit number of rename detection files
git config --global diff.renameLimit 3000
```

### Pager Settings

```bash
# Use less as pager with better defaults
git config --global core.pager "less -FRX"

# Disable pager for branch command
git config --global pager.branch false

# Disable pager for diff when used with tool
git config --global difftool.prompt false
```

## Performance Settings (Priority 3)

**These settings optimize git for large repositories and operations.**

### Core Performance

```bash
# Preload index for faster operations
git config --global core.preloadindex true

# Enable file system cache (Windows)
git config --global core.fscache true

# Enable untracked cache (speeds up status)
git config --global core.untrackedCache true

# Enable multi-threading for packing
git config --global pack.threads 0  # 0 = auto-detect cores

# Delta compression window
git config --global pack.windowMemory "100m"

# Larger pack size limit before repacking
git config --global pack.packSizeLimit "2g"
```

### Feature Flags for Large Repos

```bash
# Enable multi-pack index
git config --global feature.manyFiles true

# Enable commit graph
git config --global feature.experimental true
git config --global core.commitGraph true
git config --global gc.writeCommitGraph true
```

### Optimization Helpers

```bash
# Automatically run gc and pack-refs
git config --global gc.auto 256

# Keep reflog entries longer
git config --global gc.reflogExpire 90
git config --global gc.reflogExpireUnreachable 30

# Aggressive delta compression
git config --global pack.compression 9
```

### Network Performance

```bash
# Enable parallel fetch
git config --global fetch.parallel 0  # 0 = auto

# HTTP settings for large repos
git config --global http.postBuffer 524288000  # 500MB

# Connection timeout
git config --global http.lowSpeedLimit 1000
git config --global http.lowSpeedTime 60
```

## Optional Features (Priority 4)

**User-driven settings - not automatically recommended.**

### Commit Signing

```bash
# GPG signing (if user wants it)
git config --global user.signingkey <key-id>
git config --global commit.gpgsign true
git config --global tag.gpgsign true

# SSH signing (newer alternative)
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
```

**When to recommend**: User asks about signing or security policies require it

### Credential Helpers

```bash
# macOS keychain
git config --global credential.helper osxkeychain

# Windows Credential Manager
git config --global credential.helper manager

# Linux libsecret
git config --global credential.helper libsecret

# Cache credentials for 1 hour
git config --global credential.helper 'cache --timeout=3600'
```

**When to recommend**: User asks about authentication or repeatedly enters passwords

### LFS Configuration

```bash
# Enable LFS (if needed)
git lfs install

# Track large files
git lfs track "*.psd"
git lfs track "*.zip"

# LFS configuration
git config --global lfs.concurrenttransfers 8
```

**When to recommend**: Repository has large binary files

## Platform-Specific Settings

### macOS

```bash
# Case-insensitive filesystem handling
git config --global core.ignoreCase true

# Use macOS keychain for credentials
git config --global credential.helper osxkeychain

# Line endings
git config --global core.autocrlf input

# File system events (faster status)
git config --global core.fsmonitor true
```

### Windows

```bash
# File system cache
git config --global core.fscache true

# Long path support
git config --global core.longpaths true

# Line endings
git config --global core.autocrlf true

# Use Windows Credential Manager
git config --global credential.helper manager
```

### Linux

```bash
# Line endings
git config --global core.autocrlf input

# Use libsecret for credentials
git config --global credential.helper libsecret
```

## Configuration Review

### View Current Configuration

```bash
# Show all settings and their sources
git config --list --show-origin

# Show global settings only
git config --global --list

# Show local settings only
git config --local --list

# Show specific setting
git config --get user.name
```

### Recommended Configuration Check

Worker Mode can analyze current configuration and suggest improvements:

```text
User: "Review my gitconfig"

Worker Mode:
*Analyzing configuration*:

✓ Safety settings:
  - push.default = simple ✓
  - pull.rebase = true ✓
  - fetch.prune = true ✓

⚠ Missing safety settings:
  - push.recurseSubmodules (recommended: check)
  - rerere.enabled (recommended: true)

✓ Quality of life:
  - color.ui = auto ✓
  - 15 helpful aliases configured ✓

💡 Performance suggestions:
  - core.untrackedCache not enabled (speeds up status)
  - pack.threads not configured (auto-threading disabled)

🔧 Platform-specific:
  - macOS detected
  - core.fsmonitor not enabled (recommended for large repos)

Would you like me to apply recommended settings? [y/N]
```

## Configuration Template

### Minimal Safe Configuration

```bash
# Safety first
git config --global push.default simple
git config --global pull.rebase true
git config --global fetch.prune true
git config --global init.defaultBranch main

# Quality of life
git config --global color.ui auto
git config --global core.editor "vim" # "code --wait" for VS Code

# User identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Recommended Full Configuration

```bash
# Run this script to set all recommended settings
# Save as: setup-git-config.sh

#!/bin/bash

# === SAFETY (Priority 1) ===
git config --global push.default simple
git config --global push.recurseSubmodules check
git config --global push.followTags true
git config --global pull.rebase true
git config --global fetch.prune true
git config --global fetch.fsckObjects true
git config --global rebase.autoStash true
git config --global rebase.autoSquash true
git config --global init.defaultBranch main
git config --global core.autocrlf input  # Change to 'true' on Windows
git config --global rerere.enabled true
git config --global rerere.autoUpdate true

# === QUALITY OF LIFE (Priority 2) ===
git config --global color.ui auto
git config --global status.submoduleSummary true
git config --global diff.renames true
git config --global diff.algorithm histogram

# Helpful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# === PERFORMANCE (Priority 3) ===
git config --global core.preloadindex true
git config --global core.untrackedCache true
git config --global pack.threads 0
git config --global feature.manyFiles true

# === PLATFORM-SPECIFIC ===

```sh

# macOS

git config --global credential.helper osxkeychain
git config --global core.fsmonitor true

# Windows

git config --global core.fscache true
git config --global core.longpaths true
git config --global credential.helper manager

# Linux

 git config --global credential.helper libsecret

```

echo "Git configuration complete!"
echo "Don't forget to set your identity:"
echo "  git config --global user.name 'Your Name'"
echo "  git config --global user.email 'your.email@example.com'"

```

## See Also

- [SAFETY.md](SAFETY.md) - Safety protocols and checks
- [WORKER.md](WORKER.md) - Execution mode
- [HEALTH.md](HEALTH.md) - Configuration health checks
