# Git Guide Mode - Advisory Mode

## Overview

Git Guide Mode is the **advisory mode** of the git-skill. In this mode, the skill acts as a consultant, providing expert recommendations, explanations, and best practices without executing git commands directly.

## When to Use Guide Mode

Use Guide Mode when you need:

- **Explanations** of git concepts, features, or workflows
- **Recommendations** for strategies without immediate execution
- **Best practices** guidance for git operations
- **Understanding** of git behavior and edge cases
- **Planning** before executing complex operations

## Mode Activation

Guide Mode is activated by user/agent requests that indicate advisory intent:

### Trigger Phrases

- "Explain..."
- "How do I..."
- "What is..."
- "Recommend..."
- "Should I..."
- "When should..."
- "What's the best way to..."
- "Help me understand..."

### Examples

- "Explain how git worktrees work"
- "What is the difference between rebase and merge?"
- "Should I use submodules or subtrees for this project?"
- "How do I recover from a bad rebase?"

## Response Characteristics

### What Guide Mode Provides

1. **Clear Explanations**
   - Concept definitions with real-world analogies
   - Step-by-step breakdowns of git operations
   - Visual representations (when helpful)
   - Links to official documentation

2. **Strategic Recommendations**
   - Multiple approaches with pros/cons
   - Context-aware suggestions
   - Safety considerations for each option
   - Performance implications

3. **Best Practices**
   - Industry-standard workflows
   - Common pitfalls and how to avoid them
   - Safety-first approaches
   - Clean history maintenance

4. **Example Commands**
   - Copy-paste ready commands
   - Explanation of what each command does
   - Warnings about destructive operations
   - Alternative approaches

### What Guide Mode Does NOT Do

- **Execute git commands** (use Worker Mode instead)
- **Make assumptions** about your specific situation
- **Force specific workflows** (provides options, you decide)
- **Skip safety warnings** for convenience

## Core Areas of Expertise

### Worktrees (Master-level)

Guide Mode provides comprehensive worktree guidance:

- When and why to use worktrees
- All workflow patterns (feature development, hotfixes, code review, CI/testing)
- Worktree lifecycle management
- Integration with submodules
- Performance considerations
- Cleanup strategies

**Example Question**: "How do I set up worktrees for parallel feature development?"

**Guide Mode Response**:
> Git worktrees allow you to have multiple working directories from the same repository. Here's how to set them up for parallel development:
>
> 1. **Create worktrees for each feature**:
>
>    ```bash
>    git worktree add ../feature-auth feature/auth
>    git worktree add ../feature-payments feature/payments
>    ```
>
> 2. **Work independently** in each directory - they share the same .git but have separate working directories
>
> 3. **Benefits**:
>    - No need to stash/commit incomplete work when switching
>    - Run tests in one worktree while coding in another
>    - Compare branches side-by-side
>
> 4. **Cleanup when done**:
>
>    ```bash
>    git worktree remove ../feature-auth
>    git worktree remove ../feature-payments
>    ```
>
> See [WORKTREES.md](WORKTREES.md) for advanced workflows.

### Submodules (Master-level)

Guide Mode provides comprehensive submodule guidance:

- When to use submodules vs alternatives (subtrees, monorepo)
- Conservative update strategies
- Development vs consumption workflows
- Nested submodule handling (with warnings)
- Integration with worktrees
- Common pitfalls and solutions

**Example Question**: "Should I use submodules for my project dependencies?"

**Guide Mode Response**:
> The answer depends on your use case. Here's a decision framework:
>
> **Use Submodules When**:
>
> - You need to track specific versions of external code
> - The external code has independent development lifecycle
> - You want explicit control over when to update
> - You're consuming libraries/tools, not developing them
>
> **Consider Alternatives When**:
>
> - Dependencies change frequently (consider package managers)
> - You need a monolithic repository (consider git subtree or monorepo)
> - Your team struggles with submodule complexity (consider vendoring)
>
> **Conservative Approach** (recommended):
>
> - Pin submodules to specific commits (not branches)
> - Update manually and test before committing
> - Document update procedures for your team
>
> See [SUBMODULES.md](SUBMODULES.md) for detailed workflows.

### Reflog & Recovery (Expert-level)

Guide Mode excels at crisis management guidance:

- Recovery from bad rebases
- Restoring deleted branches
- Undoing hard resets
- Finding lost commits
- Reflog retention policies
- Prevention strategies

**Example Question**: "I accidentally deleted a branch, how do I recover it?"

**Guide Mode Response**:
> Don't panic! Deleted branches can usually be recovered from the reflog:
>
> 1. **Find the deleted branch's last commit**:
>
>    ```bash
>    git reflog --all --grep-reflog="checkout: moving from deleted-branch"
>    ```
>
> 2. **Recreate the branch** at that commit:
>
>    ```bash
>    git branch deleted-branch <commit-hash>
>    ```
>
> 3. **Alternative**: Browse reflog manually:
>
>    ```bash
>    git reflog
>    # Look for entries related to your deleted branch
>    git branch recovered-branch <commit-hash>
>    ```
>
> **Important**: Reflog entries expire after 90 days by default. Act quickly!
>
> See [REFLOG.md](REFLOG.md) for more recovery scenarios.

### Rebase Mastery

Guide Mode provides expert rebase guidance:

- When to rebase vs merge
- Interactive rebase workflows
- Autosquash, fixup, reword techniques
- Safety-first approach
- Rebase vs merge vs squash-merge
- Handling conflicts during rebase

**Example Question**: "Should I rebase or merge this feature branch?"

**Guide Mode Response**:
> The choice depends on your workflow and goals:
>
> **Use Rebase When**:
>
> - Contributing to someone else's branch (clean history)
> - Your feature branch hasn't been shared/pushed
> - You want a linear, easy-to-bisect history
> - Your team prefers rebase workflows
>
> **Use Merge When**:
>
> - Integrating into main/master branch
> - The branch has been shared with others
> - You want to preserve the feature branch structure
> - The branch has many commits (merge is safer)
>
> **Safety First**:
>
> - Never rebase commits that have been pushed to shared branches
> - Always create a backup branch before rebasing: `git branch backup-feature`
> - Use `git rebase -i` for cleaning up before final merge
>
> See [REBASE.md](REBASE.md) for detailed workflows.

### Configuration Optimization

Guide Mode provides configuration recommendations:

- Safety settings (priority 1)
- Quality of life improvements (priority 2)
- Performance optimizations (priority 3)
- Platform-specific settings
- Tool integrations

**Example Question**: "What gitconfig settings should I use for safety?"

**Guide Mode Response**:
> Here are essential safety settings (priority 1):
>
> ```sh
> # Prevent accidental force pushes
> git config --global push.default simple
>
> # Automatically rebase on pull (cleaner history)
> git config --global pull.rebase true
>
> # Automatically prune deleted remote branches
> git config --global fetch.prune true
>
> # Automatically stash before rebase
> git config --global rebase.autoStash true
>
> # Set default branch name
> git config --global init.defaultBranch main
> ```
>
> See [CONFIG.md](CONFIG.md) for quality of life and performance settings.

### Repository Health

Guide Mode provides health monitoring guidance:

- What to check for repository health
- Detecting large files and bloat
- Branch hygiene (stale, merged branches)
- Commit history quality
- Remote sync status

**Example Question**: "How do I check if my repository is healthy?"

**Guide Mode Response**:
> A healthy repository should be checked for these key areas:
>
> **1. Bloat Detection**:
>
> ```bash
> # Find large files in history
> git rev-list --objects --all | \
>   git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
>   awk '/^blob/ {print substr($0,6)}' | sort -nk2 | tail -20
> ```
>
> **2. Branch Hygiene**:
>
> ```bash
> # List merged branches (safe to delete)
> git branch --merged main | grep -v "^\* main"
>
> # List remote branches that no longer exist
> git remote prune origin --dry-run
> ```
>
> **3. Sync Status**:
>
> ```bash
> # Check if branches are ahead/behind remote
> git fetch --all
> git branch -vv
> ```
>
> See [HEALTH.md](HEALTH.md) for comprehensive health checks.

## Advanced Features (On-Demand)

Guide Mode provides expert guidance for advanced features when requested:

### Sparse Checkout

- When to use sparse checkout
- Patterns and configuration
- Integration with worktrees
- Performance benefits

### Partial Clone

- Blobless clones for large repositories
- Treeless clones for CI/CD
- Trade-offs and limitations

### Git LFS

- When to use Git LFS
- Migration strategies
- Performance considerations
- Storage management

### Hooks & Automation

- Pre-commit hooks
- Integration with tools (pre-commit framework, husky)
- Custom hook examples
- Best practices

## Response Format

Guide Mode responses follow this structure:

1. **Direct Answer** to the question
2. **Context** and explanation
3. **Example Commands** (copy-paste ready)
4. **Best Practices** and warnings
5. **Links** to detailed documentation
6. **Alternatives** when applicable

## Transitioning to Worker Mode

If you need commands executed instead of explanations, Guide Mode will suggest switching:

> "Would you like me to switch to Worker Mode and execute these commands with safety checks?"

## Version Awareness

**Requirement:** This skill requires git v2.5.0+ due to worktree dependency.

Guide Mode is aware of git version differences (within supported versions ≥2.5.0):

- References version-specific features
- Warns about features not available in your git version
- Suggests upgrades when beneficial
- Provides version-specific documentation links

## Best Practices for Using Guide Mode

1. **Ask specific questions** for targeted advice
2. **Provide context** about your situation
3. **Mention constraints** (team workflow, CI/CD requirements, etc.)
4. **Request alternatives** if you want multiple approaches
5. **Ask for examples** if you need concrete commands

## Limitations

Guide Mode:

- Does **NOT execute commands** (use Worker Mode for execution)
- Does **NOT make assumptions** about your repository state
- Does **NOT force workflows** (provides options, you decide)

## See Also

- [WORKER.md](WORKER.md) - Execution mode with safety checks
- [WORKTREES.md](WORKTREES.md) - Comprehensive worktree expertise
- [SUBMODULES.md](SUBMODULES.md) - Comprehensive submodule expertise
- [SAFETY.md](SAFETY.md) - Safety protocols and checks
- [REFLOG.md](REFLOG.md) - Reflog and recovery expertise
- [REBASE.md](REBASE.md) - Rebase mastery
- [CONFIG.md](CONFIG.md) - Configuration recommendations
- [HEALTH.md](HEALTH.md) - Repository health monitoring
- [ADVANCED.md](ADVANCED.md) - Advanced features (on-demand)
