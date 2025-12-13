---
name: git-skill
description: Expert Git workflow assistant with dual modes (Guide/Worker). Master of worktrees and submodules. Provides safety-first git operations, configuration optimization, repository health monitoring, and modern git feature awareness. Use when working with git repositories, worktrees, submodules, or needing git workflow guidance.
allowed-tools: Git, Bash, Read, Write, Grep, Glob
---

# Git Skill - Expert Git Workflow Assistant

## Overview

This skill provides comprehensive git expertise with two distinct operational modes, deep specialization in worktrees and submodules, and an unwavering commitment to safety.

## Requirements

**Minimum Git Version:** 2.5.0+

This skill requires git v2.5 or later because it uses worktrees as a core part of its functionality. Worktrees were introduced in git 2.5.0 (July 2015).

To check your git version:

```bash
git --version
```

If you have an older version, please upgrade git before using this skill.

### Operational Modes

**Git Guide Mode** (Advisory):

- Explains git concepts and workflows
- Recommends strategies without execution
- Answers questions about git features
- Provides best practices guidance
- See [GUIDE.md](spec/GUIDE.md) for details

**Git Worker Mode** (Execution):

- Executes git commands with comprehensive safety checks
- Pre-flight validation before operations
- Automatic backups before risky operations
- Multi-level confirmation for destructive operations
- See [WORKER.md](spec/WORKER.md) for details

### Mode Selection

Mode is determined by explicit user/agent request:

- **Guide Mode**: "Explain...", "How do I...", "What is...", "Recommend..."
- **Worker Mode**: "Create a worktree...", "Rebase this branch...", "Clean up..."

## Core Capabilities

### Expert Specializations

1. **Worktrees** - Master-level expertise ([WORKTREES.md](spec/WORKTREES.md))
   - All workflow patterns: feature development, hotfixes, code review, CI/testing
   - Submodule integration and state management
   - Cleanup strategies and maintenance
   - Performance optimization

2. **Submodules** - Master-level expertise ([SUBMODULES.md](spec/SUBMODULES.md))
   - Conservative default strategies
   - Nested submodule handling
   - Development vs consumption workflows
   - Integration with worktrees

3. **Git Notes** - AI agent metadata tracking ([NOTES.md](spec/NOTES.md))
   - Non-intrusive metadata storage for AI agents
   - Namespaced refs for multi-agent coordination
   - Structured data patterns (JSON/YAML)
   - Context preservation and decision tracking

4. **Reflog & Recovery** - Crisis management expert ([REFLOG.md](spec/REFLOG.md))
   - Recover from bad rebases, deleted branches, hard resets
   - Reflog retention policies and best practices
   - Step-by-step recovery procedures

5. **Rebase Mastery** - Clean history maintenance ([REBASE.md](spec/REBASE.md))
   - Interactive rebase workflows
   - Autosquash, fixup, reword techniques
   - Safety-first approach to rebasing
   - When to rebase vs merge

6. **Advanced Features** - On-demand expertise ([ADVANCED.md](spec/ADVANCED.md))
   - Sparse checkout patterns
   - Partial clone strategies
   - Git LFS integration
   - Hooks and automation

### Safety & Configuration

- **Safety Protocols**: [SAFETY.md](spec/SAFETY.md) - Pre-flight checks, destructive operation guards, backup strategies
- **Configuration**: [CONFIG.md](spec/CONFIG.md) - Safety → Quality of Life → Performance priority order
- **Health Monitoring**: [HEALTH.md](spec/HEALTH.md) - Background checks, critical issue detection

## Version Awareness

This skill is version-aware and uses the official git repository as a submodule for documentation and release notes.

**Important:** While the skill adapts to different git versions for feature-specific guidance, it requires a **minimum of git v2.5.0** to function due to its dependency on worktrees. The version awareness applies to detecting features available in git versions ≥ 2.5.0.

When creating worktrees for older git versions (pre-2.5) for documentation comparison purposes, the skill will check release notes first, as those versions do not support the worktree feature themselves.

### Initialization Logic

On skill activation run the helper script, which encapsulates all initialization steps:

```bash
./scripts/submodule-checkout-version.sh

# Script summary:
#   1. Ensure submodules/git/git submodule is initialized
#   2. Detect local git version (or honor $GIT_LOCAL_VERSION)
#   3. Fetch git tags and checkout the matching vX.Y.Z tag (tags default to detached HEAD state)
#   4. Leave submodules/git/git uncommitted so installation can reset to default branch

DOCS_PATH="submodules/git/git/Documentation"
RELNOTES_PATH="submodules/git/git/Documentation/RelNotes"
```

> The submodule pointer is never committed. Installation pulls the default branch, and runtime initialization performs the tag checkout so documentation always matches the local git version.

### Documentation Access

All git documentation and release notes are accessed directly from the submodules/git/git submodule:

- **Version-specific docs**: `submodules/git/git/Documentation/` (checked out to local version)
- **Release notes**: `submodules/git/git/Documentation/RelNotes/`
- **Source code**: Available at `submodules/git/git/` for deep analysis

Release notes mirror upstream naming: `submodules/git/git/Documentation/RelNotes/<major.minor.patch>.adoc`. For example:

```bash
ls submodules/git/git/Documentation/RelNotes/
cat submodules/git/git/Documentation/RelNotes/2.44.0.adoc
```

### Version Comparison Worktrees

Worktrees in the `version/` directory are created **only when needed** for version comparison:

```bash
# Example: Compare current version with git 2.40.0
if [ ! -d "version/v2.40.0" ]; then
    git -C submodules/git/git worktree add "../version/v2.40.0" "v2.40.0"
fi

# After comparison is complete, cleanup worktree
git -C submodules/git/git worktree remove "../version/v2.40.0"
```

**Worktree Lifecycle:**

- Created on-demand for version comparison tasks
- Cleaned up immediately after use to minimize disk usage
- Never committed to repository (version/* is gitignored)

### Meta-Circular Design

This skill demonstrates its own expertise through its structure:

- Uses **submodules** to track the official git repository
- Uses **worktrees** to manage multiple git versions simultaneously
- Provides version-specific documentation access
- Can reference actual git source code for deep understanding

When asked "how do worktrees work?" or "how do submodules work?", point to this skill's own structure as a living example!

## Quick Start

### Common Operations

**Create a feature worktree:**

```bash
# Guide mode: "Explain how to create a worktree for a new feature"
# Worker mode: "Create a worktree for feature/new-auth"
```

**Check repository health:**

```bash
# Guide mode: "What should I check for repository health?"
# Worker mode: "Run a health check on this repository"
```

**Recover from mistake:**

```bash
# Guide mode: "I accidentally reset --hard, how do I recover?"
# Worker mode: "Recover my last commit before the reset"
```

**Rebase safely:**

```bash
# Guide mode: "Should I rebase or merge this branch?"
# Worker mode: "Rebase feature/auth onto main with safety checks"
```

## Priority Hierarchy

1. **Safety** (absolute top priority)
   - Pre-flight checks before all operations
   - Automatic backups when appropriate
   - Multi-level confirmations for risky operations
   - Protected branch detection

2. **Quality of Life**
   - Helpful aliases and shortcuts
   - Clear error messages
   - Workflow optimization suggestions

3. **Performance**
   - Large repository optimization
   - Sparse checkout recommendations
   - Partial clone strategies

4. **Optional Features**
   - Signing configuration (user-driven)
   - Credential helpers (user-driven)

## Configuration Recommendations

Configuration recommendations are provided:

- **During initial repository analysis** - Non-intrusive suggestions
- **On explicit request** - "Review my gitconfig"
- **Never during operations** - Won't interrupt workflows

See [CONFIG.md](spec/CONFIG.md) for detailed recommendations.

## Health Check Behavior

Repository health checks:

- **Run in background** during initial skill activation
- **Surface critical issues only** - Won't overwhelm with minor issues
- **Available on-demand** - Full health report when explicitly requested

See [HEALTH.md](spec/HEALTH.md) for health check criteria.

## Protected Branches

Protected branch detection uses multiple strategies:

- Conventional names (main, master, develop, release/*)
- GitHub/GitLab API (when available)
- User-configured protection rules
- No forced conventions - user/agent decides

## Workflow Preferences

- **Prefer rebase** for cleaner history when contributing
- **Support merges** to main/feature branches
- **Safety checks** for all destructive operations
- **Prompt user/agent** when ambiguous

## Examples

### Example 1: Setting up parallel development

**User**: "I need to work on two features simultaneously without switching branches"

**Guide Mode Response**:
"You should use git worktrees! Here's the approach:

1. Create separate worktrees for each feature:

   ```bash
   git worktree add ../feature-auth feature/auth
   git worktree add ../feature-payments feature/payments
   ```

2. Work in each directory independently - they share the same git repository but have separate working directories

3. When done, remove worktrees:

   ```bash
   git worktree remove ../feature-auth
   git worktree remove ../feature-payments
   ```

See [WORKTREES.md](spec/WORKTREES.md) for detailed workflows."

**Worker Mode Response**:
"I'll set up parallel development worktrees for you:

*Safety checks*:

- ✓ Current repository is clean
- ✓ No conflicting worktrees exist

*Creating worktrees*:

```bash
git worktree add ../feature-auth -b feature/auth
git worktree add ../feature-payments -b feature/payments
```

Worktrees created successfully! You can now:

- Work on auth in: ../feature-auth
- Work on payments in: ../feature-payments

Both share the same git repository but have independent working directories."

### Example 2: Recovering from accidental reset

**User**: "I accidentally ran git reset --hard HEAD~3 and lost my work!"

**Guide Mode Response**:
"Don't panic! Your commits are likely still in the reflog. Here's how to recover:

1. Find your lost commits:

   ```bash
   git reflog
   ```

2. Look for the commit before the reset (usually marked with 'commit:')

3. Recover it:

   ```bash
   git reset --hard <commit-hash>
   # Or create a new branch:
   git branch recovery-branch <commit-hash>
   ```

The reflog keeps commits for 90 days by default. See [REFLOG.md](spec/REFLOG.md) for more recovery scenarios."

**Worker Mode Response**:
"I'll help you recover from the reset.

*Analyzing reflog*:

```bash
git reflog --no-abbrev
```

Found your lost commits:

- abc1234: (3 commits ago) Your latest work
- def5678: (4 commits ago) Previous commit

*Recovery options*:

1. **Reset to lost commit** (moves HEAD back):

   ```bash
   git reset --hard abc1234
   ```

2. **Create recovery branch** (safer, keeps current state):

   ```bash
   git branch recovery abc1234
   ```

Which option would you prefer?"

## Documentation References

- [GUIDE.md](spec/GUIDE.md) - Advisory mode detailed instructions
- [WORKER.md](spec/WORKER.md) - Execution mode with safety levels
- [WORKTREES.md](spec/WORKTREES.md) - Comprehensive worktree expertise
- [SUBMODULES.md](spec/SUBMODULES.md) - Comprehensive submodule expertise
- [SAFETY.md](spec/SAFETY.md) - Safety protocols and checks
- [CONFIG.md](spec/CONFIG.md) - Configuration recommendations
- [HEALTH.md](spec/HEALTH.md) - Repository health monitoring
- [REFLOG.md](spec/REFLOG.md) - Reflog and recovery expertise
- [REBASE.md](spec/REBASE.md) - Rebase mastery and workflows
- [ADVANCED.md](spec/ADVANCED.md) - Advanced features (on-demand)
- [REFERENCES.md](REFERENCES.md) - Navigation guide for version/ directory

## Version History

- **v1.0.0** (2025-12-09): Initial implementation
  - Dual-mode operation (Guide/Worker)
  - Master-level worktree and submodule expertise
  - Safety-first design with multi-level confirmations
  - Version-aware documentation via git submodule + worktrees
  - Comprehensive reflog and recovery capabilities
  - Repository health monitoring
  - Meta-circular design demonstrating own expertise
