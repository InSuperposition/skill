# Git Skill - Expert Git Workflow Assistant

A comprehensive AI skill providing master-level git expertise with dual operational modes, specializing in worktrees, submodules, and safety-first git operations.

## Overview

This skill transforms an AI into an expert git consultant and automation agent with:

- **Dual Modes**: Advisory (Guide) and Execution (Worker) modes
- **Master-Level Expertise**: Worktrees, submodules, rebasing, reflog recovery
- **Safety-First**: Multi-level safety checks, pre-flight validation, automatic backups
- **Version-Aware**: Uses official git repository as submodule for accurate documentation
- **Modern Git Features**: Sparse checkout, partial clone, LFS integration, and more

## Features

### Core Capabilities

- **🌳 Worktree Mastery** - All patterns: feature development, hotfixes, code review, CI/testing
- **📦 Submodule Expertise** - Conservative strategies, nested handling, development vs consumption workflows
- **📝 Git Notes** - AI agent metadata tracking, context preservation, decision rationale storage
- **🔄 Rebase & History** - Interactive rebase, autosquash, clean history maintenance
- **🔧 Crisis Recovery** - Reflog navigation, recovering from bad rebases/resets/deletions
- **⚡ Advanced Features** - Sparse checkout, partial clones, Git LFS, hooks, bisect
- **🛡️ Safety Protocols** - 5-level safety system, destructive operation guards, backup strategies
- **⚙️ Configuration** - Optimized settings (safety → quality of life → performance)
- **🏥 Health Monitoring** - Repository health checks, bloat detection, integrity validation

### Operational Modes

**Guide Mode** (Advisory):

- Explains git concepts and workflows
- Recommends strategies without execution
- Answers questions about git features
- Provides best practices guidance

**Worker Mode** (Execution):

- Executes git commands with comprehensive safety checks
- Pre-flight validation before operations
- Automatic backups before risky operations
- Multi-level confirmation for destructive operations

## Requirements

- **Git**: v2.5.0 or later (worktree support required)
- **Platform**: macOS, Linux, Windows (using WSL)

Check your git version:

```bash
git --version
```

## Installation

### For Claude Desktop

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/git-skill.git
   cd git-skill
   ```

2. **Initialize the submodule** (official git repository):

   ```bash
   ./scripts/submodule-checkout-version.sh
   ```

   This script:
   - Initializes the `submodules/git/git` submodule
   - Detects your local git version
   - Checks out the matching version tag
   - Provides version-specific documentation

3. **Configure Claude Desktop**:

   Add to your Claude Desktop configuration (`~/Library/Application Support/Claude/config.json` on macOS):

   ```json
   {
     "skills": [
       {
         "name": "git-skill",
         "path": "/path/to/git-skill"
       }
     ]
   }
   ```

4. **Restart Claude Desktop** to load the skill

### For Claude CLI

1. **Clone the repository** (same as above)

2. **Initialize the submodule** (same as above)

3. **Use in conversations**:

   ```bash
   claude-code chat --skill /path/to/git-skill
   ```

### Verification

Test the installation:

```bash
# Verify submodule is initialized
git submodule status

# Verify scripts are executable
ls -l scripts/*.sh

# Test version checkout
./scripts/submodule-checkout-version.sh
```

## Quick Start

### Using Guide Mode

Ask git questions or request explanations:

```txt
"Explain how git worktrees work"
"What's the difference between rebase and merge?"
"How do I recover from a bad rebase?"
"Recommend a strategy for managing submodules"
```

### Using Worker Mode

- tag: `v2.5.0`
- branch: `feature/auth`, `qa/956/feature_name`
- SHA: `91fe76w`

Request git operations with safety checks:

```txt
"Create a worktree for a tag, branch or SHA, prompt for worktree-folder name, it should be namespaced"



Worktree folder is name spaced by project name
  - 

"Rebase this branch on main"
"Clean up stale branches"
"Recover my deleted branch"
```

### Getting Help

```txt
"How do worktrees integrate with submodules?"
"Show me safe rebase workflows"
"What are the safety levels?"
```

## Documentation

### Main Documentation

- **[SKILL.md](SKILL.md)** - Skill definition and overview
- **[spec/](spec/)** - Detailed specifications (11 comprehensive guides)

### Specification Files

| File | Purpose |
|------|---------|
| **[GUIDE.md](spec/GUIDE.md)** | Advisory mode - explanations and recommendations |
| **[WORKER.md](spec/WORKER.md)** | Execution mode - operations with safety checks |
| **[WORKTREES.md](spec/WORKTREES.md)** | Master-level worktree expertise |
| **[SUBMODULES.md](spec/SUBMODULES.md)** | Master-level submodule expertise |
| **[REBASE.md](spec/REBASE.md)** | Rebase mastery and clean history |
| **[REFLOG.md](spec/REFLOG.md)** | Crisis management and recovery |
| **[SAFETY.md](spec/SAFETY.md)** | Safety protocols and pre-flight checks |
| **[CONFIG.md](spec/CONFIG.md)** | Configuration optimization |
| **[HEALTH.md](spec/HEALTH.md)** | Repository health monitoring |
| **[ADVANCED.md](spec/ADVANCED.md)** | Advanced git features |
| **[REFERENCES.md](spec/REFERENCES.md)** | Documentation structure and references |

## Architecture

### Repository Structure

```sh
git-skill/
├── SKILL.md                    # Main skill documentation
├── README.md                   # This file
├── .gitmodules                 # Submodule configuration
├── spec/                       # Detailed specifications
│   ├── GUIDE.md
│   ├── WORKER.md
│   ├── WORKTREES.md
│   ├── SUBMODULES.md
│   ├── REBASE.md
│   ├── REFLOG.md
│   ├── SAFETY.md
│   ├── CONFIG.md
│   ├── HEALTH.md
│   ├── ADVANCED.md
│   └── REFERENCES.md
├── scripts/                    # Automation scripts
│   ├── submodule-update.sh
│   ├── submodule-checkout-version.sh
│   └── submodule-rename-test.sh
├── submodules/git/git/         # Official git repository (submodule)
│   └── Documentation/          # Version-specific docs
├── version/                    # Worktrees for version comparison
└── worktrees/                  # Worktrees directory
```

### Version-Aware Documentation

This skill includes the **official git repository as a submodule** (`submodules/git/git/`), providing:

- **Authoritative documentation** matched to your git version
- **Release notes** for all git versions
- **Source code** for deep analysis
- **Worktree-based version comparison** for multi-version reference

The initialization script automatically checks out documentation matching your installed git version.

## Examples

### Worktree Workflows

```txt
"Create a worktree for feature/auth at ../feature-auth"
"List all worktrees and their status"
"Create a hotfix worktree from main"
"Clean up merged worktrees"
```

### Submodule Management

```txt
"Add a submodule for the React library"
"Update all submodules to latest"
"Show me submodule status"
"Help me rename a submodule"
```

### Safety & Recovery

```txt
"Recover my deleted branch feature/auth"
"Undo the last rebase"
"Show me reflog for the last 10 operations"
"Check repository health"
```

### Configuration

```txt
"Optimize my git configuration for safety"
"Set up recommended rebase settings"
"Configure automatic stashing"
```

## Contributing

We welcome contributions! Here's how to help:

### Reporting Issues

- Check existing issues first
- Provide git version: `git --version`
- Include error messages and context
- Describe expected vs actual behavior

### Submitting Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Follow existing code style and documentation patterns
4. Add tests if applicable (see `scripts/submodule-rename-test.sh`)
5. Update documentation as needed
6. Commit with clear messages (see [commit guidelines](#commit-guidelines))
7. Push and create a pull request

### Commit Guidelines

```txt
type: brief description

Detailed explanation of changes

Why this change was needed
What was changed
How it was tested

**Types**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

### Development

Test your changes:

```bash
# Validate submodule configuration
./scripts/submodule-rename-test.sh

# Test initialization
./scripts/submodule-checkout-version.sh

# Check links in documentation
grep -r "\[.*\](.*\.md)" spec/
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Uses the [official Git repository](https://github.com/git/git) as a submodule
- Inspired by git best practices from the community

## Support

- **Documentation**: [spec/REFERENCES.md](spec/REFERENCES.md)
- **Issues**: [GitHub Issues](https://github.com/yourusername/git-skill/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/git-skill/discussions)

---

**Note**: This skill requires git v2.5.0+ due to worktree functionality. For older git versions, some features may not be available.
