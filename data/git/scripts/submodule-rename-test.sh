#!/usr/bin/env bash
#
# Test script to validate submodule rename process
#
# This script validates that a submodule rename was successful by checking:
#   1. .gitmodules configuration is correct
#   2. Submodule directory exists at new path
#   3. Submodule is properly initialized
#   4. Git index reflects the new path
#   5. Submodule scripts reference correct path
#   6. Submodule can be updated successfully

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Configuration
EXPECTED_SUBMODULE_NAME="${SUBMODULE_NAME:-git-repo}"
EXPECTED_SUBMODULE_PATH="${SUBMODULE_PATH:-}"
EXPECTED_URL="https://github.com/git/git.git"

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "  $1"
}

# Test counter
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

run_test() {
    local test_name="$1"
    local test_command="$2"

    TESTS_RUN=$((TESTS_RUN + 1))

    if eval "$test_command" >/dev/null 2>&1; then
        print_success "$test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "$test_name"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Auto-detect submodule path if not specified
detect_submodule_path() {
    if [[ -z "${EXPECTED_SUBMODULE_PATH}" ]]; then
        EXPECTED_SUBMODULE_PATH=$(git config -f "${ROOT_DIR}/.gitmodules" "submodule.${EXPECTED_SUBMODULE_NAME}.path" 2>/dev/null || echo "")
        if [[ -z "${EXPECTED_SUBMODULE_PATH}" ]]; then
            print_error "Could not detect submodule path. Please set SUBMODULE_PATH environment variable."
            exit 1
        fi
        print_info "Auto-detected submodule path: ${EXPECTED_SUBMODULE_PATH}"
    fi
}

print_header "Submodule Rename Validation Test Suite"
echo ""

detect_submodule_path

# Test 1: Check .gitmodules exists
print_header "Test 1: Configuration Files"
run_test ".gitmodules file exists" "[[ -f '${ROOT_DIR}/.gitmodules' ]]"

# Test 2: Check submodule is registered in .gitmodules
if git config -f "${ROOT_DIR}/.gitmodules" "submodule.${EXPECTED_SUBMODULE_NAME}.path" >/dev/null 2>&1; then
    REGISTERED_PATH=$(git config -f "${ROOT_DIR}/.gitmodules" "submodule.${EXPECTED_SUBMODULE_NAME}.path")
    if [[ "${REGISTERED_PATH}" == "${EXPECTED_SUBMODULE_PATH}" ]]; then
        print_success "Submodule '${EXPECTED_SUBMODULE_NAME}' registered at correct path: ${EXPECTED_SUBMODULE_PATH}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "Submodule path mismatch: expected '${EXPECTED_SUBMODULE_PATH}', got '${REGISTERED_PATH}'"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
else
    print_error "Submodule '${EXPECTED_SUBMODULE_NAME}' not found in .gitmodules"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    TESTS_RUN=$((TESTS_RUN + 1))
fi

# Test 3: Check submodule URL
REGISTERED_URL=$(git config -f "${ROOT_DIR}/.gitmodules" "submodule.${EXPECTED_SUBMODULE_NAME}.url" 2>/dev/null || echo "")
if [[ "${REGISTERED_URL}" == "${EXPECTED_URL}" ]]; then
    print_success "Submodule URL is correct: ${EXPECTED_URL}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule URL mismatch: expected '${EXPECTED_URL}', got '${REGISTERED_URL}'"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

echo ""
print_header "Test 2: Submodule Directory"

# Test 4: Check submodule directory exists
run_test "Submodule directory exists at ${EXPECTED_SUBMODULE_PATH}" "[[ -d '${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}' ]]"

# Test 5: Check .git file/directory exists in submodule
run_test "Submodule .git exists" "[[ -e '${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/.git' ]]"

# Test 6: Check if using gitfile (modern approach)
if [[ -f "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/.git" ]]; then
    print_success "Submodule uses gitfile (modern approach)"
    TESTS_PASSED=$((TESTS_PASSED + 1))

    # Check gitfile points to correct location
    GITFILE_CONTENT=$(cat "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/.git")
    if [[ "${GITFILE_CONTENT}" =~ gitdir:\ \.\./ ]]; then
        print_success "Gitfile format is valid"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_warning "Gitfile format may be non-standard: ${GITFILE_CONTENT}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 2))
elif [[ -d "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/.git" ]]; then
    print_warning "Submodule uses old .git directory (consider updating)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
    TESTS_RUN=$((TESTS_RUN + 1))
fi

echo ""
print_header "Test 3: Git Index and Status"

# Test 7: Check submodule status
SUBMODULE_STATUS=$(git submodule status "${EXPECTED_SUBMODULE_PATH}" 2>/dev/null || echo "error")
if [[ "${SUBMODULE_STATUS}" != "error" ]]; then
    print_success "Submodule status command works"
    print_info "Status: ${SUBMODULE_STATUS}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule status command failed"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 8: Check submodule is in git index
if git ls-files -s "${EXPECTED_SUBMODULE_PATH}" | grep -q "^160000"; then
    print_success "Submodule is properly tracked in git index (mode 160000)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule not found in git index with correct mode"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 9: Check for old submodule path remnants
print_info "Checking for old path remnants..."
OLD_PATHS=("git-repo" "vendor/git" "upstream-git" "source/git" "submodules/git/git/git-repo")
FOUND_OLD_PATH=false
for old_path in "${OLD_PATHS[@]}"; do
    if [[ "${old_path}" != "${EXPECTED_SUBMODULE_PATH}" ]] && git ls-files -s "${old_path}" 2>/dev/null | grep -q "^160000"; then
        print_error "Found old submodule path still in index: ${old_path}"
        FOUND_OLD_PATH=true
    fi
done
if [[ "${FOUND_OLD_PATH}" == "false" ]]; then
    print_success "No old submodule paths found in index"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

echo ""
print_header "Test 4: Script References"

# Test 10: Check submodule-checkout-version.sh references correct path
if [[ -f "${ROOT_DIR}/scripts/submodule-checkout-version.sh" ]]; then
    if grep -q "GIT_SUBMODULE_PATH=\"\${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}\"" "${ROOT_DIR}/scripts/submodule-checkout-version.sh"; then
        print_success "submodule-checkout-version.sh references correct path"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "submodule-checkout-version.sh does not reference correct path"
        print_info "Expected: GIT_SUBMODULE_PATH=\"\${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}\""
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
fi

# Test 11: Check submodule-update.sh references correct path
if [[ -f "${ROOT_DIR}/scripts/submodule-update.sh" ]]; then
    if grep -q "GIT_SUBMODULE_PATH=\"\${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}\"" "${ROOT_DIR}/scripts/submodule-update.sh"; then
        print_success "submodule-update.sh references correct path"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "submodule-update.sh does not reference correct path"
        print_info "Expected: GIT_SUBMODULE_PATH=\"\${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}\""
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
fi

echo ""
print_header "Test 5: Submodule Functionality"

# Test 12: Check submodule can be updated
print_info "Testing submodule update (this may take a moment)..."
if git -C "${ROOT_DIR}" submodule update --init "${EXPECTED_SUBMODULE_PATH}" >/dev/null 2>&1; then
    print_success "Submodule update command works"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule update command failed"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 13: Check submodule has content
if [[ -f "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/README.md" ]] || [[ -f "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}/README" ]]; then
    print_success "Submodule has content (README found)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_warning "Submodule may be empty (no README found)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 14: Check submodule git operations work
if git -C "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}" status >/dev/null 2>&1; then
    print_success "Git operations work inside submodule"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Git operations fail inside submodule"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 15: Check submodule remote URL
ACTUAL_REMOTE=$(git -C "${ROOT_DIR}/${EXPECTED_SUBMODULE_PATH}" config --get remote.origin.url 2>/dev/null || echo "")
if [[ "${ACTUAL_REMOTE}" == "${EXPECTED_URL}" ]]; then
    print_success "Submodule remote URL is correct: ${EXPECTED_URL}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule remote URL mismatch: expected '${EXPECTED_URL}', got '${ACTUAL_REMOTE}'"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

echo ""
print_header "Test 6: Module Metadata"

# Test 16: Check .git/modules directory
if [[ -d "${ROOT_DIR}/.git/modules/${EXPECTED_SUBMODULE_PATH}" ]] || [[ -d "${ROOT_DIR}/.git/modules/${EXPECTED_SUBMODULE_NAME}" ]]; then
    print_success "Submodule metadata exists in .git/modules"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_warning "Submodule metadata not found in expected location"
    TESTS_PASSED=$((TESTS_PASSED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

# Test 17: Test sync command
if git submodule sync "${EXPECTED_SUBMODULE_PATH}" >/dev/null 2>&1; then
    print_success "Submodule sync command works"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_error "Submodule sync command failed"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
TESTS_RUN=$((TESTS_RUN + 1))

echo ""
print_header "Test Results Summary"
echo ""
echo -e "Total tests run:    ${BLUE}${TESTS_RUN}${NC}"
echo -e "Tests passed:       ${GREEN}${TESTS_PASSED}${NC}"
echo -e "Tests failed:       ${RED}${TESTS_FAILED}${NC}"
echo ""

if [[ ${TESTS_FAILED} -eq 0 ]]; then
    print_success "All tests passed! Submodule rename appears successful."
    echo ""
    print_info "Next steps:"
    print_info "  1. Review git status: git status"
    print_info "  2. Test the automation scripts"
    print_info "  3. Commit changes if everything looks good"
    exit 0
else
    print_error "Some tests failed. Please review the output above."
    echo ""
    print_info "Common issues:"
    print_info "  - Scripts not updated with new path"
    print_info "  - Submodule not properly synced"
    print_info "  - Old path still in git index"
    exit 1
fi
