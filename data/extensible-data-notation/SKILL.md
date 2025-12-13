---
name: skill-extensible-data-notation
description: Expert guide for Extensible Data Notation (EDN). Master EDN's syntax, design extensible schemas with tagged literals, apply namespace conventions, and leverage EDN's semantic richness for configuration, data interchange, and domain modeling. Use for format selection, schema design, or implementing custom readers.
allowed-tools: Read, Write, Grep, Glob, Bash, WebFetch
---

# Extensible Data Notation (EDN) Skill - Format Mastery & Design Expertise

## Overview

This skill provides comprehensive expertise in **Extensible Data Notation (EDN)** - a data format designed for extensibility, semantic richness, and human readability. EDN goes beyond simple serialization by providing tagged literals for custom types, multiple collection semantics, and namespace conventions that make data self-documenting.

Unlike JSON (minimal but inflexible) or YAML (flexible but surprising), EDN was built from first principles to be **extensible without specification changes** through its tagged literal system.

## Requirements

**No external dependencies required**

This skill covers the EDN specification and can be applied across:

- Configuration management
- Data interchange and API contracts
- Event sourcing and domain modeling
- Schema design and validation
- Cross-language data serialization

## Operational Modes

### Guide Mode (Advisory)

- Explains EDN concepts and design philosophy
- Recommends when to use EDN vs alternatives
- Teaches tagged literal design patterns
- Provides namespace organization strategies
- Answers conceptual questions
- See [GUIDE.md](spec/GUIDE.md) for details

### Designer Mode (Interactive)

- Guides EDN schema design step-by-step
- Helps choose appropriate collection types
- Assists with qualified keyword naming
- Designs custom tagged literals
- Validates schemas against best practices
- See [FACILITATOR.md](spec/FACILITATOR.md) for details

### Implementation Mode (Code Assistance)

- Helps implement custom EDN readers
- Provides parsing/serialization code examples
- Guides library selection for target languages
- Assists with migration from JSON/YAML
- Troubleshoots EDN-related issues
- See [INTEGRATION.md](spec/INTEGRATION.md) for details

## Core Capabilities

### 1. Format Specification Mastery

Complete understanding of EDN syntax and semantics ([FORMAT.md](spec/FORMAT.md)):

- **12 built-in data types**: nil, booleans, strings, characters, numbers, keywords, symbols, vectors, lists, maps, sets
- **Parsing semantics**: Whitespace handling, comments, reader behavior
- **Collection distinctions**: When to use vectors vs lists, maps vs sets
- **Syntax rules**: Valid characters, escaping, number formats
- **Edge cases**: Empty collections, nested structures, special values

### 2. Extensibility Through Tagged Literals

Master the core innovation of EDN ([EXTENSIBILITY.md](spec/EXTENSIBILITY.md)):

- **Tagged literal syntax**: `#tag value` for custom types
- **Built-in tags**: `#inst` for timestamps, `#uuid` for UUIDs
- **Custom tag design**: Creating domain-specific tagged literals
- **Reader extensibility**: How tagged literals work at reader level
- **Namespace conventions**: Organizing tags to prevent collisions
- **Common patterns**: Money, dates, measurements, domain entities

### 3. Schema Design & Best Practices

Guidance for designing EDN data structures ([DESIGN.md](spec/DESIGN.md)):

- **Collection type selection**: Vector vs list, map vs set
- **Qualified keywords**: Using namespaces for self-documenting data
- **Domain modeling**: Mapping business concepts to EDN structures
- **Schema evolution**: Maintaining backward compatibility
- **Validation strategies**: With spec, schemas, or custom validation
- **Design patterns**: Configuration, events, entities, aggregates

### 4. Format Comparison & Selection

Understanding when and why to use EDN ([COMPARISON.md](spec/COMPARISON.md)):

- **EDN vs JSON**: Extensibility, semantic richness, use cases
- **EDN vs YAML**: Clarity vs convenience trade-offs
- **EDN vs XML**: Simplicity vs expressiveness
- **EDN vs Binary**: Human readability vs performance
- **Decision matrix**: Choosing the right format for your needs
- **Migration strategies**: Moving from other formats to EDN

### 5. Cross-Language Ecosystem

Working with EDN across programming languages ([LIBRARIES.md](spec/LIBRARIES.md)):

- **Clojure/ClojureScript**: Native support and idioms
- **JavaScript/TypeScript**: jsedn, edn-js libraries
- **Python**: edn_format library
- **Ruby**: edn-ruby gem
- **Rust**: edn-rs crate
- **Go**: go-edn package
- **Language-specific patterns**: Idiomatic usage per ecosystem

### 6. Real-World Applications

Practical patterns from production use cases ([EXAMPLES.md](spec/EXAMPLES.md)):

- **Configuration management**: Application config, feature flags, cloud-native settings
- **API contracts**: Request/response schemas, versioned endpoints
- **Event sourcing**: Event streams, command patterns, sagas
- **Domain modeling**: User management, financial data, catalog systems
- **Data interchange**: Service-to-service communication, ETL pipelines
- **Schema design**: Complex domain entities with rich types

## Quick Start

### Learning the Format

**User**: "Explain what makes EDN different from JSON"

**Guide Mode Response**:
> EDN fundamentally differs from JSON in three ways:
>
> **1. Extensibility**: Tagged literals let you add custom types without changing the parser
>
> ```clojure
> #money/usd 99.99          ; Custom money type
> #inst "2025-12-11T10:00"  ; Built-in timestamp
> ```
>
> **2. Semantic Collections**: Different collection types have distinct meanings
>
> ```clojure
> [1 2 3]    ; Vector - indexed access
> (1 2 3)    ; List - sequential processing
> #{1 2 3}   ; Set - uniqueness constraint
> ```
>
> **3. Rich Identifiers**: Keywords and symbols are first-class
>
> ```clojure
> {:user/name "Alice"       ; Qualified keyword (self-documenting)
>  :user/id 123
>  :user/email "alice@example.com"}
> ```
>
> See [FORMAT.md](spec/FORMAT.md) and [COMPARISON.md](spec/COMPARISON.md) for complete details.

### Designing a Schema

**User**: "Help me design an EDN schema for user profiles with addresses"

**Designer Mode Response**:
> Let's design this step-by-step using EDN best practices:
>
> **Step 1: Identify domains**
>
> - User domain (identity, profile)
> - Address domain (location)
>
> **Step 2: Use qualified keywords**
>
> ```clojure
> {:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
>  :user/name "Alice Smith"
>  :user/email "alice@example.com"
>  :user/created-at #inst "2025-01-15T08:30:00Z"
>  :user/address
>  {:address/street "123 Main St"
>   :address/city "San Francisco"
>   :address/state "CA"
>   :address/postal-code "94102"
>   :address/country "US"}}
> ```
>
> **Step 3: Consider tagged literals for rich types**
>
> ```clojure
> {:user/id #uuid "..."
>  :user/address #address/us {:street "..." :city "..." :zip "94102"}}
> ```
>
> Would you like to add validation rules or discuss schema evolution?
>
> See [DESIGN.md](spec/DESIGN.md) for comprehensive design patterns.

### Implementing a Reader

**User**: "How do I implement a custom reader for #money/usd tags in JavaScript?"

**Implementation Mode Response**:
> Here's how to implement a custom #money/usd reader using the jsedn library:
>
> ```javascript
> const edn = require('jsedn');
>
> // Define a Money class
> class Money {
>   constructor(amount, currency) {
>     this.amount = amount;
>     this.currency = currency;
>   }
>
>   toString() {
>     return `${this.currency} ${this.amount.toFixed(2)}`;
>   }
> }
>
> // Register custom tag reader
> edn.setTagAction(
>   new edn.Tag('money', 'usd'),
>   (value) => new Money(value, 'USD')
> );
>
> // Parse EDN with custom tag
> const data = edn.parse('#money/usd 99.99');
> console.log(data.toString()); // "USD 99.99"
> ```
>
> For other languages, see [LIBRARIES.md](spec/LIBRARIES.md) and [frameworks/reader-implementation.md](frameworks/reader-implementation.md).

## When to Use This Skill

### Optimal Use Cases

1. **Configuration Files** - Rich types, extensibility, clarity
2. **API Schemas** - Self-documenting, evolvable, semantic
3. **Domain Modeling** - Qualified keywords map to bounded contexts
4. **Event Streams** - Tagged literals for event types
5. **Data Interchange** - Between services in heterogeneous systems
6. **Schema Design** - When you need more than JSON but less than XML
7. **Migration from JSON** - Adding type safety and extensibility

### When NOT to Use EDN

- **Browser JavaScript** - JSON has native support and better tooling
- **Maximum Performance** - Binary formats (Protocol Buffers, MessagePack) are faster
- **SQL Databases** - Most DBs don't have native EDN support (use JSONB instead)
- **Existing JSON Ecosystems** - Don't force EDN where JSON is standard
- **Team Unfamiliarity** - Learning curve may not be worth it for simple use cases

## Skill Structure

This skill is organized into comprehensive documentation layers:

```sh
skill-extensible-data-notation/
├── SKILL.md                         # This file - skill definition
├── README.md                        # Installation and quick start
├── spec/                            # Detailed specifications
│   ├── FORMAT.md                   # Complete syntax reference
│   ├── EXTENSIBILITY.md            # Tagged literals and namespaces
│   ├── DESIGN.md                   # Schema design patterns
│   ├── COMPARISON.md               # vs JSON/YAML/XML
│   ├── GUIDE.md                    # Advisory mode (conceptual)
│   ├── FACILITATOR.md              # Designer mode (interactive)
│   ├── INTEGRATION.md              # Implementation mode (code)
│   ├── LIBRARIES.md                # Cross-language ecosystem
│   ├── EXAMPLES.md                 # Case study index
│   └── REFERENCES.md               # Documentation navigation
├── frameworks/                      # Practical templates
│   ├── schema-design.md            # Schema design process
│   ├── namespace-design.md         # Namespace organization
│   ├── reader-implementation.md    # Custom reader patterns
│   └── migration-guide.md          # JSON/YAML → EDN
├── examples/                        # Real-world case studies
│   ├── configuration/
│   ├── data-interchange/
│   └── domain-modeling/
└── reference/
    └── tagged-literal-registry.md   # Common custom tags
```

## Priority Hierarchy

1. **Conceptual Clarity** (absolute top priority)
   - Explain fundamental differences from other formats
   - Make tagged literal concept crystal clear
   - Demonstrate when to use which collection type
   - Show why namespace conventions matter

2. **Practical Application**
   - Design patterns for real problems
   - Collection type selection guidance
   - Namespace organization strategies
   - Migration path from JSON/YAML

3. **Implementation Guidance**
   - Custom reader implementation examples
   - Library selection criteria
   - Language-specific idioms
   - Integration patterns

4. **Ecosystem Awareness**
   - Available tooling and libraries
   - Community conventions
   - Clojure and cross-language usage
   - Real-world adoption patterns

## Design Philosophy

This skill embodies EDN's own principles:

- **Extensibility First**: Tagged literals as core concept, not afterthought
- **Semantic Richness**: Multiple collection types with distinct meanings
- **Clarity Over Complexity**: Simple syntax, powerful concepts
- **Self-Documenting**: Qualified keywords make data understandable
- **Cross-Language**: Not tied to any implementation

## Documentation References

- [FORMAT.md](spec/FORMAT.md) - Complete syntax and semantics reference
- [EXTENSIBILITY.md](spec/EXTENSIBILITY.md) - Tagged literals and namespaces
- [DESIGN.md](spec/DESIGN.md) - Schema design patterns and best practices
- [COMPARISON.md](spec/COMPARISON.md) - Format selection and trade-offs
- [GUIDE.md](spec/GUIDE.md) - Advisory mode (conceptual explanations)
- [FACILITATOR.md](spec/FACILITATOR.md) - Designer mode (interactive design)
- [INTEGRATION.md](spec/INTEGRATION.md) - Implementation mode (code assistance)
- [LIBRARIES.md](spec/LIBRARIES.md) - Cross-language ecosystem guide
- [EXAMPLES.md](spec/EXAMPLES.md) - Real-world applications and case studies
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation and learning paths

## Version History

- **v1.0.0** (2025-12-11): Initial implementation
  - Complete EDN format specification coverage
  - Three operational modes (Guide, Designer, Implementation)
  - Extensibility mastery with tagged literals
  - Schema design frameworks and patterns
  - Format comparison and selection guidance
  - Cross-language ecosystem documentation
  - Real-world examples across multiple domains
  - Designed for mixed audience (Clojure, polyglot, DevOps, data engineers)
  - Balanced depth and breadth for all use cases
