# Extensible Data Notation (EDN) Skill

**Expert guidance for mastering EDN format, designing extensible schemas, and leveraging semantic richness for configuration, data interchange, and domain modeling.**

## Overview

This Claude Code skill provides comprehensive expertise in **Extensible Data Notation (EDN)** - a data format that prioritizes:

- **Extensibility**: Tagged literals for custom types without parser changes
- **Semantic Richness**: Multiple collection types with distinct meanings
- **Self-Documentation**: Qualified keywords that convey domain intent
- **Human Readability**: Clean syntax with powerful expressiveness
- **Cross-Language Support**: Language-agnostic specification

Whether you're learning EDN, designing schemas, migrating from JSON/YAML, or implementing custom readers, this skill provides expert guidance at every level.

## Features

- **Format Mastery**: Complete coverage of all 12 EDN data types and syntax rules
- **Extensibility Expertise**: Tagged literal design patterns and namespace conventions
- **Schema Design Guidance**: Best practices for domain modeling with EDN
- **Format Comparison**: Decision framework for choosing EDN vs JSON/YAML/XML
- **Cross-Language Support**: Library guidance for Clojure, JavaScript, Python, Ruby, Rust, Go
- **Real-World Examples**: Production patterns for configuration, APIs, events, and domain models
- **Three Operational Modes**: Guide (advisory), Designer (interactive), Implementation (code assistance)
- **Migration Support**: Frameworks for moving from JSON/YAML to EDN

## Requirements

**No external dependencies required**

This skill is purely knowledge-based and can be applied to any EDN-related task:

- Learning the EDN format
- Designing EDN schemas
- Implementing custom readers
- Migrating from other formats
- Making format selection decisions
- Working with EDN libraries in any language

## Installation

### Using Claude Code

1. **Clone or download this skill repository**:

   ```bash
   cd /path/to/your/skills
   git clone <repository-url> skill-extensible-data-notation
   ```

2. **Verify the skill is recognized**:

   ```bash
   claude-code skills list
   ```

   You should see `skill-extensible-data-notation` in the list.

3. **Invoke the skill**:

   In Claude Code, activate the skill with:

   ```txt
   @skill-extensible-data-notation help me design an EDN schema for user profiles
   ```

### Verification

To verify the skill is working correctly:

```txt
@skill-extensible-data-notation explain the difference between EDN and JSON
```

You should receive a detailed explanation of EDN's extensibility, semantic richness, and how it differs from JSON.

## Quick Start

### Learning EDN

**Understand the Format Fundamentals**:

```txt
@skill-extensible-data-notation what are the core data types in EDN?
```

The skill will explain all 12 built-in types with examples:

- Atomic values (nil, booleans, strings, characters, numbers)
- Identifiers (keywords, symbols)
- Collections (vectors, lists, maps, sets)
- Extensibility (tagged literals)

See [spec/FORMAT.md](spec/FORMAT.md) for complete syntax reference.

### Designing Schemas

**Get Interactive Design Guidance**:

```txt
@skill-extensible-data-notation help me design an EDN schema for e-commerce orders
```

The skill will guide you step-by-step through:

- Domain identification
- Qualified keyword naming
- Collection type selection
- Tagged literal design
- Schema evolution considerations

See [spec/DESIGN.md](spec/DESIGN.md) and [frameworks/schema-design.md](frameworks/schema-design.md) for design patterns.

### Studying Examples

**Learn from Real-World Patterns**:

```txt
@skill-extensible-data-notation show me EDN examples for API contracts
```

The skill provides production-tested examples with:

- Problem statement
- Conventional approach (JSON/YAML)
- EDN solution with tagged literals
- Outcome and benefits
- Lessons learned

See [examples/](examples/) directory for case studies across configuration, data interchange, and domain modeling.

### Implementing Readers

**Get Language-Specific Code Help**:

```txt
@skill-extensible-data-notation how do I implement a custom #money/usd reader in Python?
```

The skill provides implementation code for:

- Clojure, JavaScript, Python, Ruby, Rust, Go
- Custom tagged literal handlers
- Library selection and usage
- Best practices per language

See [spec/LIBRARIES.md](spec/LIBRARIES.md) and [frameworks/reader-implementation.md](frameworks/reader-implementation.md).

## Documentation

### Main Documentation

- [SKILL.md](SKILL.md) - Skill definition, operational modes, capabilities overview

### Specification Files (Core Knowledge)

- [FORMAT.md](spec/FORMAT.md) - Complete EDN syntax and semantics reference
- [EXTENSIBILITY.md](spec/EXTENSIBILITY.md) - Tagged literals, namespaces, reader extensibility
- [DESIGN.md](spec/DESIGN.md) - Schema design patterns and best practices
- [COMPARISON.md](spec/COMPARISON.md) - EDN vs JSON/YAML/XML decision framework
- [LIBRARIES.md](spec/LIBRARIES.md) - Cross-language ecosystem and library guide

### Operational Mode Documentation

- [GUIDE.md](spec/GUIDE.md) - Advisory mode (conceptual explanations)
- [FACILITATOR.md](spec/FACILITATOR.md) - Designer mode (interactive schema design)
- [INTEGRATION.md](spec/INTEGRATION.md) - Implementation mode (code assistance)

### Supporting Documentation

- [EXAMPLES.md](spec/EXAMPLES.md) - Case study index and catalog
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation and learning paths

### Frameworks (Practical Templates)

- [schema-design.md](frameworks/schema-design.md) - Step-by-step schema design process
- [namespace-design.md](frameworks/namespace-design.md) - Namespace organization strategies
- [reader-implementation.md](frameworks/reader-implementation.md) - Custom reader patterns
- [migration-guide.md](frameworks/migration-guide.md) - JSON/YAML → EDN migration

### Examples (Real-World Applications)

#### Configuration

- [app-config.md](examples/configuration/app-config.md) - Application configuration patterns
- [cloud-native.md](examples/configuration/cloud-native.md) - Cloud-native config with secrets

#### Data Interchange

- [api-contracts.md](examples/data-interchange/api-contracts.md) - API request/response schemas
- [event-sourcing.md](examples/data-interchange/event-sourcing.md) - Event stream patterns

#### Domain Modeling

- [user-management.md](examples/domain-modeling/user-management.md) - User domain entities
- [financial-data.md](examples/domain-modeling/financial-data.md) - Money, dates, calculations

### Reference

- [tagged-literal-registry.md](reference/tagged-literal-registry.md) - Common custom tags catalog

## Architecture

```sh
skill-extensible-data-notation/
├── SKILL.md                          # Skill definition and entry point
├── README.md                         # This file
├── spec/                             # Core specifications
│   ├── FORMAT.md                    # Syntax and semantics
│   ├── EXTENSIBILITY.md             # Tagged literals
│   ├── DESIGN.md                    # Schema patterns
│   ├── COMPARISON.md                # Format selection
│   ├── GUIDE.md                     # Advisory mode
│   ├── FACILITATOR.md               # Designer mode
│   ├── INTEGRATION.md               # Implementation mode
│   ├── LIBRARIES.md                 # Cross-language
│   ├── EXAMPLES.md                  # Case study index
│   └── REFERENCES.md                # Navigation
├── frameworks/                       # Practical templates
│   ├── schema-design.md             # Design process
│   ├── namespace-design.md          # Namespace patterns
│   ├── reader-implementation.md     # Reader patterns
│   └── migration-guide.md           # Migration steps
├── examples/                         # Real-world cases
│   ├── configuration/               # Config examples
│   ├── data-interchange/            # API/event examples
│   └── domain-modeling/             # Domain examples
└── reference/
    └── tagged-literal-registry.md    # Common tags
```

## Usage Patterns

### Pattern 1: Learning Mode

**Goal**: Understand EDN format and when to use it

**Approach**:

1. Start with [spec/FORMAT.md](spec/FORMAT.md) for syntax basics
2. Read [spec/COMPARISON.md](spec/COMPARISON.md) to understand trade-offs
3. Study [spec/EXTENSIBILITY.md](spec/EXTENSIBILITY.md) for tagged literals
4. Review examples in [examples/](examples/) for real patterns

**Example Questions**:

- "What makes EDN extensible?"
- "When should I use a vector vs a list?"
- "How do tagged literals work?"
- "Why would I choose EDN over JSON?"

### Pattern 2: Design Mode

**Goal**: Design EDN schemas for a specific domain

**Approach**:

1. Describe your domain to the skill in Designer Mode
2. Follow the interactive schema design process
3. Review [frameworks/schema-design.md](frameworks/schema-design.md) for structured approach
4. Validate against patterns in [spec/DESIGN.md](spec/DESIGN.md)

**Example Questions**:

- "Help me design an EDN schema for product catalogs"
- "How should I model user permissions in EDN?"
- "What's the best way to represent hierarchical data?"
- "Should I use qualified keywords for this use case?"

### Pattern 3: Implementation Mode

**Goal**: Implement EDN parsing/generation in your language

**Approach**:

1. Identify your target language
2. Consult [spec/LIBRARIES.md](spec/LIBRARIES.md) for library options
3. Follow [frameworks/reader-implementation.md](frameworks/reader-implementation.md) for custom tags
4. Request language-specific code examples

**Example Questions**:

- "How do I parse EDN in JavaScript?"
- "Show me how to implement #date tags in Python"
- "What's the best EDN library for Rust?"
- "How do I serialize EDN from Go?"

## Examples by Use Case

### Configuration Management

**Search**: Configuration, settings, feature flags, cloud-native

**Examples**:

- Application configuration with rich types ([app-config.md](examples/configuration/app-config.md))
- Cloud-native configuration with secrets ([cloud-native.md](examples/configuration/cloud-native.md))

### API Design

**Search**: API, contracts, request, response, REST, GraphQL

**Examples**:

- API request/response schemas ([api-contracts.md](examples/data-interchange/api-contracts.md))

### Event Sourcing

**Search**: Events, commands, CQRS, event streams

**Examples**:

- Event stream patterns ([event-sourcing.md](examples/data-interchange/event-sourcing.md))

### Domain Modeling

**Search**: Entities, aggregates, domain-driven design

**Examples**:

- User management domain ([user-management.md](examples/domain-modeling/user-management.md))
- Financial data modeling ([financial-data.md](examples/domain-modeling/financial-data.md))

## Integration with Other Skills

This EDN skill can enhance domain-specific skills by providing:

### For Configuration Skills

- **Rich type support**: Use tagged literals instead of string encoding
- **Self-documentation**: Qualified keywords make config understandable
- **Extensibility**: Add custom types without breaking parsers

### For API Design Skills

- **Schema evolution**: Tagged literals for versioned entities
- **Semantic clarity**: Collection types convey intent
- **Cross-service contracts**: Language-agnostic format

### For Domain Modeling Skills

- **Bounded contexts**: Namespaces map to domain boundaries
- **Rich domain types**: Money, dates, measurements as tagged literals
- **Event design**: Tagged event types for event sourcing

## Contributing

### Reporting Issues

If you encounter issues or have questions:

1. Check [spec/REFERENCES.md](spec/REFERENCES.md) for documentation navigation
2. Review relevant spec files and examples
3. Open an issue describing the problem or question

### Submitting Examples

To contribute real-world EDN examples:

1. Follow the structure in [examples/](examples/)
2. Include: Problem → Conventional Approach → EDN Solution → Outcome → Lessons
3. Add references to relevant spec files
4. Submit via pull request

### Documentation Standards

- Use code blocks with `clojure` syntax highlighting for EDN
- Cross-reference related documentation
- Include practical examples for every concept
- Follow the pattern: What → Why → How → Example

## Philosophy

This skill demonstrates **first principles thinking** applied to data formats:

1. **Fundamental Question**: What should a data notation be if designed from scratch?
2. **Core Truths Identified**:
   - Data should be values (immutable, comparable)
   - Extensibility should be first-class (not bolted on)
   - Semantics should be rich (multiple collection types)
   - Structure should be simple (minimal syntax)
3. **Result**: EDN's design emerges from these principles

The skill itself is structured using the same principles: fundamentals first, then patterns, then applications.

## License

[Specify your license]

## Support

For questions about EDN specification: https://github.com/edn-format/edn

For questions about this skill: [Your support channel]

---

**Version**: 1.0.0
**Last Updated**: 2025-12-11
**Skill Type**: Knowledge/Advisory
**Target Audience**: Mixed (Clojure developers, polyglot developers, DevOps engineers, data engineers)
