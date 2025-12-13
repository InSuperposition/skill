---
name: skill-simplicity
description: Expert guide for understanding and applying simplicity in design, engineering, and decision-making. Helps distinguish genuine simplicity from superficial ease, reduce complexity through thoughtful design, and build systems that are comprehensible, maintainable, and elegant. Use for architecture decisions, code design, product development, or when fighting complexity.
allowed-tools: Read, Write, Grep, Glob, Bash
---

# Simplicity Skill - Principles and Practices for Elegant Design

## Overview

This skill provides comprehensive expertise in **simplicity** - the art and science of creating solutions that are comprehensible, maintainable, and elegant through careful reduction and thoughtful design. Simplicity is not about making things simplistic or dumbed-down; it's about achieving clarity by eliminating unnecessary complexity while preserving essential functionality.

## Core Philosophy

**Simplicity is objective, ease is subjective**

- **Simplicity** measures the intrinsic structure: How many parts? How entangled? How composable?
- **Ease** measures human convenience: How familiar? How fast to implement? How close at hand?

Great design prioritizes simplicity first, then adds ease through tooling and ergonomics. Reversing this order creates complexity debt that compounds over time.

## Requirements

**No external dependencies required**

This skill is methodology-based and applicable to any domain:

- Software architecture and system design
- Product and interface design
- Engineering and technical decisions
- Business processes and workflows
- Communication and documentation

## Core Capabilities

### 1. Simplicity Frameworks

Master-level understanding of foundational approaches to simplicity:

- **Simple Made Easy** (Rich Hickey) - Distinguishing objective simplicity from subjective ease
- **Less, but Better** (Dieter Rams) - Design principles focused on essentials
- **Laws of Simplicity** (John Maeda) - Ten laws for balancing simplicity and complexity
- **Gall's Law** - Building complex systems from simple foundations
- **KISS Principle** - Keep It Simple, Stupid
- **Unix Philosophy** - Do one thing and do it well

### 2. Evaluation Techniques

Methods for assessing and measuring simplicity:

- Identifying entanglement and coupling
- Counting essential vs accidental complexity
- Testing composability and orthogonality
- Measuring comprehensibility
- Analyzing dependencies and constraints

### 3. Reduction Strategies

Practical approaches for achieving simplicity:

- Subtracting the obvious, adding the meaningful
- Separating concerns and responsibilities
- Eliminating unnecessary abstractions
- Making implicit dependencies explicit
- Removing accidental complexity

### 4. Design Patterns

Proven patterns for simple design:

- Data-oriented design over object complexity
- Composition over inheritance
- Explicit over implicit
- Boring technology choices
- Minimal viable scope

### 5. Anti-Patterns Recognition

Common traps that masquerade as simplicity:

- Choosing ease over simplicity
- Premature abstraction
- Hidden complexity
- Tool-driven design
- Familiarity bias

## When to Use This Skill

### Optimal Use Cases

1. **Architecture Decisions** - Choosing between design approaches
2. **Code Review** - Evaluating complexity and maintainability
3. **System Design** - Building comprehensible systems
4. **Refactoring** - Reducing accidental complexity
5. **Technology Evaluation** - Assessing new tools and frameworks
6. **API Design** - Creating clear interfaces
7. **Process Design** - Streamlining workflows
8. **Decision-Making** - Cutting through complexity

### Signs You Need This Skill

- "This should be simple but feels complicated"
- "Only senior engineers understand this system"
- "We can't change X without breaking Y"
- "The easy solution created more problems"
- "Our abstractions have abstractions"
- "This worked until we scaled"

## Quick Start

### Understanding Simplicity vs Ease

**User**: "What's the difference between simple and easy?"

**Response**:
> **Simple** = structurally uncomplicated (objective)
> **Easy** = close at hand, familiar (subjective)
>
> A new language might be simple (few concepts) but not easy (unfamiliar).
> A familiar framework might be easy (you know it) but not simple (many entangled parts).
>
> Example:
> - React hooks (easy: popular, familiar) vs plain functions (simple: just functions)
> - SQL (simple: declarative) vs ORMs (easy: looks like code, but more complex)
>
> Choose simplicity first, then make it easy through tooling.

### Evaluating a Design

**User**: "How do I know if my design is simple?"

**Response**:
> Ask these questions:
>
> 1. **Can I explain it without hand-waving?** If you need "just trust me" or "it's magic," it's not simple.
> 2. **How many concepts must I hold in my head?** Simple designs have few orthogonal concepts.
> 3. **Can I change one part without touching others?** Entanglement is the enemy of simplicity.
> 4. **Is the data visible or hidden?** Simple systems make data inspectable.
> 5. **Are there implicit dependencies?** Hidden requirements create accidental complexity.
>
> See [EVALUATION.md](spec/EVALUATION.md) for detailed assessment techniques.

### Simplifying an Existing System

**User**: "Our system is too complex. Where do I start?"

**Response**:
> 1. **Map the essential complexity**: What problems MUST we solve?
> 2. **Identify accidental complexity**: What did we add that isn't essential?
> 3. **Look for entanglement**: Where are concerns mixed together?
> 4. **Find the seams**: Where can we separate responsibilities?
> 5. **Start small**: Pick one entangled area and decompose it
>
> Remember Gall's Law: You can't redesign into simplicity. Start with a simple core and grow.
>
> See [REDUCTION.md](spec/REDUCTION.md) for systematic approaches.

## Skill Structure

```
simplicity/
├── SKILL.md              # This file - skill overview
├── README.md             # Installation and quick reference
├── spec/
│   ├── CORE.md          # Core principles and philosophy
│   ├── EVALUATION.md    # How to measure simplicity
│   ├── REDUCTION.md     # Strategies for simplification
│   ├── PATTERNS.md      # Design patterns for simplicity
│   ├── ANTIPATTERNS.md  # Common traps and mistakes
│   └── REFERENCES.md    # Navigation guide
├── frameworks/
│   ├── simple-made-easy.md      # Rich Hickey's framework
│   ├── dieter-rams.md           # 10 Principles of Good Design
│   ├── laws-of-simplicity.md    # John Maeda's Laws
│   ├── galls-law.md             # Complex from simple
│   ├── kiss-principle.md        # Keep It Simple
│   └── unix-philosophy.md       # Do one thing well
└── examples/
    ├── architecture/
    ├── code/
    └── process/
```

## Priority Hierarchy

1. **Clarity** (absolute top priority)
   - Make the implicit explicit
   - Separate concerns cleanly
   - Use precise language
   - Make data visible

2. **Comprehensibility**
   - Minimize concepts
   - Reduce entanglement
   - Enable reasoning
   - Support inspection

3. **Maintainability**
   - Orthogonal changes
   - Clear dependencies
   - Predictable behavior
   - Composable parts

4. **Performance**
   - Simple often performs better
   - Fewer layers, less overhead
   - Easier to optimize
   - Clearer bottlenecks

## Key Principles

### From Rich Hickey (Simple Made Easy)

- Simple is objective; easy is relative to our experience
- Simplicity is a prerequisite for reliability
- Focus on simplicity, not familiarity
- Choose boring technology

### From Dieter Rams (Less, but Better)

- Good design is as little design as possible
- Less, but better
- Focus on the essential
- Back to purity, back to simplicity

### From John Maeda (Laws of Simplicity)

- Simplicity is about subtracting the obvious and adding the meaningful
- The simplest way to achieve simplicity is through thoughtful reduction
- Organization makes a system of many appear fewer
- Knowledge makes everything simpler

### From Gall's Law

- Complex systems that work evolved from simple systems that worked
- Complex systems designed from scratch never work
- Start simple, grow complexity only when needed
- You can't jump to complex and make it work

### From Kelly Johnson (KISS)

- Keep it simple, stupid
- Design for the average mechanic in combat conditions
- Sophistication should match the repair context
- Complexity is a liability

### From Doug McIlroy (Unix Philosophy)

- Do one thing and do it well
- Write programs that work together
- Expect the output of every program to become input to another
- Design for composition

### From Antoine de Saint-Exupéry

- Perfection is achieved not when there is nothing more to add
- But when there is nothing left to take away
- Strip down to nakedness
- Essence over decoration

## Meta-Circular Design

This skill itself demonstrates simplicity principles:

- **Structure**: Minimal, focused documentation files
- **Organization**: Clear separation of concerns (principles, frameworks, examples)
- **Content**: Each file does one thing well
- **Composition**: Files reference each other without duplication

When asked "how does simplicity work?", this skill's own structure serves as an example.

## Integration with Other Skills

This skill enhances other domain skills by providing:

- **Decision frameworks** for choosing approaches
- **Evaluation criteria** for assessing designs
- **Reduction techniques** for fighting complexity
- **Design patterns** for simple solutions

Use with:
- **First Principles Thinking** - Start from fundamentals
- **Architecture Skills** - Design simple systems
- **Code Review Skills** - Evaluate complexity
- **Refactoring Skills** - Reduce accidental complexity

## Documentation References

- [CORE.md](spec/CORE.md) - Core principles and philosophy of simplicity
- [EVALUATION.md](spec/EVALUATION.md) - How to measure and assess simplicity
- [REDUCTION.md](spec/REDUCTION.md) - Strategies for achieving simplicity
- [PATTERNS.md](spec/PATTERNS.md) - Design patterns that promote simplicity
- [ANTIPATTERNS.md](spec/ANTIPATTERNS.md) - Common traps and how to avoid them
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation guide

## Version History

- **v1.0.0** (2025-12-13): Initial implementation
  - Core simplicity principles and philosophy
  - Six foundational frameworks (Rich Hickey, Dieter Rams, John Maeda, Gall's Law, KISS, Unix)
  - Evaluation and reduction techniques
  - Design patterns and anti-patterns
  - Real-world examples
  - Extracted and enhanced from first-principles skill
