# Technical Debt - Identification, Management, and Paydown

## Overview

Technical debt is the implied cost of future rework caused by choosing an easy solution now instead of a better approach that would take longer. This guide covers debt identification, classification, prioritization, and paydown strategies.

**Philosophy**: "Ship first, then make it right" - but track and pay down debt strategically.

## What is Technical Debt?

### Deliberate vs Inadvertent Debt

**Deliberate Debt** (conscious decision):

```python
# ❌ Quick hack to meet deadline
def calculate_shipping(order):
    # TODO: This is temporary! Replace with proper shipping calculator
    # Deliberate debt: We know it's wrong, ship anyway
    return 5.99  # Flat rate for now
```

**Inadvertent Debt** (didn't know better):

```python
# ❌ Written before learning about SQL injection
def get_user(username):
    # Inadvertent debt: Didn't know this was vulnerable
    query = f"SELECT * FROM users WHERE name='{username}'"
    return db.execute(query)
```

### Types of Technical Debt

**Code Debt**:

- Duplicated code
- God objects
- Complex conditionals
- No tests
- Poor naming

**Design Debt**:

- Violated SOLID principles
- Leaky abstractions
- Circular dependencies
- Missing patterns

**Documentation Debt**:

- Outdated README
- No API docs
- No architecture docs
- Commented-out code

**Test Debt**:

- Low test coverage
- Flaky tests
- No integration tests
- Slow test suites

**Infrastructure Debt**:

- Outdated dependencies
- No CI/CD
- Manual deployments
- No monitoring

**Architecture Debt**:

- Monolith needing microservices
- Wrong database choice
- No caching layer
- Poor scalability

## Identifying Technical Debt

### Code Quality Metrics

**Cyclomatic Complexity**:

```python
# High complexity = debt
def process_order(order):  # Complexity: 25
    if order.type == "standard":
        if order.priority == "high":
            if order.customer.is_premium:
                if order.total > 100:
                    # ... 20 more nested conditions
```

**Code Duplication**:

```bash
# Find duplicates with simian, jscpd, or PMD
npx jscpd src/

# Output: 15% duplication (debt!)
```

**Code Churn** (using git skill):

```bash
# Files changed most frequently (likely need refactoring)
git log --format=format: --name-only | grep -v '^$' | sort | uniq -c | sort -rn | head -10
```

### Git Skill Integration

**Hotspot Analysis**:

```python
# Use git skill to find problematic areas
# Files with:
# 1. High change frequency (churn)
# 2. Many contributors (coordination overhead)
# 3. Recent bugs (defect density)

# Example git skill query:
# "Find files changed most frequently in last 6 months with high bug rate"
```

**Temporal Coupling**:

```bash
# Files that change together (hidden dependencies)
git log --format=format: --name-only | grep -v '^$' |
  # Group by commit, find co-changing files
```

**Code Age**:

```bash
# Old code without recent changes (might be stable or forgotten)
git log --all --format='%ai %H' -- path/to/file | tail -1
```

### Static Analysis Tools

**Python**:

```bash
# Complexity
radon cc src/ -a  # Cyclomatic complexity
radon mi src/     # Maintainability index

# Code smells
pylint src/
flake8 src/
```

**JavaScript**:

```bash
# Complexity
npm install -g complexity-report
cr --format plain src/

# Code smells
eslint src/
```

**Multi-Language**:

```bash
# SonarQube (comprehensive)
sonar-scanner
```

## Debt Classification

### Severity Levels

**Critical Debt** (fix now):

- Security vulnerabilities
- Data loss risks
- Production-breaking bugs
- Compliance violations

**High Debt** (fix soon):

- Performance bottlenecks
- Frequent bug sources
- Blocking new features
- High-churn hotspots

**Medium Debt** (schedule):

- Code duplication
- Missing tests
- Poor documentation
- Minor design issues

**Low Debt** (nice to have):

- Style inconsistencies
- Verbose code
- Minor refactoring opportunities

### Impact vs Effort Matrix

```md
High Impact │ 🔴 Fix Soon    │ 🟢 Quick Wins
            │ (Big payoff,   │ (Big payoff,
            │  big effort)   │  small effort)
            ├────────────────┼──────────────
Low Impact  │ 🟡 Defer       │ 🔵 Nice to Have
            │ (Low value,    │ (Low value,
            │  big effort)   │  small effort)
            └────────────────┴──────────────
               High Effort      Low Effort
```

**Prioritization Formula**:

```md
Priority Score = (Impact × Urgency) / Effort

Impact: 1-10 (business value, user pain)
Urgency: 1-10 (how soon needed)
Effort: 1-10 (time, complexity)
```

**Example**:

```python
debt_items = [
    {
        "name": "SQL injection in login",
        "impact": 10,      # Critical security issue
        "urgency": 10,     # Exploitable now
        "effort": 2,       # Easy fix (parameterize query)
        "score": (10 * 10) / 2 = 50  # 🔴 Fix immediately!
    },
    {
        "name": "Refactor god object",
        "impact": 6,       # Slows development
        "urgency": 4,      # Not blocking
        "effort": 8,       # Major refactoring
        "score": (6 * 4) / 8 = 3  # 🟡 Defer
    },
    {
        "name": "Add missing index",
        "impact": 7,       # Performance issue
        "urgency": 6,      # Users complaining
        "effort": 1,       # One-line SQL
        "score": (7 * 6) / 1 = 42  # 🟢 Quick win!
    }
]

# Sort by score
sorted_debt = sorted(debt_items, key=lambda x: x['score'], reverse=True)
```

## Debt Paydown Strategies

### Boy Scout Rule

**Principle**: Leave code better than you found it

```python
# Before touching code:
def get_user(uid):  # Bad name
    q = f"SELECT * FROM u WHERE id={uid}"  # SQL injection
    return db.exec(q)

# After boy scout cleanup:
def get_user_by_id(user_id):  # Better name
    query = "SELECT * FROM users WHERE id=?"  # Parameterized
    return db.execute(query, (user_id,))
```

**Guideline**: Spend 10-20% of time on small cleanups when touching code

### Dedicated Debt Sprints

**Approach**: Allocate time for paydown

**Example Sprint**:

```md
Sprint Goal: Reduce security debt

Tasks:
- [ ] Fix 5 SQL injection vulnerabilities (3 days)
- [ ] Update dependencies with CVEs (1 day)
- [ ] Add rate limiting to login (1 day)
- [ ] Enable security headers (0.5 days)
- [ ] Run penetration test (1 day)

Capacity: 6.5 days of 10-day sprint (65% debt, 35% features)
```

**Frequency**: Every 4-6 sprints, or 10-20% of capacity ongoing

### Strangler Fig Pattern

**Approach**: Gradually replace old system

```md
Old System (Legacy)         New System (Modern)
┌─────────────────┐        ┌─────────────────┐
│  ┌───────────┐  │        │  ┌───────────┐  │
│  │ Feature A │  │   →    │  │ Feature A │  │ (Migrated)
│  └───────────┘  │        │  └───────────┘  │
│  ┌───────────┐  │        │                 │
│  │ Feature B │  │        │  ┌───────────┐  │ (New)
│  └───────────┘  │        │  │ Feature C │  │
│  ┌───────────┐  │        │  └───────────┘  │
│  │ Feature D │  │        └─────────────────┘
│  └───────────┘  │
└─────────────────┘        (B, D still in old system)
```

**Example**:

1. Route new features to new system
2. Gradually migrate old features
3. Decommission old system when empty

### Refactoring Workflows

**Safe Refactoring**:

1. **Ensure tests exist** (coverage > 80%)
2. **Refactor incrementally** (one change at a time)
3. **Keep tests green** (run after each change)
4. **Commit frequently** (small, safe commits)

**Example**:

```bash
# Step 1: Ensure tests
pytest --cov=user_service
# Coverage: 85% ✓

# Step 2: Extract method
git commit -m "Extract validate_user method"
pytest  # ✓

# Step 3: Extract another method
git commit -m "Extract save_user method"
pytest  # ✓

# Step 4: Simplify main method
git commit -m "Simplify create_user using extracted methods"
pytest  # ✓
```

## Debt Tracking

### Debt Register

**Format**: Markdown table or issue tracker

```markdown
| ID | Description | Type | Severity | Impact | Effort | Score | Status |
|----|-------------|------|----------|--------|--------|-------|--------|
| 1  | SQL injection in auth | Security | Critical | 10 | 2 | 50 | 🔴 In Progress |
| 2  | N+1 queries in dashboard | Performance | High | 8 | 3 | 27 | 🟢 Planned |
| 3  | Missing tests for payments | Test | High | 9 | 5 | 18 | 🟡 Backlog |
| 4  | Duplicate shipping logic | Code | Medium | 4 | 2 | 8 | 🔵 Backlog |
```

### Code Comments

**TODOs** (for small debts):

```python
def calculate_discount(user, order):
    # TODO: Replace magic numbers with config
    # Debt: Hard-coded discount rates
    # Impact: Medium (hard to change rates)
    # Effort: Low (extract to config)
    # Ticket: DEBT-42
    if user.is_premium:
        return order.total * 0.2  # Magic number!
    return order.total * 0.1      # Magic number!
```

**FIXME** (for bugs/issues):

```python
def process_payment(amount):
    # FIXME: Race condition if two payments at once
    # Debt: No transaction locking
    # Impact: High (duplicate charges)
    # Effort: Medium (add DB transaction)
    # Ticket: DEBT-99
    balance = get_balance()
    if balance >= amount:
        charge(amount)  # Race condition here!
```

## Preventing New Debt

### Quality Gates

**Pre-Commit Hooks**:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: complexity-check
        name: Check cyclomatic complexity
        entry: radon cc --min B src/
        language: system
        pass_filenames: false

      - id: test-coverage
        name: Ensure test coverage > 80%
        entry: pytest --cov=src --cov-fail-under=80
        language: system
        pass_filenames: false
```

**CI/CD Checks**:

```yaml
# .github/workflows/quality.yml
- name: Security scan
  run: bandit -r src/

- name: Complexity check
  run: radon cc --min B src/

- name: Test coverage
  run: pytest --cov=src --cov-fail-under=80

- name: Dependency audit
  run: pip-audit
```

**Code Review Checklist**:

- [ ] No security vulnerabilities (OWASP Top 10)
- [ ] Test coverage > 80%
- [ ] Cyclomatic complexity < 10
- [ ] No code duplication
- [ ] SOLID principles followed
- [ ] Documentation updated

### Definition of Done

**Include Debt Prevention**:

- [ ] Code written
- [ ] Tests written (coverage > 80%)
- [ ] Code reviewed
- [ ] Documentation updated
- [ ] No new linter warnings
- [ ] No new security issues
- [ ] Performance benchmarks pass

## Measuring Debt Paydown

### Metrics

**Code Quality Trends**:

```python
# Track over time
{
    "date": "2024-01-01",
    "metrics": {
        "test_coverage": 75,
        "avg_complexity": 12,
        "duplication": 8,
        "security_issues": 5,
        "dependency_vulnerabilities": 3
    }
}

# Goal: All metrics improving
```

**Debt Ratio**:

```md
Debt Ratio = (Debt Items / Total Codebase Size)

Example:
- 50 debt items
- 10,000 LOC
- Ratio: 50 / 10,000 = 0.5%

Goal: < 1% debt ratio
```

**Paydown Velocity**:

```md
Debt Items Closed Per Sprint

Sprint 1: 3 items
Sprint 2: 5 items
Sprint 3: 4 items

Average: 4 items/sprint
```

## Integration with Other Skills

**Git Skill**:

- Hotspot analysis (high-churn files)
- Temporal coupling (co-changing files)
- Code age and staleness
- Defect density by file

**First-Principles Thinking**:

- Question why debt exists
- Understand root causes
- Prevent recurrence

**Simplicity Principles**:

- Simple code = less debt
- Avoid over-engineering
- YAGNI (You Aren't Gonna Need It)

**Tech Stack Advisor**:

- Modernization paths
- Dependency updates
- Technology evolution

## Best Practices

**Do**:
✅ Track all debt explicitly
✅ Prioritize by impact and effort
✅ Pay down continuously (boy scout rule)
✅ Prevent new debt (quality gates)
✅ Measure progress (trends, velocity)
✅ Communicate debt to stakeholders

**Don't**:
❌ Ignore debt (compounds over time)
❌ Fix everything at once (risky)
❌ Create debt without tracking
❌ Sacrifice quality for speed repeatedly
❌ Let debt accumulate unchecked

## Debt Paydown Example

### Before (High Debt)

```python
# Multiple debt issues:
# 1. God object (500 lines)
# 2. No tests
# 3. SQL injection
# 4. Duplicated logic
# 5. High complexity

class OrderManager:
    def create_order(self, data):
        # Validation (duplicated in 3 places)
        if not data.get('items'):
            raise ValueError()
        if not data.get('user_id'):
            raise ValueError()

        # SQL injection
        user = db.execute(
            f"SELECT * FROM users WHERE id={data['user_id']}"
        ).fetchone()

        # Complex calculation (complexity: 20)
        total = 0
        for item in data['items']:
            if item['type'] == 'physical':
                if item['weight'] > 10:
                    if user['is_premium']:
                        total += item['price'] * 0.9
                    else:
                        total += item['price']
                else:
                    # ... 15 more conditions

        # Database (no transaction)
        db.execute(f"INSERT INTO orders VALUES (...)")
        db.execute(f"UPDATE inventory SET quantity=...")

        # Email (hardcoded SMTP)
        smtp = SMTPClient("smtp.example.com")
        smtp.send(user['email'], "Order confirmed")

        return total
```

### After (Debt Paid Down)

```python
# Debt resolved:
# 1. ✅ Split into focused classes
# 2. ✅ Full test coverage
# 3. ✅ Parameterized queries
# 4. ✅ Extracted common logic
# 5. ✅ Simplified complexity

class OrderService:
    def __init__(self, validator, repository, calculator, notifier):
        self.validator = validator
        self.repository = repository
        self.calculator = calculator
        self.notifier = notifier

    def create_order(self, data):
        # Validation extracted
        order = self.validator.validate(data)

        # Calculation extracted
        order.total = self.calculator.calculate_total(order)

        # Repository handles DB safely
        order = self.repository.save(order)

        # Notification extracted
        self.notifier.send_confirmation(order)

        return order

class OrderValidator:
    def validate(self, data):
        if not data.get('items'):
            raise ValueError("Items required")
        if not data.get('user_id'):
            raise ValueError("User ID required")
        return Order(**data)

class OrderRepository:
    def save(self, order):
        # Parameterized query, transaction
        with self.db.transaction():
            self.db.execute(
                "INSERT INTO orders (user_id, total) VALUES (?, ?)",
                (order.user_id, order.total)
            )
            self.update_inventory(order.items)
        return order

# Tests added
def test_create_order_calculates_total():
    service = OrderService(
        validator=OrderValidator(),
        repository=MockRepository(),
        calculator=OrderCalculator(),
        notifier=MockNotifier()
    )
    order = service.create_order({
        "user_id": 1,
        "items": [{"price": 100}]
    })
    assert order.total == 100
```

## See Also

- [REFACTOR.md](REFACTOR.md) - Techniques for paying down debt
- [AUDITOR.md](AUDITOR.md) - Comprehensive debt assessment
- [ARCHITECTURE.md](ARCHITECTURE.md) - Architectural debt patterns
- [REFERENCES.md](REFERENCES.md) - Complete navigation
