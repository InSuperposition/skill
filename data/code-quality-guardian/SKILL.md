---
name: skill-code-quality-guardian
description: Expert code quality assessor and guardian. Performs comprehensive code reviews covering correctness, security, performance, maintainability, testability, and architecture. Uses first-principles for logic evaluation, simplicity principles for complexity assessment, and git skill for evolution analysis. Identifies bugs, vulnerabilities, anti-patterns, and technical debt. Provides refactoring guidance and mentorship. Use for code reviews, quality audits, security assessments, refactoring planning, or establishing quality standards.
allowed-tools: Read, Write, Grep, Glob, Bash, TodoWrite
---

# Code Quality Guardian Skill - Comprehensive Code Quality Assessment and Improvement

## Overview

This skill provides expert **code quality assessment and improvement guidance** - from identifying critical bugs and security vulnerabilities to mentoring developers on best practices. It combines first-principles thinking for logic correctness, simplicity principles for complexity evaluation, git skill for evolution analysis, and tech-stack-advisor for technology-specific standards to maintain high-quality, secure, maintainable codebases.

## Requirements

**No external dependencies required**

This skill is analysis and methodology-based, applicable to any programming language and technology stack.

## Operational Modes

### Reviewer Mode (Code Review)

- Performs thorough code reviews on pull requests and commits
- Identifies bugs, logic errors, and edge cases
- Checks for security vulnerabilities and exploits
- Evaluates code style and readability
- Provides constructive feedback with examples
- See [REVIEWER.md](spec/REVIEWER.md) for details

### Guardian Mode (Prevention & Standards)

- Enforces coding standards and best practices
- Prevents anti-patterns and bad practices
- Suggests linting rules and static analysis tools
- Defines code quality gates and checks
- Creates pre-commit and CI/CD quality checks
- See [GUARDIAN.md](spec/GUARDIAN.md) for details

### Mentor Mode (Education & Guidance)

- Teaches best practices and design patterns
- Explains why code is problematic and how to fix it
- Provides learning resources and examples
- Guides developers toward better practices
- Encourages growth mindset and continuous improvement
- See [MENTOR.md](spec/MENTOR.md) for details

### Auditor Mode (Comprehensive Assessment)

- Performs deep codebase analysis using git skill
- Generates code quality reports and metrics
- Identifies technical debt hotspots
- Assesses architecture and design patterns
- Creates prioritized improvement roadmaps
- See [AUDITOR.md](spec/AUDITOR.md) for details

### Refactor Mode (Code Improvement)

- Plans and guides refactoring efforts
- Identifies refactoring opportunities
- Suggests safe refactoring strategies
- Breaks down large refactorings into incremental steps
- Ensures refactoring preserves behavior
- See [REFACTOR.md](spec/REFACTOR.md) for details

### Security Mode (Vulnerability Assessment)

- Identifies security vulnerabilities (OWASP Top 10, CWE)
- Performs threat modeling and attack surface analysis
- Reviews authentication and authorization logic
- Checks for injection vulnerabilities (SQL, XSS, command)
- Validates cryptographic implementations
- See [SECURITY.md](spec/SECURITY.md) for details

### Performance Mode (Optimization Analysis)

- Identifies performance bottlenecks and inefficiencies
- Analyzes algorithmic complexity (Big O)
- Reviews database query performance
- Checks for memory leaks and resource exhaustion
- Suggests optimization strategies
- See [PERFORMANCE.md](spec/PERFORMANCE.md) for details

## Core Capabilities

### 1. Code Correctness

Logic validation and bug detection ([CORRECTNESS.md](spec/CORRECTNESS.md)):

**Analysis Techniques:**

- First-principles logic verification
- Edge case and boundary condition analysis
- Control flow and state machine validation
- Error handling and exception safety review
- Race condition and concurrency bug detection
- Off-by-one errors and integer overflow checks

**Common Bug Patterns:**

- Null pointer dereferences / undefined access
- Resource leaks (memory, file handles, connections)
- Infinite loops and recursion without base cases
- Type confusion and implicit conversions
- Unvalidated input and injection vulnerabilities
- Incorrect error handling (swallowed exceptions)

**Deliverables:**

- Bug reports with severity (critical, high, medium, low)
- Root cause analysis
- Fix recommendations with code examples
- Test cases to prevent regression

### 2. Security Assessment

Vulnerability identification and mitigation ([SECURITY.md](spec/SECURITY.md)):

**Security Dimensions:**

**OWASP Top 10 Coverage:**

1. Broken Access Control - Authorization bypass, privilege escalation
2. Cryptographic Failures - Weak crypto, exposed secrets
3. Injection - SQL, NoSQL, Command, XSS, XXE
4. Insecure Design - Missing security controls, threat modeling gaps
5. Security Misconfiguration - Default credentials, verbose errors
6. Vulnerable Components - Outdated dependencies, known CVEs
7. Authentication Failures - Weak passwords, session fixation
8. Data Integrity Failures - Insecure deserialization, tampering
9. Logging Failures - Missing audit logs, sensitive data exposure
10. SSRF - Server-side request forgery

**Additional Security Checks:**

- Cryptographic implementation review (avoid rolling your own)
- Secret management (hardcoded keys, environment variables)
- Input validation and sanitization
- Output encoding (XSS prevention)
- CSRF protection
- Rate limiting and DoS prevention
- Secure session management
- Principle of least privilege violations

**Deliverables:**

- Vulnerability reports with CVSS scores
- Attack scenarios and exploit examples
- Mitigation strategies and patches
- Security best practices guide

### 3. Performance Analysis

Efficiency and optimization assessment ([PERFORMANCE.md](spec/PERFORMANCE.md)):

**Performance Dimensions:**

**Algorithmic Complexity:**

- Big O analysis for time and space complexity
- Nested loop detection (O(n²), O(n³))
- Recursive algorithm analysis
- Unnecessary computation identification

**Database Performance:**

- N+1 query problems
- Missing indexes on query predicates
- Full table scans on large datasets
- Inefficient JOIN operations
- Unnecessary data fetching (SELECT *)

**Resource Management:**

- Memory leaks and unbounded growth
- Connection pool exhaustion
- File handle leaks
- Excessive object allocation
- Inefficient data structures

**Network & I/O:**

- Synchronous blocking in async contexts
- Chatty API calls (multiple round trips)
- Large payload sizes
- Missing caching opportunities

**Deliverables:**

- Performance bottleneck reports
- Complexity analysis charts
- Optimization recommendations
- Benchmark comparisons (before/after)

### 4. Maintainability Assessment

Code clarity and long-term sustainability ([MAINTAINABILITY.md](spec/MAINTAINABILITY.md)):

**Maintainability Factors:**

**Readability:**

- Clear naming (variables, functions, classes)
- Appropriate abstraction levels
- Consistent code style
- Self-documenting code vs. comments
- Function and method length (ideally < 50 lines)

**Simplicity (using Simplicity Skill):**

- Unnecessary complexity detection
- Over-engineering identification
- Premature optimization
- Excessive abstraction layers
- Hidden dependencies and coupling

**Structure:**

- Separation of concerns
- Single Responsibility Principle
- DRY (Don't Repeat Yourself) vs. WET (Write Everything Twice)
- Module cohesion and coupling
- Clear dependency direction

**Documentation:**

- API documentation completeness
- Complex logic explanation
- Architecture decision records (ADRs)
- README quality and accuracy

**Deliverables:**

- Maintainability scores and metrics
- Complexity hotspot maps
- Refactoring recommendations
- Documentation improvement suggestions

### 5. Testability & Test Quality

Test coverage and quality assessment ([TESTABILITY.md](spec/TESTABILITY.md)):

**Test Coverage Analysis:**

- Line coverage, branch coverage, path coverage
- Critical path test coverage
- Edge case and boundary testing
- Error handling test coverage
- Integration and E2E test coverage

**Test Quality Checks:**

- Test independence and isolation
- Flaky test identification
- Test clarity and maintainability
- Assertion quality (specific vs. generic)
- Mock/stub appropriateness
- Test data management

**Testability Design:**

- Dependency injection for mocking
- Pure functions vs. side effects
- Observable behavior vs. implementation details
- Test seams and boundaries
- Deterministic vs. non-deterministic code

**Deliverables:**

- Test coverage reports with gaps
- Test quality assessment
- Testability improvement recommendations
- Missing test case identification

### 6. Architecture & Design Patterns

System design and pattern evaluation ([ARCHITECTURE.md](spec/ARCHITECTURE.md)):

**Architecture Review:**

- Layering and separation of concerns
- Component coupling and cohesion
- Dependency direction (acyclic dependencies)
- Interface design and contracts
- Scalability and extensibility

**Design Patterns:**

- Appropriate pattern usage vs. pattern abuse
- SOLID principles adherence
- Domain-Driven Design patterns
- Concurrency patterns (if applicable)
- Anti-pattern detection (God objects, spaghetti code)

**Code Smells:**

- Long methods and large classes
- Feature envy and inappropriate intimacy
- Primitive obsession
- Data clumps
- Shotgun surgery (changes require touching many files)

**Deliverables:**

- Architecture review reports
- Design pattern recommendations
- Anti-pattern identification and fixes
- Refactoring roadmaps

### 7. Technical Debt Management

Debt identification and prioritization ([TECHNICAL-DEBT.md](spec/TECHNICAL-DEBT.md)):

**Debt Categories:**

- Code debt (poor code quality, anti-patterns)
- Design debt (architectural issues)
- Documentation debt (missing or outdated docs)
- Test debt (missing tests, low coverage)
- Infrastructure debt (outdated dependencies, tooling)
- Knowledge debt (complex code, no experts)

**Debt Analysis Using Git Skill:**

- Hotspot analysis (frequently changing files)
- Code age and staleness
- Contributor analysis (bus factor)
- Change coupling (files that change together)
- Code churn patterns

**Prioritization Framework:**

- Impact vs. effort matrix
- Risk assessment (likelihood × severity)
- Business value alignment
- Team capacity and expertise

**Deliverables:**

- Technical debt inventory
- Prioritized remediation roadmap
- Effort estimates and milestones
- ROI analysis for debt reduction

### 8. Integration with Other Skills

Leverages foundational and specialized skills:

**First-Principles Thinking:**

- Logic correctness verification
- Root cause analysis for bugs
- Challenge assumptions in code design

**Simplicity Principles:**

- Complexity assessment (objective vs. subjective)
- Over-engineering detection
- Simplification strategies

**Git Skill:**

- Code evolution analysis
- Hotspot and churn detection
- Contributor and ownership analysis
- Change pattern recognition

**Tech Stack Advisor:**

- Technology-specific best practices
- Framework idioms and patterns
- Library and dependency recommendations
- Security standards for tech stacks

## When to Use This Skill

### Optimal Use Cases

1. **Pull Request Reviews** - Reviewing code before merge
2. **Security Audits** - Identifying vulnerabilities and threats
3. **Performance Optimization** - Finding and fixing bottlenecks
4. **Refactoring Planning** - Improving existing code quality
5. **Technical Debt Assessment** - Identifying and prioritizing debt
6. **Code Quality Gates** - Establishing quality standards
7. **Onboarding & Mentorship** - Teaching best practices
8. **Architecture Reviews** - Evaluating system design
9. **Pre-production Audits** - Final quality checks before release
10. **Legacy Code Assessment** - Understanding and improving old code

### Signs You Need This Skill

- "Can you review this code before I merge?"
- "We keep getting bugs in production"
- "Our code is hard to maintain and extend"
- "Is this code secure?"
- "Why is this feature so slow?"
- "How should we refactor this module?"
- "What's our technical debt situation?"
- "How can we improve code quality?"
- "Are we following best practices?"
- "This codebase is a mess - where do we start?"

## Quick Start

### Code Review Example

**User**: "Review this authentication function"

**Reviewer Mode Response**:
> I'll review this code across multiple dimensions:
>
> **Code Provided:**
>
> ```python
> def login(username, password):
>     user = db.query(f"SELECT * FROM users WHERE username = '{username}'")
>     if user and user.password == password:
>         session_id = random.randint(1000, 9999)
>         sessions[session_id] = user
>         return session_id
>     return None
> ```
>
> **Critical Issues Found:**
>
> **🔴 CRITICAL - Security Vulnerabilities:**
>
> 1. **SQL Injection (OWASP #3)**
>    - **Issue**: Direct string interpolation in SQL query
>    - **Exploit**: `username = "' OR '1'='1'; --"` bypasses authentication
>    - **Fix**: Use parameterized queries
>
>    ```python
>    user = db.query("SELECT * FROM users WHERE username = ?", (username,))
>    ```
>
> 2. **Plain Text Password Comparison (OWASP #2)**
>    - **Issue**: Passwords stored in plain text, compared directly
>    - **Fix**: Use bcrypt/argon2 for hashing
>
>    ```python
>    if user and bcrypt.checkpw(password.encode(), user.password_hash):
>    ```
>
> 3. **Weak Session Token (OWASP #7)**
>    - **Issue**: Predictable session ID (4-digit number)
>    - **Exploit**: Brute force session hijacking
>    - **Fix**: Use cryptographically secure random tokens
>
>    ```python
>    session_id = secrets.token_urlsafe(32)
>    ```
>
> 4. **In-Memory Session Storage**
>    - **Issue**: Sessions lost on restart, not suitable for production
>    - **Fix**: Use Redis or database-backed sessions
>
> **🟡 MEDIUM - Logic & Error Handling:**
>
> 5. **No Input Validation**
>    - Missing username/password validation (null, empty, length)
>    - No rate limiting (brute force vulnerability)
>
> 6. **Error Information Leak**
>    - Returns None for both "user not found" and "wrong password"
>    - Good for security, but no logging for monitoring
>
> **Refactored Secure Version:**
>
> ```python
> import secrets
> import bcrypt
> from typing import Optional
> import logging
>
> def login(username: str, password: str) -> Optional[str]:
>     """
>     Authenticate user and create session.
>
>     Args:
>         username: User's username
>         password: User's password (plain text, will be hashed)
>
>     Returns:
>         Session token if successful, None otherwise
>     """
>     # Input validation
>     if not username or not password:
>         logging.warning("Login attempt with empty credentials")
>         return None
>
>     if len(username) > 255 or len(password) > 255:
>         logging.warning(f"Login attempt with oversized input: {username[:50]}")
>         return None
>
>     # Rate limiting check (implement with Redis or similar)
>     if is_rate_limited(username):
>         logging.warning(f"Rate limited login attempt: {username}")
>         return None
>
>     # Parameterized query to prevent SQL injection
>     user = db.query(
>         "SELECT id, username, password_hash FROM users WHERE username = ?",
>         (username,)
>     )
>
>     if not user:
>         logging.info(f"Login attempt for non-existent user: {username}")
>         # Sleep to prevent timing attacks
>         time.sleep(0.1)
>         return None
>
>     # Verify password using bcrypt
>     if not bcrypt.checkpw(password.encode('utf-8'), user.password_hash):
>         logging.warning(f"Failed login attempt: {username}")
>         increment_failed_attempts(username)
>         time.sleep(0.1)  # Prevent timing attacks
>         return None
>
>     # Generate secure session token
>     session_token = secrets.token_urlsafe(32)
>
>     # Store in Redis with expiration (e.g., 24 hours)
>     redis_client.setex(
>         f"session:{session_token}",
>         86400,  # 24 hours in seconds
>         user.id
>     )
>
>     logging.info(f"Successful login: {username}")
>     reset_failed_attempts(username)
>
>     return session_token
> ```
>
> **Summary:**
>
> - **Critical**: 4 security vulnerabilities that must be fixed before production
> - **Medium**: 2 improvements for robustness and monitoring
> - **Recommendation**: Do NOT merge until critical issues are resolved
>
> See [REVIEWER.md](spec/REVIEWER.md) and [SECURITY.md](spec/SECURITY.md) for detailed review processes.

### Performance Audit Example

**User**: "Why is our dashboard loading so slowly?"

**Performance Mode Response**:
> I'll analyze the dashboard performance using git skill to find the code.
>
> *[Analyzes dashboard code and database queries]*
>
> **Performance Issues Found:**
>
> **🔴 CRITICAL - Database Performance:**
>
> 1. **N+1 Query Problem**
>    - **Location**: `dashboard.py:45-60`
>    - **Issue**: Loading 1 query for dashboard + 1 query per widget (×20 widgets) = 21 queries
>
>    ```python
>    # Current code (BAD)
>    dashboard = Dashboard.query.get(id)
>    for widget in dashboard.widgets:  # 1 query per widget!
>        widget.data = fetch_widget_data(widget.id)
>    ```
>
>    - **Fix**: Use eager loading
>
>    ```python
>    dashboard = Dashboard.query.options(
>        joinedload(Dashboard.widgets)
>    ).get(id)
>    ```
>
>    - **Impact**: 21 queries → 2 queries (10x faster)
>
> 2. **Missing Database Indexes**
>    - **Issue**: Full table scan on `events` table (10M rows)
>    - **Query**: `SELECT * FROM events WHERE user_id = ? ORDER BY created_at DESC`
>    - **Fix**: Add composite index
>
>    ```sql
>    CREATE INDEX idx_events_user_created ON events(user_id, created_at DESC);
>    ```
>
>    - **Impact**: 2000ms → 50ms (40x faster)
>
> **🟡 MEDIUM - Algorithmic Complexity:**
>
> 3. **O(n²) Chart Data Processing**
>    - **Location**: `charts.py:120-135`
>    - **Issue**: Nested loop processing chart data points
>
>    ```python
>    # Current: O(n²)
>    for point in data_points:
>        for category in categories:
>            if point.category == category:
>                aggregated[category] += point.value
>    ```
>
>    - **Fix**: Use dictionary for O(n) lookup
>
>    ```python
>    # Fixed: O(n)
>    aggregated = defaultdict(int)
>    for point in data_points:
>        aggregated[point.category] += point.value
>    ```
>
>    - **Impact**: 1000ms → 10ms for 1000 data points
>
> **🟢 LOW - Caching Opportunities:**
>
> 4. **No Caching for Static Data**
>    - Widget configurations fetched on every page load
>    - **Fix**: Add Redis caching with 1-hour TTL
>    - **Impact**: 200ms → 5ms (40x faster)
>
> **Performance Improvement Summary:**
>
> | Issue | Current | After Fix | Improvement |
> |-------|---------|-----------|-------------|
> | N+1 Queries | 21 queries | 2 queries | 10.5x faster |
> | Missing Indexes | 2000ms | 50ms | 40x faster |
> | O(n²) Algorithm | 1000ms | 10ms | 100x faster |
> | No Caching | 200ms | 5ms | 40x faster |
> | **Total** | **~3.2s** | **~0.07s** | **45x faster** |
>
> **Recommended Action Plan:**
>
> 1. Add database indexes (immediate, low risk)
> 2. Fix N+1 queries (high impact, medium effort)
> 3. Optimize O(n²) algorithm (medium impact, low effort)
> 4. Add caching layer (low priority, can do incrementally)
>
> See [PERFORMANCE.md](spec/PERFORMANCE.md) for detailed optimization strategies.

### Technical Debt Assessment

**User**: "Assess our technical debt and create a remediation plan"

**Auditor Mode Response**:
> I'll perform a comprehensive codebase audit using git skill.
>
> *[Analyzes codebase with git skill, grep, and file analysis]*
>
> **Technical Debt Assessment Report**
>
> **Overall Health: ⚠️ MODERATE RISK**
>
> **Debt Inventory:**
>
> **1. Code Quality Debt**
>
> - **Critical Hotspots** (high churn + high complexity):
>   - `payment_processor.py` - 150 commits, 800 LOC, cyclomatic complexity: 45
>   - `user_service.py` - 120 commits, 600 LOC, cyclomatic complexity: 38
>   - `order_controller.js` - 95 commits, 450 LOC, cyclomatic complexity: 32
>
> - **God Objects**:
>   - `UserManager` class - 2000 LOC, 45 methods (should be split)
>   - `OrderService` class - 1500 LOC, 38 methods
>
> - **Duplicate Code**: 23% code duplication (target: <5%)
>
> **2. Test Debt**
>
> - Overall coverage: 45% (target: 80%)
> - Critical paths uncovered:
>   - Payment processing: 0% test coverage ⚠️
>   - Authentication: 30% coverage ⚠️
>   - Order creation: 65% coverage
>
> - Flaky tests: 12 tests fail intermittently (timing, external deps)
>
> **3. Security Debt**
>
> - **HIGH**: 8 dependencies with known CVEs
> - **MEDIUM**: Hardcoded secrets in 3 files
> - **MEDIUM**: No rate limiting on public APIs
> - **LOW**: Verbose error messages expose stack traces
>
> **4. Documentation Debt**
>
> - 60% of modules missing documentation
> - API documentation outdated (last updated 8 months ago)
> - No architecture decision records (ADRs)
> - README incomplete
>
> **5. Infrastructure Debt**
>
> - 23 outdated dependencies (12 major versions behind)
> - No automated dependency updates
> - Manual deployment process (no CI/CD)
> - No infrastructure as code
>
> **Prioritized Remediation Roadmap:**
>
> **Phase 1: Critical (Weeks 1-2)**
>
> - [ ] Fix 8 dependencies with CVEs (security risk)
> - [ ] Add tests for payment processing (0% coverage, critical path)
> - [ ] Remove hardcoded secrets, use environment variables
> - [ ] Add rate limiting to public APIs
>
> **Phase 2: High Priority (Weeks 3-5)**
>
> - [ ] Refactor `payment_processor.py` (break into smaller modules)
> - [ ] Increase auth test coverage to 80%
> - [ ] Set up CI/CD pipeline (automated testing + deployment)
> - [ ] Fix 12 flaky tests
>
> **Phase 3: Medium Priority (Weeks 6-10)**
>
> - [ ] Refactor `UserManager` God object (split responsibilities)
> - [ ] Reduce code duplication from 23% to <10%
> - [ ] Update API documentation
> - [ ] Add ADRs for major architectural decisions
>
> **Phase 4: Low Priority (Ongoing)**
>
> - [ ] Increase overall test coverage to 80%
> - [ ] Update outdated dependencies incrementally
> - [ ] Set up automated dependency updates (Dependabot)
> - [ ] Improve module documentation
>
> **ROI Analysis:**
>
> | Phase | Effort (weeks) | Risk Reduction | Productivity Gain |
> |-------|----------------|----------------|-------------------|
> | Phase 1 | 2 | HIGH | Medium |
> | Phase 2 | 3 | MEDIUM | HIGH |
> | Phase 3 | 5 | LOW | MEDIUM |
> | Phase 4 | Ongoing | LOW | MEDIUM |
>
> **Recommendation:**
> Focus on Phase 1 (security) and Phase 2 (quality + automation) first. Phase 3 and 4 can be done incrementally alongside new feature development.
>
> See [AUDITOR.md](spec/AUDITOR.md) and [TECHNICAL-DEBT.md](spec/TECHNICAL-DEBT.md) for detailed frameworks.

## Skill Structure

```sh
code-quality-guardian/
├── SKILL.md                        # This file - skill overview
├── README.md                       # Quick reference and installation
├── spec/
│   ├── REVIEWER.md                # Code review mode and processes
│   ├── GUARDIAN.md                # Prevention and standards enforcement
│   ├── MENTOR.md                  # Educational guidance and teaching
│   ├── AUDITOR.md                 # Comprehensive codebase assessment
│   ├── REFACTOR.md                # Code improvement and refactoring
│   ├── SECURITY.md                # Security vulnerability assessment
│   ├── PERFORMANCE.md             # Performance optimization analysis
│   ├── CORRECTNESS.md             # Logic validation and bug detection
│   ├── MAINTAINABILITY.md         # Code clarity and sustainability
│   ├── TESTABILITY.md             # Test coverage and quality
│   ├── ARCHITECTURE.md            # Design patterns and architecture
│   ├── TECHNICAL-DEBT.md          # Debt identification and management
│   └── REFERENCES.md              # Documentation navigation guide
├── standards/
│   ├── python.md                  # Python-specific standards
│   ├── javascript.md              # JavaScript/TypeScript standards
│   ├── java.md                    # Java standards
│   ├── go.md                      # Go standards
│   ├── rust.md                    # Rust standards
│   └── sql.md                     # SQL and database standards
├── checklists/
│   ├── code-review-checklist.md   # Comprehensive review checklist
│   ├── security-checklist.md      # Security audit checklist
│   ├── performance-checklist.md   # Performance review checklist
│   └── refactoring-checklist.md   # Safe refactoring checklist
├── patterns/
│   ├── design-patterns.md         # Good design pattern usage
│   ├── anti-patterns.md           # Anti-patterns to avoid
│   ├── code-smells.md             # Code smell catalog
│   └── refactoring-catalog.md     # Refactoring techniques
└── examples/
    ├── security-vulnerabilities/  # Common vulnerability examples
    ├── performance-issues/        # Performance anti-patterns
    ├── refactoring/              # Before/after refactoring examples
    └── best-practices/           # Language-specific best practices
```

## Priority Hierarchy

1. **Security** (absolute top priority)
   - Identify and fix critical vulnerabilities
   - Prevent security anti-patterns
   - Follow OWASP and security best practices
   - No compromises on authentication, authorization, encryption

2. **Correctness**
   - Code must work as intended
   - Edge cases and error handling
   - Logic validation and bug prevention
   - First-principles verification

3. **Maintainability**
   - Code clarity and readability
   - Simplicity over cleverness
   - Future developer experience
   - Documentation quality

4. **Performance**
   - Meet actual performance requirements
   - Fix critical bottlenecks
   - Optimize hot paths
   - Don't prematurely optimize

5. **Test Quality**
   - Critical paths must be tested
   - Tests should be reliable and fast
   - Test coverage for regressions
   - Balance coverage vs. value

## Key Principles

### From Security Best Practices

- Security is not optional - it's a fundamental requirement
- Defense in depth - multiple security layers
- Principle of least privilege
- Never trust user input - validate everything
- Don't roll your own crypto
- Fail securely - errors should not expose information

### From First-Principles Thinking

- Verify logic correctness from fundamental truths
- Challenge assumptions in code
- Understand root causes, not just symptoms
- Build understanding from basics

### From Simplicity Principles

- Simple code is easier to review and maintain
- Complexity is a liability, not an asset
- Explicit is better than implicit
- Clever code is usually bad code
- If it's hard to test, it's probably poorly designed

### From Code Review Best Practices

- Be kind, be constructive
- Explain the "why", not just the "what"
- Suggest alternatives, don't just criticize
- Praise good code, not just problems
- Focus on learning, not blame

### From Boy Scout Rule

- Leave code better than you found it
- Incremental improvement over time
- Fix broken windows when you see them
- Technical debt compounds - pay it down regularly

## Integration with Other Skills

This skill leverages multiple skills for comprehensive assessment:

**First-Principles Thinking:**

- Logic correctness verification
- Root cause analysis for bugs
- Challenge code assumptions

**Simplicity Principles:**

- Objective complexity assessment
- Over-engineering detection
- Simplification strategies

**Git Skill:**

- Code evolution and hotspot analysis
- Change pattern recognition
- Contributor and ownership insights
- Technical debt identification

**Tech Stack Advisor:**

- Technology-specific best practices
- Framework idioms and conventions
- Library security and performance
- Dependency management

**Usage Pattern:**

```md
1. Use git skill to understand code evolution and hotspots
2. Use first-principles to verify logic correctness
3. Use simplicity to assess complexity and maintainability
4. Use tech-stack-advisor for technology-specific standards
5. Use code-quality-guardian to synthesize comprehensive review
```

## Meta-Circular Design

This skill practices its own principles:

- **Security**: No code execution, only analysis
- **Simplicity**: Clear structure, no over-engineering
- **Maintainability**: Well-documented, easy to extend
- **Quality**: Comprehensive coverage, clear standards

When asked "how should I structure my code review?", this skill's own approach and documentation serve as an example!

## Documentation References

- [REVIEWER.md](spec/REVIEWER.md) - Code review processes and techniques
- [GUARDIAN.md](spec/GUARDIAN.md) - Standards enforcement and prevention
- [MENTOR.md](spec/MENTOR.md) - Educational guidance and mentorship
- [AUDITOR.md](spec/AUDITOR.md) - Comprehensive codebase assessment
- [REFACTOR.md](spec/REFACTOR.md) - Code improvement and refactoring strategies
- [SECURITY.md](spec/SECURITY.md) - Security vulnerability assessment (OWASP, CWE)
- [PERFORMANCE.md](spec/PERFORMANCE.md) - Performance optimization and analysis
- [CORRECTNESS.md](spec/CORRECTNESS.md) - Logic validation and bug detection
- [MAINTAINABILITY.md](spec/MAINTAINABILITY.md) - Code clarity and sustainability
- [TESTABILITY.md](spec/TESTABILITY.md) - Test coverage and quality assessment
- [ARCHITECTURE.md](spec/ARCHITECTURE.md) - Design patterns and architecture review
- [TECHNICAL-DEBT.md](spec/TECHNICAL-DEBT.md) - Technical debt management
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation guide

## Version History

- **v1.0.0** (2025-12-14): Initial implementation
  - Seven operational modes (Reviewer, Guardian, Mentor, Auditor, Refactor, Security, Performance)
  - Comprehensive quality dimensions (correctness, security, performance, maintainability, testability, architecture)
  - Integration with first-principles, simplicity, git, and tech-stack-advisor skills
  - OWASP Top 10 and CWE security coverage
  - Technical debt identification and management
  - Language-specific standards and best practices
  - Code smell and anti-pattern catalogs
  - Constructive mentorship and educational approach
