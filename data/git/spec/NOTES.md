# Git Notes - Master-Level Guide for AI Agent Metadata

## Overview

Git notes provide a powerful mechanism for attaching metadata to Git objects **without modifying the objects themselves**. For AI agents and skills, this enables:

- **Non-intrusive tracking** - Add metadata without touching commits
- **Namespace isolation** - Multiple agents can maintain separate notes
- **Version control** - Notes have their own history and can be shared
- **Selective sync** - Control which notes are pushed/pulled
- **Rich metadata** - Store structured data (JSON, YAML) or plain text

**Key insight**: Notes are perfect for AI agents because they store metadata **outside** the commit history while remaining **associated** with specific commits.

**CRITICAL**: Git notes **modify the repository** by creating new commits in the notes ref. AI agents **MUST** obtain explicit user permission before adding, editing, or removing notes, just like any other repository-modifying operation.

---

## Core Concepts

### What Are Git Notes?

Notes are **additional information attached to Git objects** (usually commits):

- Stored in special refs like `refs/notes/commits`
- Don't modify the original object
- Can be added, edited, or removed anytime
- Have their own commit history
- Optional sync with remotes

### Notes vs. Commit Messages

| Aspect | Commit Messages | Git Notes |
| ------ | --------------- | --------- |
| **Mutability** | Immutable (unless rebase) | Fully mutable |
| **Visibility** | Always shown by `git log` | Shown with `--notes` flag |
| **Scope** | Part of commit object | External metadata |
| **History** | Part of repo history | Separate notes history |
| **Use case** | What changed and why | Supplemental metadata |

### Storage Model

```text
refs/notes/commits        ← Default notes namespace
refs/notes/ai-agent       ← Custom namespace for AI agents
refs/notes/skill-git      ← Custom namespace for git-skill
refs/notes/review         ← Code review notes
refs/notes/ci             ← CI/CD metadata
```

Each ref stores a tree structure mapping commit SHA-1s to note objects:

```text
refs/notes/ai-agent/
├── bf/fe30/...           ← Commit SHA (sharded for performance)
│   └── <note-blob>       ← Note content
└── 12/34ab/...
    └── <note-blob>
```

---

## AI Agent Use Cases

### 1. **Behavior Tracking**

Track AI agent actions and decisions:

```bash
# Record what the agent did
git notes --ref=ai-agent add -m '{
  "timestamp": "2025-12-11T10:30:00Z",
  "agent": "git-skill-worker",
  "action": "worktree-created",
  "details": {
    "path": "../feature-auth",
    "branch": "feature/auth"
  }
}' HEAD
```

### 2. **Skill Metadata**

Store skill-specific information:

```bash
# Record skill usage
git notes --ref=skill-git add -m '{
  "safety_level": 3,
  "mode": "worker",
  "operations": ["worktree-add", "worktree-prune"],
  "warnings": ["working-directory-dirty"]
}' HEAD
```

### 3. **Decision Rationale**

Explain why specific decisions were made:

```bash
# Record AI reasoning
git notes --ref=ai-reasoning add -m "
Strategy: Chose worktree over branch checkout
Reason: User has uncommitted changes
Alternatives considered:
  - git stash (rejected: complexity)
  - git checkout -b (rejected: dirty working dir)
" HEAD
```

### 4. **Quality Metrics**

Track code quality and test results:

```bash
# Record test results
git notes --ref=ci-results add -m '{
  "tests_passed": 142,
  "tests_failed": 0,
  "coverage": 87.3,
  "build_time": "2m 34s",
  "timestamp": "2025-12-11T10:30:00Z"
}' HEAD
```

### 5. **Context Preservation**

Maintain context across agent invocations:

```bash
# Store agent context
git notes --ref=ai-context add -m '{
  "conversation_id": "abc-123",
  "previous_tasks": [
    "created worktree",
    "ran tests"
  ],
  "next_steps": [
    "merge changes",
    "cleanup worktree"
  ]
}' HEAD
```

---

## Operations

### Basic Operations

#### Add Notes

```bash
# Add note to HEAD
git notes add -m "This is a note"

# Add note to specific commit
git notes add -m "Note for this commit" abc1234

# Add note from file
git notes add -F note.txt abc1234

# Add note interactively (opens editor)
git notes add abc1234
```

#### View Notes

```bash
# Show notes for HEAD
git notes show

# Show notes for specific commit
git notes show abc1234

# Show in git log
git log --notes

# Show multiple note namespaces
git log --notes=ai-agent --notes=skill-git
```

#### Edit Notes

```bash
# Edit existing note (opens editor)
git notes edit abc1234

# Append to existing note
git notes append -m "Additional information" abc1234

# Overwrite existing note (force)
git notes add -f -m "New content" abc1234
```

#### Remove Notes

```bash
# Remove note from HEAD
git notes remove

# Remove note from specific commit
git notes remove abc1234

# Remove notes from multiple commits
git notes remove abc1234 def5678

# Remove notes via stdin
git rev-list main | git notes remove --stdin
```

#### List Notes

```bash
# List all notes
git notes list

# List notes showing commit info
git log --notes --oneline

# Get current notes ref
git notes get-ref
```

---

## Custom Namespaces

### Why Use Custom Namespaces?

**Isolation**: Different agents don't interfere with each other
**Organization**: Separate concerns (AI, CI, review)
**Selective sync**: Push/pull only relevant notes
**Performance**: Avoid loading irrelevant notes

### Creating Custom Namespaces

```bash
# Use --ref to specify namespace
git notes --ref=ai-agent add -m "AI metadata" HEAD

# Or use environment variable
export GIT_NOTES_REF=refs/notes/ai-agent
git notes add -m "AI metadata" HEAD
```

### Namespace Conventions

**For AI agents**:

```text
refs/notes/ai-agent           ← General AI agent notes
refs/notes/ai-agent/behavior  ← Behavior tracking
refs/notes/ai-agent/context   ← Context preservation
refs/notes/ai-agent/decisions ← Decision rationale
```

**For skills**:

```text
refs/notes/skill-git          ← Git skill notes
refs/notes/skill-git/worker   ← Worker mode metadata
refs/notes/skill-git/safety   ← Safety check results
```

**For workflows**:

```text
refs/notes/review             ← Code review notes
refs/notes/ci                 ← CI/CD results
refs/notes/deployment         ← Deployment metadata
```

---

## Advanced Patterns

### 1. Structured Data Storage

Store JSON for machine-readable metadata:

```bash
# Store structured data
git notes --ref=ai-agent add -m "$(cat <<'EOF'
{
  "version": "1.0",
  "agent": {
    "name": "git-skill",
    "mode": "worker",
    "confidence": 0.95
  },
  "operations": [
    {
      "type": "worktree-add",
      "path": "../feature-auth",
      "timestamp": "2025-12-11T10:30:00Z",
      "success": true
    }
  ],
  "metadata": {
    "safety_level": 3,
    "backup_created": true
  }
}
EOF
)" HEAD

# Query structured data
git notes --ref=ai-agent show HEAD | jq '.operations[0].type'
```

### 2. Hierarchical Organization

Use multiple refs for different types of data:

```bash
# Behavior tracking
git notes --ref=ai-agent/behavior add -m "Action: created worktree" HEAD

# Context preservation
git notes --ref=ai-agent/context add -m "Task: feature development" HEAD

# Decision rationale
git notes --ref=ai-agent/decisions add -m "Chose worktree over branch" HEAD
```

### 3. Time-Series Metadata

Track changes over time:

```bash
# Append timestamped entries
git notes --ref=ai-agent/timeline append -m "
[2025-12-11 10:30] Started task
[2025-12-11 10:35] Created worktree
[2025-12-11 10:40] Ran tests
[2025-12-11 10:45] Merged changes
" HEAD
```

### 4. Multi-Agent Coordination

Different agents maintain separate notes:

```bash
# Agent A records its work
git notes --ref=agent-a add -m "Completed code generation" HEAD

# Agent B records review
git notes --ref=agent-b add -m "Code review: approved" HEAD

# Agent C records deployment
git notes --ref=agent-c add -m "Deployed to staging" HEAD

# View all agent notes
git log --notes=agent-a --notes=agent-b --notes=agent-c
```

### 5. Conditional Notes Display

Configure which notes to show by default:

```bash
# Show AI agent notes by default
git config notes.displayRef refs/notes/ai-agent

# Show multiple namespaces
git config --add notes.displayRef refs/notes/skill-git
git config --add notes.displayRef refs/notes/review

# Now git log shows these notes automatically
git log
```

---

## Syncing and Collaboration

### Pushing Notes

```bash
# Push default notes (refs/notes/commits)
git push origin refs/notes/commits

# Push custom namespace
git push origin refs/notes/ai-agent

# Push all notes
git push origin 'refs/notes/*'

# Configure automatic push
git config remote.origin.push 'refs/notes/ai-agent:refs/notes/ai-agent'
```

### Pulling Notes

```bash
# Fetch notes
git fetch origin refs/notes/ai-agent:refs/notes/ai-agent

# Configure automatic fetch
git config remote.origin.fetch '+refs/notes/*:refs/notes/*'

# Now git pull fetches notes automatically
git pull
```

### Merging Notes

When multiple people/agents add notes:

```bash
# Merge notes from remote
git fetch origin
git notes --ref=ai-agent merge origin/notes/ai-agent

# Merge strategies
git notes merge -s ours origin/notes/ai-agent      # Keep local
git notes merge -s theirs origin/notes/ai-agent    # Take remote
git notes merge -s union origin/notes/ai-agent     # Concatenate
git notes merge -s cat_sort_uniq origin/notes/ai-agent  # Merge + dedupe
```

### Selective Sharing

**Share only relevant notes**:

```bash
# Share AI behavior notes
git push origin refs/notes/ai-agent/behavior

# Don't share internal context (keep local)
# refs/notes/ai-agent/context stays local
```

---

## Permission and Safety Requirements

### ALWAYS Require User Permission

**Git notes modify the repository**. Even though they don't touch commits themselves, adding/editing/removing notes creates new commits in the notes ref (e.g., `refs/notes/ai-agent`).

**AI agents MUST:**

1. **Request explicit permission** before any notes operation:
   ```text
   Agent: "I'd like to record metadata about this operation using git notes.
          This will create a commit in refs/notes/ai-agent.
          May I proceed?"

   User: "Yes" or "No"
   ```

2. **Never assume permission** based on other operations:
   ```text
   ❌ Wrong: "Since you approved the worktree creation, I'll automatically
             record it in git notes."

   ✅ Right: "Worktree created. Would you like me to record this operation
             in git notes for future reference?"
   ```

3. **Respect user preferences**:
   ```bash
   # If user says "no", skip notes tracking
   # If user says "always", remember for session
   # If user says "never", disable notes feature
   ```

4. **Explain the impact**:
   ```text
   "Git notes will:
    - Create commits in refs/notes/ai-agent
    - Add metadata to .git/refs/notes/
    - Not modify your working directory or commits
    - Optionally sync to remote if you push notes refs"
   ```

### When Permission is Required

**ALWAYS ask permission for:**

- ✅ `git notes add` - Creates new note (modifies repo)
- ✅ `git notes append` - Modifies existing note (modifies repo)
- ✅ `git notes edit` - Modifies existing note (modifies repo)
- ✅ `git notes remove` - Deletes note (modifies repo)
- ✅ `git notes copy` - Copies note (modifies repo)
- ✅ `git notes merge` - Merges notes refs (modifies repo)
- ✅ `git notes prune` - Removes unreachable notes (modifies repo)
- ✅ `git push origin refs/notes/*` - Syncs to remote (modifies remote)

**NO permission needed for:**

- ⚪ `git notes show` - Read-only operation
- ⚪ `git notes list` - Read-only operation
- ⚪ `git notes get-ref` - Read-only operation
- ⚪ `git log --notes` - Read-only operation

### Permission Patterns

**Pattern 1: Explicit per-operation**

```text
Agent: "Operation complete. May I record this in git notes?"
User: "Yes"
Agent: *records note*
```

**Pattern 2: Session-level permission**

```text
Agent: "Would you like me to automatically track operations in git notes
        for this session?"
User: "Yes, enable automatic tracking"
Agent: *sets session flag, tracks all subsequent operations*
```

**Pattern 3: Configuration-based**

```bash
# User can configure default behavior
git config skill.notes.auto-track false  # Always ask
git config skill.notes.auto-track true   # Auto-track with notice
git config skill.notes.enabled false     # Disable completely
```

### Safety Checks Before Using Notes

Before requesting permission, verify:

1. **Git repository exists**:
   ```bash
   if ! git rev-parse --git-dir &>/dev/null; then
       echo "Not in a git repository - notes unavailable"
       return 1
   fi
   ```

2. **Notes ref is safe to use**:
   ```bash
   # Check if notes ref already exists and has uncommitted changes
   if git show-ref refs/notes/ai-agent &>/dev/null; then
       # Ref exists - safe to use
   fi
   ```

3. **User has write permissions**:
   ```bash
   # Test if we can write to .git/refs/
   if [[ ! -w "$(git rev-parse --git-dir)/refs" ]]; then
       echo "No write permission to .git/refs/"
       return 1
   fi
   ```

---

## Best Practices for AI Agents

### 1. Always Obtain Permission First

**NEVER modify repository without explicit user approval**:

```bash
# ❌ WRONG - No permission requested
git notes --ref=ai-agent add -m "metadata" HEAD

# ✅ RIGHT - Permission requested first
ask_user_permission "May I record this operation in git notes?"
if [[ $? -eq 0 ]]; then
    git notes --ref=ai-agent add -m "metadata" HEAD
fi
```

### 2. Use Namespaced Refs

**Always** use custom refs to avoid conflicts:

```bash
# ✅ Good - isolated namespace
git notes --ref=ai-agent add -m "metadata" HEAD

# ❌ Bad - uses default namespace
git notes add -m "metadata" HEAD
```

### 2. Store Structured Data

Use JSON or YAML for machine-readable data:

```bash
# ✅ Good - structured and queryable
git notes --ref=ai-agent add -m '{
  "action": "worktree-add",
  "timestamp": "2025-12-11T10:30:00Z"
}' HEAD

# ❌ Bad - unstructured text
git notes --ref=ai-agent add -m "Added worktree at 10:30" HEAD
```

### 3. Include Timestamps

Always include ISO 8601 timestamps:

```bash
# ✅ Good - includes timestamp
git notes --ref=ai-agent add -m '{
  "timestamp": "2025-12-11T10:30:00Z",
  "action": "worktree-add"
}' HEAD

# ❌ Bad - no timestamp
git notes --ref=ai-agent add -m '{
  "action": "worktree-add"
}' HEAD
```

### 4. Version Your Schema

Include schema version for future compatibility:

```bash
git notes --ref=ai-agent add -m '{
  "schema_version": "1.0",
  "timestamp": "2025-12-11T10:30:00Z",
  "data": { ... }
}' HEAD
```

### 5. Keep Notes Concise

Notes should be metadata, not documentation:

```bash
# ✅ Good - concise metadata
git notes --ref=ai-agent add -m '{
  "safety_level": 3,
  "backup_created": true
}' HEAD

# ❌ Bad - too verbose
git notes --ref=ai-agent add -m "
This commit was created with safety level 3 which means
that a backup was created before the operation because...
[500 more words]
" HEAD
```

### 6. Clean Up Old Notes

Remove notes when no longer relevant:

```bash
# Remove notes for merged branches
git notes --ref=ai-agent prune

# Remove specific old notes
git log --since="6 months ago" --format="%H" | \
  git notes --ref=ai-agent remove --stdin
```

### 7. Document Your Schema

Create a schema document for your notes format:

```bash
# Store schema in repo
cat > .git-notes-schema.json <<'EOF'
{
  "ai-agent": {
    "version": "1.0",
    "fields": {
      "timestamp": "ISO 8601 timestamp",
      "agent": "Agent identifier",
      "action": "Action performed",
      "details": "Action-specific details"
    }
  }
}
EOF
```

---

## Integration with Git Skill

### Worker Mode Integration

The git-skill worker mode can automatically record operations:

```bash
# Example: Record worktree creation
create_worktree_with_notes() {
  local path="$1"
  local branch="$2"

  # Create worktree
  git worktree add "$path" "$branch"

  # Record in notes
  git notes --ref=skill-git add -m "{
    \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
    \"operation\": \"worktree-add\",
    \"path\": \"$path\",
    \"branch\": \"$branch\",
    \"safety_level\": 2
  }" HEAD
}
```

### Safety Protocol Integration

Record safety check results:

```bash
# Before risky operation
safety_check() {
  local operation="$1"
  local level="$2"

  # Perform checks...
  local checks_passed=true
  local warnings=()

  # Record results
  git notes --ref=skill-git/safety add -m "{
    \"operation\": \"$operation\",
    \"safety_level\": $level,
    \"checks_passed\": $checks_passed,
    \"warnings\": $(printf '%s\n' "${warnings[@]}" | jq -R . | jq -s .)
  }" HEAD
}
```

### Context Preservation

Maintain context across skill invocations:

```bash
# Save context
save_skill_context() {
  git notes --ref=skill-git/context add -m "{
    \"session_id\": \"$SESSION_ID\",
    \"mode\": \"worker\",
    \"current_task\": \"$CURRENT_TASK\",
    \"state\": $(save_state_as_json)
  }" HEAD
}

# Restore context
restore_skill_context() {
  local context=$(git notes --ref=skill-git/context show HEAD)
  # Parse and restore state...
}
```

---

## Querying and Reporting

### Find Commits with Specific Notes

```bash
# Find commits with AI agent notes
git log --notes=ai-agent --grep="worktree" --all-match

# Find commits where agent performed specific action
git log --notes=ai-agent --format="%H %s" | while read hash subject; do
  note=$(git notes --ref=ai-agent show $hash 2>/dev/null)
  if echo "$note" | jq -e '.action == "worktree-add"' &>/dev/null; then
    echo "$hash: $subject"
  fi
done
```

### Generate Reports

```bash
# Generate activity report
generate_agent_report() {
  echo "AI Agent Activity Report"
  echo "========================"
  echo ""

  git log --format="%H" | while read hash; do
    note=$(git notes --ref=ai-agent show $hash 2>/dev/null)
    if [[ -n "$note" ]]; then
      timestamp=$(echo "$note" | jq -r '.timestamp')
      action=$(echo "$note" | jq -r '.action')
      echo "[$timestamp] $action ($(git show -s --format=%h $hash))"
    fi
  done | sort
}
```

### Statistics

```bash
# Count operations by type
git log --format="%H" | while read hash; do
  git notes --ref=ai-agent show $hash 2>/dev/null | jq -r '.action'
done | sort | uniq -c | sort -rn

# Average safety level
git log --format="%H" | while read hash; do
  git notes --ref=ai-agent show $hash 2>/dev/null | jq -r '.safety_level'
done | awk '{sum+=$1; count++} END {print sum/count}'
```

---

## Performance Considerations

### 1. Sharding

Git automatically shards notes for performance:

```text
refs/notes/commits/
├── bf/fe30/...    ← First 2 chars, next 2 chars, rest
└── 12/34ab/...
```

**Don't worry about this** - Git handles it automatically.

### 2. Pruning

Remove notes for commits that no longer exist:

```bash
# Prune unreachable notes
git notes --ref=ai-agent prune

# Dry run to see what would be removed
git notes --ref=ai-agent prune -n
```

### 3. Selective Fetching

Only fetch notes you need:

```bash
# Fetch only AI agent notes
git fetch origin refs/notes/ai-agent:refs/notes/ai-agent

# Don't fetch everything
# git fetch origin 'refs/notes/*:refs/notes/*'  # ❌ Overkill
```

### 4. Display Configuration

Control which notes are displayed by default:

```bash
# Only show relevant notes
git config notes.displayRef refs/notes/ai-agent
git config --add notes.displayRef refs/notes/skill-git

# Don't show all notes
# git config notes.displayRef 'refs/notes/*'  # ❌ Too much noise
```

---

## Troubleshooting

### Notes Not Showing

**Problem**: `git log` doesn't show notes

**Solutions**:

```bash
# Explicitly request notes
git log --notes

# Check which notes are configured
git config --get-all notes.displayRef

# Configure default display
git config notes.displayRef refs/notes/ai-agent
```

### Merge Conflicts

**Problem**: Notes merge conflicts

**Solutions**:

```bash
# Use automatic merge strategy
git notes merge -s union origin/notes/ai-agent

# Manual resolution
git notes merge origin/notes/ai-agent
# Edit files in .git/NOTES_MERGE_WORKTREE/
git notes merge --commit

# Abort merge
git notes merge --abort
```

### Notes Not Syncing

**Problem**: Notes not pushed/pulled

**Solutions**:

```bash
# Explicitly push notes
git push origin refs/notes/ai-agent

# Configure automatic push
git config remote.origin.push '+refs/notes/ai-agent:refs/notes/ai-agent'

# Fetch notes
git fetch origin refs/notes/ai-agent:refs/notes/ai-agent

# Configure automatic fetch
git config remote.origin.fetch '+refs/notes/*:refs/notes/*'
```

### Large Notes Performance

**Problem**: Notes are too large, causing performance issues

**Solutions**:

```bash
# Keep notes concise (< 1KB each)
# Store large data in repo, reference in notes:

# ❌ Bad - large note
git notes add -F large-file.json HEAD

# ✅ Good - reference in note
echo "large-file.json" > .git-notes/data/$(git rev-parse HEAD).json
git notes add -m "{\"data_file\": \".git-notes/data/$(git rev-parse HEAD).json\"}" HEAD
```

---

## Security Considerations

### 1. Don't Store Secrets

**Never** store sensitive information in notes:

```bash
# ❌ NEVER DO THIS
git notes add -m "{\"api_key\": \"secret123\"}" HEAD

# ✅ Store references instead
git notes add -m "{\"api_key_ref\": \"vault:ai-agent-key\"}" HEAD
```

### 2. Validate Note Content

AI agents should validate notes before processing:

```bash
# Validate JSON schema
validate_note() {
  local note="$1"

  # Check JSON validity
  if ! echo "$note" | jq . &>/dev/null; then
    echo "Error: Invalid JSON in note" >&2
    return 1
  fi

  # Validate schema
  if ! echo "$note" | jq -e '.timestamp and .action' &>/dev/null; then
    echo "Error: Missing required fields" >&2
    return 1
  fi

  return 0
}
```

### 3. Access Control

Control who can modify notes:

```bash
# Server-side hook to validate notes
# .git/hooks/update

#!/bin/bash
if [[ "$1" == "refs/notes/ai-agent" ]]; then
  # Validate note content
  # Reject if invalid
fi
```

---

## Examples for AI Agents

### Example 1: Track Skill Operations

```bash
#!/bin/bash

# Function to record skill operation
record_operation() {
  local operation="$1"
  local details="$2"

  git notes --ref=skill-git add -f -m "$(cat <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "operation": "$operation",
  "mode": "worker",
  "details": $details,
  "success": true
}
EOF
)" HEAD
}

# Use in skill
git worktree add ../feature-auth feature/auth
record_operation "worktree-add" '{
  "path": "../feature-auth",
  "branch": "feature/auth"
}'
```

### Example 2: Multi-Agent Workflow

```bash
# Agent 1: Code generator
git notes --ref=agent-code-gen add -m '{
  "timestamp": "2025-12-11T10:00:00Z",
  "generated_files": ["src/auth.ts", "src/auth.test.ts"],
  "confidence": 0.95
}' HEAD

# Agent 2: Code reviewer
git notes --ref=agent-review add -m '{
  "timestamp": "2025-12-11T10:15:00Z",
  "review_status": "approved",
  "suggestions": ["add-error-handling"],
  "confidence": 0.88
}' HEAD

# Agent 3: Test runner
git notes --ref=agent-test add -m '{
  "timestamp": "2025-12-11T10:30:00Z",
  "tests_passed": 142,
  "tests_failed": 0,
  "coverage": 87.3
}' HEAD

# Query all agent activity
git log --notes=agent-code-gen --notes=agent-review --notes=agent-test
```

### Example 3: Context Preservation

```bash
# Save context before operation
save_context() {
  git notes --ref=ai-context add -f -m "{
    \"session_id\": \"$SESSION_ID\",
    \"working_directory\": \"$(pwd)\",
    \"current_branch\": \"$(git branch --show-current)\",
    \"worktrees\": $(git worktree list --porcelain | grep -E '^worktree' | cut -d' ' -f2 | jq -R . | jq -s .),
    \"pending_tasks\": $(printf '%s\n' "${PENDING_TASKS[@]}" | jq -R . | jq -s .)
  }" HEAD
}

# Restore context in next invocation
restore_context() {
  local context=$(git notes --ref=ai-context show HEAD 2>/dev/null)

  if [[ -n "$context" ]]; then
    SESSION_ID=$(echo "$context" | jq -r '.session_id')
    PENDING_TASKS=($(echo "$context" | jq -r '.pending_tasks[]'))
    echo "Restored context from session: $SESSION_ID"
  fi
}
```

### Example 4: Decision Tracking

```bash
# Record AI decision rationale
record_decision() {
  local decision="$1"
  local reasoning="$2"
  local alternatives="$3"

  git notes --ref=ai-decisions add -m "$(cat <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "decision": "$decision",
  "reasoning": "$reasoning",
  "alternatives_considered": $alternatives,
  "confidence": 0.92
}
EOF
)" HEAD
}

# Example usage
record_decision \
  "use-worktree" \
  "Working directory has uncommitted changes. Worktree avoids stash complexity." \
  '["git-stash", "git-checkout-b", "git-clone"]'
```

---

## Configuration

### Recommended Settings

```bash
# Display AI agent notes by default
git config notes.displayRef refs/notes/ai-agent
git config --add notes.displayRef refs/notes/skill-git

# Auto-fetch notes
git config remote.origin.fetch '+refs/notes/*:refs/notes/*'

# Set merge strategy
git config notes.mergeStrategy cat_sort_uniq

# Configure rewrite behavior (preserve notes during rebase)
git config notes.rewrite.rebase true
git config notes.rewrite.amend true
```

### Per-Repository vs Global

```bash
# Per-repository (recommended for AI agents)
git config notes.displayRef refs/notes/ai-agent

# Global (for personal use)
git config --global notes.displayRef refs/notes/commits
```

---

## See Also

- [WORKER.md](WORKER.md) - Execution mode and safe operations
- [SAFETY.md](SAFETY.md) - Safety protocols for risky operations
- [CONFIG.md](CONFIG.md) - Git configuration recommendations
- Official docs: `submodules/git/git/Documentation/git-notes.adoc`
- Release notes: `submodules/git/git/Documentation/RelNotes/`

---

## Quick Reference

### Common Commands

```bash
# Add note
git notes --ref=ai-agent add -m "metadata" HEAD

# Show note
git notes --ref=ai-agent show HEAD

# Edit note
git notes --ref=ai-agent edit HEAD

# Remove note
git notes --ref=ai-agent remove HEAD

# List all notes
git notes --ref=ai-agent list

# Show in log
git log --notes=ai-agent

# Push notes
git push origin refs/notes/ai-agent

# Fetch notes
git fetch origin refs/notes/ai-agent:refs/notes/ai-agent
```

### JSON Schema Template

```jsonc
{
  "schema_version": "1.0",
  "timestamp": "2025-12-11T10:30:00Z",
  "agent": "skill-name",
  "action": "operation-name",
  "details": {
    "key": "value"
  },
  "success": true,
  "metadata": {}
}
```

---

**Master-level insight**: Git notes are the perfect mechanism for AI agents to maintain metadata without polluting commit history. Use namespaced refs, structured data, and timestamps for maximum utility.
