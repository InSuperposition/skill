# EDN Extensibility - Tagged Literals & Namespaces

Deep dive into EDN's core innovation: extensibility through tagged literals and namespace conventions.

## Overview

**The Fundamental Innovation**: EDN allows you to extend the data format **without changing the parser** through tagged literals.

### The Problem

Other formats handle custom types poorly:

**JSON**: String encoding and loss of type information

```json
{
  "timestamp": "2025-12-11T10:00:00Z",
  "amount": "99.99",
  "currency": "USD"
}
```

**YAML**: Type tags are awkward and limited

```yaml
timestamp: !!timestamp 2025-12-11T10:00:00Z
```

### EDN's Solution

**Tagged Literals**: Reader-level extensibility

```clojure
{:timestamp #inst "2025-12-11T10:00:00Z"
 :amount #money/usd 99.99}
```

**Key Insight**: The `#tag value` syntax is **parsed** by all EDN readers, but **interpreted** by registered tag handlers. This means you can add new types without specification changes.

---

## Tagged Literal Syntax

### Basic Format

```txt
#tag value
```

- `#` - Tag prefix
- `tag` - Tag name (symbol syntax rules)
- `value` - Any EDN value

### Examples

```clojure
#inst "2025-12-11T10:00:00Z"      ; Built-in instant
#uuid "f81d4fae-7dec-11d0-a765"   ; Built-in UUID
#money/usd 99.99                   ; Custom money type
#geo/point [37.7749 -122.4194]     ; Custom geographic point
#date "2025-12-11"                 ; Custom date-only
```

---

## Built-in Tagged Literals

EDN specifies two built-in tags that **all implementations should support**:

### #inst - Instants (Timestamps)

**Format**: RFC-3339 timestamp string

**Examples**:

```clojure
#inst "2025-12-11T10:00:00.000-00:00"  ; Full ISO-8601
#inst "2025-12-11T10:00:00Z"           ; UTC
#inst "2025-12-11T10:00:00-08:00"      ; With timezone
#inst "2025-12-11"                      ; Date only (midnight UTC)
```

**Semantics**:

- Represents a point in time
- Includes timezone information
- Millisecond precision typical
- Maps to native time type in each language

**Language Mappings**:

```clojure
;; Clojure
#inst "2025-12-11T10:00:00Z"  → java.util.Date

;; JavaScript
#inst "2025-12-11T10:00:00Z"  → Date object

;; Python
#inst "2025-12-11T10:00:00Z"  → datetime.datetime
```

**Use Cases**:

```clojure
{:event/name "Product Launch"
 :event/scheduled-at #inst "2025-12-11T10:00:00Z"
 :event/created-at #inst "2025-01-15T08:30:00Z"}
```

### #uuid - Universally Unique Identifiers

**Format**: UUID string in standard format

**Example**:

```clojure
#uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
```

**Semantics**:

- 128-bit unique identifier
- Standard UUID format (8-4-4-4-12 hex digits)
- Maps to native UUID type in each language

**Language Mappings**:

```clojure
;; Clojure
#uuid "f81d4fae..."  → java.util.UUID

;; Python
#uuid "f81d4fae..."  → uuid.UUID

;; JavaScript
#uuid "f81d4fae..."  → String (no native UUID)
```

**Use Cases**:

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :session/id #uuid "a1b2c3d4-e5f6-7890-abcd-ef1234567890"}
```

---

## Custom Tagged Literals

### Design Principles

**1. Tags are Namespaced**

```clojure
#money/usd 99.99           ; money namespace, usd tag
#myapp/user {:id 123}      ; myapp namespace, user tag
#geo/point [37.7, -122.4]  ; geo namespace, point tag
```

**2. Tags are Application-Defined**

The EDN spec doesn't define custom tags - you create them for your domain.

**3. Tags Transform Values**

Tags tell the reader HOW to interpret the following value:

```clojure
;; The value [37.7, -122.4] is transformed by #geo/point reader
#geo/point [37.7749 -122.4194]

;; Might become:
{:latitude 37.7749 :longitude -122.4194}
;; or
Point(37.7749, -122.4194)
```

### Common Custom Tag Patterns

#### Money

**Problem**: Floating point imprecision for currency

**Solution**: Tagged literal with currency information

```clojure
#money/usd 99.99
#money/eur 85.50
#money/jpy 10000

;; Or with explicit currency
#money {:amount 99.99M :currency :USD}
```

**Reader Implementation**:

```clojure
;; Clojure
(defn read-money-usd [amount]
  {:amount (bigdec amount)
   :currency :USD})

;; Python
def read_money_usd(amount):
    return Money(Decimal(amount), 'USD')
```

#### Dates (Date-Only, No Time)

**Problem**: #inst includes time, but sometimes you only want date

**Solution**: Custom #date tag

```clojure
#date "2025-12-11"
#date "2025-01-01"
```

**Reader Implementation**:

```clojure
;; Clojure
(defn read-date [date-str]
  (java.time.LocalDate/parse date-str))

;; Python
def read_date(date_str):
    return datetime.datetime.strptime(date_str, '%Y-%m-%d').date()
```

#### Geographic Points

**Problem**: Latitude/longitude pairs need semantic meaning

**Solution**: #geo/point tag

```clojure
#geo/point [37.7749 -122.4194]  ; San Francisco
```

**Reader Implementation**:

```clojure
;; Clojure
(defn read-geo-point [[lat lon]]
  {:latitude lat :longitude lon})

;; JavaScript
function readGeoPoint([lat, lon]) {
  return {latitude: lat, longitude: lon};
}
```

#### Durations

**Problem**: Time intervals need semantic representation

**Solution**: #duration tag

```clojure
#duration "PT30S"     ; 30 seconds (ISO-8601)
#duration "PT5M"      ; 5 minutes
#duration "PT1H"      ; 1 hour

;; Or simpler format
#duration "30s"
#duration "5m"
#duration "1h"
```

#### Regular Expressions

**Problem**: Regex patterns are strings but need special handling

**Solution**: #regex tag

```clojure
#regex "\\d{3}-\\d{4}"   ; Phone pattern
#regex "[a-z]+"           ; Letters only
```

#### Base64 Binary Data

**Problem**: Binary data in text format

**Solution**: #base64 tag

```clojure
#base64 "SGVsbG8gV29ybGQ="
```

---

## Namespace Conventions

### Why Namespaces Matter

**Problem**: Tag name collisions between applications

**Solution**: Namespace-qualified tags

```clojure
;; Bad - collision risk
#user {:id 123}     ; Whose 'user' tag?

;; Good - namespace prevents collision
#myapp/user {:id 123}
#otherapp/user {:id 456}
```

### Namespace Patterns

#### Reverse DNS (Libraries/Organizations)

Used for widely-distributed libraries:

```clojure
#com.example.myapp/entity {:data ...}
#org.clojure/spec-def {...}
#io.github.username/custom-type ...
```

#### Domain-Based (Applications)

Used within applications for domain concepts:

```clojure
#user/profile {...}
#order/placed {...}
#payment/processed {...}
#inventory/item {...}
```

#### Type-Based (Not Recommended)

Avoid organizing by type:

```clojure
;; Bad - organized by type
#string/email "alice@example.com"
#number/currency 99.99

;; Good - organized by domain
#user/email "alice@example.com"
#money/amount 99.99
```

### Best Practices

**1. Use Qualified Names for Reusable Tags**

```clojure
#geo/point [...]      ; Reusable across apps
#money/usd 99.99      ; Standard money representation
```

**2. Use App Namespaces for Internal Tags**

```clojure
#myapp.domain/entity {...}
#myapp.events/user-created {...}
```

**3. Document Your Tags**

Create a registry of custom tags:

```clojure
;; tagged-literal-registry.md
#money/usd amount      - USD currency
#money/eur amount      - EUR currency
#geo/point [lat lon]   - Geographic coordinate
#myapp/user map        - User entity
```

See [../reference/tagged-literal-registry.md](../reference/tagged-literal-registry.md)

---

## Reader Implementation

### How Tagged Literals Work

**1. Parser sees `#tag value`**

```clojure
#money/usd 99.99
```

**2. Parser reads the value**

```txt
tag: "money/usd"
value: 99.99
```

**3. Reader looks up tag handler**

```txt
handlers["money/usd"] → read_money_usd function
```

**4. Handler transforms value**

```txt
read_money_usd(99.99) → {:amount 99.99M :currency :USD}
```

**5. Transformed value used in data structure**

```clojure
{:price {:amount 99.99M :currency :USD}}
```

### Clojure Implementation

```clojure
(require '[clojure.edn :as edn])

;; Define tag handler
(defn read-money-usd [amount]
  {:amount (bigdec amount)
   :currency :USD})

;; Register handler
(def readers
  {'money/usd read-money-usd})

;; Parse EDN with custom tags
(edn/read-string
  {:readers readers}
  "#money/usd 99.99")
;; => {:amount 99.99M :currency :USD}
```

### JavaScript Implementation

```javascript
const edn = require('jsedn');

// Define Money class
class Money {
  constructor(amount, currency) {
    this.amount = amount;
    this.currency = currency;
  }
}

// Register tag handler
edn.setTagAction(
  new edn.Tag('money', 'usd'),
  (amount) => new Money(amount, 'USD')
);

// Parse EDN
const data = edn.parse('#money/usd 99.99');
// => Money { amount: 99.99, currency: 'USD' }
```

### Python Implementation

```python
import edn_format
from decimal import Decimal

# Define Money class
class Money:
    def __init__(self, amount, currency):
        self.amount = Decimal(str(amount))
        self.currency = currency

# Define tag handler
def read_money_usd(amount):
    return Money(amount, 'USD')

# Register handler
edn_format.add_tag('money/usd', read_money_usd)

# Parse EDN
data = edn_format.loads('#money/usd 99.99')
# => Money(amount=Decimal('99.99'), currency='USD')
```

---

## Advanced Patterns

### Polymorphic Data

Use tagged literals for type discrimination:

```clojure
[#event/user-created
 {:user/id #uuid "..."
  :user/name "Alice"
  :timestamp #inst "2025-12-11T10:00:00Z"}

 #event/order-placed
 {:order/id 12345
  :order/total #money/usd 99.99
  :timestamp #inst "2025-12-11T10:05:00Z"}

 #event/payment-processed
 {:payment/id #uuid "..."
  :payment/amount #money/usd 99.99
  :timestamp #inst "2025-12-11T10:06:00Z"}]
```

### Versioned Entities

Tag entities with version information:

```clojure
;; Version 1
#user/v1
{:id 123
 :name "Alice Smith"}

;; Version 2 (added email)
#user/v2
{:id 123
 :name "Alice Smith"
 :email "alice@example.com"}
```

**Reader can handle both**:

```clojure
(defn read-user-v1 [data]
  (assoc data :email nil))  ; Add missing email

(defn read-user-v2 [data]
  data)  ; Already has all fields
```

### Nested Tagged Literals

Tags can contain tags:

```clojure
#order/placed
{:order/id 12345
 :order/customer #user/entity {:id 67890 :name "Alice"}
 :order/placed-at #inst "2025-12-11T10:00:00Z"
 :order/items
 [#item/product
  {:sku "ABC-123"
   :price #money/usd 29.99}]}
```

### Conditional Reading

Make tags environment-aware:

```clojure
;; Development: use stub
#env/dev #stub/payment-gateway {...}

;; Production: use real
#env/prod #real/payment-gateway {...}
```

---

## Tag Design Guidelines

### 1. Make Tags Self-Documenting

```clojure
;; Bad - unclear
#p [37.7, -122.4]

;; Good - obvious meaning
#geo/point [37.7, -122.4]
```

### 2. Value Should Be Human-Readable

```clojure
;; Bad - opaque value
#money [9999 :USD]

;; Good - readable value
#money/usd 99.99
```

### 3. Keep Tag Transformation Simple

```clojure
;; Bad - complex transformation logic
#complex/thing "parse:this:weird:format"

;; Good - straightforward transformation
#duration "30s"
```

### 4. Use Existing EDN Types for Value

```clojure
;; Good - vector for coordinates
#geo/point [37.7, -122.4]

;; Good - map for structured data
#address {:street "123 Main" :city "SF"}

;; Good - string for formatted data
#date "2025-12-11"
```

### 5. Namespace by Domain, Not Type

```clojure
;; Bad - type-based
#types/string-email "alice@example.com"
#types/integer-id 123

;; Good - domain-based
#user/email "alice@example.com"
#user/id 123
```

---

## Unknown Tag Handling

### Default Behavior

When a reader encounters an unknown tag:

**Option 1**: Preserve as tagged element

```clojure
;; Unknown tag preserved
#unknown/tag "value"
→ TaggedElement(tag="unknown/tag", value="value")
```

**Option 2**: Error on unknown tag

```clojure
;; Strict mode - error
#unknown/tag "value"
→ Error: Unknown tag 'unknown/tag'
```

**Option 3**: Use default handler

```clojure
;; Custom default handler
#unknown/tag "value"
→ {:tag "unknown/tag" :value "value"}
```

### Clojure Example

```clojure
;; Preserve unknown tags
(edn/read-string
  {:default (fn [tag value]
              {:tag tag :value value})}
  "#unknown/tag 42")
;; => {:tag unknown/tag :value 42}
```

---

## Common Tag Registry

See [../reference/tagged-literal-registry.md](../reference/tagged-literal-registry.md) for a comprehensive catalog of common custom tags including:

- Temporal types (#date, #time, #duration)
- Monetary types (#money/*, #currency)
- Geographic types (#geo/point, #geo/polygon)
- Binary data (#base64, #hex)
- Regular expressions (#regex)
- URLs and URIs (#url, #uri)
- Domain-specific tags

---

## Migration from Other Formats

### JSON to EDN with Tagged Literals

**Before (JSON)**:

```json
{
  "id": "f81d4fae-7dec-11d0-a765-00a0c91e6bf6",
  "createdAt": "2025-12-11T10:00:00Z",
  "price": "99.99",
  "currency": "USD"
}
```

**After (EDN)**:

```clojure
{:id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :created-at #inst "2025-12-11T10:00:00Z"
 :price #money/usd 99.99}
```

**Benefits**:

- Type safety (UUID, instant, money vs strings)
- Semantic clarity (price is money, not generic number)
- Validation at read time

See [../frameworks/migration-guide.md](../frameworks/migration-guide.md) for complete migration strategies.

---

## See Also

- [FORMAT.md](FORMAT.md) - Core EDN syntax and data types
- [DESIGN.md](DESIGN.md) - Schema design patterns using tagged literals
- [../frameworks/reader-implementation.md](../frameworks/reader-implementation.md) - Implementing custom readers
- [../reference/tagged-literal-registry.md](../reference/tagged-literal-registry.md) - Common custom tags
- [LIBRARIES.md](LIBRARIES.md) - Language-specific reader implementations
- [Official EDN Spec](https://github.com/edn-format/edn) - Authoritative tagged literal specification
