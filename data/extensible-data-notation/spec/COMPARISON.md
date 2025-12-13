# EDN Format Comparison

Comprehensive analysis of EDN versus other data formats, helping you make informed decisions about when and why to use EDN.

## Overview

This guide uses **first principles thinking** to compare data formats by examining their fundamental design goals and trade-offs, not just surface features.

---

## Decision Framework

### When to Use EDN

**Choose EDN when you need**:

1. **Extensibility without parser changes** - Tagged literals
2. **Semantic richness** - Multiple collection types with meaning
3. **Self-documenting data** - Qualified keywords
4. **Cross-language data interchange** - Language-agnostic specification
5. **Type safety at read time** - Custom readers validate early
6. **Human-readable and debuggable** - Clean syntax

### When NOT to Use EDN

**Avoid EDN when**:

1. **Browser JavaScript native support required** - JSON has better tooling
2. **Maximum performance critical** - Binary formats faster
3. **Existing JSON ecosystem** - Don't force migration
4. **SQL database storage** - Most DBs lack native EDN support
5. **Team unfamiliarity** - Learning curve may not justify benefits

---

## EDN vs JSON

### Fundamental Differences

| Aspect | JSON | EDN | Winner |
|--------|------|-----|--------|
| **Design Goal** | JavaScript object serialization | Extensible data notation | Depends |
| **Extensibility** | None | Tagged literals | **EDN** |
| **Data Types** | 6 types | 12 types + extensible | **EDN** |
| **Keywords** | No | Yes (`:keyword`) | **EDN** |
| **Sets** | No (use arrays) | Yes (`#{}`) | **EDN** |
| **Comments** | No | Yes (`;`) | **EDN** |
| **Map Keys** | Strings only | Any type | **EDN** |
| **Numbers** | IEEE 754 | Arbitrary precision | **EDN** |
| **Browser Support** | Native | Requires library | **JSON** |
| **Tooling** | Excellent | Good (Clojure-centric) | **JSON** |
| **Human Readability** | Good | Good | Tie |

### Example Comparison

**JSON**:

```json
{
  "userId": "f81d4fae-7dec-11d0-a765-00a0c91e6bf6",
  "createdAt": "2025-12-11T10:00:00Z",
  "price": "99.99",
  "currency": "USD",
  "roles": ["admin", "user", "admin"]
}
```

**EDN**:

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/created-at #inst "2025-12-11T10:00:00Z"
 :product/price #money/usd 99.99
 :user/roles #{:admin :user}}  ; Set automatically deduplicates
```

### Trade-offs

**Use JSON when**:

- Browser JavaScript is primary consumer
- Ecosystem maturity critical (libraries, tooling, documentation)
- Simple data structures without custom types
- Team familiar with JSON but not EDN

**Use EDN when**:

- Need extensibility (custom types via tagged literals)
- Want semantic collections (vector vs set distinction matters)
- Self-documenting data important (qualified keywords)
- Clojure or polyglot environment

---

## EDN vs YAML

### Fundamental Differences

| Aspect | YAML | EDN | Winner |
|--------|------|-----|--------|
| **Design Goal** | Human writability | Extensible data notation | Depends |
| **Whitespace** | Significant (indentation) | Insignificant | **EDN** |
| **Ambiguity** | Many edge cases | Minimal | **EDN** |
| **Complexity** | High (many features) | Low (focused) | **EDN** |
| **Extensibility** | Limited (`!!` tags) | First-class (`#tag`) | **EDN** |
| **Readability** | Very high | High | **YAML** |
| **Parsing** | Complex spec | Simple, unambiguous | **EDN** |
| **Config Files** | Excellent | Good | **YAML** |

### Example Comparison

**YAML**:

```yaml
user:
  id: f81d4fae-7dec-11d0-a765-00a0c91e6bf6
  createdAt: 2025-12-11T10:00:00Z
  price: 99.99
  currency: USD
  roles:
    - admin
    - user
  verified: true
  middleName: null  # Explicit null
```

**EDN**:

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/created-at #inst "2025-12-11T10:00:00Z"
 :product/price #money/usd 99.99
 :user/roles #{:admin :user}
 :user/verified true
 :user/middle-name nil}
```

### YAML Gotchas EDN Avoids

**Implicit Type Coercion**:

```yaml
# YAML surprise
norway: NO  # Becomes false!
```

```clojure
;; EDN - explicit
{:country "NO"}  ; String "NO", not boolean
```

**Indentation Sensitivity**:

```yaml
# YAML - whitespace matters
key:
  nested: value
    error: breaks  # Incorrect indent
```

```clojure
;; EDN - whitespace insignificant
{:key
 {:nested "value"
  :error "works"}}
```

### Trade-offs

**Use YAML when**:

- Configuration files for humans
- Team prefers whitespace-based syntax
- Existing YAML ecosystem (Kubernetes, etc.)
- Maximum human writability priority

**Use EDN when**:

- Programmatic data generation/manipulation
- Want unambiguous parsing
- Need extensibility (custom types)
- Prefer explicit over implicit

---

## EDN vs XML

### Fundamental Differences

| Aspect | XML | EDN | Winner |
|--------|------|-----|--------|
| **Design Goal** | Markup language | Data notation | Depends |
| **Verbosity** | Very high | Low | **EDN** |
| **Schema** | External (XSD, DTD) | Embedded (tagged literals) | **EDN** |
| **Namespaces** | Complex (`xmlns`) | Simple (qualified keywords) | **EDN** |
| **Attributes** | Yes | No (use maps) | Depends |
| **Mixed Content** | Yes (text + elements) | No | **XML** |
| **Documents** | Excellent | Poor | **XML** |
| **Data** | Poor | Excellent | **EDN** |

### Example Comparison

**XML**:

```xml
<user xmlns="http://example.com/user">
  <id>f81d4fae-7dec-11d0-a765-00a0c91e6bf6</id>
  <createdAt>2025-12-11T10:00:00Z</createdAt>
  <price currency="USD">99.99</price>
  <roles>
    <role>admin</role>
    <role>user</role>
  </roles>
</user>
```

**EDN**:

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/created-at #inst "2025-12-11T10:00:00Z"
 :product/price #money/usd 99.99
 :user/roles #{:admin :user}}
```

### Trade-offs

**Use XML when**:

- Document markup (HTML-like structure)
- Mixed content (text with embedded elements)
- Enterprise systems requiring XML
- Schema validation with XSD critical

**Use EDN when**:

- Pure data (not documents)
- Want concise syntax
- Extensibility via tagged literals
- Namespaces for data, not markup

---

## EDN vs Binary Formats

### Protocol Buffers / MessagePack / Avro

| Aspect | Binary Formats | EDN | Winner |
|--------|----------------|-----|--------|
| **Performance** | Excellent | Good | **Binary** |
| **Size** | Compact | Larger (text) | **Binary** |
| **Human Readable** | No | Yes | **EDN** |
| **Debugging** | Difficult | Easy | **EDN** |
| **Schema** | Required (usually) | Optional | Depends |
| **Versioning** | Challenging | Easier | **EDN** |
| **Tooling** | Specialized | Standard text | **EDN** |

### Trade-offs

**Use Binary Formats when**:

- Performance critical (high throughput, low latency)
- Network bandwidth limited
- Size matters (mobile, embedded)
- Schema enforcement required

**Use EDN when**:

- Human readability important
- Debugging and development speed matters
- Schema flexibility needed
- Configuration or small datasets

---

## Migration Decision Matrix

### From JSON to EDN

**Reasons to Migrate**:

- ✅ Need custom types (dates, money, UUIDs)
- ✅ Want set semantics (unique values)
- ✅ Need qualified keywords (namespace collisions)
- ✅ Want comments in data files
- ✅ Polyglot environment (not JavaScript-centric)

**Reasons to Stay with JSON**:

- ❌ Browser JavaScript primary consumer
- ❌ Excellent tooling ecosystem critical
- ❌ Simple data structures (no custom types needed)
- ❌ Team unfamiliar with EDN

**Migration Strategy**: See [../frameworks/migration-guide.md](../frameworks/migration-guide.md)

### From YAML to EDN

**Reasons to Migrate**:

- ✅ Tired of YAML gotchas (implicit types, indentation)
- ✅ Need programmatic data generation
- ✅ Want unambiguous parsing
- ✅ Need extensibility (tagged literals)

**Reasons to Stay with YAML**:

- ❌ Human writability top priority
- ❌ Existing YAML infrastructure (K8s, Ansible)
- ❌ Team loves whitespace-based syntax

### From XML to EDN

**Reasons to Migrate**:

- ✅ Pure data (not documents)
- ✅ Want concise syntax
- ✅ Tired of XML verbosity
- ✅ Simple namespace requirements

**Reasons to Stay with XML**:

- ❌ Document markup needed
- ❌ Mixed content (text + elements)
- ❌ Enterprise systems require XML
- ❌ XSD schema validation critical

---

## Use Case Recommendations

### Configuration Files

**Best Choice**: YAML or EDN

**Choose EDN if**:

- Need typed values (`#inst`, `#uuid`, `#duration`)
- Programmatic generation/manipulation
- Want unambiguous parsing

**Example**:

```clojure
{:app/name "MyApp"
 :database/url "postgresql://localhost:5432/db"
 :cache/ttl #duration "1h"
 :features #{:auth :logging}}
```

### API Contracts

**Best Choice**: EDN or JSON

**Choose EDN if**:

- Need semantic types (money, timestamps)
- Want self-documenting (qualified keywords)
- Schema evolution important

**Example**:

```clojure
{:user/id #uuid "..."
 :user/created-at #inst "2025-12-11T10:00:00Z"
 :order/total #money/usd 99.99}
```

### Event Sourcing

**Best Choice**: EDN or Avro

**Choose EDN if**:

- Need human-readable events
- Want flexible schema evolution
- Debugging important

**Example**:

```clojure
[#event/user-created {:user-id #uuid "..." :timestamp #inst "..."}
 #event/order-placed {:order-id 456 :timestamp #inst "..."}]
```

### High-Performance Data

**Best Choice**: Protocol Buffers or MessagePack

**Choose EDN if**:

- Development speed > runtime performance
- Human readability critical
- Datasets small enough that text overhead acceptable

---

## Summary Table

| Use Case | JSON | YAML | XML | EDN | Binary |
|----------|------|------|-----|-----|--------|
| **Browser APIs** | ⭐⭐⭐ | ❌ | ⭐ | ⭐ | ❌ |
| **Config Files** | ⭐⭐ | ⭐⭐⭐ | ⭐ | ⭐⭐ | ❌ |
| **API Contracts** | ⭐⭐⭐ | ⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐ |
| **Event Sourcing** | ⭐⭐ | ⭐ | ⭐ | ⭐⭐⭐ | ⭐⭐ |
| **Documents** | ❌ | ⭐ | ⭐⭐⭐ | ❌ | ❌ |
| **Performance** | ⭐ | ⭐ | ⭐ | ⭐⭐ | ⭐⭐⭐ |
| **Human Debug** | ⭐⭐ | ⭐⭐⭐ | ⭐ | ⭐⭐⭐ | ❌ |
| **Extensibility** | ❌ | ⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| **Type Safety** | ❌ | ⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| **Schema Evolution** | ⭐ | ⭐ | ⭐ | ⭐⭐⭐ | ⭐⭐ |

---

## See Also

- [FORMAT.md](FORMAT.md) - EDN syntax and semantics
- [EXTENSIBILITY.md](EXTENSIBILITY.md) - Tagged literals (EDN's key advantage)
- [DESIGN.md](DESIGN.md) - Schema design patterns
- [../frameworks/migration-guide.md](../frameworks/migration-guide.md) - Migration strategies
