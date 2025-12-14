# Refactoring - Code Improvement and Safe Transformation

## Overview

Refactoring is the process of improving code structure without changing its behavior. This guide covers safe refactoring strategies, when to refactor, and how to avoid breaking changes.

**Philosophy**: "Make the change easy, then make the easy change" - prepare the code, then implement the feature.

## When to Refactor

**Good Times to Refactor**:

- Before adding new features (prepare the ground)
- When you touch code (boy scout rule - leave it better)
- When fixing bugs (prevent similar bugs)
- During code review (address tech debt)
- When tests are green (safety net in place)

**Bad Times to Refactor**:

- Without tests (no safety net)
- While debugging (too many variables)
- On deadline (risk without reward)
- Across the entire codebase (too risky)

## Safe Refactoring Principles

**1. Tests First**: Ensure comprehensive tests before refactoring
**2. Small Steps**: One change at a time, commit frequently
**3. Keep It Green**: Tests pass after every change
**4. No Behavior Changes**: Same inputs → same outputs
**5. Separate Refactor from Feature**: Don't mix concerns

## Common Refactoring Patterns

### Extract Method/Function

**Before**:

```python
def process_order(order):
    # Validate
    if not order.items:
        raise ValueError("Empty order")
    if order.total < 0:
        raise ValueError("Negative total")

    # Calculate
    subtotal = sum(item.price * item.quantity for item in order.items)
    tax = subtotal * 0.1
    total = subtotal + tax

    # Save
    db.save(order)
    send_confirmation(order.customer.email)
```

**After**:

```python
def process_order(order):
    validate_order(order)
    order.total = calculate_total(order)
    save_and_notify(order)

def validate_order(order):
    if not order.items:
        raise ValueError("Empty order")
    if order.total < 0:
        raise ValueError("Negative total")

def calculate_total(order):
    subtotal = sum(item.price * item.quantity for item in order.items)
    tax = subtotal * 0.1
    return subtotal + tax

def save_and_notify(order):
    db.save(order)
    send_confirmation(order.customer.email)
```

### Extract Variable

**Before**:

```python
if (user.age >= 18 and user.country == "US" and
    user.has_valid_id and not user.is_banned):
    approve_registration()
```

**After**:

```python
is_adult = user.age >= 18
is_us_resident = user.country == "US"
has_valid_credentials = user.has_valid_id and not user.is_banned

if is_adult and is_us_resident and has_valid_credentials:
    approve_registration()
```

### Replace Conditional with Polymorphism

**Before**:

```python
def calculate_shipping(order):
    if order.shipping_type == "standard":
        return order.weight * 0.5
    elif order.shipping_type == "express":
        return order.weight * 1.5 + 10
    elif order.shipping_type == "overnight":
        return order.weight * 3.0 + 25
```

**After**:

```python
class StandardShipping:
    def calculate(self, order):
        return order.weight * 0.5

class ExpressShipping:
    def calculate(self, order):
        return order.weight * 1.5 + 10

class OvernightShipping:
    def calculate(self, order):
        return order.weight * 3.0 + 25

def calculate_shipping(order):
    return order.shipping_strategy.calculate(order)
```

### Replace Magic Numbers with Constants

**Before**:

```python
if user.account_age > 30:  # What's 30?
    discount = price * 0.15  # What's 0.15?
```

**After**:

```python
LOYALTY_THRESHOLD_DAYS = 30
LOYALTY_DISCOUNT_RATE = 0.15

if user.account_age > LOYALTY_THRESHOLD_DAYS:
    discount = price * LOYALTY_DISCOUNT_RATE
```

## Refactoring Workflow

### Step 1: Ensure Tests Exist

**Check Coverage**:

```bash
# Python
pytest --cov=module_to_refactor

# JavaScript
npm test -- --coverage
```

**If Coverage < 80%**: Write tests first, then refactor

### Step 2: Identify Code Smells

**Common Smells**:

- Long methods (> 50 lines)
- Large classes (> 500 lines)
- Duplicated code
- Long parameter lists (> 4 params)
- Complex conditionals
- Feature envy (method uses another class more than its own)

### Step 3: Plan Small Steps

**Bad**: "Rewrite the entire module"
**Good**:

1. Extract validation logic
2. Extract calculation logic
3. Simplify conditionals
4. Remove duplication

### Step 4: Refactor Incrementally

**For Each Step**:

1. Make one change
2. Run tests (should pass)
3. Commit
4. Repeat

**Example Commit Sequence**:

```sh
git commit -m "Extract validate_order method"
git commit -m "Extract calculate_total method"
git commit -m "Extract save_and_notify method"
git commit -m "Simplify process_order using extracted methods"
```

### Step 5: Review and Document

**After Refactoring**:

- Code review the changes
- Update documentation
- Celebrate improvement!

## Integration with Other Skills

**Simplicity Principles**:

- Refactor toward simplicity
- Remove unnecessary complexity
- Make code easier to understand

**First-Principles Thinking**:

- Question why code is complex
- Understand root requirements
- Rebuild from fundamentals

**Git Skill**:

- Use feature branches for large refactors
- Commit frequently (small steps)
- Review git diff to verify behavior unchanged

## Refactoring Catalog

### Code-Level Refactorings

**Rename Variable/Method**: Improve clarity
**Extract Method**: Break down long functions
**Inline Method**: Remove unnecessary indirection
**Extract Variable**: Name complex expressions
**Inline Variable**: Remove trivial variables
**Replace Temp with Query**: Calculate instead of storing
**Split Temporary Variable**: One variable, one purpose

### Class-Level Refactorings

**Extract Class**: Split god objects
**Inline Class**: Remove unnecessary classes
**Move Method**: Put method where it belongs
**Move Field**: Put data where it's used
**Extract Interface**: Define contracts

### Architecture-Level Refactorings

**Extract Module**: Separate concerns
**Introduce Layer**: Add abstraction level
**Collapse Hierarchy**: Remove unnecessary inheritance
**Replace Inheritance with Delegation**: Favor composition

## Tools

**Python**:

- PyCharm/VS Code refactoring tools
- rope (automated refactoring)
- autoflake (remove unused code)

**JavaScript/TypeScript**:

- VS Code refactoring tools
- TypeScript language server
- ts-migrate (automated migrations)

**Multi-Language**:

- IDE refactoring features (rename, extract, inline)
- git diff (verify behavior unchanged)
- Tests (safety net)

## Common Pitfalls

**Don't**:
❌ Refactor without tests
❌ Mix refactoring with new features
❌ Make big changes at once
❌ Refactor unfamiliar code without understanding
❌ Skip code review
❌ Change behavior during refactoring

**Do**:
✅ Write tests first
✅ Small, incremental changes
✅ Keep tests passing
✅ Commit frequently
✅ Get code review
✅ Preserve existing behavior

## Examples

### Example 1: Refactoring God Object

**Before** (UserManager - 2000 lines):

```python
class UserManager:
    def create_user(self, data): ...      # 200 lines
    def validate_user(self, data): ...    # 150 lines
    def send_welcome_email(self, user): ...
    def authenticate(self, creds): ...
    # ... 45 more methods
```

**After** (Split into focused classes):

```python
class UserService:
    def create_user(self, data):
        validated = UserValidator().validate(data)
        user = UserRepository().save(validated)
        UserNotifier().send_welcome(user)
        return user

class UserValidator:
    def validate(self, data): ...

class UserRepository:
    def save(self, user): ...
    def find(self, id): ...

class UserNotifier:
    def send_welcome(self, user): ...
```

### Example 2: Simplifying Conditionals

**Before**:

```python
def get_discount(user, order):
    if user.is_premium:
        if order.total > 100:
            if user.account_age > 365:
                return 0.25
            else:
                return 0.15
        else:
            return 0.10
    else:
        if order.total > 100:
            return 0.05
        else:
            return 0.0
```

**After**:

```python
def get_discount(user, order):
    if not user.is_premium:
        return 0.05 if order.total > 100 else 0.0

    base_discount = 0.10
    if order.total > 100:
        base_discount = 0.15
    if user.account_age > 365:
        base_discount = 0.25

    return base_discount
```

**Even Better** (Strategy Pattern):

```python
class DiscountCalculator:
    def __init__(self, strategies):
        self.strategies = strategies

    def calculate(self, user, order):
        discount = 0.0
        for strategy in self.strategies:
            discount = max(discount, strategy.calculate(user, order))
        return discount

# Usage
calculator = DiscountCalculator([
    PremiumUserDiscount(),
    LargeOrderDiscount(),
    LoyaltyDiscount()
])
```

## Best Practices

**Start Small**:

- Rename variables for clarity
- Extract simple methods
- Add constants for magic numbers
- Build confidence with small wins

**Build Incrementally**:

- One smell at a time
- One pattern at a time
- Commit frequently
- Keep tests green

**Communicate**:

- Share refactoring plans with team
- Get buy-in for large refactors
- Document why, not just what
- Celebrate improvements

## See Also

- [REVIEWER.md](REVIEWER.md) - Identify refactoring opportunities in reviews
- [MENTOR.md](MENTOR.md) - Teach refactoring to team
- [ARCHITECTURE.md](ARCHITECTURE.md) - Design patterns for refactoring targets
- [TECHNICAL-DEBT.md](TECHNICAL-DEBT.md) - Prioritize refactoring work
- [REFERENCES.md](REFERENCES.md) - Complete navigation
