# Reviewer Mode - Interactive Code Review

## Overview

Reviewer Mode provides interactive, thorough code reviews for pull requests, commits, and manual code inspections. It analyzes code across multiple quality dimensions (security, performance, correctness, maintainability, testability, architecture) and provides severity-based findings with actionable recommendations.

**When to Use**:

- Pull request reviews before merge
- Manual code spot-checks
- Pre-deployment code validation
- Security vulnerability scans
- Performance bottleneck detection
- Legacy code assessment

**Not For**:

- Automated CI/CD enforcement (use [Guardian Mode](GUARDIAN.md))
- Teaching best practices (use [Mentor Mode](MENTOR.md))
- Comprehensive audits (use [Auditor Mode](AUDITOR.md))

## Activation

### Mode Selection Triggers

**Explicit Requests**:

- "Review this code"
- "Check this PR"
- "Is this secure?"
- "Find bugs in this function"
- "Review for performance issues"

**Context-Based**:

- User provides code snippet or file path
- Pull request URL or git diff provided
- Security-focused questions
- Performance-focused questions

## Core Capabilities

### 1. Multi-Dimensional Analysis

**Security Review**:

- OWASP Top 10 vulnerabilities (injection, auth, crypto, etc.)
- CWE (Common Weakness Enumeration) patterns
- Hardcoded secrets, exposed credentials
- Input validation and sanitization
- Authentication and authorization flaws

**Performance Review**:

- Algorithmic complexity (Big O analysis)
- Database query optimization (N+1, missing indexes)
- Resource leaks (memory, connections, file handles)
- Unnecessary computation
- Network and I/O inefficiencies

**Correctness Review**:

- Logic errors and edge cases
- Null/undefined handling
- Off-by-one errors
- Type safety issues
- Error handling completeness
- Race conditions

**Maintainability Review**:

- Code clarity and readability
- Naming conventions
- Complexity (using simplicity skill)
- Code duplication
- Documentation quality

**Testability Review**:

- Test coverage gaps
- Missing test cases (edge cases, error paths)
- Testability design (dependency injection, pure functions)
- Test quality and reliability

**Architecture Review**:

- Design pattern appropriateness
- SOLID principles adherence
- Separation of concerns
- Coupling and cohesion
- Anti-pattern detection

### 2. Severity-Based Findings

**🔴 CRITICAL** - Must fix before merge:

- Security vulnerabilities (auth bypass, injection, crypto failures)
- Data loss or corruption risks
- Critical logic errors
- Production-breaking bugs

**🟡 HIGH** - Should fix before merge:

- Performance issues (severe bottlenecks)
- Moderate security concerns (info disclosure)
- Significant logic errors
- Maintainability problems (god objects, high complexity)

**🟠 MEDIUM** - Fix soon:

- Minor performance issues
- Code duplication
- Missing tests for non-critical paths
- Documentation gaps
- Minor anti-patterns

**🟢 LOW** - Nice to have:

- Style/formatting issues
- Optimization opportunities
- Enhanced documentation
- Refactoring suggestions

### 3. Output Format

**Review Report Structure**:

```md
## Review Summary
- X critical issues
- Y high-priority issues
- Z medium issues
- N low-priority issues

## Critical Issues
1. [Issue Name] - [Location]
   - Issue: [Description]
   - Exploit/Impact: [What could go wrong]
   - Fix: [Recommended solution with code]

## High Priority Issues
[...]

## Medium/Low Issues
[...]

## Recommendations
- Priority action items
- Overall assessment
```

**Code-Specific Format**:

```python
# Issue highlighted
def problematic_function():
    # ❌ CRITICAL: SQL Injection
    query = f"SELECT * FROM users WHERE id = {user_id}"

    # ✅ FIX: Use parameterized query
    query = "SELECT * FROM users WHERE id = ?"
    cursor.execute(query, (user_id,))
```

### 4. Integration with Other Skills

**First-Principles Thinking**:

- Verify logic correctness from fundamental truths
- Challenge assumptions in code ("Why is this check necessary?")
- Root cause analysis for bugs
- Example: "This auth check assumes user_id is always present - is that true?"

**Simplicity Principles**:

- Evaluate code complexity objectively
- Detect over-engineering (unnecessary abstractions)
- Identify hidden complexity
- Example: "This caching layer adds 3 abstraction layers for marginal benefit"

**Git Skill**:

- Analyze code history for context
- Identify hotspots (frequently changed files)
- Understand code evolution
- Check previous bug fixes in area
- Example: "This file has 45 commits in 3 months - potential hotspot"

**Tech Stack Advisor**:

- Apply technology-specific best practices
- Framework-specific patterns
- Library usage recommendations
- Example: "Use FastAPI's dependency injection instead of global state"

## Review Workflow

### Step 1: Context Gathering

**Understand the Change**:

- What is the purpose of this code?
- What problem does it solve?
- What are the requirements?
- What is the scope of changes?

**Gather Context**:

- Read commit messages
- Review PR description
- Check related issues/tickets
- Use git skill for file history

### Step 2: Initial Scan

**Quick Pass**:

- Code structure and organization
- Obvious bugs or security issues
- Test coverage presence
- Documentation presence

**Red Flags**:

- Hardcoded credentials/secrets
- Direct SQL queries with string interpolation
- Missing error handling
- Commented-out code
- TODO/FIXME comments
- Very long functions (>100 lines)

### Step 3: Deep Analysis

**Security Deep-Dive**:

- Input validation (all user inputs)
- Output encoding (XSS prevention)
- Authentication checks
- Authorization checks
- Cryptographic operations
- Secret management

**Performance Deep-Dive**:

- Database queries (N+1, indexes, SELECT *)
- Algorithmic complexity (nested loops)
- Memory usage (large objects, leaks)
- Network calls (batching, caching)

**Logic Deep-Dive**:

- Edge cases (null, empty, zero, negative, large values)
- Error paths (what if API fails?)
- State management (race conditions)
- Type safety

**Maintainability Deep-Dive**:

- Naming clarity
- Function length and complexity
- Code duplication
- Documentation completeness
- Test coverage and quality

### Step 4: Generate Findings

**Prioritize Issues**:

- Security first (always critical)
- Correctness second (bugs)
- Maintainability third
- Performance fourth (unless severe)

**Actionable Recommendations**:

- Specific fix, not just "improve this"
- Code examples where possible
- Links to relevant documentation
- Rationale for why change is needed

### Step 5: Constructive Delivery

**Positive Framing**:

- Start with what's good
- Be specific about issues
- Suggest alternatives, don't just criticize
- Focus on code, not person

**Educational Value**:

- Explain "why" not just "what"
- Link to principles (security, simplicity, etc.)
- Reference best practices
- Help developer learn

## Examples

### Example 1: Security Review

**Input**:

```python
def authenticate(username, password):
    user = db.execute(f"SELECT * FROM users WHERE name='{username}'")
    if user and user.password == password:
        return create_session(user)
    return None
```

**Output**:

```md
🔴 CRITICAL - Security Vulnerabilities (3):

1. SQL Injection (OWASP #3)
   Location: Line 2
   Issue: Direct string interpolation in SQL query
   Exploit: username="admin' OR '1'='1';--" bypasses auth
   Fix: Use parameterized queries

   db.execute("SELECT * FROM users WHERE name=?", (username,))

2. Plaintext Password Comparison (OWASP #2)
   Location: Line 3
   Issue: Passwords stored/compared in plaintext
   Fix: Use bcrypt/argon2 for password hashing

   if user and bcrypt.checkpw(password.encode(), user.password_hash):

3. No Rate Limiting (OWASP #7)
   Issue: Allows unlimited login attempts
   Fix: Implement rate limiting (5 attempts per 15 min)

🟡 HIGH - Logic Issues:
- No input validation (null/empty username/password)
- Missing logging for security events

Recommendation: DO NOT MERGE until Critical issues fixed.
Security risk: Critical - Active authentication bypass vulnerability.
```

### Example 2: Performance Review

**Input**:

```python
def get_dashboard_data(user_id):
    dashboard = Dashboard.query.get(user_id)
    widgets = []
    for widget_id in dashboard.widget_ids:
        widget = Widget.query.get(widget_id)  # N+1 query!
        widget.data = compute_data(widget)
        widgets.append(widget)
    return widgets
```

**Output**:

```md
🔴 CRITICAL - Performance Issues:

1. N+1 Query Problem
   Location: Lines 4-6
   Issue: Separate DB query for each widget (1 + N queries)
   Impact: For 20 widgets: 21 queries instead of 1-2
   Fix: Use eager loading

   dashboard = Dashboard.query.options(
       joinedload(Dashboard.widgets)
   ).get(user_id)

   Performance: 500ms → 50ms (10x faster)

🟡 MEDIUM - Optimization Opportunities:

2. Synchronous computation in loop
   Issue: compute_data() runs serially for all widgets
   Fix: Use async/await or parallel processing if data is independent

   Performance: Additional 200ms → 20ms potential savings

Recommendation: Fix N+1 before merge.
Current: ~700ms per request
After fix: ~70ms per request (10x improvement)
```

### Example 3: Correctness Review (First-Principles)

**Input**:

```python
def calculate_discount(price, discount_percent):
    discount = price * (discount_percent / 100)
    final_price = price - discount
    return final_price
```

**Output**:

```md
🟡 HIGH - Logic Issues:

1. Missing Input Validation
   Issue: No validation of inputs
   Edge cases not handled:
   - price < 0 (negative prices)
   - discount_percent < 0 (negative discounts increase price)
   - discount_percent > 100 (negative final price)
   - price or discount_percent = None (TypeError)

   First-principles question: What are valid ranges for these values?

   Fix:
   def calculate_discount(price, discount_percent):
       if price is None or discount_percent is None:
           raise ValueError("Price and discount cannot be None")
       if price < 0:
           raise ValueError("Price cannot be negative")
       if not (0 <= discount_percent <= 100):
           raise ValueError("Discount must be between 0 and 100")

       discount = price * (discount_percent / 100)
       return price - discount

🟠 MEDIUM - Code Quality:
- Missing docstring (what does this function do?)
- No type hints (Python 3.5+)

Recommendation: Add validation before merge.
Risk: Medium - Could produce incorrect prices in production.
```

### Example 4: Maintainability Review (Simplicity)

**Input**:

```python
class UserManagerServiceFactoryProvider:
    def __init__(self):
        self.cache = LRUCache()
        self.validator = ValidationService()
        self.repository = UserRepository()

    def get_user(self, id):
        # 50 lines of complex caching logic...

    def create_user(self, data):
        # 60 lines of validation and creation...

    # ... 20 more methods
```

**Output**:

```md
🟡 HIGH - Maintainability Issues:

1. God Object Anti-Pattern
   Issue: Single class doing too much (22 methods, 800 lines)
   Violates: Single Responsibility Principle
   Simplicity analysis: High coupling, low cohesion

   Fix: Split into focused classes:
   - UserCache (caching)
   - UserValidator (validation)
   - UserRepository (data access)
   - UserService (orchestration)

2. Over-Engineering
   Issue: "ManagerServiceFactoryProvider" - unnecessary abstraction layers
   Simplicity principle: "Simple is better than complex"

   Fix: Rename to "UserService" (clear, direct)

🟠 MEDIUM:
3. Long Methods
   - get_user(): 50 lines → split into smaller functions
   - create_user(): 60 lines → extract validation, creation

Recommendation: Refactor before adding more features.
Technical debt: This pattern will make future changes difficult.
```

## Integration Patterns

### With Git Skill

**Hotspot Analysis**:

```md
User: "Review auth.py"
1. Use git skill to check file history
2. Identify: "auth.py has 45 commits in 3 months"
3. Flag as hotspot in review
4. Recommend extra scrutiny or refactoring
```

**Change Context**:

```md
User: "Review this function"
1. Use git skill to see recent changes
2. Identify: "This function was changed 3 times this week"
3. Check: "Are we fixing the same bug repeatedly?"
4. Suggest root cause analysis
```

### With First-Principles

**Logic Verification**:

```md
User: "Review this auth check"
Code: if user.role != 'admin': return False

First-principles question:
- What are ALL possible role values?
- What if role is None?
- What if role is 'ADMIN' (uppercase)?
- Should empty role be allowed?

Recommendation: Whitelist approach instead of blacklist
```

### With Simplicity

**Complexity Assessment**:

```md
User: "Review this caching implementation"

Simplicity analysis:
- Counts: 3 abstraction layers for simple key-value cache
- Entanglement: Cache logic mixed with business logic
- Hiddenness: Cache invalidation logic implicit

Recommendation: Use Redis directly (proven, simple)
Instead of: CustomCacheAbstractionFactoryService
```

## Best Practices

|**Do**|**Don't**|
|------------------|------------------|
| ✅ Start with security and correctness | ❌ Focus only on style/formatting (use linters) |
| ✅ Provide specific, actionable fixes | ❌ Criticize without suggesting alternatives |
| ✅ Include code examples | ❌ Block on minor issues |
| ✅ Explain rationale ("why", not just "what") | ❌ Assume malicious intent |
| ✅ Be constructive and kind | ❌ Review without understanding context |
| ✅ Prioritize issues by severity | ❌ Miss security issues (always check) |
| ✅ Consider context (team expertise, timeline) |  |

## See Also

- [GUARDIAN.md](GUARDIAN.md) - Automated quality enforcement
- [MENTOR.md](MENTOR.md) - Educational guidance
- [AUDITOR.md](AUDITOR.md) - Comprehensive assessments
- [REFERENCES.md](REFERENCES.md) - Complete navigation guide
- [SKILL.md](../SKILL.md) - Full skill specification
