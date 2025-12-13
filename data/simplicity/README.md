# Simplicity Skill

**Principles and practices for elegant design through thoughtful reduction**

## Quick Start

This skill helps you understand and apply simplicity in software design, architecture, engineering, and decision-making. It distinguishes genuine simplicity from superficial ease and provides frameworks for reducing complexity.

## Installation

This skill is included in the skill repository. No additional dependencies required.

## What This Skill Provides

### Core Understanding

- **Simplicity vs Ease**: Learn to distinguish objective simplicity from subjective convenience
- **Essential vs Accidental Complexity**: Identify what's necessary vs what you added
- **Evaluation Frameworks**: Systematic methods for measuring simplicity
- **Reduction Techniques**: Practical approaches for achieving simplicity

### Foundational Frameworks

This skill integrates insights from six foundational approaches to simplicity:

1. **Simple Made Easy** (Rich Hickey) - Distinguishing objective simplicity from subjective ease
2. **Less, but Better** (Dieter Rams) - 10 principles of good design focused on essentials
3. **Laws of Simplicity** (John Maeda) - 10 laws for balancing simplicity and complexity
4. **Gall's Law** - Building complex systems from simple foundations
5. **KISS Principle** (Kelly Johnson) - Keep It Simple, Stupid
6. **Unix Philosophy** (Doug McIlroy) - Do one thing and do it well

## When to Use This Skill

Use this skill when you're:

- **Making architecture decisions**: Choosing between design approaches
- **Reviewing code**: Evaluating complexity and maintainability
- **Designing systems**: Building comprehensible, maintainable systems
- **Refactoring**: Reducing accidental complexity
- **Evaluating technology**: Assessing new tools and frameworks
- **Designing APIs**: Creating clear, usable interfaces
- **Streamlining processes**: Simplifying workflows
- **Making decisions**: Cutting through unnecessary complexity

## Quick Examples

### Understanding the Difference

```
Simple vs Easy:

Simple (objective):
- Few intertwined concepts
- Orthogonal components
- Explicit dependencies
- Inspectable data

Easy (subjective):
- Familiar to you
- Tools exist
- Quick to start
- Matches current skills
```

### Evaluation Questions

When assessing a design:

1. Can I explain this without hand-waving?
2. How many concepts must I hold in my head?
3. Can I change one part without touching others?
4. Is the data visible or hidden behind behavior?
5. Are there implicit dependencies?
6. Could an average practitioner understand this?

### The Path to Simplicity

```
1. Map essential complexity (what MUST we solve?)
2. Identify accidental complexity (what did we add?)
3. Look for entanglement (where are concerns mixed?)
4. Find the seams (where can we separate?)
5. Start small (pick one area, simplify it)
6. Repeat
```

## Architecture

```
simplicity/
├── SKILL.md              # Skill definition and overview
├── README.md             # This file - quick start guide
├── spec/
│   ├── CORE.md          # Core principles and philosophy
│   ├── EVALUATION.md    # How to measure simplicity
│   ├── REDUCTION.md     # Strategies for simplification
│   ├── PATTERNS.md      # Design patterns for simplicity
│   ├── ANTIPATTERNS.md  # Common traps and mistakes
│   └── REFERENCES.md    # Navigation guide
├── frameworks/          # Individual framework deep-dives
│   ├── simple-made-easy.md      # Rich Hickey's framework
│   ├── dieter-rams.md           # 10 Principles of Good Design
│   ├── laws-of-simplicity.md    # John Maeda's Laws
│   ├── galls-law.md             # Complex from simple
│   ├── kiss-principle.md        # Keep It Simple
│   └── unix-philosophy.md       # Do one thing well
└── examples/            # Real-world applications
    ├── architecture/
    ├── code/
    └── process/
```

## Key Principles at a Glance

### From Rich Hickey (Simple Made Easy)

- Simplicity is objective (structural); ease is subjective (familiarity)
- Choose simple first, then make it easy
- Complexity compounds; simplicity enables reasoning

### From Dieter Rams (Less, but Better)

- Good design is as little design as possible
- Subtract the non-essential
- Focus returns you to purity and simplicity

### From John Maeda (Laws of Simplicity)

- Simplicity is subtracting the obvious and adding the meaningful
- Thoughtful reduction is the simplest path to simplicity
- Organization makes many appear as few

### From Gall's Law

- Complex systems that work evolved from simple systems that worked
- You cannot design complexity from scratch successfully
- Start simple, prove it works, then grow

### From Kelly Johnson (KISS)

- Simple systems work better under stress
- Design for the repair context, not just the creation context
- Sophistication should match available capabilities

### From Doug McIlroy (Unix Philosophy)

- Do one thing and do it well
- Programs should work together
- Use universal interfaces (text streams)
- Compose simple tools into powerful systems

### From Antoine de Saint-Exupéry

- Perfection is achieved not when there is nothing more to add
- But when there is nothing left to take away

## Priority Hierarchy

1. **Clarity** - Make the implicit explicit, use precise language
2. **Comprehensibility** - Minimize concepts, reduce entanglement
3. **Maintainability** - Enable orthogonal changes, clear dependencies
4. **Performance** - Simple often performs better (fewer layers, clearer bottlenecks)

## Common Questions

### "Isn't simple just less powerful?"

No. Unix command-line tools are extremely powerful through composition of simple parts. Simple ≠ simplistic.

### "But the simple approach is harder to implement!"

Initially, yes. That's the difference between simple and easy. Simple requires more thought but pays off in comprehensibility, maintainability, and reliability.

### "Our domain is complex, so our system must be complex"

Essential complexity (from the domain) is unavoidable. Accidental complexity (from our design) should be minimized. This skill helps distinguish the two.

### "When should I choose easy over simple?"

When the ease provides genuine value without hiding complexity debt. Example: Using a well-tested library (easy) is fine if the library itself is simple. Using a complex framework because it's familiar is choosing ease at simplicity's expense.

## Getting Started

### For Beginners

1. Read [SKILL.md](SKILL.md) for an overview
2. Study [simple-made-easy.md](frameworks/simple-made-easy.md) to understand the core distinction
3. Review [EVALUATION.md](spec/EVALUATION.md) for assessment techniques
4. Apply to a small project or component

### For Practitioners

1. Read the framework that resonates with your domain:
   - Software: [simple-made-easy.md](frameworks/simple-made-easy.md), [unix-philosophy.md](frameworks/unix-philosophy.md)
   - Product/Design: [dieter-rams.md](frameworks/dieter-rams.md), [laws-of-simplicity.md](frameworks/laws-of-simplicity.md)
   - Architecture: [galls-law.md](frameworks/galls-law.md), [kiss-principle.md](frameworks/kiss-principle.md)
2. Review [PATTERNS.md](spec/PATTERNS.md) and [ANTIPATTERNS.md](spec/ANTIPATTERNS.md)
3. Apply to current work

### For Teams

1. Share [SKILL.md](SKILL.md) and [CORE.md](spec/CORE.md) for common language
2. Use evaluation frameworks in code review and design discussions
3. Reference specific frameworks when debating approaches
4. Make simplicity a stated priority

## Integration with Other Skills

This skill enhances:

- **First Principles Thinking**: Start from fundamentals, avoid cargo-culting
- **Architecture Skills**: Design simple systems from the ground up
- **Code Review**: Evaluate complexity objectively
- **Refactoring**: Identify and remove accidental complexity
- **Decision-Making**: Choose approaches based on simplicity, not familiarity

## Version History

- **v1.0.0** (2025-12-13): Initial release
  - Six foundational frameworks
  - Comprehensive evaluation and reduction techniques
  - Real-world examples and anti-patterns
  - Extracted and enhanced from first-principles skill

## References

For detailed navigation of all documentation, see [spec/REFERENCES.md](spec/REFERENCES.md).

For the complete skill definition, see [SKILL.md](SKILL.md).

## Contributing

This skill is designed to be extended with:

- Additional frameworks and perspectives
- Domain-specific examples
- New evaluation techniques
- Case studies from real projects

## License

Part of the Claude Code Skills repository.
