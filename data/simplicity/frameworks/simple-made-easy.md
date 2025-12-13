# Simple Made Easy

## What It Is

Simple Made Easy is Rich Hickey's framework for distinguishing **simple** (unentangled, comprehensible) solutions from merely **easy** (convenient, familiar) ones. Introduced in his Strange Loop 2011 talk "Simple Made Easy," the framework argues that many engineering problems stem from choosing what feels easy over what is objectively simple.

Simple ≠ easy. Easy is relative to the tool you already know, the abstractions you have muscle memory for, and the short-term effort required. Simple is objective: how many moving pieces are intertwined, how many concepts overlap, and how tightly things are coupled.

## Core Philosophy

### The Axes Are Different

- **Simplicity axis**: Measures the essential structure of the thing itself. Simple things are singular, orthogonal, and unentangled.
- **Ease axis**: Measures human proximity—what is close at hand, what libraries exist, what the team already knows.
- A system can be simple but hard (new language, fewer moving parts) or easy but complex (familiar stack, tangled dependencies). Optimizing for ease alone hides complexity debt.

### Simplicity Is Objective

Simple isn't "feels simple" or "I think it's simple." It is observable:

- Does it compose without hidden constraints?
- Can you explain it without switching abstraction levels?
- Are responsibilities separated rather than intertwined?
- Are data and behavior orthogonal?

### Ease Is Subjective

Ease depends on:

- Prior expertise
- Tooling and ecosystem
- Deadlines and organizational incentives

Ease is valuable, but only after simplicity. Trading simplicity for ease creates accidental complexity that compounds.

## Evaluating Simplicity

Use these questions (adapted from the talk) when analyzing a design, architecture, or process:

1. **Is it singular?** Does the construct do one conceptual job or many?
2. **Is it orthogonal?** Can you change one piece without touching others?
3. **Is it composable?** Do pieces plug together without bespoke glue code?
4. **Is the data simple?** Are facts separated from behavior, or trapped behind objects and lifecycles?
5. **Is time explicit?** Are ordering, state transitions, and causality clear rather than implicit?
6. **Is representation clear?** Can the model be inspected and reasoned about directly?

If you answer "no" to several questions, you're likely looking at something easy-but-complex.

## Applying the Framework

### 1. Enumerate the Essential Pieces

Break the domain down to the smallest meaningful units. Describe them as pure data, operations, or invariants. This exposes where concepts are already entangled.

### 2. Score Each Option on Both Axes

Create a two-column table: simple vs easy. For each architecture or approach:

- **Simple**: List tangles, hidden couplings, number of concepts per artifact.
- **Easy**: List availability of tools, libraries, team familiarity, time-to-first-success.

Explicit scoring prevents the team from defaulting to the "easy" column without acknowledging the simplicity cost.

### 3. Prefer Simple First, Then Make It Easy

Sequence decisions:

1. Design the simplest decomposition that satisfies the fundamental requirements.
2. Only after the design is simple do you invest in tooling, automation, ergonomics to make it easy to use.

### 4. Fight Temporal Bias

What is easy today might be a support burden tomorrow. When tempted by the easy path, ask: "Will this still be easy for a new teammate six months from now?" If the answer depends on tribal knowledge, it's not truly easy—it's just familiar.

### 5. Use Hammock-Driven Development

Rich Hickey advocates stepping away (the "hammock") to think deeply about the problem. Before committing to code:

- Write down the problem in plain language.
- Identify the nouns (data) and verbs (operations) separately.
- Play with combinations mentally until the structure feels singular.

This reflective step surfaces simplifications you won't see while fighting tools.

## Examples

### Example 1: Service Boundaries vs Comfort Tools

**Problem**: A team needs a billing API. The easiest path is to add billing endpoints to an existing monolith that already exposes authentication.

- **Easy**: Same repository, familiar framework, reused deployment pipeline. Shipping takes one week.
- **Complexity Cost**: Authentication concerns, billing logic, and customer notifications merge into a single deployable. Any change now requires regression testing unrelated pieces, and the code mixes three separate concepts.
- **Simple Alternative**: Create a small billing service with a plain HTTP interface and its own datastore. It is harder short-term (new repo, new pipeline, extra infrastructure), but billing responsibilities stay singular and the auth service remains pure. Future experiments (e.g., new pricing engine) happen without risking login stability.

Simple here means keeping responsibilities orthogonal even if the toolchain is less convenient.

### Example 2: Data Pipelines vs Object Systems

**Problem**: A data platform ingests events, enriches them, and stores aggregates for dashboards. The team reaches for an OO workflow system because they know it well.

- **Easy**: Each step is a subclass with overridden hooks. IDE support and company standards exist.
- **Complexity Cost**: Data, state transitions, and scheduling policy live together. To understand what runs in production, you must execute code; there is no declarative representation to inspect.
- **Simple Alternative**: Represent the pipeline as immutable data (EDN/YAML/JSON) describing sources, transforms, and sinks. Runtime interprets the data, and functions operate on simple maps. It's initially harder (new interpreter, less IDE support) but the pipeline can be versioned, diffed, and reasoned about as data. Scheduling, retries, and transforms remain orthogonal modules.

The data-first design aligns with Hickey's emphasis on separating facts from behavior, trading short-term ease for lasting composability.

## Antipatterns to Watch For

- **Entanglement as convenience**: "We'll just add this concern to the existing service to ship faster." The short-term ease creates long-term coupling.
- **Premature abstractions**: Wrapping everything in classes/DSLs to match existing tooling rather than reflecting the domain.
- **Hiding data behind behavior**: Making facts inaccessible without executing code makes reasoning hard.
- **Leaky temporal coupling**: Systems where operations must happen in undocumented orders—easy to hack together, hard to comprehend.
- **Tool-driven design**: Choosing solutions because "Kubernetes does it this way" without verifying simplicity relative to your needs.

## Practice Prompts

1. **Codebase inventory**: Pick a subsystem. List its responsibilities. How many are entangled? What would it look like if each responsibility lived alone?
2. **Data liberation**: Take an object-heavy design and rewrite it as pure data plus functions. What got simpler? What got harder?
3. **Operational review**: Diagram a production incident. Highlight where ease choices (copy-pasted scripts, implicit dependencies) added complexity.
4. **New tech evaluation**: Before adopting a tool, answer: "How does this keep things simple? Where does it make things merely easy?"

## Takeaways

- Simplicity is an objective property of the solution; ease is a human perception of effort.
- Prioritize simplicity because it keeps reasoning grounded and composable.
- Make it simple, then make it easy. Reversing the order guarantees accidental complexity.
- Continually re-evaluate "easy" choices—familiarity fades, complexity compounds.

Simple Made Easy is a commitment to unspectacular clarity. It favors boring, orthogonal parts that can be reasoned about independently.

## References

- Rich Hickey, ["Simple Made Easy" (Strange Loop 2011)](https://www.infoq.com/presentations/Simple-Made-Easy/)
- Rich Hickey, ["Hammock Driven Development"](https://www.youtube.com/watch?v=f84n5oFoZBc)
