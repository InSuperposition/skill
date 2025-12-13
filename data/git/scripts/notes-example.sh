#!/usr/bin/env bash
#
# Git Notes Example for AI Agent Metadata Tracking
#
# This script demonstrates practical patterns for using git notes
# to track AI agent operations and metadata.
#
# Usage:
#   ./scripts/notes-example.sh demo          # Run demo
#   ./scripts/notes-example.sh record        # Record operation
#   ./scripts/notes-example.sh report        # Generate report
#   ./scripts/notes-example.sh cleanup       # Clean up demo

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Configuration
NOTES_REF="refs/notes/ai-agent"
SKILL_NOTES_REF="refs/notes/skill-git"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo ""
    echo -e "${BLUE}===${NC} $1 ${BLUE}===${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}→${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# Check if jq is available
require_jq() {
    if ! command -v jq &>/dev/null; then
        print_error "This script requires 'jq' for JSON processing"
        print_info "Install with: brew install jq (macOS) or apt-get install jq (Ubuntu)"
        exit 1
    fi
}

# Ask for user permission (demo mode - simulated)
ask_permission() {
    local message="$1"

    # In real implementation, this would prompt the user
    # For demo purposes, we assume permission is granted
    print_info "Permission check: $message"
    print_info "(In production, agent would ask user for approval)"
    return 0
}

# Record an AI agent operation
record_operation() {
    local operation="${1:-unknown}"
    local details="${2:-{}}"
    local commit="${3:-HEAD}"

    # IMPORTANT: Always ask permission before modifying repository
    if ! ask_permission "May I record this operation in git notes (refs/notes/ai-agent)?"; then
        print_warning "Permission denied - skipping notes"
        return 1
    fi

    local timestamp
    timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    local note_content
    note_content=$(cat <<EOF
{
  "schema_version": "1.0",
  "timestamp": "$timestamp",
  "agent": "git-skill",
  "mode": "worker",
  "operation": "$operation",
  "details": $details,
  "success": true,
  "user_approved": true
}
EOF
)

    # Add note (force overwrite if exists)
    git notes --ref="$NOTES_REF" add -f -m "$note_content" "$commit"

    print_success "Recorded operation: $operation"
}

# Record skill-specific metadata
record_skill_metadata() {
    local safety_level="${1:-2}"
    local mode="${2:-worker}"
    local commit="${3:-HEAD}"

    # IMPORTANT: Always ask permission before modifying repository
    if ! ask_permission "May I record skill metadata in git notes (refs/notes/skill-git)?"; then
        print_warning "Permission denied - skipping skill metadata"
        return 1
    fi

    local timestamp
    timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    local note_content
    note_content=$(cat <<EOF
{
  "timestamp": "$timestamp",
  "safety_level": $safety_level,
  "mode": "$mode",
  "pre_flight_checks": true,
  "backup_created": true,
  "user_approved": true
}
EOF
)

    git notes --ref="$SKILL_NOTES_REF" add -f -m "$note_content" "$commit"

    print_success "Recorded skill metadata (safety level: $safety_level)"
}

# View notes for a commit
view_notes() {
    local commit="${1:-HEAD}"

    print_header "Notes for $(git rev-parse --short "$commit")"

    # AI agent notes
    if git notes --ref="$NOTES_REF" show "$commit" 2>/dev/null; then
        print_info "AI Agent Notes:"
        git notes --ref="$NOTES_REF" show "$commit" | jq -C .
    else
        print_warning "No AI agent notes found"
    fi

    echo ""

    # Skill notes
    if git notes --ref="$SKILL_NOTES_REF" show "$commit" 2>/dev/null; then
        print_info "Skill Notes:"
        git notes --ref="$SKILL_NOTES_REF" show "$commit" | jq -C .
    else
        print_warning "No skill notes found"
    fi
}

# Generate activity report
generate_report() {
    print_header "AI Agent Activity Report"

    local count=0
    local operations=()

    # Iterate through recent commits
    git log --format="%H" --max-count=20 | while read -r hash; do
        if note=$(git notes --ref="$NOTES_REF" show "$hash" 2>/dev/null); then
            count=$((count + 1))
            timestamp=$(echo "$note" | jq -r '.timestamp')
            operation=$(echo "$note" | jq -r '.operation')
            commit_short=$(git rev-parse --short "$hash")

            echo "[$timestamp] $operation ($commit_short)"
        fi
    done

    echo ""
    print_info "Total operations tracked: $(git notes --ref="$NOTES_REF" list 2>/dev/null | wc -l | xargs)"
}

# Generate statistics
generate_stats() {
    require_jq

    print_header "AI Agent Statistics"

    # Operation counts
    print_info "Operations by type:"
    git log --format="%H" | while read -r hash; do
        git notes --ref="$NOTES_REF" show "$hash" 2>/dev/null | jq -r '.operation'
    done | sort | uniq -c | sort -rn

    echo ""

    # Safety levels
    print_info "Safety levels:"
    git log --format="%H" | while read -r hash; do
        git notes --ref="$SKILL_NOTES_REF" show "$hash" 2>/dev/null | jq -r '.safety_level'
    done | sort | uniq -c | sort -rn
}

# Run demo
run_demo() {
    require_jq

    print_header "Git Notes Demo for AI Agents"

    # Check if we're in a git repo
    if ! git rev-parse --git-dir &>/dev/null; then
        print_error "Not in a git repository"
        exit 1
    fi

    print_info "This demo shows how AI agents can use git notes for metadata tracking"
    echo ""

    # Example 1: Record a worktree operation
    print_info "Example 1: Recording a worktree creation operation"
    record_operation "worktree-add" '{
        "path": "../feature-auth",
        "branch": "feature/auth",
        "reason": "parallel-development"
    }'
    record_skill_metadata 3 "worker"
    echo ""

    # Example 2: Record a safety check
    print_info "Example 2: Recording safety check results"
    record_operation "safety-check" '{
        "checks": ["working-directory-clean", "no-conflicts", "branch-exists"],
        "warnings": [],
        "passed": true
    }'
    record_skill_metadata 2 "worker"
    echo ""

    # Example 3: View notes
    print_info "Example 3: Viewing notes for HEAD"
    view_notes HEAD
    echo ""

    # Example 4: Generate report
    print_info "Example 4: Generating activity report"
    generate_report
    echo ""

    print_success "Demo complete!"
    print_info "Notes are stored in refs/notes/ai-agent and refs/notes/skill-git"
    print_info "View them with: git log --notes=ai-agent --notes=skill-git"
}

# Query notes
query_notes() {
    require_jq

    local query="${1:-}"

    if [[ -z "$query" ]]; then
        print_error "Usage: $0 query <operation-type>"
        exit 1
    fi

    print_header "Commits with operation: $query"

    git log --format="%H" | while read -r hash; do
        if note=$(git notes --ref="$NOTES_REF" show "$hash" 2>/dev/null); then
            if echo "$note" | jq -e ".operation == \"$query\"" &>/dev/null; then
                commit_short=$(git rev-parse --short "$hash")
                timestamp=$(echo "$note" | jq -r '.timestamp')
                echo "[$timestamp] $commit_short"
            fi
        fi
    done
}

# Export notes as JSON
export_notes() {
    require_jq

    local output_file="${1:-notes-export.json}"

    print_info "Exporting notes to $output_file"

    {
        echo "{"
        echo "  \"export_timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\","
        echo "  \"notes\": ["

        local first=true
        git log --format="%H" | while read -r hash; do
            if note=$(git notes --ref="$NOTES_REF" show "$hash" 2>/dev/null); then
                if [[ "$first" != true ]]; then
                    echo ","
                fi
                first=false

                echo "    {"
                echo "      \"commit\": \"$hash\","
                echo "      \"commit_short\": \"$(git rev-parse --short "$hash")\","
                echo "      \"data\": $(echo "$note" | jq -c .)"
                echo -n "    }"
            fi
        done

        echo ""
        echo "  ]"
        echo "}"
    } > "$output_file"

    print_success "Exported notes to $output_file"
}

# Cleanup demo notes
cleanup_demo() {
    print_header "Cleaning up demo notes"

    # Remove notes from HEAD
    if git notes --ref="$NOTES_REF" show HEAD &>/dev/null; then
        git notes --ref="$NOTES_REF" remove HEAD
        print_success "Removed AI agent notes from HEAD"
    fi

    if git notes --ref="$SKILL_NOTES_REF" show HEAD &>/dev/null; then
        git notes --ref="$SKILL_NOTES_REF" remove HEAD
        print_success "Removed skill notes from HEAD"
    fi

    print_info "Demo cleanup complete"
}

# Main command dispatcher
main() {
    local command="${1:-help}"

    case "$command" in
        demo)
            run_demo
            ;;
        record)
            shift
            record_operation "$@"
            ;;
        view)
            shift
            view_notes "${1:-HEAD}"
            ;;
        report)
            generate_report
            ;;
        stats)
            generate_stats
            ;;
        query)
            shift
            query_notes "$@"
            ;;
        export)
            shift
            export_notes "${1:-notes-export.json}"
            ;;
        cleanup)
            cleanup_demo
            ;;
        help|*)
            cat <<EOF
Git Notes Example Script for AI Agents

Usage:
  $0 <command> [options]

Commands:
  demo                  Run interactive demo
  record <op> [json]    Record an operation
  view [commit]         View notes for commit (default: HEAD)
  report                Generate activity report
  stats                 Generate statistics
  query <operation>     Find commits with specific operation
  export [file]         Export notes to JSON file
  cleanup               Clean up demo notes
  help                  Show this help

Examples:
  # Run the full demo
  $0 demo

  # Record a custom operation
  $0 record "custom-op" '{"key": "value"}'

  # View notes for specific commit
  $0 view abc1234

  # Generate activity report
  $0 report

  # Query for specific operations
  $0 query worktree-add

  # Export all notes
  $0 export my-notes.json

  # Cleanup demo notes
  $0 cleanup

Notes are stored in:
  - refs/notes/ai-agent        (AI agent operations)
  - refs/notes/skill-git       (Skill metadata)

View in git log:
  git log --notes=ai-agent --notes=skill-git

EOF
            ;;
    esac
}

# Run main
main "$@"
