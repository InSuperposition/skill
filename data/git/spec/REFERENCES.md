# Git Documentation References

## Overview

This skill uses the **official git repository as a submodule** to provide version-specific documentation and release notes. This ensures accurate, authoritative information matched to your installed git version.

## Repository Structure

```sh
git-skill/
├── SKILL.md                    # Main skill documentation
├── .gitmodules                 # Submodule configuration
├── spec/                       # Detailed specifications
│   ├── GUIDE.md                # Advisory mode guide
│   ├── WORKER.md               # Execution mode guide
│   ├── WORKTREES.md            # Worktree expertise
│   ├── SUBMODULES.md           # Submodule expertise
│   ├── NOTES.md                # Git notes for AI metadata
│   ├── SAFETY.md               # Safety protocols
│   ├── CONFIG.md               # Configuration recommendations
│   ├── HEALTH.md               # Health monitoring
│   ├── REFLOG.md               # Reflog and recovery
│   ├── REBASE.md               # Rebase mastery
│   ├── ADVANCED.md             # Advanced features
│   └── REFERENCES.md           # This file
├── scripts/                    # Automation scripts
│   ├── submodule-update.sh     # Update submodule to latest
│   ├── submodule-checkout-version.sh  # Checkout version tag
│   └── submodule-rename-test.sh       # Validate submodule rename
├── submodules/git/git/         # Submodule: official git source
│   ├── Documentation/          # Version-specific git docs
│   │   ├── git.adoc
│   │   ├── git-worktree.adoc
│   │   ├── git-submodule.adoc
│   │   ├── git-reflog.adoc
│   │   ├── git-rebase.adoc
│   │   └── RelNotes/           # All git release notes
│   │       ├── 2.52.0.adoc
│   │       ├── 2.51.0.adoc
│   │       └── ...
│   ├── builtin/                # Git command implementations
│   ├── t/                      # Git test suite
│   └── ...
├── version/                    # Worktrees (created on-demand)
│   ├── .gitignore              # Keeps directory tracked while ignoring worktrees
│   └── v2.40.0/                # Example: worktree for version comparison
│       └── Documentation/
└── worktrees/                  # Worktrees directory
    └── .gitignore              # Keeps directory tracked
```

## Git-Repo Submodule

### What It Contains

The `submodules/git/git/` submodule is the complete official git repository:

- **Full git source code** - All implementation details
- **Comprehensive documentation** - Official docs for all git commands
- **Release notes** - Every git version's release notes
- **Test suite** - How git tests itself
- **History** - Complete development history

### How It Works

During skill initialization run the helper script:

```bash
./scripts/submodule-checkout-version.sh
```

The script:

1. Ensures the `submodules/git/git` submodule is initialized
2. Detects or validates `$GIT_LOCAL_VERSION` (semantic `X.Y.Z` or `X.Y.Z-rcN`)
3. Confirms `submodules/git/git` tracks the URL declared in `.gitmodules` and is free of local modifications
4. Fetches upstream tags, verifies the signed `vX.Y.Z` tag, and checks it out (tags default to detached HEAD state)
5. Leaves `submodules/git/git` uncommitted so installation can reset it to the default branch

After the script finishes, documentation lives at `submodules/git/git/Documentation/` and release notes at `submodules/git/git/Documentation/RelNotes/`.

> Submodule updates remain uncommitted; installation resets to the default branch, and runtime initialization re-runs the script so docs always match your local git version.

### Accessing Documentation

**Current git version docs** (checked out in submodules/git/git):

```bash
# View worktree documentation
cat submodules/git/git/Documentation/git-worktree.adoc
less submodules/git/git/Documentation/git-worktree.adoc

# View release notes
cat submodules/git/git/Documentation/RelNotes/2.52.0.adoc
```

**Searching documentation**:

```bash
# Find all mentions of worktrees
grep -r "worktree" submodules/git/git/Documentation/

# Find configuration options
grep -r "config" submodules/git/git/Documentation/config.adoc
```

#### Release Notes Directory

```bash
# List available release notes
ls submodules/git/git/Documentation/RelNotes/

# View a specific release
cat submodules/git/git/Documentation/RelNotes/2.44.0.adoc
```

Each filename matches upstream git tags (`<major>.<minor>.<patch>.adoc`). Use these files for version-specific change summaries.

## Version Worktrees

### Purpose

The `version/` directory contains **on-demand worktrees** for version comparison:

- **NOT created automatically** - only when needed
- **Cleaned up after use** - to minimize disk space
- **Never committed** - `version/*` is gitignored

### When Worktrees Are Created

Worktrees are created when you need to compare git versions:

```text
User: "Compare git 2.40.0 worktree behavior with current version"

Worker Mode:
*Creating version comparison worktree*:
git -C submodules/git/git worktree add ../version/v2.40.0 v2.40.0

*Now you can compare*:
- Current version docs: submodules/git/git/Documentation/git-worktree.adoc
- Git 2.40.0 docs: version/v2.40.0/Documentation/git-worktree.adoc

*After comparison, cleanup*:
git -C submodules/git/git worktree remove ../version/v2.40.0
```

### Version Worktree Lifecycle

1. **Creation**: `git -C submodules/git/git worktree add ../version/v{version} v{version}`
2. **Use**: Access docs at `version/v{version}/Documentation/`
3. **Cleanup**: `git -C submodules/git/git worktree remove ../version/v{version}`

### Benefits of Worktree Approach

- **No duplication** - Worktrees share objects with submodules/git/git
- **Fast creation** - Instant worktree creation (no cloning)
- **Minimal disk usage** - Only working directory files, not full history
- **Easy cleanup** - Remove worktree when done
-

## Troubleshooting Submodule Sync

### Git Version Too Old

**Problem**: Script fails with error about git version requirement.

**Cause**: This skill requires git v2.5.0 or later due to worktree functionality.

**Solution**:

```bash
# Check your git version
git --version

# Upgrade git (method depends on your OS)
# macOS: brew upgrade git
# Ubuntu/Debian: sudo apt-get update && sudo apt-get install git
# See: https://git-scm.com/downloads
```

---

### Other Common Issues

- **Submodule missing or stale**: run `./scripts/submodule-checkout-version.sh` to reinitialize and re-checkout the correct tag.
- **Tag not found**: ensure your local git version exists upstream. If you're on a pre-release build, expect the warning and stay on the default branch.
- **Dirty `submodules/git/git` state**: `git -C submodules/git/git status --short` must be clean before re-running the script; stash or discard local edits.
- **Network hiccups**: the script fetches from origin; verify network access or retry with `GIT_TRACE=1` for more context.
- **Never commit `submodules/git/git`**: the superproject intentionally leaves the submodule pointer floating. If you accidentally stage it, drop it with `git reset submodules/git/git`.
| git-hooks.adoc | Hook documentation |
| gitignore.adoc | Ignore pattern documentation |
| gitattributes.adoc | Attributes documentation |

### Release Notes

Located in `submodules/git/git/Documentation/RelNotes/`:

```bash
# List all release notes
ls submodules/git/git/Documentation/RelNotes/

# View latest release notes
cat submodules/git/git/Documentation/RelNotes/2.52.0.adoc

# Search release notes for feature
grep -r "sparse-checkout" submodules/git/git/Documentation/RelNotes/
```

### Technical Notes

Located in `submodules/git/git/Documentation/technical/`:

Deep-dive technical documentation:

- Protocol specifications
- Pack format
- Index format
- Repository layout

## Using Documentation in Skill

### Reading Documentation

The skill can read version-specific documentation:

```text
User: "What does git worktree documentation say about prune?"

Worker Mode:
*Reading official documentation*:
cat submodules/git/git/Documentation/git-worktree.adoc | grep -A 10 "prune"

Output:
PRUNE
  Prune working tree information in $GIT_DIR/worktrees.

  This removes working trees that are no longer referenced
  but whose administrative files still exist. A working tree
  is considered referenced if it is still linked to a valid
  worktree directory.
```

### Comparing Versions

```text
User: "When was --sparse option added to git worktree add?"

Worker Mode:
*Searching release notes*:
grep -r "sparse" submodules/git/git/Documentation/RelNotes/ | grep worktree

Output:
RelNotes/2.25.0.adoc: * "git worktree add" learned "--sparse" option
```

### Deep Analysis

Access git source code for deep understanding:

```bash
# How does git implement worktree add?
cat submodules/git/git/builtin/worktree.c

# How are worktrees stored?
ls -la .git/worktrees/
cat .git/worktrees/*/gitdir
```

## Meta-Circular Excellence

This skill **demonstrates its own expertise**:

### Submodules

The skill uses a submodule (`submodules/git/git`) to teach submodules:

- Shows real-world submodule usage
- Demonstrates conservative update strategy
- Example of consumption workflow (not development)

### Worktrees

The skill uses worktrees (`version/`) to teach worktrees:

- Shows on-demand worktree creation
- Demonstrates cleanup strategy
- Examples of version comparison workflow

### Documentation Strategy

The skill uses git's own docs as source of truth:

- Version-specific accuracy
- Official authoritative source
- Always up-to-date (via submodule update)

## Updating Git-Repo Submodule

### Check for Updates

```bash
# See current submodule commit
git submodule status

# Fetch latest from git.git
cd submodules/git/git
git fetch origin
git log --oneline HEAD..origin/master | head -10
```

### Update to Latest

```bash
# Option 1: Update to latest master
cd submodules/git/git
git pull origin master
cd ..
git add submodules/git/git
git commit -m "Update submodules/git/git submodule to latest"

# Option 2: Update to specific version
cd submodules/git/git
git checkout v2.53.0
cd ..
git add submodules/git/git
git commit -m "Update submodules/git/git submodule to v2.53.0"
```

### Update to Match Local Git

```bash
LOCAL_VERSION=$(git --version | awk '{print $3}')
cd submodules/git/git
git fetch --all --tags
git checkout "v${LOCAL_VERSION}"
cd ..
git add submodules/git/git
git commit -m "Update submodules/git/git to match local git v${LOCAL_VERSION}"
```

## External References

### Official Git Resources

- **Git Website**: <https://git-scm.com/>
- **Git Documentation**: <https://git-scm.com/doc>
- **Pro Git Book**: <https://git-scm.com/book/en/v2>
- **Git Reference**: <https://git-scm.com/docs>
- **Git Source**: <https://github.com/git/git>

### Community Resources

- **Git Mailing List**: <https://lore.kernel.org/git/>
- **Stack Overflow**: `[git]` tag
- **GitHub Git Guides**: <https://github.com/git-guides>

### Learning Resources

- **Visualizing Git**: <https://git-school.github.io/visualizing-git/>
- **Learn Git Branching**: <https://learngitbranching.js.org/>
- **Oh Shit, Git!**: <https://ohshitgit.com/>

## Skill Documentation Map

### Quick Reference

| Topic | File | Description |
| ----- | ---- | ----------- |
| Overview | [SKILL.md](SKILL.md) | Main skill entry point |
| Advisory mode | [GUIDE.md](GUIDE.md) | Explanations and recommendations |
| Execution mode | [WORKER.md](WORKER.md) | Safe command execution |
| Worktrees | [WORKTREES.md](WORKTREES.md) | Master-level worktree expertise |
| Submodules | [SUBMODULES.md](SUBMODULES.md) | Master-level submodule expertise |
| Notes | [NOTES.md](NOTES.md) | Git notes for AI agent metadata |
| Safety | [SAFETY.md](SAFETY.md) | Safety protocols and checks |
| Configuration | [CONFIG.md](CONFIG.md) | Recommended settings |
| Health | [HEALTH.md](HEALTH.md) | Repository health monitoring |
| Recovery | [REFLOG.md](REFLOG.md) | Reflog and crisis management |
| Rebasing | [REBASE.md](REBASE.md) | Rebase mastery |
| Advanced | [ADVANCED.md](ADVANCED.md) | Advanced features on-demand |
| References | [REFERENCES.md](REFERENCES.md) | This file |

### Workflow-Based Navigation

**"I need to..."**:

- ...work on multiple branches simultaneously → [WORKTREES.md](WORKTREES.md)
- ...manage external dependencies → [SUBMODULES.md](SUBMODULES.md)
- ...track AI agent metadata → [NOTES.md](NOTES.md)
- ...recover from a mistake → [REFLOG.md](REFLOG.md)
- ...clean up my commit history → [REBASE.md](REBASE.md)
- ...optimize my git config → [CONFIG.md](CONFIG.md)
- ...check repository health → [HEALTH.md](HEALTH.md)
- ...understand safety protocols → [SAFETY.md](SAFETY.md)
- ...use advanced features → [ADVANCED.md](ADVANCED.md)

### Mode-Based Navigation

**"I want to..."**:

- ...understand how something works → [GUIDE.md](GUIDE.md) (Advisory mode)
- ...execute git operations safely → [WORKER.md](WORKER.md) (Execution mode)

## See Also

- [SKILL.md](SKILL.md) - Start here for overview
- All documentation files listed above
- Official git docs in `submodules/git/git/Documentation/`

### Additional Hardening Options

- **Trusted ownership**: run `git config --global --add safe.directory "$(pwd)/submodules/git/git"` so git refuses to operate on attacker-controlled directories mounted with a different UID.
- **Limit filesystem traversal**: wrap script invocations with `GIT_CEILING_DIRECTORIES="$(pwd)" GIT_TEST_CEILING_DIRECTORIES="$(pwd)" ./scripts/submodule-checkout-version.sh` to prevent git from walking into parent repositories.
- **Minimize fetched data**: export `GIT_INIT_FETCH_FLAGS="--depth=1 --filter=blob:none"` before running the script to constrain the data downloaded from potentially compromised remotes.
- **Signature verification**: import the Git maintainer keyring (see `submodules/git/git/Documentation/RelNotes/` for fingerprints) so `git verify-tag` succeeds.
