# Testability - Test Coverage and Quality Assessment

## Overview

Testability measures how easily code can be tested. This guide covers test coverage, test quality, design for testability, and test maintainability.

**Philosophy**: "Untestable code is unmaintainable code" - design for testability from the start.

## Testability Dimensions

### 1. Test Coverage

**What Coverage Measures**:

- **Line Coverage**: % of code lines executed
- **Branch Coverage**: % of decision branches taken
- **Function Coverage**: % of functions called
- **Condition Coverage**: % of boolean sub-expressions tested

**Coverage Analysis**:

```python
# ❌ Bad: Low coverage (33%)
def calculate_discount(price, user_type):
    if user_type == "premium":
        return price * 0.2
    elif user_type == "regular":
        return price * 0.1
    else:
        return 0

# Test only covers one branch
def test_premium_discount():
    assert calculate_discount(100, "premium") == 20

# ✅ Good: High coverage (100%)
def test_all_discount_types():
    assert calculate_discount(100, "premium") == 20
    assert calculate_discount(100, "regular") == 10
    assert calculate_discount(100, "guest") == 0
```

**Coverage Tools**:

```bash
# Python
pytest --cov=myapp --cov-report=html

# JavaScript
npm test -- --coverage

# Go
go test -cover ./...

# Rust
cargo tarpaulin
```

**Coverage Targets**:

- **Critical paths**: 100% (auth, payments, security)
- **Business logic**: 90%+
- **General code**: 80%+
- **UI/glue code**: 60%+

### 2. Test Quality

**Good Tests Are**:

- **Fast**: Run in milliseconds
- **Isolated**: No dependencies between tests
- **Repeatable**: Same result every time
- **Self-checking**: Pass/fail without manual inspection
- **Timely**: Written with or before code

**Test Smells**:

**Flaky Tests** (non-deterministic):

```python
# ❌ Bad: Flaky test (depends on time)
def test_is_business_hours():
    assert is_business_hours()  # Fails at night!

# ✅ Good: Inject time dependency
def test_is_business_hours():
    morning = datetime(2024, 1, 1, 9, 0)
    assert is_business_hours(morning) == True

    evening = datetime(2024, 1, 1, 18, 0)
    assert is_business_hours(evening) == False
```

**Slow Tests** (minutes instead of seconds):

```python
# ❌ Bad: Sleeps in test
def test_retry_logic():
    time.sleep(5)  # Wait for retry
    assert retry_successful()

# ✅ Good: Mock time or use shorter intervals
def test_retry_logic(mock_time):
    mock_time.fast_forward(5)
    assert retry_successful()
```

**Unclear Tests** (poor naming/structure):

```python
# ❌ Bad: Unclear test name
def test_case_1():
    result = do_something(5, True, "abc")
    assert result == 42

# ✅ Good: Descriptive name and AAA structure
def test_calculate_tax_returns_10_percent_for_standard_items():
    # Arrange
    item_price = 100
    item_type = "standard"

    # Act
    tax = calculate_tax(item_price, item_type)

    # Assert
    assert tax == 10
```

### 3. Design for Testability

**Dependency Injection**:

```python
# ❌ Bad: Hard to test (hardcoded dependency)
class UserService:
    def __init__(self):
        self.db = PostgresDB()  # Can't mock!

    def get_user(self, id):
        return self.db.query(f"SELECT * FROM users WHERE id={id}")

# ✅ Good: Testable (injected dependency)
class UserService:
    def __init__(self, db):
        self.db = db

    def get_user(self, id):
        return self.db.query(f"SELECT * FROM users WHERE id={id}")

# Test with mock
def test_get_user():
    mock_db = Mock()
    mock_db.query.return_value = {"id": 1, "name": "Alice"}

    service = UserService(mock_db)
    user = service.get_user(1)

    assert user["name"] == "Alice"
```

**Pure Functions** (easiest to test):

```python
# ❌ Bad: Depends on global state
current_discount = 0.1

def calculate_price(base_price):
    return base_price * (1 - current_discount)  # Global!

# ✅ Good: Pure function
def calculate_price(base_price, discount):
    return base_price * (1 - discount)

# Easy to test
def test_calculate_price():
    assert calculate_price(100, 0.1) == 90
    assert calculate_price(100, 0.2) == 80
```

**Seams** (points where behavior can be changed):

```python
# ❌ Bad: No seams, untestable
def send_notification(user):
    smtp_client = SMTPClient("smtp.example.com")  # Hardcoded!
    smtp_client.send(user.email, "Welcome!")

# ✅ Good: Seam for testing
def send_notification(user, email_client=None):
    if email_client is None:
        email_client = SMTPClient("smtp.example.com")
    email_client.send(user.email, "Welcome!")

# Test with mock
def test_send_notification():
    mock_email = Mock()
    user = User(email="test@example.com")

    send_notification(user, mock_email)

    mock_email.send.assert_called_once_with("test@example.com", "Welcome!")
```

### 4. Test Maintainability

**Test Organization**:

```sh
tests/
  unit/
    test_user_service.py
    test_order_service.py
  integration/
    test_api.py
    test_database.py
  e2e/
    test_user_journey.py
  fixtures/
    sample_data.py
```

**Test Fixtures** (reusable test data):

```python
# ✅ Good: Reusable fixtures
import pytest

@pytest.fixture
def sample_user():
    return User(
        id=1,
        name="Alice",
        email="alice@example.com",
        role="user"
    )

@pytest.fixture
def admin_user():
    return User(
        id=2,
        name="Bob",
        email="bob@example.com",
        role="admin"
    )

def test_user_permissions(sample_user):
    assert sample_user.can_view_dashboard() == True
    assert sample_user.can_access_admin() == False

def test_admin_permissions(admin_user):
    assert admin_user.can_access_admin() == True
```

**Avoid Test Duplication**:

```python
# ❌ Bad: Duplicated test logic
def test_valid_email_lowercase():
    assert is_valid_email("test@example.com") == True

def test_valid_email_uppercase():
    assert is_valid_email("TEST@EXAMPLE.COM") == True

def test_valid_email_subdomain():
    assert is_valid_email("test@mail.example.com") == True

# ✅ Good: Parameterized tests
@pytest.mark.parametrize("email", [
    "test@example.com",
    "TEST@EXAMPLE.COM",
    "test@mail.example.com",
    "user+tag@example.com"
])
def test_valid_email_formats(email):
    assert is_valid_email(email) == True
```

## Testing Strategies

### Unit Testing

**Scope**: Single function/method in isolation

**Example**:

```python
# Function under test
def calculate_shipping(weight, distance):
    base_rate = 5.0
    weight_rate = 0.5  # per kg
    distance_rate = 0.1  # per km
    return base_rate + (weight * weight_rate) + (distance * distance_rate)

# Unit tests
def test_shipping_cost_for_light_package_short_distance():
    assert calculate_shipping(1, 10) == 6.5  # 5 + 0.5 + 1

def test_shipping_cost_for_heavy_package_long_distance():
    assert calculate_shipping(10, 100) == 20.0  # 5 + 5 + 10

def test_shipping_cost_for_zero_weight():
    assert calculate_shipping(0, 10) == 6.0  # 5 + 0 + 1
```

### Integration Testing

**Scope**: Multiple components working together

**Example**:

```python
# Integration test (database + service)
def test_user_registration_flow():
    # Setup
    db = TestDatabase()
    email_service = MockEmailService()
    user_service = UserService(db, email_service)

    # Execute
    user = user_service.register({
        "name": "Alice",
        "email": "alice@example.com",
        "password": "secure123"
    })

    # Verify database
    saved_user = db.get_user(user.id)
    assert saved_user.name == "Alice"
    assert saved_user.email == "alice@example.com"

    # Verify email sent
    assert email_service.sent_count == 1
    assert "Welcome" in email_service.last_email.subject
```

### Test-Driven Development (TDD)

**Red-Green-Refactor Cycle**:

1. **Red**: Write failing test

```python
def test_fibonacci_of_0_returns_0():
    assert fibonacci(0) == 0  # Fails: fibonacci doesn't exist
```

2. **Green**: Write minimal code to pass

```python
def fibonacci(n):
    return 0  # Passes test, but incomplete
```

3. **Refactor**: Improve implementation

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

4. **Repeat**: Add more tests

```python
def test_fibonacci_of_1_returns_1():
    assert fibonacci(1) == 1

def test_fibonacci_of_5_returns_5():
    assert fibonacci(5) == 5
```

### Property-Based Testing

**Test properties instead of examples**:

```python
from hypothesis import given, strategies as st

# Property: Reversing twice returns original
@given(st.lists(st.integers()))
def test_reverse_twice_is_identity(items):
    assert list(reversed(list(reversed(items)))) == items

# Property: Sorting is idempotent
@given(st.lists(st.integers()))
def test_sort_idempotent(items):
    sorted_once = sorted(items)
    sorted_twice = sorted(sorted_once)
    assert sorted_once == sorted_twice

# Property: Addition is commutative
@given(st.integers(), st.integers())
def test_addition_commutative(a, b):
    assert a + b == b + a
```

## Common Testability Issues

### God Objects

**Problem**: Too many responsibilities, hard to test

```python
# ❌ Bad: God object
class Application:
    def __init__(self):
        self.db = Database()
        self.cache = RedisCache()
        self.email = EmailService()
        self.analytics = AnalyticsService()

    def process_order(self, order):
        # 500 lines using all dependencies
        ...

# ✅ Good: Focused components
class OrderProcessor:
    def __init__(self, repository, notifier):
        self.repository = repository
        self.notifier = notifier

    def process(self, order):
        self.repository.save(order)
        self.notifier.send_confirmation(order)
```

### Hidden Dependencies

**Problem**: Code depends on global state or environment

```python
# ❌ Bad: Hidden dependency on environment
def get_api_key():
    return os.environ["API_KEY"]  # Test needs env var!

# ✅ Good: Explicit dependency
def get_api_key(config):
    return config.api_key

# Test
def test_get_api_key():
    config = Config(api_key="test-key")
    assert get_api_key(config) == "test-key"
```

### Non-Deterministic Code

**Problem**: Different results on each run

```python
# ❌ Bad: Non-deterministic
def generate_token():
    return random.randint(100000, 999999)  # Different every time!

# ✅ Good: Deterministic with seed
def generate_token(seed=None):
    if seed is not None:
        random.seed(seed)
    return random.randint(100000, 999999)

# Test
def test_generate_token():
    assert generate_token(seed=42) == generate_token(seed=42)
```

## Test Metrics

### Coverage Metrics

**What to Measure**:

- Line coverage (% of lines executed)
- Branch coverage (% of branches taken)
- Mutation score (% of mutations caught)

**What NOT to Optimize**:

```python
# ❌ Bad: High coverage, low quality
def calculate_discount(price, customer_type):
    if customer_type == "premium":
        return price * 0.2
    elif customer_type == "regular":
        return price * 0.1
    return 0

def test_coverage_only():
    # Executes all lines but doesn't assert anything!
    calculate_discount(100, "premium")
    calculate_discount(100, "regular")
    calculate_discount(100, "guest")
    # 100% coverage, 0% value
```

### Test Quality Metrics

**Good Metrics**:

- **Test:Code Ratio**: 1:1 to 3:1 lines of test per code
- **Test Execution Time**: < 10 seconds for unit tests
- **Test Failure Rate**: < 1% flaky tests
- **Mutation Score**: > 80% (mutations caught by tests)

## Testing Checklist

**Test Coverage**:

- [ ] Critical paths: 100% coverage
- [ ] Business logic: 90%+ coverage
- [ ] Edge cases tested (null, empty, boundary)
- [ ] Error paths tested

**Test Quality**:

- [ ] Tests are fast (< 10s for unit tests)
- [ ] Tests are isolated (no dependencies)
- [ ] Tests are deterministic (no flakiness)
- [ ] Tests have clear names
- [ ] Tests follow AAA pattern (Arrange-Act-Assert)

**Design for Testability**:

- [ ] Dependencies injected (not hardcoded)
- [ ] Pure functions where possible
- [ ] Seams for testing (interfaces, hooks)
- [ ] No global state
- [ ] No hidden dependencies

**Test Maintainability**:

- [ ] Tests organized by type (unit/integration/e2e)
- [ ] Fixtures reused
- [ ] Parameterized tests for similar cases
- [ ] No test duplication
- [ ] Tests documented (when logic is complex)

## Integration with Other Skills

**First-Principles Thinking**:

- Question: "What behavior am I actually testing?"
- Break down complex tests to fundamental assertions
- Identify true dependencies vs incidental coupling

**Simplicity Principles**:

- Simple code is easier to test
- Avoid over-mocking (test real behavior)
- Prefer integration tests over complex unit test setups

**Git Skill**:

- Identify untested code with coverage + git blame
- Find test gaps in frequently changed code
- Track test coverage trends over time

**Tech Stack Advisor**:

- Use language-appropriate test frameworks
- Follow testing conventions (pytest, Jest, JUnit)
- Leverage built-in testing features

## Best Practices

**Write Tests**:
✅ For all new code (TDD or shortly after)
✅ When fixing bugs (regression tests)
✅ For critical paths (100% coverage)
✅ Before refactoring (safety net)

**Good Test Structure**:
✅ AAA pattern (Arrange-Act-Assert)
✅ One assertion per test (or closely related assertions)
✅ Descriptive test names
✅ Fast execution (< 10s)
✅ Independent tests (no order dependency)

**Avoid**:
❌ Testing implementation details
❌ Flaky tests (fix or delete)
❌ Slow tests (optimize or move to integration suite)
❌ Unclear test names
❌ Tests that never fail
❌ Over-mocking (test real behavior when possible)

## Common Test Patterns

### Mocking External Services

```python
# Mock HTTP API
from unittest.mock import Mock, patch

@patch('requests.get')
def test_fetch_user_data(mock_get):
    # Arrange
    mock_response = Mock()
    mock_response.json.return_value = {"id": 1, "name": "Alice"}
    mock_get.return_value = mock_response

    # Act
    user = fetch_user_data(1)

    # Assert
    assert user["name"] == "Alice"
    mock_get.assert_called_once_with("https://api.example.com/users/1")
```

### Testing Exceptions

```python
# Test that exceptions are raised
import pytest

def test_divide_by_zero_raises_error():
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)

def test_invalid_email_raises_value_error():
    with pytest.raises(ValueError, match="Invalid email"):
        validate_email("not-an-email")
```

### Testing Async Code

```python
# Test async functions
import pytest

@pytest.mark.asyncio
async def test_async_fetch():
    result = await fetch_data_async()
    assert result is not None

@pytest.mark.asyncio
async def test_concurrent_requests():
    results = await asyncio.gather(
        fetch_user(1),
        fetch_user(2),
        fetch_user(3)
    )
    assert len(results) == 3
```

## See Also

- [REVIEWER.md](REVIEWER.md) - Test quality review in PRs
- [MAINTAINABILITY.md](MAINTAINABILITY.md) - Testable code is maintainable
- [REFACTOR.md](REFACTOR.md) - Refactor with tests as safety net
- [REFERENCES.md](REFERENCES.md) - Complete navigation
