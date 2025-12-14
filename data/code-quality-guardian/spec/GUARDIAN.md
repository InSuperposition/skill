# Guardian Mode - Prevention and Standards Enforcement

## Overview

Guardian Mode prevents bad code from entering the codebase through automated quality gates, linting rules, static analysis, and CI/CD integration. It enforces standards proactively rather than finding issues after the fact.

**Philosophy**: "Prevention is better than cure" - catch issues before they reach code review.

**When to Use**:

- Setting up quality gates for CI/CD pipelines
- Configuring pre-commit hooks
- Establishing linting and formatting rules
- Implementing automated security scanning
- Preventing merges of problematic code
- Enforcing team coding standards

**Not For**:

- Manual code reviews (use [Reviewer Mode](REVIEWER.md))
- Teaching developers (use [Mentor Mode](MENTOR.md))
- One-time audits (use [Auditor Mode](AUDITOR.md))

## Activation

### Mode Selection Triggers

**Explicit Requests**:

- "Set up quality gates"
- "Configure pre-commit hooks"
- "Prevent bad code from merging"
- "Set up automated security scanning"
- "Configure linting for my project"

**Context-Based**:

- Questions about CI/CD integration
- Requests for automated checks
- Tool configuration questions

## Core Capabilities

### 1. Quality Gates

**Definition**: Automated checks that must pass before code can be merged or deployed.

**Types of Gates**:

**Security Gates**:

- Dependency vulnerability scanning (CVEs)
- Secret detection (hardcoded credentials, API keys)
- SAST (Static Application Security Testing)
- License compliance checking

**Code Quality Gates**:

- Linting (code style, potential bugs)
- Complexity thresholds (cyclomatic complexity)
- Code coverage minimums (e.g., 80%)
- Type checking (TypeScript, MyPy, etc.)

**Performance Gates**:

- Bundle size limits (frontend)
- Build time limits
- Test execution time limits

**Testing Gates**:

- All tests must pass
- No flaky tests (3+ runs)
- New code must have tests

### 2. Linting and Static Analysis

**Purpose**: Catch bugs, enforce style, prevent anti-patterns before code review.

**Language-Specific Tools**:

**Python**:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.0.0
    hooks:
      - id: black  # Formatting

  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8  # Linting
        args: [--max-line-length=88, --max-complexity=10]

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.0.0
    hooks:
      - id: mypy  # Type checking
```

**JavaScript/TypeScript**:

```json
// package.json
{
  "scripts": {
    "lint": "eslint . --ext .js,.jsx,.ts,.tsx",
    "lint:fix": "eslint . --ext .js,.jsx,.ts,.tsx --fix",
    "type-check": "tsc --noEmit",
    "format": "prettier --write ."
  },
  "devDependencies": {
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "typescript": "^5.0.0"
  }
}

// .eslintrc.json
{
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
  "rules": {
    "complexity": ["error", 10],
    "max-lines-per-function": ["warn", 50],
    "no-console": "warn"
  }
}
```

**Multi-Language**:

- **SonarQube/SonarCloud** - Comprehensive quality analysis
- **CodeQL** - Security vulnerability detection
- **Semgrep** - Custom rule engine for bugs and security

### 3. Pre-Commit Hooks

**Purpose**: Catch issues before commit, preventing broken code from reaching the repository.

**Essential Hooks**:

**Secret Detection**:

```yaml
# .pre-commit-config.yaml
- repo: https://github.com/Yelp/detect-secrets
  rev: v1.4.0
  hooks:
    - id: detect-secrets
      args: ['--baseline', '.secrets.baseline']
```

**Linting and Formatting**:

```yaml
- repo: local
  hooks:
    - id: lint
      name: Run linter
      entry: npm run lint
      language: system
      pass_filenames: false
```

**Type Checking**:

```yaml
- repo: local
  hooks:
    - id: type-check
      name: Type check
      entry: npm run type-check
      language: system
      pass_filenames: false
```

**Test Running** (fast tests only):

```yaml
- repo: local
  hooks:
    - id: fast-tests
      name: Run fast unit tests
      entry: npm test -- --onlyChanged
      language: system
      pass_filenames: false
```

### 4. CI/CD Integration

**Three-Stage Approach**:

**Stage 1: Pre-Commit (Local)**

- Fast checks (< 30 seconds)
- Linting, formatting
- Secret detection
- Fast unit tests

**Stage 2: CI Pipeline (On Push)**

- All tests (unit, integration)
- Type checking
- Code coverage
- Security scanning
- Build verification

**Stage 3: Pre-Merge (PR Required)**

- Code review (human)
- All CI checks passing
- Coverage thresholds met
- No security vulnerabilities
- Approval from maintainer

**Example GitHub Actions**:

```yaml
# .github/workflows/quality-gate.yml
name: Quality Gate

on: [pull_request]

jobs:
  quality-checks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up environment
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install dependencies
        run: npm ci

      - name: Lint
        run: npm run lint

      - name: Type check
        run: npm run type-check

      - name: Run tests
        run: npm test -- --coverage

      - name: Check coverage
        run: |
          coverage=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
          if (( $(echo "$coverage < 80" | bc -l) )); then
            echo "Coverage $coverage% is below 80%"
            exit 1
          fi

      - name: Security scan
        run: npm audit --audit-level=moderate

      - name: Dependency vulnerabilities
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

### 5. Security Automation

**Dependency Scanning**:

- **Dependabot** (GitHub) - Automated dependency updates
- **Snyk** - Vulnerability scanning with remediation
- **npm audit** / **pip-audit** - Built-in package security

**Secret Scanning**:

- **git-secrets** - Prevent committing secrets
- **detect-secrets** - Baseline and scan for secrets
- **GitHub Secret Scanning** - Automatic detection

**SAST (Static Analysis)**:

- **CodeQL** - Query-based security analysis
- **Semgrep** - Custom security rules
- **Bandit** (Python) - Security linting

**Container Security**:

- **Trivy** - Container vulnerability scanning
- **Snyk Container** - Docker image analysis

### 6. Integration with Other Skills

**Tech Stack Advisor**:

- Technology-specific tool recommendations
- Framework-specific linting rules
- Best practices for your stack
- Example: "For Python, use Black + Flake8 + MyPy + Bandit"

**Git Skill**:

- Configure git hooks
- Set up pre-receive hooks (server-side)
- Branch protection rules
- Merge requirements

**Simplicity Principles**:

- Prefer simple, proven tools over complex setups
- Start with minimal rules, add incrementally
- Avoid tool proliferation (one linter per language)
- Example: "Use ESLint's recommended config, don't create 100 custom rules"

## Guardian Implementation Guide

### Phase 1: Local Development (Week 1)

**Objective**: Catch issues before commit

**Steps**:

1. Install pre-commit framework
2. Configure linting (language-specific)
3. Add formatting (Black, Prettier, etc.)
4. Enable secret detection
5. Run fast unit tests

**Validation**:

- Developers can't commit code with linting errors
- Secrets are blocked
- Fast feedback (< 30 seconds)

### Phase 2: CI Pipeline (Week 2)

**Objective**: Comprehensive checks on every push

**Steps**:

1. Set up CI/CD (GitHub Actions, GitLab CI, etc.)
2. Run full test suite
3. Generate code coverage reports
4. Security vulnerability scanning
5. Type checking and static analysis

**Validation**:

- All checks run automatically on push
- PR status shows check results
- Failing checks block merge

### Phase 3: Quality Gates (Week 3)

**Objective**: Enforce standards before merge

**Steps**:

1. Define thresholds (coverage, complexity, etc.)
2. Configure branch protection rules
3. Require passing CI before merge
4. Require code review approval
5. Set up automated dependency updates

**Validation**:

- PRs can't merge without passing gates
- Team follows standard process
- Metrics tracked over time

## Examples

### Example 1: Setting Up Python Quality Gates

**Request**: "Set up quality gates for my Python project"

**Response**:

```md
I'll set up a comprehensive quality gate system for Python.

**Phase 1: Local Pre-Commit Hooks**

1. Install pre-commit:
   pip install pre-commit

2. Create .pre-commit-config.yaml:

repos:
  # Formatting
  - repo: https://github.com/psf/black
    rev: 23.0.0
    hooks:
      - id: black
        args: [--line-length=88]

  # Linting
  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
        args: [--max-line-length=88, --max-complexity=10]

  # Security
  - repo: https://github.com/PyCQA/bandit
    rev: 1.7.5
    hooks:
      - id: bandit
        args: [-ll]  # Low and above

  # Secret detection
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets

  # Type checking
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.0.0
    hooks:
      - id: mypy

3. Install hooks:
   pre-commit install

**Phase 2: CI Pipeline (GitHub Actions)**

Create .github/workflows/quality.yml:

name: Quality Gate
on: [pull_request, push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -e .
          pip install pytest pytest-cov

      - name: Run tests with coverage
        run: pytest --cov --cov-report=xml

      - name: Check coverage threshold
        run: |
          coverage=$(grep -oP 'line-rate="\K[^"]+' coverage.xml | awk '{print $1*100}')
          if (( $(echo "$coverage < 80" | bc -l) )); then
            echo "Coverage ${coverage}% below 80%"
            exit 1
          fi

      - name: Security audit
        run: pip-audit

**Phase 3: Branch Protection Rules**

GitHub Settings → Branches → Add Rule:
- Require pull request reviews: 1
- Require status checks: ✓ Quality Gate
- Require branches to be up to date: ✓
- Include administrators: ✓

**Result**:
- ✅ No commits with linting errors
- ✅ No secrets in code
- ✅ 80%+ test coverage enforced
- ✅ Security vulnerabilities caught
- ✅ Code review required
```

### Example 2: Preventing Security Issues

**Request**: "Prevent committing hardcoded secrets"

**Response**:

```md
I'll set up multi-layered secret detection:

**Layer 1: Pre-Commit (Immediate Feedback)**

.pre-commit-config.yaml:

- repo: https://github.com/Yelp/detect-secrets
  rev: v1.4.0
  hooks:
    - id: detect-secrets
      args: ['--baseline', '.secrets.baseline']

# Initialize baseline (current secrets)
detect-secrets scan > .secrets.baseline

# Developer commits attempt:
git commit -m "Add API key"
❌ Potential secret detected! Commit blocked.

**Layer 2: CI Pipeline (Backup Check)**

GitHub Actions step:
- name: Secret scanning
  run: |
    pip install detect-secrets
    detect-secrets scan --baseline .secrets.baseline
    if [ $? -ne 0 ]; then
      echo "Secrets detected in code!"
      exit 1
    fi

**Layer 3: GitHub Native (Repository Level)**

GitHub Settings → Security → Secret scanning: Enable

**Layer 4: Education (Mentor Mode)**

If developer asks "How do I handle secrets?":
- Use environment variables
- Use secret management (AWS Secrets Manager, etc.)
- Never commit secrets to git
- Rotate exposed secrets immediately

**Result**: 4 layers preventing secret leaks
```

### Example 3: Code Complexity Enforcement

**Request**: "Prevent overly complex code from being merged"

**Response**:

```md
I'll enforce complexity limits using static analysis:

**JavaScript/TypeScript:**

.eslintrc.json:
{
  "rules": {
    "complexity": ["error", 10],  // Max cyclomatic complexity
    "max-lines-per-function": ["error", 50],
    "max-depth": ["error", 3],
    "max-nested-callbacks": ["error", 3]
  }
}

**Python:**

.flake8:
[flake8]
max-complexity = 10
max-line-length = 88

Or use radon:
radon cc --min C .  # Fail on complexity C or worse

**CI Integration:**

- name: Check complexity
  run: |
    npm run lint  # Includes complexity checks
    # For Python:
    # radon cc --min C --total-average .

**Example Violation:**

function processOrder(order) {  // ❌ Complexity 15
  if (order.type === 'standard') {
    if (order.items.length > 10) {
      if (order.total > 1000) {
        // ... 50 more lines of nested ifs
      }
    }
  }
}

**Fix Guidance (Mentor Mode):**
- Extract functions (reduce nesting)
- Use early returns
- Apply strategy pattern for type handling

**Result**: Developers refactor before merge, not after
```

## Best Practices

**Do**:
✅ Start with minimal rules, add incrementally
✅ Make checks fast (< 2 minutes locally)
✅ Provide clear error messages
✅ Auto-fix where possible (formatting)
✅ Document why each rule exists
✅ Review and update rules quarterly
✅ Get team buy-in before enforcing

**Don't**:
❌ Block commits for style (auto-fix instead)
❌ Add too many rules at once (overwhelming)
❌ Make CI checks slow (> 10 minutes)
❌ Enforce rules retrospectively without warning
❌ Use different tools than team is familiar with
❌ Skip education (explain why rules matter)

## Tool Recommendations

**Essential (All Projects)**:

- Linter (ESLint, Flake8, etc.)
- Formatter (Prettier, Black, etc.)
- Secret detection (detect-secrets)
- Dependency scanning (Dependabot, Snyk)

**Recommended (Medium+ Projects)**:

- Type checker (TypeScript, MyPy)
- Security SAST (Bandit, Semgrep)
- Code coverage (Jest, pytest-cov)
- Pre-commit hooks

**Advanced (Large Projects)**:

- SonarQube (comprehensive analysis)
- CodeQL (advanced security)
- Custom static analysis rules
- Performance budgets

## Troubleshooting

**"Pre-commit hooks are too slow"**

- Run only fast checks pre-commit
- Move slow checks to CI
- Use `--no-verify` escape hatch (sparingly)

**"Too many false positives"**

- Tune rules gradually
- Add exceptions file (.eslintignore, etc.)
- Review rules with team

**"Team bypassing checks"**

- Make checks valuable, not annoying
- Provide education on why rules exist
- Fast feedback (< 30 seconds locally)
- Auto-fix where possible

## See Also

- [REVIEWER.md](REVIEWER.md) - Manual code review
- [MENTOR.md](MENTOR.md) - Teaching standards
- [AUDITOR.md](AUDITOR.md) - Assessing current state
- [REFERENCES.md](REFERENCES.md) - Complete navigation
- [SKILL.md](../SKILL.md) - Full specification
