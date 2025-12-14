# Correctness - Logic Validation and Bug Detection

## Overview

Correctness ensures code works as intended, handles edge cases, and produces correct results. This guide covers logic validation, edge case analysis, and bug prevention using first-principles thinking.

**Philosophy**: "Correctness first, then performance" - working code is better than fast broken code.

## Correctness Dimensions

### 1. Logic Verification

**First-Principles Approach**:

- What are the inputs? (types, ranges, constraints)
- What are the outputs? (expected results)
- What are the transformations? (algorithm correctness)
- What are the edge cases? (boundary conditions)

**Example Analysis**:

```python
def calculate_discount(price, discount_percent):
    discount = price * (discount_percent / 100)
    return price - discount

# First-principles questions:
# - What if price is negative?
# - What if discount_percent > 100?
# - What if inputs are None?
# - What if inputs are strings?
```

### 2. Edge Cases

**Common Edge Cases**:

- **Empty/Null**: `None`, `[]`, `""`, `{}`
- **Zero**: `0`, `0.0`
- **Negative**: `-1`, `-100`
- **Boundary**: `MAX_INT`, `MIN_INT`
- **Large**: Very large numbers, arrays
- **Special**: `NaN`, `Infinity`, `-0`

**Example**:

```python
def get_first_element(items):
    # ❌ Bad: Assumes non-empty list
    return items[0]  # IndexError if empty!

    # ✅ Good: Handle empty case
    return items[0] if items else None
```

### 3. Type Safety

**Dynamic Languages**:

```python
# Use type hints
def add(a: int, b: int) -> int:
    return a + b

# Runtime validation
from typeguard import typechecked

@typechecked
def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Division by zero")
    return a / b
```

**Static Languages**:

```typescript
// TypeScript catches type errors
function add(a: number, b: number): number {
    return a + b;
}

add(1, "2");  // Compile error!
```

### 4. Error Handling

**Explicit Error Handling**:

```python
# ❌ Bad: Swallowed exception
try:
    result = risky_operation()
except:
    pass  # What went wrong?

# ✅ Good: Specific, logged
try:
    result = risky_operation()
except ValueError as e:
    logger.error(f"Invalid input: {e}")
    raise
except ConnectionError as e:
    logger.error(f"Connection failed: {e}")
    return fallback_value()
```

**Error Paths**:

```python
def process_payment(amount, card):
    # ✅ Validate inputs
    if amount <= 0:
        raise ValueError("Amount must be positive")
    if not card.is_valid():
        raise InvalidCardError("Card validation failed")

    # ✅ Handle external failures
    try:
        charge = payment_gateway.charge(amount, card)
    except GatewayTimeout:
        # Retry logic
        charge = retry_with_backoff(payment_gateway.charge, amount, card)
    except InsufficientFunds:
        # User-facing error
        raise PaymentError("Insufficient funds")

    return charge
```

### 5. Boundary Conditions

**Off-By-One Errors**:

```python
# ❌ Bad: Off by one
for i in range(len(items)):
    if i < len(items):  # Redundant, but shows confusion
        process(items[i])

# ✅ Good: Clear iteration
for item in items:
    process(item)

# ✅ Good: Index access with bounds
for i in range(len(items) - 1):  # Don't access items[i+1] at end
    compare(items[i], items[i+1])
```

**Range Validation**:

```python
def get_items_page(page_number, page_size):
    # Validate inputs
    if page_number < 1:
        raise ValueError("Page number must be >= 1")
    if not (1 <= page_size <= 100):
        raise ValueError("Page size must be 1-100")

    offset = (page_number - 1) * page_size
    return items[offset:offset + page_size]
```

## Common Bug Patterns

**Race Conditions**:

```python
# ❌ Bad: Race condition
if balance >= amount:  # Thread 1 checks
    # Thread 2 withdraws here!
    balance -= amount  # Thread 1 withdraws (overdraft!)

# ✅ Good: Atomic operation
with lock:
    if balance >= amount:
        balance -= amount
```

**Integer Overflow**:

```c
// C: Check before overflow
if (a > INT_MAX - b) {
    // Overflow would occur
    handle_overflow();
} else {
    result = a + b;
}
```

**Null Dereference**:

```python
# ❌ Bad: Assumes user exists
user_name = get_user(user_id).name  # NoneType error

# ✅ Good: Check first
user = get_user(user_id)
user_name = user.name if user else "Unknown"
```

## Testing for Correctness

**Unit Tests**:

```python
def test_calculate_discount():
    # Normal cases
    assert calculate_discount(100, 10) == 90
    assert calculate_discount(50, 20) == 40

    # Edge cases
    assert calculate_discount(100, 0) == 100  # 0%
    assert calculate_discount(0, 10) == 0     # $0
    with pytest.raises(ValueError):
        calculate_discount(-100, 10)  # Negative price
    with pytest.raises(ValueError):
        calculate_discount(100, 150)  # > 100%
```

**Property-Based Testing**:

```python
from hypothesis import given
import hypothesis.strategies as st

@given(st.integers(), st.integers())
def test_addition_commutative(a, b):
    assert a + b == b + a  # Always true

@given(st.lists(st.integers()))
def test_sort_idempotent(items):
    sorted_once = sorted(items)
    sorted_twice = sorted(sorted_once)
    assert sorted_once == sorted_twice  # Sorting twice = sorting once
```

## Correctness Checklist

**Input Validation**:

- [ ] All inputs validated (type, range)
- [ ] Null/empty cases handled
- [ ] Negative numbers handled
- [ ] Boundary conditions checked

**Logic**:

- [ ] Algorithm correct for all cases
- [ ] Edge cases covered
- [ ] No off-by-one errors
- [ ] Race conditions prevented

**Error Handling**:

- [ ] All error paths handled
- [ ] Specific exceptions caught
- [ ] Errors logged
- [ ] Resources cleaned up (try/finally)

**Testing**:

- [ ] Unit tests for normal cases
- [ ] Unit tests for edge cases
- [ ] Unit tests for error cases
- [ ] Integration tests

## Best Practices

**Do**:
✅ Validate all inputs
✅ Handle edge cases explicitly
✅ Use type hints/checking
✅ Write comprehensive tests
✅ Think through error paths
✅ Use first-principles verification

**Don't**:
❌ Assume inputs are valid
❌ Ignore edge cases
❌ Swallow exceptions
❌ Skip error handling
❌ Forget boundary conditions

## See Also

- [REVIEWER.md](REVIEWER.md) - Logic review in PRs
- [TESTABILITY.md](TESTABILITY.md) - Testing strategies
- [REFERENCES.md](REFERENCES.md) - Navigation
