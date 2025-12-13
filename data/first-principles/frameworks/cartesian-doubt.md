# Cartesian Method of Doubt

## What It Is

The Cartesian Method of Doubt, also known as methodological skepticism, is a systematic approach to knowledge and problem-solving developed by René Descartes in the 17th century. The method involves deliberately doubting everything that can possibly be doubted to discover what remains - the indubitable foundations upon which certain knowledge can be built.

This is perhaps the most rigorous approach to reaching first principles: by doubting everything except what is absolutely certain, you strip away all assumptions, conventions, and inherited wisdom to reach bedrock truth.

## Historical Context

### René Descartes (1596-1650)

French philosopher and mathematician who sought to establish a foundation for knowledge that was as certain as mathematical proof.

**His Challenge**: In an era of competing philosophies and religious doctrines, how could one establish certain knowledge?

**His Solution**: Doubt everything that can be doubted until you find something that cannot be doubted.

**His Famous Conclusion**: "Cogito, ergo sum" (I think, therefore I am) - the one thing he couldn't doubt was his own existence as a thinking being.

## Core Principle

### Systematic Doubt

**Not skepticism for its own sake**, but doubt as a method to find certainty.

The process:
1. Accept nothing as true unless it is self-evidently certain
2. Systematically doubt everything that can be doubted
3. What remains after all possible doubt is bedrock truth
4. Build knowledge only on these indubitable foundations

### Levels of Doubt

Descartes identified increasing levels of doubt:

**Level 1: Sensory Doubt**
- Our senses sometimes deceive us
- If they can deceive us sometimes, perhaps they always do
- Conclusion: Sensory experience is not certain

**Level 2: Dream Doubt**
- We cannot always distinguish dreams from reality
- What if all experience is dream-like?
- Conclusion: Even seemingly real experiences may not be certain

**Level 3: Evil Demon Doubt**
- What if a powerful deceiver manipulates all our thoughts?
- Even mathematical truths might be false
- Conclusion: Nearly everything can be doubted

**What Remains**:
- The fact that I am doubting proves I exist as a thinking thing
- This is the indubitable foundation

## Application to Modern Problem-Solving

### The Cartesian Approach to Technical Decisions

Apply systematic doubt to technical assumptions:

1. **Identify beliefs** about the problem or solution
2. **Doubt each belief** systematically
3. **Test if belief withstands doubt** with evidence
4. **Reject or downgrade** beliefs that don't withstand scrutiny
5. **Build solutions** only on what remains certain

## Step-by-Step Process

### Step 1: State the Problem or Decision

Be explicit about what you're examining.

**Example**: "We need to use a relational database for our application."

### Step 2: List All Assumptions and Beliefs

Write down everything you're assuming to be true.

**Example Assumptions**:
- We need a database
- Relational model fits our data
- SQL is the right query language
- ACID properties are required
- Data relationships are stable
- Schemas should be defined upfront

### Step 3: Apply Systematic Doubt

For each assumption, ask: "Can I doubt this?"

#### Questions to Apply:
- Is this necessarily true, or just commonly believed?
- Could this be false in our specific case?
- What evidence actually supports this?
- Am I assuming this because "everyone does it"?
- Would someone with no prior knowledge accept this?

### Step 4: Categorize Assumptions

Place each assumption into categories:

**Category A: Indubitable**
- Cannot be reasonably doubted
- Supported by direct evidence
- Logically necessary

**Category B: Probable**
- Likely true but not certain
- Supported by some evidence
- Common but not universal

**Category C: Doubtful**
- Questionable in our context
- Assumed without evidence
- May be false

### Step 5: Identify What Remains

After maximum doubt, what do you still accept as true?

These are your first principles.

### Step 6: Rebuild from Foundations

Construct your solution using only:
- What survived doubt (indubitable)
- What you can prove from foundations
- What you consciously choose to assume (with awareness of risk)

## Detailed Examples

### Example 1: Database Selection

**Initial Position**: "We need PostgreSQL for our application."

**Systematic Doubt**:

**Question**: Do we need a database?
- **Doubt**: Could we use flat files? In-memory storage?
- **Result**: For persistence and queries, yes, we need a database
- **Status**: Survives doubt

**Question**: Must it be relational?
- **Doubt**: What about document, key-value, or graph databases?
- **Result**: We assumed relational because we have "relations" in data
- **Deeper Question**: Are these relations inherent or could we model differently?
- **Status**: Doubtful assumption

**Question**: Do we need ACID properties?
- **Doubt**: What actually breaks if we have eventual consistency?
- **Result**: We can't name a specific critical failure
- **Status**: Assumed, not proven

**Question**: Must schema be defined upfront?
- **Doubt**: What if requirements change frequently?
- **Result**: Schema-first assumed because it's "best practice"
- **Status**: Convention, not necessity

**What Remains** (Indubitable):
- We need to persist data
- We need to query data efficiently
- We have data access patterns (reads, writes, relationships)

**Rebuilding from First Principles**:
- Start with actual data access patterns
- Choose storage that matches proven needs
- Don't add features "just in case"
- Result: Maybe PostgreSQL, maybe not - decision based on requirements, not assumptions

### Example 2: Microservices Architecture

**Initial Position**: "We should break our monolith into microservices."

**Systematic Doubt**:

**Question**: Do we need multiple services?
- **Doubt**: What problem would separate services solve?
- **Evidence**: "Better scalability" - but do we have scaling problems?
- **Status**: Assumed benefit without proven need

**Question**: Will microservices solve our actual problems?
- **Doubt**: What are our actual problems?
- **Evidence**: "Code is hard to change" - would service boundaries help?
- **Status**: Hypothesis, not fact

**Question**: Are our teams organized for microservices?
- **Doubt**: Do we have the DevOps maturity?
- **Evidence**: No CI/CD, manual deployments
- **Status**: Prerequisites missing

**Question**: Is distributed complexity worth it?
- **Doubt**: Are we prepared for distributed debugging, eventual consistency?
- **Evidence**: Team struggled with simple deployment automation
- **Status**: Likely to create more problems

**What Remains**:
- Code is difficult to change (proven by experience)
- We want to improve development speed (stated goal)
- We have limited DevOps maturity (observed fact)

**Rebuilding from First Principles**:
- Primary need: Improve code changeability
- Constraint: Limited DevOps capability
- Solution space: Could be better modularization, clearer boundaries, better tests
- Microservices: One option, not the only option, and high-risk given constraints
- Better approach: Improve modularity first, split services later if needed

### Example 3: Technology Stack Selection

**Initial Position**: "We should build this with React, Node.js, and MongoDB (MERN stack)."

**Systematic Doubt**:

**Question**: Why React?
- **Assumed**: "It's popular and has a large ecosystem"
- **Doubt**: Do we need React's complexity for our use case?
- **Question**: What problems does React solve?
- **Answer**: Complex UI state management
- **Doubt**: Do we have complex UI state?
- **Evidence**: Mostly form-based CRUD operations
- **Status**: Choosing React for popularity, not need

**Question**: Why Node.js?
- **Assumed**: "JavaScript everywhere is efficient"
- **Doubt**: Is JavaScript the best language for our backend needs?
- **Question**: What are our backend requirements?
- **Answer**: API serving, database access, business logic
- **Doubt**: Does Node.js excel at our requirements?
- **Status**: Chosen for developer convenience, not technical fit

**Question**: Why MongoDB?
- **Assumed**: "NoSQL is modern and flexible"
- **Doubt**: Do we need schema flexibility?
- **Evidence**: Domain model is stable, relationships are clear
- **Status**: Following trend, not solving problem

**What Remains**:
- Need to build web interface (proven)
- Need backend API (proven)
- Need to store relational data (proven)
- Team knows JavaScript (proven)

**Rebuilding from First Principles**:
- UI needs: Simple forms and tables → Could be simple HTML + Alpine.js
- Backend needs: API + business logic → Many languages suitable
- Data needs: Relational → SQL database appropriate
- Team skill: JavaScript → Consider, but not sole factor
- Result: Maybe simpler stack, maybe MERN, but decision is deliberate, not default

### Example 4: Testing Strategy

**Initial Position**: "We need 100% code coverage with unit tests."

**Systematic Doubt**:

**Question**: Is 100% coverage valuable?
- **Doubt**: Does coverage percentage equal quality?
- **Evidence**: Can have 100% coverage with meaningless tests
- **Status**: Metric doesn't guarantee value

**Question**: Are unit tests sufficient?
- **Doubt**: Do unit tests catch integration issues?
- **Evidence**: Production bugs often occur at integration points
- **Status**: Unit tests alone insufficient

**Question**: Should we test everything equally?
- **Doubt**: Is testing a simple getter as valuable as testing business logic?
- **Evidence**: ROI varies dramatically by code area
- **Status**: Equal testing is inefficient

**What Remains**:
- Code breaks in production (proven problem)
- Tests can catch bugs (proven value)
- Team time is limited (proven constraint)

**Rebuilding from First Principles**:
- Goal: Prevent production bugs
- Constraint: Limited time
- Strategy: Test what breaks most often or costs most
- Result: Risk-based testing, not coverage-based testing

## Modern Applications

### Software Engineering

**Apply Cartesian Doubt to**:
- Architectural patterns
- Technology choices
- Best practices
- Development methodologies
- Tool selection

### Product Development

**Apply Cartesian Doubt to**:
- User needs assumptions
- Feature requirements
- Market assumptions
- Competitive responses

### Business Strategy

**Apply Cartesian Doubt to**:
- Market size estimates
- Growth assumptions
- Competitive advantages
- Revenue models

## Connection to First Principles

Cartesian doubt is the most rigorous path to first principles:

1. **Maximum Skepticism**: Doubt everything that can be doubted
2. **Indubitable Foundations**: Keep only what survives maximum doubt
3. **Rebuild Deliberately**: Construct solutions from certainty
4. **Avoid Assumptions**: Recognize assumptions as assumptions, not facts
5. **Test Constantly**: Continue applying doubt to new beliefs

**The Process**:
```
Conventional Wisdom
↓ (Apply systematic doubt)
Remove assumptions
↓ (Continue doubting)
Remove conventions
↓ (Maximum skepticism)
Indubitable truths = First Principles
↓ (Rebuild)
New Solutions Built on Solid Foundations
```

## Common Pitfalls

### 1. Excessive Skepticism

Doubting things that are practically certain leads to paralysis.

**Balance**: Doubt to find foundations, then build on them confidently.

### 2. Nihilism

Concluding "nothing can be known" misses the point.

**Goal**: Find what IS certain through doubt, not prove nothing is certain.

### 3. Ignoring Practical Constraints

Pure philosophy might doubt everything; real projects have deadlines.

**Balance**: Apply Cartesian doubt to key decisions, not every detail.

### 4. Doubting Without Rebuilding

Tearing down without constructing leaves you with nothing.

**Process**: Doubt → Foundation → Rebuild

## Practice Exercises

### Exercise 1: Technology Audit

Pick a technology your team uses.
Apply systematic doubt:
- Why do we use this?
- What problem does it solve?
- Could we solve it differently?
- What would we choose with no prior commitment?

### Exercise 2: Best Practice Challenge

Identify a "best practice" your team follows.
Doubt it systematically:
- Why is it considered best?
- Best for whom, in what context?
- Does it apply to our situation?
- What evidence supports it in our case?

### Exercise 3: Requirements Deconstruction

Take a feature request.
Doubt every aspect:
- Why does the user want this?
- Is the stated need the real need?
- What problem underlies the request?
- Could we solve it differently?

### Exercise 4: Personal Belief Audit

Choose a technical belief you hold strongly.
Apply maximum doubt:
- Why do I believe this?
- What if the opposite were true?
- What evidence do I really have?
- Am I believing because of authority or evidence?

## Tips for Effective Use

1. **Schedule Doubt Sessions**: Set aside time specifically for challenging assumptions
2. **Write It Down**: Document assumptions and doubts explicitly
3. **Separate Doubt from Decision**: First doubt, then rebuild - don't mix
4. **Embrace Discomfort**: Real doubt feels unsettling - that's good
5. **Don't Doubt Forever**: Find foundations, then build on them
6. **Apply to Big Decisions**: Use for significant choices, not trivia
7. **Invite Others**: Group doubt sessions reveal more assumptions

## Integration with Other Methods

**Combine with Socratic Method**: Use Socratic questions to facilitate systematic doubt

**Combine with Five Whys**: Each "why" can be a point to apply doubt

**Combine with Feynman Technique**: Doubt your own explanations to ensure understanding

## Final Insight

Descartes' goal was philosophical certainty. Yours is practical clarity.

Apply Cartesian doubt not to prove nothing can be known, but to distinguish:
- What you know for certain (evidence, logic)
- What you assume (aware risk)
- What you're told (conventional wisdom)

Build solutions on the first, be cautious with the second, challenge the third.

This is the path to first principles thinking: doubt until you reach bedrock, then build something solid.
