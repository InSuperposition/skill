# Auditor Mode - Comprehensive Codebase Assessment

## Overview

Auditor Mode performs comprehensive codebase assessments, identifies technical debt, analyzes quality metrics, and creates prioritized remediation roadmaps. It combines git skill integration for hotspot analysis with systematic quality evaluation across all dimensions.

**Philosophy**: "Measure to improve" - data-driven quality assessment and improvement planning.

**When to Use**:

- Comprehensive codebase health audits
- Technical debt assessment and prioritization
- Legacy code evaluation
- Pre-acquisition due diligence
- Quality baseline establishment
- Architecture and design reviews
- Compliance and security audits

**Not For**:

- Pull request reviews (use [Reviewer Mode](REVIEWER.md))
- Real-time enforcement (use [Guardian Mode](GUARDIAN.md))
- Teaching (use [Mentor Mode](MENTOR.md))

## Activation

### Mode Selection Triggers

**Explicit Requests**:

- "Audit our codebase"
- "Assess our technical debt"
- "What's our code quality situation?"
- "Evaluate our codebase health"
- "Identify our biggest quality issues"

**Context-Based**:

- Comprehensive assessment requests
- Technical debt questions
- Quality metric inquiries
- Health check requests

## Core Capabilities

### 1. Audit Methodology

**Four-Phase Approach**:

**Phase 1: Discovery** (Understand the Codebase)

- Repository structure and organization
- Technology stack and dependencies
- Team size and contribution patterns (git skill)
- Development practices and workflows

**Phase 2: Analysis** (Identify Issues)

- Code quality metrics
- Security vulnerabilities
- Performance bottlenecks
- Test coverage gaps
- Technical debt hotspots
- Architecture problems

**Phase 3: Assessment** (Evaluate Impact)

- Severity classification
- Business impact analysis
- Risk assessment
- Effort estimation

**Phase 4: Roadmap** (Plan Remediation)

- Prioritized issue list
- Quick wins vs. long-term fixes
- Resource requirements
- Timeline recommendations

### 2. Quality Metrics

**Code Quality Metrics**:

**Complexity**:

- Cyclomatic complexity (per function/method)
- Cognitive complexity
- Nesting depth
- Function/method length

**Duplication**:

- Code duplication percentage
- Copy-paste patterns
- Opportunities for abstraction

**Maintainability Index**:

- Combined metric (complexity, volume, duplication)
- Industry standard: 0-100 scale
- < 10: Low (needs refactoring)
- 10-20: Moderate
- > 20: Good

**Test Coverage**:

- Line coverage percentage
- Branch coverage percentage
- Critical path coverage
- Flaky test identification

**Technical Debt Metrics**:

**Debt Ratio**:

```md
Debt Ratio = (Remediation Cost) / (Development Cost)

- < 5%: Excellent
- 5-10%: Good
- 10-20%: Warning
- > 20%: Critical
```

**SQALE Rating** (Software Quality Assessment):

- A: < 5% debt ratio
- B: 5-10%
- C: 10-20%
- D: 20-50%
- E: > 50%

### 3. Git Skill Integration

**Hotspot Analysis**:

**Definition**: Files with high churn + high complexity = maintenance nightmares

**Identification**:

```bash
# Using git skill to find hotspots
# 1. High commit frequency
git log --format=format: --name-only | \
  sort | uniq -c | sort -rn | head -20

# 2. Large change volume
git log --numstat | awk '{print $3}' | \
  sort | uniq -c | sort -rn

# 3. Recent activity
git log --since="3 months ago" --name-only --format=format: | \
  sort | uniq -c | sort -rn
```

**Hotspot Metrics**:

- **Change Frequency**: Commits in last 6 months
- **Change Volume**: Lines added/deleted
- **Complexity**: Cyclomatic/cognitive complexity
- **Author Count**: How many people touch this file

**Example Hotspot Report**:

```md
Top 10 Hotspots:

File                    Commits  Complexity  Risk
payment_processor.py    150      45          ⚠️ CRITICAL
user_service.py         120      38          ⚠️ HIGH
auth.py                 95       32          🟡 MEDIUM
order_controller.js     85       28          🟡 MEDIUM
```

**Code Ownership Analysis**:

- Bus factor (how many people can maintain critical code)
- Knowledge distribution
- Abandoned code (no recent commits)
- Single point of failure identification

**Change Coupling**:

- Files that change together (potential coupling issues)
- Example: If auth.py changes, user_service.py changes 80% of the time
- Suggests tight coupling or shared responsibility

### 4. Technical Debt Classification

**Debt Categories**:

**Code Debt**:

- Poor code quality (complexity, duplication)
- Anti-patterns (god objects, spaghetti code)
- Missing error handling
- Hard-coded values

**Design Debt**:

- Architectural issues (tight coupling, low cohesion)
- Violated design principles (SOLID)
- Inappropriate patterns
- Missing abstractions

**Documentation Debt**:

- Missing or outdated documentation
- No architecture decision records (ADRs)
- Poor API documentation
- Missing README or setup instructions

**Test Debt**:

- Low test coverage (< 80%)
- Missing tests for critical paths
- Flaky or unreliable tests
- No integration/E2E tests

**Infrastructure Debt**:

- Outdated dependencies
- Missing CI/CD automation
- No deployment automation
- Manual processes

**Knowledge Debt**:

- Complex code with no experts
- High bus factor
- No knowledge transfer
- Tribal knowledge

### 5. Prioritization Framework

**Impact vs. Effort Matrix**:

```md
High Impact
    │
  4 │  [Do Later]    [Do First]
    │   Medium        High
    │   Priority      Priority
    │
  2 │  [Don't Do]    [Quick Wins]
    │   Low           Medium
    │   Priority      Priority
Low │
Impact└────────────────────────────
    2              4  High Effort
    Low Effort
```

**Priority Calculation**:

```md
Priority Score = (Business Impact × 10) +
                 (Security Risk × 10) +
                 (User Impact × 8) +
                 (Frequency × 6) -
                 (Effort × 2)

Higher score = Higher priority
```

**Risk-Based Prioritization**:

```md
Risk = Likelihood × Severity

Likelihood:
- Low: Rarely occurs
- Medium: Occasionally occurs
- High: Frequently occurs

Severity:
- Low: Minor inconvenience
- Medium: Feature degradation
- High: Data loss, security breach
```

### 6. Integration with Other Skills

**Git Skill**:

- Hotspot identification
- Code ownership analysis
- Change frequency patterns
- Historical context for decisions

**First-Principles Thinking**:

- Question why debt exists
- Challenge assumptions about necessity
- Identify root causes
- Build remediation from fundamentals

**Simplicity Principles**:

- Evaluate architectural complexity
- Identify over-engineering
- Suggest simplification strategies
- Assess cognitive load

**Tech Stack Advisor**:

- Dependency security analysis
- Technology obsolescence assessment
- Framework best practices
- Migration recommendations

## Audit Workflow

### Step 1: Initial Repository Scan

**Basic Metrics**:

```bash
# Repository size and age
git rev-list --count HEAD  # Total commits
git log --reverse --format="%ai" | head -1  # Age

# Language breakdown
cloc .  # Count lines of code

# Dependency count
# Python: pip list | wc -l
# JavaScript: cat package.json | jq '.dependencies | length'
```

**Automated Tools**:

- **SonarQube**: Comprehensive quality analysis
- **CodeClimate**: Maintainability and test coverage
- **Snyk**: Security vulnerability scanning

### Step 2: Hotspot Analysis (Git Skill)

**Identify Critical Files**:

```md
1. Find high-churn files (git skill)
2. Measure complexity (radon, eslint-complexity)
3. Cross-reference: High churn + High complexity = Hotspot
4. Prioritize for deep review
```

**Example Analysis**:

```md
payment_processor.py:
- 150 commits in 6 months
- Cyclomatic complexity: 45
- 8 authors
- 15 bug fixes
→ CRITICAL HOTSPOT: Needs immediate refactoring
```

### Step 3: Quality Assessment

**For Each Quality Dimension**:

**Security**:

- Run SAST tools (Bandit, Semgrep)
- Check dependency vulnerabilities
- Review authentication/authorization
- Scan for hardcoded secrets

**Performance**:

- Identify N+1 queries
- Check for missing database indexes
- Review algorithmic complexity
- Analyze resource usage

**Maintainability**:

- Measure complexity metrics
- Detect code smells
- Check for duplication
- Assess naming and structure

**Testability**:

- Calculate coverage percentages
- Identify untested critical paths
- Check for flaky tests
- Review test quality

### Step 4: Report Generation

**Executive Summary**:

- Overall health rating (A-E)
- Critical issues count
- Risk assessment
- Recommended actions

**Detailed Findings**:

- By category (security, performance, etc.)
- By severity (critical, high, medium, low)
- By component/module

**Prioritized Roadmap**:

- Phase 1: Critical fixes (weeks 1-2)
- Phase 2: High priority (weeks 3-5)
- Phase 3: Medium priority (weeks 6-10)
- Phase 4: Low priority (ongoing)

## Examples

### Example 1: Comprehensive Audit

**Request**: "Audit our codebase and create a remediation plan"

**Response**:

```md
# Codebase Quality Audit Report

## Executive Summary

**Overall Health**: ⚠️ MODERATE RISK (SQALE Rating: C)
**Debt Ratio**: 15% (Warning level)
**Critical Issues**: 12
**Recommendation**: Address critical security and hotspots immediately

## Key Findings

### 1. Critical Hotspots (Git Skill Analysis)

Top 3 Files Requiring Attention:

**payment_processor.py** - ⚠️ CRITICAL
- Commits (6mo): 150
- Complexity: 45
- Authors: 8
- Bug fixes: 15
- Risk: Changes frequently break, hard to maintain
- Action: Immediate refactoring required

**user_service.py** - ⚠️ HIGH
- Commits (6mo): 120
- Complexity: 38
- God Object (2000 LOC, 45 methods)
- Action: Split into focused modules

**auth.py** - 🟡 MEDIUM
- Commits (6mo): 95
- Complexity: 32
- Multiple responsibilities
- Action: Refactor for single responsibility

### 2. Security Debt

**HIGH PRIORITY**:
- 8 dependencies with known CVEs
- Hardcoded secrets in 3 files
- No rate limiting on public APIs
- Verbose error messages expose stack traces

**MEDIUM PRIORITY**:
- Missing CSRF protection
- Weak password requirements
- No security headers

### 3. Test Debt

**Coverage**: 45% (Target: 80%)

**Critical Gaps**:
- Payment processing: 0% ⚠️
- Authentication: 30%
- Order creation: 65%

**Flaky Tests**: 12 tests fail intermittently

### 4. Code Quality

**Complexity Violations**: 45 functions with complexity > 10
**Duplication**: 23% (Target: < 5%)
**God Objects**: 3 classes with > 1500 LOC

### 5. Infrastructure Debt

- 23 outdated dependencies (12 major versions behind)
- No CI/CD automation
- Manual deployment process

## Prioritized Remediation Roadmap

### Phase 1: Critical (Weeks 1-2)
Cost: 2 weeks | Risk Reduction: HIGH

- [ ] Fix 8 CVEs in dependencies
- [ ] Add tests for payment processing (0% → 80%)
- [ ] Remove hardcoded secrets
- [ ] Add rate limiting to APIs

### Phase 2: High Priority (Weeks 3-5)
Cost: 3 weeks | Risk Reduction: MEDIUM

- [ ] Refactor payment_processor.py hotspot
- [ ] Increase auth test coverage (30% → 80%)
- [ ] Set up CI/CD pipeline
- [ ] Fix 12 flaky tests

### Phase 3: Medium Priority (Weeks 6-10)
Cost: 5 weeks | Productivity Gain: MEDIUM

- [ ] Refactor user_service.py god object
- [ ] Reduce code duplication (23% → <10%)
- [ ] Update API documentation
- [ ] Add ADRs for architectural decisions

### Phase 4: Ongoing
- [ ] Increase overall coverage (45% → 80%)
- [ ] Update dependencies incrementally
- [ ] Automated dependency updates (Dependabot)
- [ ] Documentation improvements

## ROI Analysis

| Phase | Effort | Risk Reduction | Productivity Gain | ROI |
|-------|--------|----------------|-------------------|-----|
| 1 | 2wk | High | Medium | High |
| 2 | 3wk | Medium | High | High |
| 3 | 5wk | Low | Medium | Medium |
| 4 | Ongoing | Low | Medium | Low |

**Recommended Focus**: Phases 1-2 (5 weeks total)
- Eliminates critical security risks
- Improves most problematic areas
- Sets up automation for future quality

Questions?
```

### Example 2: Legacy Code Assessment

**Request**: "We inherited a legacy codebase - where do we start?"

**Response**:

```md
# Legacy Code Assessment

## Discovery Phase

**Codebase Stats**:
- Age: 5 years
- Languages: Python, JavaScript
- Total LOC: 150,000
- Dependencies: 87 (32 outdated)
- Last major refactor: 2 years ago

**Git Skill Analysis**:
- Active contributors: 3 (down from 12)
- Bus factor: 1 (critical risk)
- Knowledge concentration: 80% in 1 developer
- Abandoned modules: 15 files, no commits in 18mo

## Critical Findings

**1. Knowledge Risk - CRITICAL**
- Only 1 developer knows payment system
- No documentation
- Complex business logic
- Recommendation: Immediate knowledge capture

**2. Dependency Risk - HIGH**
- 12 dependencies with security vulnerabilities
- Python 2.7 (end of life)
- Django 1.11 (unsupported)
- Recommendation: Migration plan required

**3. Test Risk - HIGH**
- Coverage: 12%
- No integration tests
- Manual testing only
- Recommendation: Add tests before any changes

## Recommended Approach

**Phase 0: Stabilize (Week 1)**
1. Add monitoring/logging
2. Document critical workflows
3. Knowledge transfer sessions
4. No code changes yet

**Phase 1: Safety Net (Weeks 2-4)**
1. Add tests for critical paths (payment, auth)
2. Set up CI/CD
3. Automated deployment
4. Reach 40% coverage

**Phase 2: Update Dependencies (Weeks 5-8)**
1. Python 2→3 migration
2. Django upgrade path
3. Fix security vulnerabilities
4. Update incrementally

**Phase 3: Refactor Hotspots (Weeks 9-16)**
1. payment_processor.py
2. user_service.py
3. Reduce complexity

Don't try to rewrite - incremental improvement is safer.
```

## Best Practices

**Do**:
✅ Use automated tools for metrics
✅ Integrate git skill for hotspot analysis
✅ Prioritize by business impact
✅ Create actionable roadmaps
✅ Involve stakeholders in prioritization
✅ Track progress over time
✅ Re-audit quarterly

**Don't**:
❌ Audit without actionable next steps
❌ Ignore business context
❌ Try to fix everything at once
❌ Skip quick wins
❌ Forget to celebrate progress
❌ Audit just to audit (waste of time)

## See Also

- [REVIEWER.md](REVIEWER.md) - Code review mode
- [GUARDIAN.md](GUARDIAN.md) - Automated enforcement
- [MENTOR.md](MENTOR.md) - Teaching and education
- [REFERENCES.md](REFERENCES.md) - Complete navigation
- [SKILL.md](../SKILL.md) - Full specification
