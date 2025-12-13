# Integration - First Principles Thinking with Domain Skills

## Overview

First principles thinking is a meta-cognitive skill that enhances any domain-specific skill. This document provides patterns for integrating FPT with specialized domains including software engineering, business strategy, product development, system architecture, and other skills in the Claude ecosystem.

## Core Integration Principle

First principles thinking provides **systematic reasoning** that complements **domain expertise**:

```txt
Domain Expertise: What's possible and how things work
     +
First Principles: Why things work and what's fundamentally necessary
     =
Breakthrough Solutions: Novel applications of domain knowledge
```

## Integration Patterns

### Pattern 1: Pre-Analysis Integration

**Use FPT before applying domain expertise.**

**When**: Starting new projects, making architectural decisions, defining strategy

**How**:

1. Use FPT to identify fundamental requirements
2. Question domain assumptions and conventions
3. Apply domain expertise to validated fundamentals
4. Build solutions from both FPT insights and domain knowledge

**Example** (Software Architecture):

```txt
Traditional: "We need microservices because we're building a scalable system"
Integrated:
1. FPT: What are fundamental scalability requirements?
2. FPT: Why do we believe microservices solve this?
3. Domain: What are actual bottlenecks? What patterns address them?
4. Solution: Architecture based on actual needs, not assumed pattern
```

### Pattern 2: Challenge Integration

**Use FPT to challenge domain conventions.**

**When**: Domain "best practices" seem wrong, inherited complexity exists

**How**:

1. Apply domain expertise to understand conventional approach
2. Use FPT to question why conventions exist
3. Identify which conventions are fundamental vs historical
4. Reconstruct approach from validated needs

**Example** (Database Design):

```txt
Convention: "Always normalize to third normal form"
Integration:
1. Domain: Understand normalization theory and benefits
2. FPT: Why normalize? (Reduce redundancy, ensure consistency)
3. FPT: Are these always the primary concerns?
4. Domain + FPT: Denormalize for read-heavy workloads, normalize for write-heavy
```

### Pattern 3: Problem-Solving Integration

**Use FPT to enhance domain problem-solving.**

**When**: Solving complex problems, debugging, optimization

**How**:

1. Use FPT to deconstruct problem to fundamentals
2. Apply domain expertise to understand components
3. Use FPT to question assumptions in domain knowledge
4. Combine both for comprehensive solution

**Example** (Performance Optimization):

```txt
Problem: "Application is slow"
Integration:
1. FPT: Define "slow" precisely (3s response time, target 500ms)
2. Domain: Profile and measure (database 2s, rendering 800ms)
3. FPT: Why are these slow? Are they fundamentally necessary?
4. Domain: Apply optimization techniques to validated bottlenecks
5. Result: Targeted, effective optimization
```

### Pattern 4: Validation Integration

**Use FPT to validate domain solutions.**

**When**: Reviewing solutions, technical decisions, architecture reviews

**How**:

1. Domain expertise proposes solution
2. FPT validates solution addresses fundamentals
3. FPT identifies unvalidated assumptions
4. Refine solution based on FPT insights

**Example** (Security Review):

```txt
Domain Solution: "Implement OAuth2 for authentication"
FPT Validation:
1. What's the fundamental need? (Secure user authentication)
2. Why OAuth2? (Industry standard, proven security)
3. Does OAuth2 address our specific threats? (Validate threat model)
4. Are we adding unnecessary complexity? (Evaluate alternatives)
5. Refined: OAuth2 for external auth, simpler JWT for internal services
```

## Domain-Specific Integration Guides

### Software Engineering

#### Architecture Decisions

**Integration Approach**:

```txt
FPT Phase                  | Software Architecture Phase
---------------------------|---------------------------
Clarify requirements       | Functional requirements analysis
Deconstruct to fundamentals| Identify core domain concepts
Question patterns          | Challenge architectural assumptions
Reconstruct solution       | Design architecture from principles
```

**Example Flow**:

```txt
1. FPT: What are we fundamentally building? (E-commerce system)
2. FPT: What are core requirements? (Product catalog, orders, payments)
3. Domain: What are technical constraints? (Scale, consistency needs)
4. FPT: Do we need distributed architecture? Why?
5. Domain: What patterns fit validated needs? (Event sourcing for orders, etc.)
6. Solution: Architecture based on actual needs, not assumed complexity
```

**Key Questions**:

- Why this architecture pattern?
- What problems does it solve that simpler approaches don't?
- Are we solving actual problems or anticipated problems?
- What's the simplest architecture that satisfies fundamentals?

#### Performance Optimization

**Integration Approach**:

```txt
FPT: Identify actual bottlenecks (measure, don't assume)
Domain: Understand why bottlenecks exist (profiling, analysis)
FPT: Question if bottleneck is necessary (can we avoid work?)
Domain: Apply optimization techniques (caching, algorithms, etc.)
FPT: Validate optimization addresses fundamental issue
```

**Example**:

```txt
Observation: "API is slow"
1. FPT: Define slow (3s, target 300ms)
2. Domain: Profile (database 2.5s, parsing 400ms, network 100ms)
3. FPT: Why 2.5s database? (12 queries, N+1 problem)
4. FPT: Do we need all 12 queries? (Test: users only use 3 fields)
5. Domain: Eager loading, query optimization, caching strategies
6. Solution: Load critical data (200ms), lazy load rest
```

#### Code Design

**Integration Approach**:

```txt
FPT: What's the core problem this code solves?
Domain: What patterns apply? (Design patterns, SOLID principles)
FPT: Why this pattern? Is complexity justified?
Domain: Implement with appropriate abstractions
FPT: Is this the simplest solution that could work?
```

**Example**:

```txt
Task: "Implement notification system"
1. FPT: What's fundamental need? (Send messages to users)
2. Domain: Observer pattern, message queues, pub-sub
3. FPT: Do we need all this complexity now?
4. FPT: What's current scale? (100 users, 10 notifications/day)
5. Solution: Simple direct notifications now, plan for scale later
```

### Business Strategy

#### Market Entry Decisions

**Integration Approach**:

```txt
FPT: What's the fundamental value proposition?
Domain: Market analysis, competitive landscape
FPT: Question market assumptions (is this real demand?)
Domain: Entry strategies, go-to-market plans
FPT: Validate assumptions with evidence
```

**Example**:

```txt
Decision: "Should we enter market X?"
1. FPT: Why do we want to enter? (Growth, diversification)
2. FPT: What customer problem are we solving?
3. Domain: Market size, competition, barriers to entry
4. FPT: How do we know customers want this? (Test, don't assume)
5. Domain + FPT: Enter with MVP, validate fundamentals, iterate
```

#### Pricing Strategy

**Integration Approach**:

```txt
FPT: What does product actually cost? (First principles costing)
FPT: What value does it provide? (Fundamental value proposition)
Domain: Pricing models, competitive pricing, market research
FPT: Why price like this? Question industry norms
Domain: Pricing psychology, segmentation strategies
```

**Example**:

```txt
Challenge: "How should we price our SaaS product?"
1. FPT: What does it cost to serve one customer? ($5/month)
2. FPT: What value does customer get? (Saves 10 hours/month = $500)
3. Domain: Market rates ($50-200/month for similar tools)
4. FPT: What's our differentiation? (Better UX, faster results)
5. Domain: Value-based pricing with tiered plans
6. Solution: $99/month (reflects value, not just market rate)
```

#### Organizational Design

**Integration Approach**:

```txt
FPT: What's fundamental purpose of organization? (Create customer value)
FPT: What structure is necessary vs inherited?
Domain: Organizational patterns, team topologies
FPT: Question "we've always done it this way"
Domain: Change management, cultural considerations
```

**Example**:

```txt
Challenge: "How should we structure our engineering org?"
1. FPT: What's the fundamental goal? (Ship value to customers)
2. FPT: What enables shipping value? (Autonomy, alignment, speed)
3. Domain: Team topologies (stream-aligned, platform, etc.)
4. FPT: Why matrix management? (Historical, or fundamentally needed?)
5. Solution: Cross-functional teams with clear ownership
```

### Product Development

#### Feature Decisions

**Integration Approach**:

```txt
FPT: What problem does this feature solve?
FPT: How do we know users have this problem?
Domain: Product management frameworks (RICE, value vs effort)
FPT: Question feature requests (why do users want this?)
Domain: UX design, technical feasibility
```

**Example**:

```txt
Request: "Users want dark mode"
1. FPT: Why do users want dark mode?
   - Some users: Eye strain at night
   - Some users: Battery life on mobile
   - Some users: Aesthetic preference
2. FPT: Are these real problems for our users? (Survey: 60% use at night)
3. Domain: Implementation complexity (theming system, CSS variables)
4. FPT: Is dark mode the only solution? (Auto night mode, brightness control)
5. Solution: Implement if validates as high-impact for core user problems
```

#### User Experience Design

**Integration Approach**:

```txt
FPT: What are users fundamentally trying to accomplish?
Domain: UX patterns, usability heuristics
FPT: Question inherited UI conventions
Domain: User research, usability testing
FPT: Validate designs address fundamental user needs
```

**Example**:

```txt
Design: "Multi-step wizard for onboarding"
1. FPT: What's fundamental goal? (Get users to core value fast)
2. FPT: Why multi-step? (Industry standard for complex setup)
3. Domain: Analyze actual complexity (only 3 required fields)
4. FPT: Is wizard necessary or inherited pattern?
5. Solution: Single-screen onboarding with optional advanced setup
```

#### Platform Architecture

**Integration Approach**:

```txt
FPT: What platforms do we actually need to support?
FPT: Why these platforms? (Evidence of demand)
Domain: Platform capabilities and constraints
FPT: Question "mobile-first" or "web-first" dogma
Domain: Cross-platform technologies and trade-offs
```

**Example**:

```txt
Decision: "Should we build native mobile apps?"
1. FPT: What are users trying to do on mobile?
2. FPT: Can responsive web accomplish this?
3. Domain: Native vs web capabilities (camera, push, offline)
4. FPT: How many users actually need native features? (Measure usage)
5. Solution: Responsive web + native for features that truly need it
```

### System Design

#### Distributed Systems

**Integration Approach**:

```txt
FPT: Why do we need distribution? (Scale, reliability, geography)
Domain: Distributed systems patterns (CAP theorem, consensus, etc.)
FPT: Validate need for distribution (measure actual load)
Domain: Technologies and trade-offs
FPT: Question microservices dogma
```

**Example**:

```txt
Design: "Should we use microservices?"
1. FPT: What problems are we solving? (Team independence, scale)
2. FPT: Do we have these problems now? (3 person team, 1000 users)
3. Domain: Complexity of microservices (networking, deployment, monitoring)
4. FPT: Is complexity justified? (Not yet)
5. Solution: Modular monolith now, services later if needed
```

#### Data Architecture

**Integration Approach**:

```txt
FPT: What data do we actually need to store?
FPT: What access patterns exist? (Measure, don't assume)
Domain: Database technologies and patterns
FPT: Question "one database to rule them all"
Domain: Polyglot persistence patterns
```

**Example**:

```txt
Design: "What database should we use?"
1. FPT: What are actual data characteristics? (Mostly reads, simple queries)
2. FPT: What consistency requirements? (Eventual okay for 80% of data)
3. Domain: SQL vs NoSQL trade-offs
4. FPT: Do we need complex transactions? (Measure: 5% of operations)
5. Solution: NoSQL for bulk data, SQL for transactional subset
```

#### Security Architecture

**Integration Approach**:

```txt
FPT: What are we protecting? (Assets)
FPT: What are actual threats? (Threat modeling from fundamentals)
Domain: Security patterns and best practices
FPT: Question "defense in depth" assumptions (what's truly necessary?)
Domain: Implementation of security controls
```

**Example**:

```txt
Design: "What authentication should we implement?"
1. FPT: What assets need protection? (User data, financial transactions)
2. FPT: What are attack vectors? (Credential theft, session hijacking)
3. Domain: Auth patterns (password + MFA, OAuth, biometric)
4. FPT: What level of security is proportional to risk?
5. Solution: MFA for financial ops, password for basic access
```

## Integration with Other Skills

### Enhancing Technical Skills

**Pattern**: Use FPT to challenge technical assumptions

**Example Skills**:

- **skill-docker**: Question when containers are necessary
- **skill-kubernetes**: Validate need for orchestration complexity
- **skill-database**: Challenge normalization dogma
- **skill-security**: Threat model from first principles

**Integration Flow**:

```txt
1. Technical skill provides domain expertise
2. FPT questions assumptions in domain
3. Technical skill applies patterns to validated needs
4. FPT validates solution addresses fundamentals
```

### Enhancing Problem-Solving Skills

**Pattern**: Use FPT for systematic reasoning

**Example Skills**:

- **skill-debugging**: Deconstruct problems to root causes
- **skill-optimization**: Identify actual vs assumed bottlenecks
- **skill-troubleshooting**: Question diagnostic assumptions

**Integration Flow**:

```txt
1. Problem-solving skill applies domain techniques
2. FPT ensures thorough deconstruction
3. FPT challenges diagnostic assumptions
4. Problem-solving skill implements validated fixes
```

### Enhancing Agent Skills

**Pattern**: Use FPT to improve agent reasoning

**Example Skills**:

- **skill-planning**: Validate plan assumptions
- **skill-research**: Question research assumptions
- **skill-analysis**: Deconstruct analysis to fundamentals

**Integration Flow**:

```txt
1. Agent skill performs task
2. FPT validates reasoning at each step
3. FPT identifies gaps in logic
4. Agent skill refines approach based on FPT insights
```

## Creating Domain-Specific FPT Workflows

### Template for New Domain Integration

```markdown
## Domain: [Your Domain Name]

### Common Assumptions to Challenge
- List domain-specific assumptions
- Identify inherited beliefs
- Note conventions that may not be fundamental

### FPT Integration Points
- Where FPT adds most value in this domain
- Critical decision points
- Areas prone to analogical thinking

### Example Workflow
1. Domain activity
2. FPT intervention
3. Domain activity with FPT insights
4. Validation

### Case Studies
- Real examples from this domain
- Before/after comparisons
- Lessons learned
```

### Example: DevOps Integration

```markdown
## Domain: DevOps

### Common Assumptions to Challenge
- "Need CI/CD pipeline" → Why? What's the fundamental goal?
- "Must use Kubernetes" → Is orchestration complexity justified?
- "Automate everything" → What should be automated vs manual?
- "Infrastructure as Code" → All infrastructure? What's the real benefit?

### FPT Integration Points
1. Tool Selection: Question why specific tools are "necessary"
2. Pipeline Design: Validate each pipeline stage's purpose
3. Deployment Strategy: Challenge deployment convention
4. Monitoring: Identify what actually needs monitoring

### Example Workflow
1. DevOps: Propose CI/CD pipeline with 10 stages
2. FPT: Why each stage? What's fundamentally necessary?
3. FPT: Which stages could be combined or eliminated?
4. DevOps: Redesign pipeline with 5 essential stages
5. Result: Faster pipeline, same safety, less complexity

### Case Study: Deployment Pipeline
Before: 10-stage pipeline, 45-minute deployment
FPT Analysis: Only 4 stages fundamentally necessary
After: 4-stage pipeline, 8-minute deployment, improved reliability
```

## Measuring Integration Effectiveness

### Qualitative Measures

- **Insight Quality**: Are we discovering non-obvious solutions?
- **Assumption Reduction**: Are we eliminating unvalidated beliefs?
- **Solution Novelty**: Are solutions more innovative?
- **Understanding Depth**: Is reasoning more rigorous?

### Quantitative Measures

- **Decision Quality**: Better outcomes from integrated decisions?
- **Time to Solution**: Faster resolution with better understanding?
- **Rework Reduction**: Fewer fixes needed post-implementation?
- **Innovation Rate**: More breakthrough vs incremental solutions?

## Common Integration Pitfalls

### Pitfall 1: Over-Application

**Problem**: Using FPT for every trivial decision

**Solution**: Apply FPT to high-stakes, novel, or complex problems. Use domain expertise for routine decisions.

### Pitfall 2: Domain Ignorance

**Problem**: Using FPT without sufficient domain knowledge

**Solution**: Build domain expertise first, then apply FPT to challenge conventions.

### Pitfall 3: Analysis Paralysis

**Problem**: Endless FPT analysis preventing action

**Solution**: Time-box FPT analysis, move to domain implementation with validated fundamentals.

### Pitfall 4: Dismissing Domain Wisdom

**Problem**: Treating all domain conventions as arbitrary

**Solution**: Understand why conventions exist, then question if they apply to your context.

## Integration Checklist

When integrating FPT with domain skills:

- [ ] Identified domain-specific assumptions to challenge
- [ ] Determined optimal integration points (pre-analysis, problem-solving, validation)
- [ ] Balanced FPT rigor with domain efficiency
- [ ] Validated fundamentals before applying domain patterns
- [ ] Used domain expertise to implement FPT-derived solutions
- [ ] Measured effectiveness of integration
- [ ] Refined integration approach based on results

## See Also

- [GUIDE.md](GUIDE.md) - Understanding when and how to use FPT
- [FACILITATOR.md](FACILITATOR.md) - Interactive FPT sessions
- [METHODOLOGY.md](METHODOLOGY.md) - Core FPT process
- [FRAMEWORKS.md](FRAMEWORKS.md) - Questioning frameworks for integration
- [DECONSTRUCTION.md](DECONSTRUCTION.md) - Breaking down domain problems
- [RECONSTRUCTION.md](RECONSTRUCTION.md) - Building domain solutions
- [EXAMPLES.md](EXAMPLES.md) - Domain-specific case studies
- [REFERENCES.md](REFERENCES.md) - Complete documentation map
