# Maintainability - Code Clarity and Long-Term Sustainability

## Overview

Maintainability is how easily code can be understood, modified, and extended. This guide covers simplicity, readability, documentation, and sustainable design using simplicity principles.

**Philosophy**: "Code is read 10x more than it's written" - optimize for understanding.

## Maintainability Factors

### 1. Readability

**Clear Naming**:

```python
# ❌ Bad: Cryptic names
def f(x, y):
    return x * y * 0.1

# ✅ Good: Descriptive names
def calculate_sales_tax(price, quantity):
    TAX_RATE = 0.1
    return price * quantity * TAX_RATE
```

**Function Length**:

```python
# ❌ Bad: 200-line function
def process_order(order):
    # 200 lines of validation, calculation, database updates...

# ✅ Good: Small, focused functions
def process_order(order):
    validate_order(order)
    calculate_totals(order)
    save_order(order)
    send_confirmation(order)
```

**Consistent Style**:

- Use a formatter (Black, Prettier)
- Follow language conventions (PEP 8, Airbnb style)
- Be consistent within project

### 2. Simplicity (from Simplicity Skill)

**Objective Simplicity**:

- Fewer moving parts
- Less coupling
- Explicit dependencies
- No hidden complexity

**Complexity Metrics**:

```python
# Cyclomatic complexity
# Low (1-10): Easy to understand
# Medium (11-20): Moderate complexity
# High (21+): Hard to maintain

def complex_function(x, y, z):  # Complexity: 15
    if x > 0:
        if y > 0:
            if z > 0:
                # 10 more nested conditions...
```

**Simplification**:

```python
# ❌ Bad: Complex abstraction
class AbstractUserFactoryProviderStrategy:
    ...

# ✅ Good: Simple and direct
def create_user(name, email):
    return User(name=name, email=email)
```

### 3. Structure

**Separation of Concerns**:

```python
# ❌ Bad: Mixed concerns
class UserController:
    def create_user(self, data):
        # Validation
        if not data.get('email'):
            raise ValueError()
        # Database
        db.execute("INSERT INTO users...")
        # Email
        smtp.send_mail(...)
        # Logging
        logger.info(...)

# ✅ Good: Separated
class UserService:
    def create_user(self, data):
        user = self.validator.validate(data)
        user = self.repository.save(user)
        self.notifier.send_welcome(user)
        return user
```

**DRY (Don't Repeat Yourself)**:

```python
# ❌ Bad: Duplication
def process_user_order(user, order):
    if user.age < 18:
        raise ValueError("Too young")
    # process...

def process_admin_order(admin, order):
    if admin.age < 18:  # Duplicated validation
        raise ValueError("Too young")
    # process...

# ✅ Good: Extract common logic
def validate_age(person):
    if person.age < 18:
        raise ValueError("Too young")

def process_user_order(user, order):
    validate_age(user)
    # process...
```

### 4. Documentation

**Code Comments**:

```python
# ❌ Bad: Obvious comment
# Increment i
i += 1

# ✅ Good: Explain "why"
# Skip header row
i += 1

# ✅ Good: Explain complex logic
# Use binary search because list is sorted and large (10M items)
index = binary_search(items, target)
```

**Docstrings**:

```python
def calculate_compound_interest(principal, rate, years):
    """
    Calculate compound interest.

    Args:
        principal: Initial amount ($)
        rate: Annual interest rate (0.05 = 5%)
        years: Number of years

    Returns:
        Final amount after compound interest

    Example:
        >>> calculate_compound_interest(1000, 0.05, 10)
        1628.89
    """
    return principal * (1 + rate) ** years
```

**README**:

- What does this do?
- How do I install it?
- How do I use it?
- How do I contribute?

### 5. Design Patterns

**Appropriate Patterns**:

- Strategy: Multiple algorithms
- Factory: Object creation
- Observer: Event handling
- Dependency Injection: Testability

**Pattern Abuse**:

```python
# ❌ Bad: Over-engineered
class SingletonFactoryBuilderAdapter:
    ...

# ✅ Good: Simple when simple suffices
config = load_config()  # Just a function
```

## Complexity Metrics

**Cyclomatic Complexity**:

- Measures decision points (if, while, for, etc.)
- Target: < 10 per function

**Lines of Code (LOC)**:

- Functions: < 50 lines
- Classes: < 500 lines
- Files: < 1000 lines

**Depth of Nesting**:

- Target: < 4 levels deep

## Maintainability Checklist

**Code Quality**:

- [ ] Clear, descriptive names
- [ ] Functions < 50 lines
- [ ] Cyclomatic complexity < 10
- [ ] No deep nesting (< 4 levels)
- [ ] DRY (no duplication)

**Structure**:

- [ ] Separation of concerns
- [ ] Single Responsibility Principle
- [ ] Appropriate abstractions
- [ ] Clear module boundaries

**Documentation**:

- [ ] Complex logic explained
- [ ] Public APIs documented
- [ ] README up to date
- [ ] Architecture documented (ADRs)

**Simplicity**:

- [ ] No unnecessary complexity
- [ ] No premature optimization
- [ ] No over-engineering
- [ ] Explicit over implicit

## Best Practices

**Do**:
✅ Write self-documenting code
✅ Keep functions small and focused
✅ Follow language conventions
✅ Use consistent formatting
✅ Explain complex logic
✅ Simplify when possible

**Don't**:
❌ Write clever code
❌ Use cryptic abbreviations
❌ Create deep nesting
❌ Mix concerns
❌ Duplicate code
❌ Over-engineer

## See Also

- [REFACTOR.md](REFACTOR.md) - Improve maintainability
- [ARCHITECTURE.md](ARCHITECTURE.md) - Design for maintainability
- [REFERENCES.md](REFERENCES.md) - Navigation
