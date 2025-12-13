# EDN Schema Design Patterns

Comprehensive guide to designing EDN data structures, choosing collection types, and applying best practices for domain modeling.

## Overview

EDN schema design is about **leveraging EDN's semantic richness** to create self-documenting, evolvable data structures that accurately represent your domain.

### Core Design Principles

1. **Use Qualified Keywords** - Self-document domain boundaries
2. **Choose Semantic Collections** - Vector vs list vs set has meaning
3. **Leverage Tagged Literals** - Rich types for domain concepts
4. **Design for Evolution** - Schemas will change over time
5. **Keep It Simple** - Don't over-engineer the schema

---

## Collection Type Selection

### Decision Tree: Which Collection?

**Do you need ordered elements?**

- **YES** → Use **Vector** `[...]` (99% of cases)
  - Indexed access
  - General purpose
  - Most common choice

- **NO, but need uniqueness** → Use **Set** `#{...}`
  - Unordered
  - Automatically unique
  - Efficient membership checks

**Do you need key-value lookup?**

- **YES** → Use **Map** `{...}`
  - Associative data
  - Entity representation
  - Configuration

**Is this code/symbolic data?**

- **YES** → Use **List** `(...)`
  - Rare in pure data
  - Common in code representation

### Examples

**Ordered sequence - Vector**:

```clojure
{:user/tags ["premium" "verified" "admin"]}
{:product/images ["img1.jpg" "img2.jpg" "img3.jpg"]}
```

**Unique values - Set**:

```clojure
{:user/roles #{:admin :user :moderator}}
{:feature/flags #{:auth :caching :logging}}
```

**Key-value data - Map**:

```clojure
{:user/id 123
 :user/name "Alice"
 :user/email "alice@example.com"}
```

---

## Qualified Keyword Patterns

### Why Qualified Keywords?

**Problem**: Namespace collisions and unclear data ownership

```clojure
;; Bad - unclear which domain
{:id 123
 :name "Alice"
 :status :active}
```

**Solution**: Qualified keywords show domain boundaries

```clojure
;; Good - domain-qualified
{:user/id 123
 :user/name "Alice"
 :user/status :active}
```

### Namespace Organization Strategies

#### 1. Domain-Based (Recommended)

Organize by domain concepts:

```clojure
;; User domain
{:user/id 123
 :user/name "Alice"
 :user/email "alice@example.com"}

;; Order domain
{:order/id 456
 :order/user-id 123
 :order/total 99.99M}

;; Product domain
{:product/sku "ABC-123"
 :product/name "Widget"
 :product/price 29.99M}
```

#### 2. Aggregate-Based

For domain-driven design:

```clojure
;; User aggregate
{:user/id 123
 :user/profile {:user.profile/bio "..." :user.profile/avatar "..."}
 :user/settings {:user.settings/theme :dark}}
```

#### 3. Reverse DNS (Libraries)

For widely-distributed code:

```clojure
{:com.example.myapp/version "1.0.0"
 :org.clojure/spec-version "0.2.0"}
```

### Best Practices

**1. Use entity-based namespaces**:

```clojure
;; Good - entity-based
{:user/id 123 :user/name "Alice"}

;; Bad - type-based
{:string/name "Alice" :int/id 123}
```

**2. Keep namespaces short**:

```clojure
;; Good
{:user/id 123}

;; Avoid overly long namespaces
{:com.example.myapp.domain.user/id 123}
```

**3. Use sub-namespaces sparingly**:

```clojure
;; Good - simple
{:user/name "Alice"
 :user/address-street "123 Main St"}

;; Also good - nested when complex
{:user/name "Alice"
 :user/address
 {:address/street "123 Main St"
  :address/city "SF"}}
```

---

## Entity Representation

### Simple Entities

**Pattern**: Flat map with qualified keywords

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/name "Alice Smith"
 :user/email "alice@example.com"
 :user/created-at #inst "2025-01-15T08:30:00Z"
 :user/verified true
 :user/roles #{:admin :user}}
```

### Nested Entities

**Pattern**: Embedded maps with their own namespaces

```clojure
{:user/id 123
 :user/name "Alice"
 :user/address
 {:address/street "123 Main St"
  :address/city "San Francisco"
  :address/state "CA"
  :address/postal-code "94102"
  :address/country "US"}
 :user/contact
 {:contact/email "alice@example.com"
  :contact/phone "+1-415-555-0100"}}
```

### Entity References

**Pattern**: ID-based references

```clojure
;; Order references user by ID
{:order/id 456
 :order/user-id 123  ; Reference to user
 :order/items [...]
 :order/total 99.99M}

;; With UUID references
{:order/id #uuid "..."
 :order/user-id #uuid "..."  ; Strong typing with UUID
 :order/status :pending}
```

### Collections of Entities

**Pattern**: Vector of entity maps

```clojure
{:order/id 12345
 :order/items
 [{:item/sku "ABC-123"
   :item/name "Widget"
   :item/quantity 2
   :item/price 29.99M}
  {:item/sku "XYZ-789"
   :item/name "Gadget"
   :item/quantity 1
   :item/price 149.99M}]
 :order/total 209.97M}
```

---

## Tagged Literal Design

### When to Use Tagged Literals

**Use tagged literals when**:

1. **Type needs special handling** - Money, dates, UUIDs
2. **Semantic clarity important** - #user/entity vs plain map
3. **Validation at read time** - Ensure format correctness
4. **Cross-system interop** - Common types across services

**Don't use tagged literals when**:

1. **Simple primitive types suffice** - Numbers, strings, booleans
2. **No special semantics** - Just data containers
3. **Reader complexity not worth it** - Overhead of custom readers

### Money and Currency

**Problem**: Floating point imprecision

**Solution**: Tagged literals with exact decimals

```clojure
;; Option 1: Currency-specific tags
{:product/price #money/usd 99.99
 :product/sale-price #money/usd 79.99}

;; Option 2: Explicit currency in value
{:product/price #money {:amount 99.99M :currency :USD}
 :product/sale-price #money {:amount 79.99M :currency :USD}}
```

### Temporal Data

**Timestamps - Use #inst**:

```clojure
{:event/occurred-at #inst "2025-12-11T10:00:00Z"}
```

**Date-only - Custom #date**:

```clojure
{:user/birth-date #date "1990-05-15"
 :event/start-date #date "2025-12-11"}
```

**Durations - Custom #duration**:

```clojure
{:session/timeout #duration "30m"
 :cache/ttl #duration "1h"
 :subscription/period #duration "1y"}
```

### Domain Entities

**Pattern**: Tag entire entities

```clojure
;; Without tag - unclear type
{:id 123 :name "Alice"}

;; With tag - explicit type
#user/entity
{:id 123 :name "Alice" :email "alice@example.com"}

;; For polymorphic data
[#user/created {:user-id 123}
 #order/placed {:order-id 456}
 #payment/processed {:payment-id 789}]
```

---

## Schema Evolution

### Versioning Strategies

#### 1. Additive Changes (Preferred)

**Pattern**: Add new fields, keep old ones

```clojure
;; Version 1
{:user/id 123
 :user/name "Alice"}

;; Version 2 - added email (backward compatible)
{:user/id 123
 :user/name "Alice"
 :user/email "alice@example.com"}
```

**Readers handle both**:

```clojure
;; Old readers ignore :user/email
;; New readers use :user/email if present
```

#### 2. Optional Fields

**Pattern**: Use nil for missing/unknown

```clojure
{:user/id 123
 :user/name "Alice"
 :user/middle-name nil  ; Explicitly no middle name
 :user/email "alice@example.com"}
```

#### 3. Explicit Versioning

**Pattern**: Version tag for breaking changes

```clojure
;; Old version
#user/v1 {:id 123 :name "Alice Smith"}

;; New version - split name
#user/v2
{:id 123
 :first-name "Alice"
 :last-name "Smith"}
```

**Reader handles both**:

```clojure
(defn read-user-v1 [data]
  (let [[first last] (str/split (:name data) #" ")]
    {:id (:id data)
     :first-name first
     :last-name last}))

(defn read-user-v2 [data]
  data)  ; Already in correct format
```

### Migration Patterns

#### Field Renaming

```clojure
;; Before
{:user/email-address "alice@example.com"}

;; After (keep both during transition)
{:user/email "alice@example.com"
 :user/email-address "alice@example.com"}  ; Deprecated

;; Eventually remove old field
{:user/email "alice@example.com"}
```

#### Type Changes

```clojure
;; Before - string ID
{:user/id "123"}

;; During migration - support both
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/legacy-id "123"}

;; After migration - UUID only
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"}
```

---

## Configuration Patterns

### Application Configuration

```clojure
{:app/name "MyApp"
 :app/version "1.0.0"
 :app/environment :production

 :server/host "0.0.0.0"
 :server/port 8080
 :server/threads 10

 :database/url "postgresql://localhost:5432/myapp"
 :database/pool-size 20
 :database/timeout #duration "30s"

 :cache/enabled true
 :cache/ttl #duration "1h"
 :cache/max-size 1000

 :features #{:authentication :rate-limiting :logging}}
```

### Feature Flags

```clojure
{:features/enabled #{:new-ui :beta-api :experimental-cache}
 :features/disabled #{:old-ui}

 :feature/new-ui
 {:enabled-for #{:admin :beta-testers}
  :rollout-percentage 50}

 :feature/beta-api
 {:enabled true
  :endpoints #{"/api/v2/users" "/api/v2/orders"}}}
```

### Environment-Specific

```clojure
;; Base config
{:app/name "MyApp"
 :database/pool-size 10}

;; Production overrides
#env/production
{:database/url "postgresql://prod:5432/myapp"
 :database/pool-size 50
 :cache/enabled true}

;; Development overrides
#env/development
{:database/url "postgresql://localhost:5432/myapp_dev"
 :debug/enabled true}
```

---

## API Schema Patterns

### Request Schema

```clojure
{:request/method :POST
 :request/path "/api/users"
 :request/headers
 {"Content-Type" "application/edn"
  "Authorization" "Bearer ..."}

 :request/body
 {:user/name "Alice Smith"
  :user/email "alice@example.com"
  :user/roles #{:user}}}
```

### Response Schema

```clojure
{:response/status 201
 :response/headers
 {"Content-Type" "application/edn"
  "Location" "/api/users/123"}

 :response/body
 {:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
  :user/name "Alice Smith"
  :user/email "alice@example.com"
  :user/created-at #inst "2025-12-11T10:00:00Z"}}
```

### Versioned Endpoints

```clojure
;; v1 response
#api/v1
{:id 123
 :name "Alice Smith"}

;; v2 response - richer structure
#api/v2
{:user/id #uuid "..."
 :user/profile
 {:profile/first-name "Alice"
  :profile/last-name "Smith"}}
```

---

## Event Sourcing Patterns

### Event Schemas

```clojure
;; Base event structure
{:event/id #uuid "..."
 :event/type :user/created
 :event/timestamp #inst "2025-12-11T10:00:00Z"
 :event/aggregate-id #uuid "..."
 :event/data {:user/name "Alice" :user/email "..."}}

;; Using tagged literals for polymorphism
[#event/user-created
 {:user-id #uuid "..."
  :name "Alice"
  :email "alice@example.com"
  :timestamp #inst "2025-12-11T10:00:00Z"}

 #event/order-placed
 {:order-id #uuid "..."
  :user-id #uuid "..."
  :items [...]
  :total #money/usd 99.99
  :timestamp #inst "2025-12-11T10:05:00Z"}]
```

### Command Schemas

```clojure
#command/create-user
{:name "Alice Smith"
 :email "alice@example.com"
 :roles #{:user}}

#command/place-order
{:user-id #uuid "..."
 :items [{:sku "ABC-123" :quantity 2}]
 :shipping-address {...}}
```

---

## Validation Strategies

### Using Clojure Spec

```clojure
(require '[clojure.spec.alpha :as s])

;; Define specs for EDN structure
(s/def :user/id uuid?)
(s/def :user/name string?)
(s/def :user/email string?)  ; Could add regex
(s/def :user/created-at inst?)

(s/def :user/entity
  (s/keys :req [:user/id :user/name :user/email]
          :opt [:user/created-at]))

;; Validate data
(s/valid? :user/entity
  {:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
   :user/name "Alice"
   :user/email "alice@example.com"})
;; => true
```

### Schema Annotations

```clojure
;; Document schema inline
{:user/id #uuid "..."          ; Required: Unique identifier
 :user/name "Alice"            ; Required: Full name
 :user/email "alice@..."       ; Required: Valid email address
 :user/middle-name nil         ; Optional: Middle name if present
 :user/verified true}          ; Required: Email verification status
```

---

## Common Patterns

### Lookup Tables

```clojure
{:colors/hex
 {:red "#FF0000"
  :green "#00FF00"
  :blue "#0000FF"}

 :status/labels
 {:pending "Pending Approval"
  :approved "Approved"
  :rejected "Rejected"}}
```

### Hierarchical Data

```clojure
{:category/id 1
 :category/name "Electronics"
 :category/children
 [{:category/id 2
   :category/name "Computers"
   :category/parent-id 1}
  {:category/id 3
   :category/name "Phones"
   :category/parent-id 1}]}
```

### Audit Trail

```clojure
{:entity/id #uuid "..."
 :entity/data {:user/name "Alice"}
 :entity/metadata
 {:created-by #uuid "..."
  :created-at #inst "2025-12-11T10:00:00Z"
  :updated-by #uuid "..."
  :updated-at #inst "2025-12-11T11:00:00Z"
  :version 2}}
```

---

## Anti-Patterns

### 1. Unqualified Keywords in Public APIs

```clojure
;; Bad
{:id 123 :name "Alice"}

;; Good
{:user/id 123 :user/name "Alice"}
```

### 2. Mixing Collection Semantics

```clojure
;; Bad - using vector when set is appropriate
{:user/roles [:admin :user :admin]}  ; Duplicates!

;; Good
{:user/roles #{:admin :user}}
```

### 3. String Encoding Rich Types

```clojure
;; Bad
{:created-at "2025-12-11T10:00:00Z"
 :price "99.99"}

;; Good
{:created-at #inst "2025-12-11T10:00:00Z"
 :price #money/usd 99.99}
```

### 4. Nested Namespaces Without Structure

```clojure
;; Bad - flat with fake hierarchy
{:user.profile.bio "..."
 :user.profile.avatar "..."
 :user.settings.theme :dark}

;; Good - actual nesting
{:user/profile {:profile/bio "..." :profile/avatar "..."}
 :user/settings {:settings/theme :dark}}
```

### 5. Over-Engineering

```clojure
;; Bad - unnecessary complexity
#user/entity
{:user/metadata
 {:metadata/version 1
  :metadata/schema-version "2.0"}
 :user/data
 {:data/id 123
  :data/name "Alice"}}

;; Good - simple and clear
{:user/id 123
 :user/name "Alice"}
```

---

## Decision Checklist

When designing an EDN schema, ask:

**1. Collection Types**:

- [ ] Ordered? → Vector
- [ ] Unique? → Set
- [ ] Lookup? → Map
- [ ] Symbolic? → List (rare)

**2. Keywords**:

- [ ] Using qualified keywords for entities?
- [ ] Namespaces match domain boundaries?
- [ ] Avoiding overly long namespaces?

**3. Tagged Literals**:

- [ ] Rich types need custom tags?
- [ ] Money using exact decimals?
- [ ] Timestamps using #inst?
- [ ] Custom tags documented?

**4. Evolution**:

- [ ] Schema allows additive changes?
- [ ] Optional fields use nil?
- [ ] Versioning strategy defined?

**5. Validation**:

- [ ] Required vs optional fields clear?
- [ ] Data constraints documented?
- [ ] Validation strategy chosen?

---

## See Also

- [FORMAT.md](FORMAT.md) - Core data types and syntax
- [EXTENSIBILITY.md](EXTENSIBILITY.md) - Tagged literal design
- [COMPARISON.md](COMPARISON.md) - When to use EDN vs other formats
- [../frameworks/schema-design.md](../frameworks/schema-design.md) - Step-by-step design process
- [../frameworks/namespace-design.md](../frameworks/namespace-design.md) - Namespace organization
- [EXAMPLES.md](EXAMPLES.md) - Real-world schema examples
