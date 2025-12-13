# EDN Format Specification

Complete reference for Extensible Data Notation syntax, semantics, and built-in data types.

## Overview

EDN (Extensible Data Notation) is a data format designed to represent values as text. Unlike formats tied to specific languages (like JSON to JavaScript), EDN is a **specification-first format** that can be implemented in any language.

### Design Principles

1. **Data as Values** - EDN represents immutable data, not object graphs
2. **Human Readable** - Clean, Lisp-style syntax
3. **Machine Parsable** - Unambiguous grammar
4. **Extensible** - Tagged literals for custom types
5. **Semantic Rich** - Multiple collection types with distinct meanings

### Why EDN Exists

**Problem**: JSON lacks extensibility, YAML has surprising behaviors, XML is verbose

**Solution**: Minimal syntax + tagged literals = extensible + readable

```clojure
;; JSON: String encoding required for custom types
{"timestamp": "2025-12-11T10:00:00Z", "amount": "99.99", "currency": "USD"}

;; EDN: Tagged literals for rich types
{:timestamp #inst "2025-12-11T10:00:00Z"
 :amount #money/usd 99.99}
```

---

## Core Data Types

EDN defines **12 built-in data types** organized into four categories:

### 1. Atomic Values

#### nil

Represents the absence of a value (like `null` in JSON).

```clojure
nil
```

**Semantics**:

- Single value in the system
- Distinct from `false`, `0`, or empty string
- Often used for optional fields

**Use Cases**:

```clojure
{:user/name "Alice"
 :user/middle-name nil    ; No middle name
 :user/age 30}
```

#### Booleans

Two values: `true` and `false`

```clojure
true
false
```

**Semantics**:

- Lowercase only (unlike JSON's case-insensitive)
- Distinct from all other values
- No implicit truthiness (unlike JavaScript)

**Use Cases**:

```clojure
{:feature/enabled true
 :user/verified false
 :config/debug-mode true}
```

#### Strings

UTF-8 encoded text in double quotes.

```clojure
"hello world"
"multi\nline\nstring"
"escaped \"quotes\""
"unicode: \u03A9"  ; Ω
```

**Escape Sequences**:

- `\t` - tab
- `\r` - carriage return
- `\n` - newline
- `\\` - backslash
- `\"` - double quote
- `\uXXXX` - Unicode character

**Use Cases**:

```clojure
{:user/name "Alice Smith"
 :user/bio "Software engineer\nLoves Clojure"
 :user/quote "She said, \"Hello!\""}
```

#### Characters

Single Unicode characters prefixed with backslash.

```clojure
\a
\b
\space
\newline
\tab
\u03A9  ; Ω
```

**Named Characters**:

- `\newline`
- `\space`
- `\tab`
- `\formfeed`
- `\backspace`
- `\return`

**Use Cases**:

```clojure
;; Less common in data, more for code
[\a \b \c]           ; Character sequence
\space               ; Space character
```

#### Numbers

Multiple numeric formats with arbitrary precision support.

**Integers**:

```clojure
42
-123
0
+99
```

**Floating Point**:

```clojure
3.14
-1.5
0.0
```

**Scientific Notation**:

```clojure
1.5e10
-2.3e-5
6.022e23
```

**Arbitrary Precision**:

```clojure
42N      ; Arbitrary precision integer
3.14M    ; Arbitrary precision decimal
```

**Use Cases**:

```clojure
{:user/age 30
 :account/balance 1234.56
 :product/price 99.99M        ; Precise decimal
 :calculation/result 6.022e23
 :large/number 999999999999999999N}
```

---

### 2. Identifiers

#### Keywords

Self-referential identifiers starting with colon.

**Simple Keywords**:

```clojure
:keyword
:my-keyword
:snake_case
:kebab-case
```

**Qualified Keywords** (with namespace):

```clojure
:user/name
:user/email
:order/id
:com.example.app/version
```

**Auto-Resolved Keywords** (Clojure-specific):

```clojure
::local-keyword  ; Resolves to current namespace
```

**Naming Rules**:

- Start with colon `:`
- Can contain: letters, numbers, `*`, `+`, `!`, `-`, `_`, `?`, `.`, `/`
- Cannot start with number after colon
- Forward slash `/` separates namespace from name

**Semantics**:

- Keywords are values (not references)
- Two keywords with same name are identical
- Commonly used as map keys
- Self-documenting in qualified form

**Use Cases**:

```clojure
;; Map keys (most common)
{:user/id 123
 :user/name "Alice"
 :user/role :admin}

;; Enums/constants
:status/pending
:status/approved
:status/rejected

;; Domain-qualified
{:order/id 456
 :order/status :pending
 :order/items [...]}
```

#### Symbols

Names for entities or identifiers.

**Simple Symbols**:

```clojure
my-symbol
another-symbol
kebab-case
```

**Qualified Symbols**:

```clojure
namespace/symbol
clojure.core/map
my.app/process-data
```

**Naming Rules**: Same as keywords but without leading colon

**Semantics**:

- Symbols typically represent references to things
- In Clojure, symbols refer to vars or classes
- Less common in pure data (more in code)

**Use Cases**:

```clojure
;; Function references (code)
my.app/handler

;; Type references
java.util.Date

;; In data (rare)
{:type java.lang.String}
```

**Keywords vs Symbols**:

```clojure
;; Keywords (data) - self-referential
:user/name

;; Symbols (code) - reference something
user/name
```

---

### 3. Collections

EDN provides **four collection types**, each with distinct semantics.

#### Vectors

Ordered, indexed collections in square brackets `[]`.

```clojure
[1 2 3]
["a" "b" "c"]
[1 "two" :three]
[]  ; Empty vector
```

**Semantics**:

- **Ordered** - Elements maintain insertion order
- **Indexed** - Efficient random access by position
- **Heterogeneous** - Can mix types
- **General purpose** - Most common collection

**Use Cases**:

```clojure
;; Ordered sequences
[:first :second :third]

;; Mixed types
[1 "two" :three {:four 4}]

;; Nested structures
[[1 2] [3 4] [5 6]]

;; Common data representation
{:user/name "Alice"
 :user/tags ["admin" "verified" "premium"]}
```

#### Lists

Sequential collections in parentheses `()`.

```clojure
(1 2 3)
("a" "b" "c")
()  ; Empty list
```

**Semantics**:

- **Sequential** - Efficient prepend, not indexed
- **Code representation** - In Clojure, lists represent code
- **Less common in data** - Vectors preferred for data

**Use Cases**:

```clojure
;; Data (less common - vectors preferred)
(1 2 3)

;; Code representation (Clojure)
(defn add [x y] (+ x y))
```

**Lists vs Vectors**:

```clojure
[1 2 3]    ; Vector - indexed access, general data
(1 2 3)    ; List - sequential, code representation
```

**When to use**:

- **Vectors**: 99% of ordered data use cases
- **Lists**: Code forms, symbolic processing, when prepend is primary operation

#### Maps

Key-value associations in curly braces `{}`.

```clojure
{:name "Alice" :age 30}
{"key" "value"}
{:a 1 :b 2 :c 3}
{}  ; Empty map
```

**Key Types**:

```clojure
;; Keywords (most common)
{:user/id 123 :user/name "Alice"}

;; Strings
{"firstName" "Alice" "lastName" "Smith"}

;; Numbers
{1 "one" 2 "two"}

;; Mixed (valid but uncommon)
{:keyword "value" "string" 42}
```

**Semantics**:

- **Unordered** - Key order not guaranteed (though often preserved)
- **Unique keys** - Duplicate keys not allowed
- **Associative** - Efficient key lookup
- **Heterogeneous** - Keys and values can be any type

**Nested Maps**:

```clojure
{:user/id 123
 :user/name "Alice"
 :user/address
 {:address/street "123 Main St"
  :address/city "San Francisco"
  :address/zip "94102"}}
```

**Use Cases**:

```clojure
;; Entity representation (most common)
{:user/id 123
 :user/name "Alice"
 :user/email "alice@example.com"}

;; Configuration
{:database/host "localhost"
 :database/port 5432
 :database/name "myapp"}

;; Lookup tables
{:red "#FF0000"
 :green "#00FF00"
 :blue "#0000FF"}
```

#### Sets

Unordered collections of unique values in `#{}`.

```clojure
#{1 2 3}
#{"a" "b" "c"}
#{:red :green :blue}
#{}  ; Empty set (DO NOT USE - ambiguous with map)
```

**Semantics**:

- **Unordered** - No guaranteed iteration order
- **Unique** - Duplicates automatically removed
- **Membership** - Efficient contains check
- **Mathematical set** - Union, intersection, difference operations

**Important**: Avoid `#{}` for empty set (ambiguous). Use language-specific constructor.

**Use Cases**:

```clojure
;; Unique collections
#{:admin :user :moderator}  ; User roles

;; Membership checks
{:user/id 123
 :user/permissions #{:read :write :delete}}

;; Tags (unordered, unique)
{:article/title "EDN Guide"
 :article/tags #{:programming :data :formats}}

;; Feature flags
{:features #{:authentication :caching :logging}}
```

**Sets vs Vectors for Uniqueness**:

```clojure
;; Vector - ordered, may have duplicates
[:admin :user :admin]  ; Valid but probably not intended

;; Set - unordered, automatically unique
#{:admin :user :admin}  ; Becomes #{:admin :user}
```

---

### 4. Extensibility

#### Tagged Literals

Custom types using `#tag value` syntax.

**Built-in Tags**:

**Instant** (`#inst`):

```clojure
#inst "2025-12-11T10:00:00.000-00:00"  ; RFC-3339 format
#inst "2025-12-11"                      ; Date only
```

**UUID** (`#uuid`):

```clojure
#uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
```

**Custom Tags**:

```clojure
#money/usd 99.99
#geo/point [37.7749 -122.4194]
#date "2025-12-11"
#myapp/user {:id 123 :name "Alice"}
```

**Semantics**:

- **Reader-level extensibility** - Parser unchanged
- **Namespace-aware** - Tags can be qualified
- **Value transformation** - Reader converts to language type

See [EXTENSIBILITY.md](EXTENSIBILITY.md) for complete tagged literal guide.

---

## Syntax Rules

### Whitespace

**Ignored Between Elements**:

```clojure
[1 2 3]
[1    2    3]
[1
 2
 3]
```

**Types**: Spaces, tabs, newlines, commas (commas treated as whitespace!)

**Commas as Whitespace**:

```clojure
;; These are identical
[1 2 3]
[1, 2, 3]
{:a 1 :b 2}
{:a 1, :b 2}
```

### Comments

**Line Comments**:

```clojure
; This is a comment
{:key "value"}  ; End-of-line comment
```

**Discard Reader Macro** (Clojure-specific):

```clojure
#_ (this entire form is ignored)
{:a 1 #_ :b #_ 2 :c 3}  ; {:a 1 :c 3}
```

### Case Sensitivity

**EDN is case-sensitive**:

```clojure
:keyword ≠ :Keyword ≠ :KEYWORD
true ≠ True ≠ TRUE
```

### Nesting

**Arbitrary Nesting Depth**:

```clojure
{:level-1
 {:level-2
  {:level-3
   {:level-4 "deep nesting is valid"}}}}

[[[[1]]]]  ; Deeply nested vectors
```

---

## Parsing Semantics

### Reading vs Evaluating

**EDN is READ, not EVAL**:

- EDN readers parse text into data structures
- No code execution during parsing
- Safe to read untrusted EDN (unlike eval)

### Reader Behavior

**Duplicate Keys in Maps**:

```clojure
{:a 1 :a 2}
```

**Behavior**: Implementation-defined (usually last value wins)

**Recommendation**: Avoid duplicate keys

**Set Duplicates**:

```clojure
#{1 2 2 3}
```

**Behavior**: Duplicates removed → `#{1 2 3}`

### Number Precision

**Integer Precision**:

```clojure
42      ; Standard integer
42N     ; Arbitrary precision (bigint)
```

**Decimal Precision**:

```clojure
3.14    ; Floating point (may lose precision)
3.14M   ; Arbitrary precision decimal (exact)
```

**Best Practice**: Use `M` suffix for money and exact decimals

```clojure
;; Bad - floating point imprecision
{:price 99.99}

;; Good - exact decimal
{:price 99.99M}
```

---

## Common Patterns

### Entity Representation

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/name "Alice Smith"
 :user/email "alice@example.com"
 :user/created-at #inst "2025-01-15T08:30:00Z"
 :user/roles #{:admin :user}
 :user/verified true}
```

### Configuration Files

```clojure
{:app/name "MyApp"
 :app/version "1.0.0"

 :database/config
 {:host "localhost"
  :port 5432
  :pool-size 10}

 :features #{:authentication :caching}

 :timeouts
 {:connection-ms 30000
  :request-ms 5000}}
```

### Nested Structures

```clojure
{:order/id 12345
 :order/customer
 {:customer/id 67890
  :customer/name "Alice"}

 :order/items
 [{:item/sku "ABC-123"
   :item/quantity 2
   :item/price 29.99M}
  {:item/sku "XYZ-789"
   :item/quantity 1
   :item/price 149.99M}]

 :order/total 209.97M
 :order/placed-at #inst "2025-12-11T10:00:00Z"}
```

---

## Format Comparison

### EDN vs JSON

| Feature | JSON | EDN |
|---------|------|-----|
| **Keywords** | No | `:keyword` |
| **Symbols** | No | `symbol` |
| **Sets** | No (array) | `#{1 2 3}` |
| **Comments** | No | `; comment` |
| **Multiple collections** | Array only | Vector, list, set |
| **Map keys** | Strings only | Any type |
| **Extensibility** | None | Tagged literals |
| **Numbers** | Limited precision | Arbitrary precision |

### EDN vs YAML

| Feature | YAML | EDN |
|---------|------|-----|
| **Whitespace** | Significant | Insignificant |
| **Ambiguity** | Many edge cases | Minimal |
| **Complexity** | High | Low |
| **Extensibility** | Limited `!!` | First-class `#tag` |
| **Readability** | Very high | High |

---

## Best Practices

### 1. Use Qualified Keywords for Public Data

```clojure
;; Bad - namespace collisions possible
{:id 123 :name "Alice"}

;; Good - self-documenting, collision-free
{:user/id 123 :user/name "Alice"}
```

### 2. Choose Right Collection Type

```clojure
;; Ordered sequence → Vector
[:first :second :third]

;; Unique values → Set
#{:admin :user :moderator}

;; Key-value lookup → Map
{:user/id 123 :user/name "Alice"}

;; Code/symbolic → List (rare in data)
(+ 1 2 3)
```

### 3. Use Tagged Literals for Rich Types

```clojure
;; Bad - string encoding
{:created-at "2025-12-11T10:00:00Z"
 :price "99.99"
 :id "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"}

;; Good - tagged literals
{:created-at #inst "2025-12-11T10:00:00Z"
 :price #money/usd 99.99
 :id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"}
```

### 4. Avoid Empty Sets Literal

```clojure
;; Bad - ambiguous
#{}

;; Good - use language constructor
(hash-set)    ; Clojure
set()         # Python
new Set()     // JavaScript
```

---

## Edge Cases

### Keyword/Symbol Naming

**Valid**:

```clojure
:my-keyword
:my_keyword
:my.keyword
:namespace/keyword
:+special*chars!
```

**Invalid**:

```clojure
:123keyword  ; Cannot start with number
:my keyword  ; No spaces
```

### Number Formats

**Valid**:

```clojure
42
-42
+42
0
3.14
1.5e10
42N
3.14M
```

**Invalid**:

```clojure
.5      ; Must have leading digit (use 0.5)
5.      ; Must have trailing digit (use 5.0)
1,000   ; No comma separators
```

### String Escaping

**Valid**:

```clojure
"Hello\nWorld"
"Quote: \"Hi\""
"\u03A9"  ; Unicode
```

**Invalid**:

```clojure
"Hello\xWorld"  ; Invalid escape sequence
'single quotes' ; Must use double quotes
```

---

## See Also

- [EXTENSIBILITY.md](EXTENSIBILITY.md) - Tagged literals and namespaces
- [DESIGN.md](DESIGN.md) - Schema design patterns
- [COMPARISON.md](COMPARISON.md) - Detailed format comparisons
- [EXAMPLES.md](EXAMPLES.md) - Real-world EDN examples
- [Official EDN Specification](https://github.com/edn-format/edn) - Authoritative reference
