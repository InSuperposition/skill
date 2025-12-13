#!/usr/bin/env bash
#
# Update submodules/git/git submodule to latest from origin
#
# This script:
#   1. Initializes submodules/git/git submodule if not already done
#   2. Validates the submodule remote URL matches expected
#   3. Fetches latest commits and tags from origin
#   4. Leaves submodule ready for further operations

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_SUBMODULE_PATH="${ROOT_DIR}/submodules/git/git"
EXPECTED_REMOTE_URL="$(git config -f "${ROOT_DIR}/.gitmodules" submodule.git-repo.url 2>/dev/null || echo "https://github.com/git/git.git")"

echo "[git-skill] Updating submodules/git/git submodule…"

# Check for local modifications before updating
if [[ -d "${GIT_SUBMODULE_PATH}" ]]; then
    if [[ -n "$(git -C "${GIT_SUBMODULE_PATH}" status --porcelain --untracked-files=no)" ]]; then
        echo "[git-skill] Error: submodules/git/git has local modifications; please clean or stash before updating" >&2
        exit 1
    fi
fi

# Initialize submodule if needed (no --recursive, single submodule only)
git -C "${ROOT_DIR}" submodule update --init

# Validate remote URL
ACTUAL_REMOTE_URL="$(git -C "${GIT_SUBMODULE_PATH}" config --get remote.origin.url 2>/dev/null || true)"
if [[ -z "${ACTUAL_REMOTE_URL}" ]]; then
    echo "[git-skill] Error: Unable to read submodules/git/git remote URL" >&2
    exit 1
fi
if [[ "${ACTUAL_REMOTE_URL}" != "${EXPECTED_REMOTE_URL}" ]]; then
    echo "[git-skill] Error: submodules/git/git remote URL '${ACTUAL_REMOTE_URL}' does not match expected '${EXPECTED_REMOTE_URL}'" >&2
    exit 1
fi

# Fetch latest commits and tags from origin
echo "[git-skill] Fetching latest from origin…"
if [[ -n "${GIT_INIT_FETCH_FLAGS:-}" ]]; then
    # shellcheck disable=SC2206
    FETCH_ARGS=(${GIT_INIT_FETCH_FLAGS})
else
    FETCH_ARGS=()
fi
git -C "${GIT_SUBMODULE_PATH}" fetch "${FETCH_ARGS[@]}" origin

echo "[git-skill] Submodule update complete"
