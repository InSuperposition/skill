# Gall's Law: Building Complex Systems from Simple Foundations

## What It Is

Gall's Law is a fundamental principle of systems design that states:

**"A complex system that works is invariably found to have evolved from a simple system that worked. A complex system designed from scratch never works and cannot be made to work. You have to start over, beginning with a working simple system."**

Formulated by John Gall in his 1975 book "Systemantics: How Systems Work and Especially How They Fail," this law emerged from studying countless system failures and successes. Gall (1925-2014) was a pediatrician and systems theorist who dedicated his research to understanding what causes systems to function and fail.

## Core Philosophy

### You Cannot Jump to Complex

The most critical insight of Gall's Law is that **complexity cannot be designed from scratch**. Complex systems that work didn't start complex—they started simple and evolved.

This directly contradicts the common engineering approach of:

1. Analyzing all requirements
2. Designing the complete, complex system
3. Implementing everything
4. Hoping it works

Gall's Law says this approach **never works**.

### The Path to Working Complexity

The only reliable path is:

1. Build a simple system that works
2. Use it, learn from it
3. Gradually expand and improve it
4. Let complexity emerge from proven simple foundations

### The Inverse Proposition

Gall also noted the inverse is true: **A complex system designed from scratch never works and cannot be made to work.**

You can't patch or fix a complex system that was born complex. You must start over with something simple that works.

## Why This Matters for Simplicity

Gall's Law is fundamentally about simplicity because it establishes:

1. **Simple is not a phase**: It's the required foundation
2. **Complexity is earned**: Only after simplicity proves itself
3. **Working matters more than complete**: A simple working system beats a complex broken one
4. **Incremental beats big-bang**: Evolution beats revolution

## Applying Gall's Law

### The MVP Approach

Modern software development has rediscovered Gall's Law through the MVP (Minimum Viable Product) approach:

- Build the simplest version that provides value
- Release it, learn from real usage
- Iterate based on actual needs, not predicted ones
- Let the product evolve toward complexity

This is Gall's Law in action.

### Agile and Iterative Development

Agile methodologies embody Gall's Law:

- Start with working software (even if simple)
- Deliver in small increments
- Adapt based on feedback
- Grow the system organically

The alternative—big design up front, waterfall development—violates Gall's Law and frequently fails.

### Architecture Evolution

When designing systems:

**Don't**: Architect the perfect, complete system on day one

**Do**:

1. Build the simplest architecture that solves today's problem
2. Ensure it works and provides value
3. Identify what's missing from real usage
4. Add complexity only where proven necessary
5. Refactor as you grow

### Technology Choices

Gall's Law favors boring, proven technology:

- **Simple database** → Add caching when needed, not before
- **Monolith** → Extract microservices when monolith proves limiting
- **File storage** → Add object storage when files prove inadequate
- **Synchronous** → Add queues when sync breaks down

Don't start with the complex solution "because we'll need it eventually." Start simple and evolve.

## Examples

### Example 1: The World Wide Web

**Simple beginnings (1989-1991)**:

- Simple HTML documents
- Simple HTTP protocol
- Simple links between pages
- No JavaScript, no CSS, no complex features

**Complex reality (today)**:

- Rich web applications
- Real-time communication
- Multimedia streaming
- Complex frameworks and tooling

**Key**: The web didn't start with a grand design for all this complexity. It started simple (hyperlinked documents) and evolved as needs became clear.

### Example 2: CORBA vs REST

**CORBA** (Complex Object Request Broker Architecture):

- Designed as a complete, comprehensive distributed object system
- Addressed every possible scenario up front
- Massive specification
- **Result**: Failed, too complex to implement or use effectively

**REST**:

- Started simple: HTTP + resources + standard methods
- Worked immediately for basic cases
- Evolved organically with extensions (HATEOAS, etc.)
- **Result**: Dominates web API design

CORBA violated Gall's Law (complex from scratch). REST followed it (simple, then evolved).

### Example 3: Microservices Evolution

**Wrong (violates Gall's Law)**:

- Day one: Design 47 microservices
- Create inter-service communication framework
- Implement service mesh, API gateway, etc.
- **Result**: Never quite works, too complex to debug

**Right (follows Gall's Law)**:

- Day one: Build a working monolith
- Identify pain points from real usage
- Extract specific services where bottlenecks/boundaries are clear
- **Result**: Microservices where they provide value, monolith where it works fine

### Example 4: Database Schema Design

**Wrong**:

- Design the complete schema for all future features
- Add 50 tables for requirements that don't exist yet
- Create complex relationships for hypothetical needs
- **Result**: Schema doesn't match actual usage, painful migrations

**Right**:

- Design schema for current, real features
- Start simple, with only proven entities
- Add tables and relationships as new features prove necessary
- **Result**: Schema matches reality, evolves naturally

## Implications for Design

### Start Small, Prove Value

Before building anything complex:

1. What's the simplest version that provides value?
2. Build and deploy that
3. Verify it actually works and is used
4. Only then consider expanding

### Incremental Complexity

When adding complexity:

- Add **one** new complex element at a time
- Verify the system still works after each addition
- Each step should be "simple system + one new thing"
- Never jump from simple to super-complex

### Resist Big-Bang Rewrites

The "rewrite everything from scratch" urge often violates Gall's Law:

- The old system, however messy, **works** (it evolved from simple)
- The new system is complex from day one
- Gall's Law predicts the rewrite will fail

Better approach: Incremental replacement (Strangler Fig pattern)

### Embrace Evolution

Accept that you **cannot** design the final system up front:

- The final system is unknowable from the start
- It will emerge from usage and learning
- Trying to design it all up front creates complexity that doesn't work
- Evolution from simple is the only reliable path

## The Gall's Law Test

Before starting a project, ask:

1. **What's the simplest version that works?** If you can't identify this, you're not ready to build.
2. **Can this simple version provide value?** If not, simplify further.
3. **Am I designing for future complexity?** If yes, stop. Build simple first.
4. **Can I deploy this in weeks, not months?** If no, you're too complex too soon.

When evaluating a design:

1. **Did you start with a working simple system?** If no, danger.
2. **Did each addition preserve "working" status?** Broken + complex = dead end.
3. **Can you trace evolution from simple to current state?** If the current complexity appeared all at once, it likely doesn't work.

## Common Misunderstandings

### "Simple" doesn't mean "toy"

Gall's Law requires a **working** simple system. It must provide real value, just in a basic form.

### "Simple first" doesn't mean "never complex"

Gall's Law isn't anti-complexity. It's anti-"complex from scratch." Complexity is fine—essential, even—but only when it **evolves** from working simplicity.

### You can't skip the simple phase

Teams often think "we know we'll need X eventually, so let's build it now." Gall's Law says: no. Build simple, prove it, then add X when the need is real and proven.

## Complementary Principles

Gall's Law works well with:

- **YAGNI** (You Aren't Gonna Need It): Don't add complexity for hypothetical future needs
- **Agile/MVP**: Build in small increments, evolve from simple
- **Rich Hickey's Simple Made Easy**: Favor simple over easy
- **Unix Philosophy**: Do one thing well (keep it simple)

## Takeaways

- **Complex systems that work evolved from simple systems that worked**
- **You cannot design complexity from scratch successfully**
- **Start simple, prove it works, then evolve**
- **Each step should maintain "working" status**
- **Resist the urge to build the final vision immediately**
- **Complexity is earned through proven simplicity**

Gall's Law is both a warning and a roadmap. It warns against the hubris of comprehensive up-front design, and it provides a path: start simple, make it work, then grow.

## References

- [Gall's Law - The Personal MBA](https://personalmba.com/galls-law/)
- [Gall's Law - TechMagic](https://www.techmagic.co/blog/galls-law)
- [What Is Gall's Law, and How Could It Direct API Design? - Nordic APIs](https://nordicapis.com/what-is-galls-law-and-how-could-it-direct-api-design/)
- [Gall's Law - Laws of Software](https://www.laws-of-software.com/laws/gall/)
- [John Gall (author) - Wikipedia](https://en.wikipedia.org/wiki/John_Gall_(author))
