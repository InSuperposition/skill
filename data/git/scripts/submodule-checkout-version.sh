#!/usr/bin/env bash
#
# Checkout submodules/git/git submodule to tag matching local git version
#
# This script:
#   1. Ensures submodules/git/git submodule is up-to-date (via submodule-update.sh)
#   2. Detects the local git version (or uses $GIT_LOCAL_VERSION)
#   3. Fetches git tags from the submodule
#   4. Checks out the matching vX.Y.Z tag (tags default to detached HEAD state)
#   5. Leaves submodules/git/git uncommitted (runtime will re-run as needed)

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_SUBMODULE_PATH="${ROOT_DIR}/submodules/git/git"
EXPECTED_REMOTE_URL="$(git config -f "${ROOT_DIR}/.gitmodules" submodule.git-repo.url 2>/dev/null || echo "https://github.com/git/git.git")"

# Optional override via environment variable.
GIT_LOCAL_VERSION="${GIT_LOCAL_VERSION:-$(git --version | awk '{print $3}')}"
if [[ ! "${GIT_LOCAL_VERSION}" =~ ^[0-9]+(\.[0-9]+){2}(-rc[0-9]+)?$ ]]; then
    echo "[git-skill] Error: GIT_LOCAL_VERSION '${GIT_LOCAL_VERSION}' is not a valid semantic version (e.g., 2.44.0 or 2.44.0-rc2)" >&2
    exit 1
fi

# Check minimum git version requirement (v2.5.0+ required for worktree support)
MIN_VERSION="2.5.0"
CURRENT_VERSION="${GIT_LOCAL_VERSION}"

version_compare() {
    # Returns 0 if $1 >= $2, 1 otherwise
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

if ! version_compare "${CURRENT_VERSION}" "${MIN_VERSION}"; then
    echo "[git-skill] Error: This skill requires git v${MIN_VERSION} or later (worktree support required)" >&2
    echo "[git-skill] Your git version: ${CURRENT_VERSION}" >&2
    echo "[git-skill] Please upgrade git before using this skill" >&2
    exit 1
fi

# Update submodules/git/git submodule to latest from origin
"${ROOT_DIR}/scripts/submodule-update.sh"

# Fetch tags (already done by update script, but be explicit for version tag)
echo "[git-skill] Fetching tags for git ${GIT_LOCAL_VERSION}"
if [[ -n "${GIT_INIT_FETCH_FLAGS:-}" ]]; then
    # shellcheck disable=SC2206
    FETCH_ARGS=(${GIT_INIT_FETCH_FLAGS})
else
    FETCH_ARGS=()
fi
git -C "${GIT_SUBMODULE_PATH}" fetch "${FETCH_ARGS[@]}" origin --tags

TARGET_TAG="refs/tags/v${GIT_LOCAL_VERSION}"
if git -C "${GIT_SUBMODULE_PATH}" rev-parse --verify --quiet "${TARGET_TAG}" >/dev/null; then
    # Optional: verify tag signature if GPG keys are available
    if git -C "${GIT_SUBMODULE_PATH}" verify-tag "v${GIT_LOCAL_VERSION}" >/dev/null 2>&1; then
        echo "[git-skill] Tag signature verified successfully"
    else
        echo "[git-skill] Warning: Could not verify tag signature (GPG key may be missing)" >&2
    fi
    git -C "${GIT_SUBMODULE_PATH}" checkout "v${GIT_LOCAL_VERSION}"
    echo "[git-skill] Checked out tag v${GIT_LOCAL_VERSION}"
else
    echo "[git-skill] Warning: tag v${GIT_LOCAL_VERSION} not found; keeping current ref" >&2
fi

echo "[git-skill] Initialization complete. Do not commit submodules/git/git state; runtime will re-run this script."
