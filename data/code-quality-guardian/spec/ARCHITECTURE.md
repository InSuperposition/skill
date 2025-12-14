# Architecture - Design Patterns and Structural Quality

## Overview

Architecture assessment evaluates code structure, design patterns, and long-term maintainability. This guide covers SOLID principles, design patterns, architectural styles, and anti-pattern detection.

**Philosophy**: "Good architecture makes the system easy to understand, develop, maintain, and deploy" - optimize for change.

## Architectural Principles

### SOLID Principles

**S - Single Responsibility Principle**:

```python
# ❌ Bad: Multiple responsibilities
class UserManager:
    def create_user(self, data):
        # Validation
        if not self.validate_email(data['email']):
            raise ValueError()
        # Database
        self.db.insert(data)
        # Email
        self.send_welcome_email(data['email'])
        # Analytics
        self.track_signup(data)

# ✅ Good: Single responsibility
class UserService:
    def __init__(self, validator, repository, notifier, analytics):
        self.validator = validator
        self.repository = repository
        self.notifier = notifier
        self.analytics = analytics

    def create_user(self, data):
        user = self.validator.validate(data)
        user = self.repository.save(user)
        self.notifier.send_welcome(user)
        self.analytics.track_signup(user)
        return user
```

**O - Open/Closed Principle**:

```python
# ❌ Bad: Modify class for new payment types
class PaymentProcessor:
    def process(self, payment_type, amount):
        if payment_type == "credit_card":
            # Credit card logic
            ...
        elif payment_type == "paypal":
            # PayPal logic
            ...
        # Adding new type requires modifying this class!

# ✅ Good: Open for extension, closed for modification
class PaymentProcessor:
    def __init__(self):
        self.processors = {}

    def register(self, payment_type, processor):
        self.processors[payment_type] = processor

    def process(self, payment_type, amount):
        return self.processors[payment_type].process(amount)

# New payment types extend without modifying
class CreditCardProcessor:
    def process(self, amount):
        ...

class PayPalProcessor:
    def process(self, amount):
        ...
```

**L - Liskov Substitution Principle**:

```python
# ❌ Bad: Violates LSP
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

class Square(Rectangle):
    def __init__(self, size):
        super().__init__(size, size)

    def set_width(self, width):
        self.width = width
        self.height = width  # Breaks Rectangle contract!

# ✅ Good: Separate hierarchies
class Shape:
    def area(self):
        raise NotImplementedError

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

class Square(Shape):
    def __init__(self, size):
        self.size = size

    def area(self):
        return self.size * self.size
```

**I - Interface Segregation Principle**:

```python
# ❌ Bad: Fat interface
class Worker:
    def work(self):
        pass

    def eat(self):
        pass

    def sleep(self):
        pass

class Robot(Worker):
    def work(self):
        return "Working"

    def eat(self):
        raise NotImplementedError  # Robots don't eat!

    def sleep(self):
        raise NotImplementedError  # Robots don't sleep!

# ✅ Good: Segregated interfaces
class Workable:
    def work(self):
        pass

class Eatable:
    def eat(self):
        pass

class Sleepable:
    def sleep(self):
        pass

class Human(Workable, Eatable, Sleepable):
    def work(self):
        return "Working"

    def eat(self):
        return "Eating"

    def sleep(self):
        return "Sleeping"

class Robot(Workable):
    def work(self):
        return "Working"
```

**D - Dependency Inversion Principle**:

```python
# ❌ Bad: High-level depends on low-level
class EmailService:
    def send(self, to, message):
        # Direct SMTP implementation
        smtp = SMTPClient("smtp.example.com")
        smtp.send(to, message)

class UserService:
    def __init__(self):
        self.email = EmailService()  # Coupled to concrete class

# ✅ Good: Both depend on abstraction
from abc import ABC, abstractmethod

class Notifier(ABC):
    @abstractmethod
    def send(self, to, message):
        pass

class EmailNotifier(Notifier):
    def send(self, to, message):
        smtp = SMTPClient("smtp.example.com")
        smtp.send(to, message)

class SMSNotifier(Notifier):
    def send(self, to, message):
        sms = SMSClient()
        sms.send(to, message)

class UserService:
    def __init__(self, notifier: Notifier):
        self.notifier = notifier  # Depends on abstraction
```

## Design Patterns

### Creational Patterns

**Factory Pattern**:

```python
# When: Need to create objects without specifying exact class

class ShippingFactory:
    @staticmethod
    def create(shipping_type):
        if shipping_type == "standard":
            return StandardShipping()
        elif shipping_type == "express":
            return ExpressShipping()
        elif shipping_type == "overnight":
            return OvernightShipping()
        raise ValueError(f"Unknown type: {shipping_type}")

# Usage
shipping = ShippingFactory.create("express")
cost = shipping.calculate(order)
```

**Singleton Pattern**:

```python
# When: Exactly one instance needed (database connection, config)

class DatabaseConnection:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance.connect()
        return cls._instance

    def connect(self):
        # Connection logic
        pass

# All calls return same instance
db1 = DatabaseConnection()
db2 = DatabaseConnection()
assert db1 is db2  # Same object
```

**Builder Pattern**:

```python
# When: Complex object construction with many optional parameters

class QueryBuilder:
    def __init__(self):
        self._select = []
        self._from = None
        self._where = []
        self._limit = None

    def select(self, *columns):
        self._select.extend(columns)
        return self

    def from_table(self, table):
        self._from = table
        return self

    def where(self, condition):
        self._where.append(condition)
        return self

    def limit(self, n):
        self._limit = n
        return self

    def build(self):
        query = f"SELECT {', '.join(self._select)} FROM {self._from}"
        if self._where:
            query += f" WHERE {' AND '.join(self._where)}"
        if self._limit:
            query += f" LIMIT {self._limit}"
        return query

# Usage
query = (QueryBuilder()
    .select("id", "name", "email")
    .from_table("users")
    .where("age > 18")
    .where("active = true")
    .limit(10)
    .build())
```

### Structural Patterns

**Adapter Pattern**:

```python
# When: Make incompatible interfaces work together

# Legacy system
class LegacyPaymentGateway:
    def make_payment(self, amount_in_cents):
        # Legacy API uses cents
        ...

# Modern system expects dollars
class ModernPaymentProcessor:
    def process(self, amount_in_dollars):
        ...

# Adapter
class PaymentAdapter:
    def __init__(self, legacy_gateway):
        self.legacy = legacy_gateway

    def process(self, amount_in_dollars):
        amount_in_cents = int(amount_in_dollars * 100)
        return self.legacy.make_payment(amount_in_cents)

# Usage
legacy = LegacyPaymentGateway()
adapter = PaymentAdapter(legacy)
adapter.process(99.99)  # Converts to 9999 cents
```

**Decorator Pattern**:

```python
# When: Add behavior to objects dynamically

class Coffee:
    def cost(self):
        return 2.0

    def description(self):
        return "Coffee"

class MilkDecorator:
    def __init__(self, coffee):
        self._coffee = coffee

    def cost(self):
        return self._coffee.cost() + 0.5

    def description(self):
        return self._coffee.description() + ", Milk"

class SugarDecorator:
    def __init__(self, coffee):
        self._coffee = coffee

    def cost(self):
        return self._coffee.cost() + 0.2

    def description(self):
        return self._coffee.description() + ", Sugar"

# Usage
coffee = Coffee()
coffee = MilkDecorator(coffee)
coffee = SugarDecorator(coffee)
print(f"{coffee.description()}: ${coffee.cost()}")  # Coffee, Milk, Sugar: $2.7
```

### Behavioral Patterns

**Strategy Pattern**:

```python
# When: Multiple algorithms for the same task

from abc import ABC, abstractmethod

class SortStrategy(ABC):
    @abstractmethod
    def sort(self, data):
        pass

class QuickSort(SortStrategy):
    def sort(self, data):
        # Quick sort implementation
        ...

class MergeSort(SortStrategy):
    def sort(self, data):
        # Merge sort implementation
        ...

class Sorter:
    def __init__(self, strategy: SortStrategy):
        self.strategy = strategy

    def sort(self, data):
        return self.strategy.sort(data)

# Usage
data = [3, 1, 4, 1, 5]
sorter = Sorter(QuickSort())
sorted_data = sorter.sort(data)
```

**Observer Pattern**:

```python
# When: One-to-many dependency (publish-subscribe)

class EventManager:
    def __init__(self):
        self._subscribers = []

    def subscribe(self, subscriber):
        self._subscribers.append(subscriber)

    def unsubscribe(self, subscriber):
        self._subscribers.remove(subscriber)

    def notify(self, event):
        for subscriber in self._subscribers:
            subscriber.update(event)

class EmailSubscriber:
    def update(self, event):
        print(f"Sending email about: {event}")

class LogSubscriber:
    def update(self, event):
        print(f"Logging event: {event}")

# Usage
events = EventManager()
events.subscribe(EmailSubscriber())
events.subscribe(LogSubscriber())
events.notify("User registered")  # Both subscribers notified
```

**Command Pattern**:

```python
# When: Encapsulate requests as objects (undo/redo, queuing)

from abc import ABC, abstractmethod

class Command(ABC):
    @abstractmethod
    def execute(self):
        pass

    @abstractmethod
    def undo(self):
        pass

class AddUserCommand(Command):
    def __init__(self, user_repository, user_data):
        self.repository = user_repository
        self.user_data = user_data
        self.user_id = None

    def execute(self):
        self.user_id = self.repository.add(self.user_data)

    def undo(self):
        self.repository.delete(self.user_id)

class CommandInvoker:
    def __init__(self):
        self.history = []

    def execute(self, command):
        command.execute()
        self.history.append(command)

    def undo(self):
        if self.history:
            command = self.history.pop()
            command.undo()
```

## Architectural Styles

### Layered Architecture

```md
┌─────────────────────────┐
│  Presentation Layer     │  (UI, Controllers)
├─────────────────────────┤
│  Business Logic Layer   │  (Services, Domain)
├─────────────────────────┤
│  Data Access Layer      │  (Repositories, ORM)
├─────────────────────────┤
│  Database               │  (PostgreSQL, etc.)
└─────────────────────────┘
```

**Example**:

```python
# Presentation Layer
class UserController:
    def __init__(self, user_service):
        self.user_service = user_service

    def create_user(self, request):
        user = self.user_service.register(request.data)
        return {"id": user.id, "name": user.name}

# Business Logic Layer
class UserService:
    def __init__(self, user_repository, email_service):
        self.repository = user_repository
        self.email = email_service

    def register(self, data):
        user = User(**data)
        user = self.repository.save(user)
        self.email.send_welcome(user)
        return user

# Data Access Layer
class UserRepository:
    def save(self, user):
        return self.db.insert("users", user)
```

### Hexagonal Architecture (Ports & Adapters)

```md
┌───────────────────────────────────────┐
│         Application Core              │
│  (Business Logic, Domain Models)      │
│                                       │
│  ┌─────────┐       ┌─────────┐      │
│  │  Port   │       │  Port   │      │
│  └─────────┘       └─────────┘      │
└───────┬───────────────┬──────────────┘
        │               │
   ┌────▼────┐     ┌───▼─────┐
   │ Adapter │     │ Adapter │
   │  (HTTP) │     │  (DB)   │
   └─────────┘     └─────────┘
```

**Example**:

```python
# Core Domain
class OrderService:
    def __init__(self, order_repository, payment_gateway):
        self.repository = order_repository  # Port
        self.payment = payment_gateway       # Port

    def place_order(self, order):
        order = self.repository.save(order)
        self.payment.charge(order.total)
        return order

# Adapters
class PostgresOrderRepository:  # Database adapter
    def save(self, order):
        # PostgreSQL implementation
        ...

class StripePaymentGateway:  # Payment adapter
    def charge(self, amount):
        # Stripe API implementation
        ...
```

### Microservices Architecture

```md
┌──────────┐    ┌──────────┐    ┌──────────┐
│  User    │    │  Order   │    │ Payment  │
│ Service  │◄──►│ Service  │◄──►│ Service  │
└──────────┘    └──────────┘    └──────────┘
     │               │                │
     ▼               ▼                ▼
  [User DB]      [Order DB]      [Payment DB]
```

**Key Principles**:

- Each service owns its data
- Communicate via APIs (REST, gRPC, events)
- Independent deployment
- Decentralized governance

## Anti-Patterns

### God Object

**Problem**: One class does everything

```python
# ❌ Anti-pattern
class Application:
    def __init__(self):
        # 50 dependencies
        ...

    def process_user_registration(self):
        # 500 lines
        ...

    def process_order(self):
        # 500 lines
        ...

    # ... 30 more methods
```

**Solution**: Split by responsibility

### Big Ball of Mud

**Problem**: No clear structure, tangled dependencies

**Signs**:

- Hard to understand where to add new features
- Changes affect unrelated parts
- No clear module boundaries

**Solution**: Introduce layered or hexagonal architecture incrementally

### Leaky Abstraction

**Problem**: Implementation details leak through abstraction

```python
# ❌ Bad: Leaky abstraction
class UserRepository:
    def find_by_id(self, user_id):
        # Returns SQLAlchemy model (implementation detail!)
        return session.query(User).filter_by(id=user_id).first()

# ✅ Good: Proper abstraction
class UserRepository:
    def find_by_id(self, user_id):
        # Returns domain model
        user_row = session.query(User).filter_by(id=user_id).first()
        return User(id=user_row.id, name=user_row.name)  # Domain object
```

### Circular Dependencies

**Problem**: A depends on B, B depends on A

```python
# ❌ Bad: Circular dependency
# module_a.py
from module_b import B

class A:
    def use_b(self):
        b = B()
        ...

# module_b.py
from module_a import A  # Circular!

class B:
    def use_a(self):
        a = A()
        ...
```

**Solution**: Introduce interface or move shared code to third module

## Architecture Review Checklist

**SOLID Principles**:

- [ ] Single Responsibility: Each class has one reason to change
- [ ] Open/Closed: Extend without modifying existing code
- [ ] Liskov Substitution: Subtypes are substitutable
- [ ] Interface Segregation: No fat interfaces
- [ ] Dependency Inversion: Depend on abstractions

**Design Patterns**:

- [ ] Patterns used appropriately (not over-engineered)
- [ ] Pattern intent matches use case
- [ ] No pattern abuse (singleton everywhere, etc.)

**Structure**:

- [ ] Clear module boundaries
- [ ] Low coupling, high cohesion
- [ ] No circular dependencies
- [ ] Consistent abstraction level

**Scalability**:

- [ ] Stateless where possible
- [ ] Database can be scaled (sharding, replication)
- [ ] Caching strategy in place
- [ ] Asynchronous processing for slow operations

## Integration with Other Skills

**First-Principles Thinking**:

- Question why patterns are used
- Verify pattern solves actual problem
- Avoid cargo-cult architecture

**Simplicity Principles**:

- Choose boring, proven patterns
- Avoid over-engineering
- Start simple, evolve as needed

**Git Skill**:

- Identify architectural hotspots (frequently changed files)
- Track coupling through co-change analysis
- Visualize module dependencies

**Tech Stack Advisor**:

- Framework-specific architectural patterns
- Language idioms and conventions
- Best practices per technology

## Best Practices

**Do**:
✅ Apply SOLID principles
✅ Use patterns when they fit
✅ Keep abstractions clean
✅ Design for change
✅ Document architectural decisions (ADRs)
✅ Review architecture regularly

**Don't**:
❌ Over-engineer (YAGNI - You Aren't Gonna Need It)
❌ Use patterns without understanding
❌ Create god objects
❌ Allow circular dependencies
❌ Leak implementation details
❌ Copy architectures without understanding context

## See Also

- [MAINTAINABILITY.md](MAINTAINABILITY.md) - Architecture affects maintainability
- [REFACTOR.md](REFACTOR.md) - Refactor toward better architecture
- [TECHNICAL-DEBT.md](TECHNICAL-DEBT.md) - Architectural debt is expensive
- [REFERENCES.md](REFERENCES.md) - Complete navigation
