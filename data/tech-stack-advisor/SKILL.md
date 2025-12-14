---
name: skill-tech-stack-advisor
description: Expert technology advisor for evaluating, recommending, and optimizing technology stacks. Provides comprehensive analysis of languages, frameworks, databases, infrastructure, and tooling choices. Uses first-principles thinking and simplicity principles to guide decisions. Covers backend, frontend, infrastructure, and cross-cutting concerns. Use for technology selection, stack evaluation, modernization planning, or technical debt assessment.
allowed-tools: Read, Write, Grep, Glob, Bash, WebSearch, WebFetch
---

# Tech Stack Advisor Skill - Comprehensive Technology Decision Support

## Overview

This skill provides expert guidance for **technology stack decisions** - from evaluating individual technologies to designing complete system architectures. It combines first-principles thinking, simplicity principles, and battle-tested technology patterns to help you make informed decisions that balance innovation, maintainability, and business value.

## Requirements

**No external dependencies required**

This skill is methodology and knowledge-based, applicable to any technology domain:

- Backend development (languages, frameworks, databases, APIs)
- Frontend development (frameworks, build tools, UI libraries)
- Infrastructure & DevOps (cloud platforms, containers, orchestration, CI/CD)
- Cross-cutting concerns (monitoring, security, testing, performance)
- Mobile, desktop, and embedded systems
- Data engineering and ML infrastructure

## Operational Modes

### Guide Mode (Educational)

- Explains technology options and trade-offs
- Teaches evaluation frameworks and decision-making processes
- Provides context on technology evolution and trends
- Answers "what is X?" and "how does Y compare to Z?"
- See [GUIDE.md](spec/GUIDE.md) for details

### Analyst Mode (Diagnostic)

- Evaluates existing technology stacks
- Identifies technical debt and modernization opportunities
- Assesses architectural patterns and anti-patterns
- Analyzes dependencies and security vulnerabilities
- Uses git skill to examine codebase patterns
- See [ANALYST.md](spec/ANALYST.md) for details

### Advisor Mode (Prescriptive)

- Recommends specific technologies for requirements
- Designs technology stacks for new projects
- Suggests migration and modernization paths
- Applies first-principles thinking to requirements
- Uses simplicity principles for complexity reduction
- See [ADVISOR.md](spec/ADVISOR.md) for details

### Evaluator Mode (Comparative)

- Compares technology options side-by-side
- Creates decision matrices with weighted criteria
- Analyzes trade-offs across multiple dimensions
- Provides objective assessment frameworks
- See [EVALUATOR.md](spec/EVALUATOR.md) for details

### Modernization Mode (Strategic)

- Assesses technical debt and legacy systems
- Plans incremental modernization strategies
- Designs strangler fig patterns for migrations
- Balances risk, cost, and business value
- See [MODERNIZATION.md](spec/MODERNIZATION.md) for details

### Research Mode (Investigative)

- Investigates emerging technologies and trends
- Validates vendor claims and marketing hype
- Researches real-world production experiences
- Analyzes community health and ecosystem maturity
- See [RESEARCH.md](spec/RESEARCH.md) for details

## Core Capabilities

### 1. Technology Domains

Comprehensive coverage across all technology layers:

#### Backend Technologies

- **Languages**: Python, JavaScript/Node.js, Java, Go, Rust, C#, Ruby, PHP, etc.
- **Frameworks**: Django, Flask, FastAPI, Express, Spring Boot, .NET, Rails, Laravel
- **Databases**: PostgreSQL, MySQL, MongoDB, Redis, Cassandra, DynamoDB, etc.
- **APIs**: REST, GraphQL, gRPC, WebSockets, Server-Sent Events
- **Message Queues**: RabbitMQ, Kafka, Redis Streams, SQS, Pub/Sub

#### Frontend Technologies

- **Frameworks**: React, Vue, Angular, Svelte, Solid, Next.js, Remix, Astro
- **Build Tools**: Vite, Webpack, Rollup, esbuild, Turbopack
- **State Management**: Redux, Zustand, Jotai, MobX, Pinia, Context API
- **Styling**: Tailwind, CSS Modules, styled-components, Sass, vanilla CSS
- **Testing**: Jest, Vitest, Playwright, Cypress, Testing Library

#### Infrastructure & DevOps

- **Cloud Platforms**: AWS, Google Cloud, Azure, DigitalOcean, Cloudflare
- **Containers**: Docker, Podman, containerd
- **Orchestration**: Kubernetes, Docker Swarm, Nomad, ECS, Cloud Run
- **CI/CD**: GitHub Actions, GitLab CI, Jenkins, CircleCI, Buildkite
- **IaC**: Terraform, Pulumi, CloudFormation, Ansible, Chef, Puppet

#### Cross-Cutting Concerns

- **Monitoring**: Prometheus, Grafana, Datadog, New Relic, Sentry
- **Logging**: ELK Stack, Loki, CloudWatch, Splunk
- **Security**: OAuth, OIDC, JWT, mTLS, WAF, SAST/DAST tools
- **Caching**: Redis, Memcached, Varnish, CDN strategies
- **Testing**: Unit, integration, E2E, load testing, chaos engineering

### 2. Decision Frameworks

Structured approaches for technology decisions ([FRAMEWORKS.md](spec/FRAMEWORKS.md)):

- **First-Principles Analysis**: Start from actual requirements, not assumptions
- **Simplicity Evaluation**: Prefer simple, composable solutions over complex ones
- **Boring Technology Choice**: Favor proven, stable technologies for critical paths
- **Innovation Budget**: Strategic allocation of "new tech" risk
- **Total Cost of Ownership**: Beyond licensing - maintenance, learning, scaling
- **Team Capability Assessment**: Match technology to team expertise and growth
- **Ecosystem Health**: Community activity, maintenance, longevity indicators
- **Performance Modeling**: Data-driven capacity planning and bottleneck analysis

### 3. Evaluation Criteria

Multi-dimensional technology assessment ([EVALUATION.md](spec/EVALUATION.md)):

**Technical Criteria:**

- Performance and scalability characteristics
- Reliability and fault tolerance
- Security posture and vulnerability history
- Operational complexity and observability
- Integration and extensibility

**Business Criteria:**

- Development velocity and time-to-market
- Hiring and training costs
- Licensing and operational costs
- Vendor lock-in and portability
- Long-term maintenance burden

**Team Criteria:**

- Existing expertise and learning curve
- Developer experience and productivity
- Debugging and troubleshooting ease
- Documentation and community support
- Career development and skill growth

### 4. Common Patterns & Anti-Patterns

Proven patterns and pitfalls to avoid ([PATTERNS.md](spec/PATTERNS.md)):

**Healthy Patterns:**

- Monolith-first approach for new projects
- Database-per-service for microservices
- Stateless application design
- Infrastructure as Code
- Observability-first architecture
- Defense in depth for security

**Anti-Patterns:**

- Resume-driven development (using tech for CV building)
- Premature microservices decomposition
- Technology gold-plating and over-engineering
- NIH syndrome (Not Invented Here)
- Ignoring operational complexity
- Cargo-cult adoption of "best practices"

### 5. Migration & Modernization

Strategic approaches for evolving systems ([MODERNIZATION.md](spec/MODERNIZATION.md)):

- Strangler fig pattern for gradual migration
- Feature parity vs. reimagination trade-offs
- Data migration strategies and rollback plans
- Blue-green, canary, and progressive rollouts
- Risk assessment and mitigation strategies
- Business continuity during transitions

### 6. Integration with Other Skills

Leverages foundational skills for better decisions:

- **First-Principles Thinking**: Break down requirements to fundamentals before choosing tech
- **Simplicity Principles**: Evaluate complexity objectively, prefer simple solutions
- **Git Skill**: Analyze existing codebases, understand technology usage patterns
- Combines multiple perspectives for comprehensive assessment

## When to Use This Skill

### Optimal Use Cases

1. **New Project Planning** - Choosing technology stack for greenfield projects
2. **Technology Evaluation** - Comparing options for specific requirements
3. **Stack Modernization** - Upgrading or replacing legacy technologies
4. **Technical Debt Assessment** - Identifying and prioritizing tech debt
5. **Architecture Reviews** - Evaluating existing system design
6. **Vendor Selection** - Choosing between commercial and open-source options
7. **Performance Optimization** - Identifying technology bottlenecks
8. **Security Hardening** - Reviewing security posture of stack
9. **Cost Optimization** - Reducing infrastructure and licensing costs
10. **Team Scaling** - Technology choices for growing teams

### Signs You Need This Skill

- "Should we use X or Y for this project?"
- "Our stack is getting too complex to maintain"
- "Is this technology still the right choice?"
- "How do we modernize without rewriting everything?"
- "What's the best database for our use case?"
- "Should we adopt this new framework?"
- "Our infrastructure costs are out of control"
- "We're spending too much time on tooling instead of features"

## Quick Start

### Choosing Technology for New Project

**User**: "We're building a new e-commerce platform. What technology stack should we use?"

**Advisor Mode Response**:
> Let me apply first-principles thinking to your requirements:
>
> **Step 1: Fundamental Requirements**
>
> - What's your expected scale? (users, transactions, data volume)
> - What's your team's current expertise?
> - What's your timeline and budget?
> - What are your critical features? (payments, inventory, recommendations, etc.)
>
> **Step 2: Simplicity-First Recommendation**
>
> For a typical e-commerce platform, I recommend starting simple:
>
> **Backend:**
>
> - Language: Python (Django/FastAPI) or Node.js (Express) - based on team expertise
> - Database: PostgreSQL (proven, reliable, handles e-commerce well)
> - Cache: Redis (sessions, caching, queues)
> - Search: Elasticsearch or PostgreSQL full-text (start with PG, add ES if needed)
>
> **Frontend:**
>
> - Framework: Next.js (React) or Nuxt (Vue) - SSR for SEO, great DX
> - Styling: Tailwind CSS (rapid development, maintainable)
> - State: Built-in framework state + React Query/SWR for server state
>
> **Infrastructure:**
>
> - Cloud: Start with single-region AWS/GCP/Azure
> - Deployment: Docker + managed container service (ECS, Cloud Run, App Service)
> - CI/CD: GitHub Actions (simple, integrated)
> - Monitoring: CloudWatch/Cloud Logging + Sentry for errors
>
> **Principles Applied:**
> ✓ Boring, proven technologies for critical path (payments, inventory)
> ✓ Monolith-first (easier to build, deploy, debug)
> ✓ Managed services over self-hosted (PostgreSQL RDS vs. self-managed)
> ✓ Optimize for team productivity, not résumé building
>
> See [ADVISOR.md](spec/ADVISOR.md) for detailed recommendation process.

### Evaluating Existing Stack

**User**: "Review our current stack and identify issues"

**Analyst Mode Response**:
> I'll analyze your stack using git skill and evaluation frameworks.
>
> **Analysis Process:**
>
> 1. Repository analysis (dependencies, patterns, technical debt)
> 2. Architecture review (coupling, complexity, testability)
> 3. Performance assessment (bottlenecks, scaling constraints)
> 4. Security review (vulnerabilities, best practices)
> 5. Operational complexity (deployment, monitoring, debugging)
>
> *[Performs analysis using git skill, grep patterns, dependency scanning]*
>
> **Findings:**
>
> - **Critical**: 15 dependencies with known vulnerabilities
> - **High**: Tight coupling between services (shared database)
> - **Medium**: Missing observability (no distributed tracing)
> - **Low**: Outdated build tools (Webpack 4)
>
> **Recommendations:**
>
> 1. Update vulnerable dependencies (security priority)
> 2. Implement database-per-service pattern incrementally
> 3. Add OpenTelemetry for distributed tracing
> 4. Migrate to Vite (improved DX, faster builds)
>
> See [ANALYST.md](spec/ANALYST.md) for detailed analysis frameworks.

### Comparing Technologies

**User**: "Should we use PostgreSQL or MongoDB for our new feature?"

**Evaluator Mode Response**:
> Let me compare using first-principles evaluation:
>
> **Your Data Characteristics:**
>
> - What's your data structure? (relational, document-oriented, hybrid?)
> - Do you need transactions? (ACID guarantees?)
> - What are your query patterns? (joins, aggregations, full-text search?)
> - What's your consistency requirement? (strong, eventual?)
>
> **Decision Matrix:**
>
> | Criterion | PostgreSQL | MongoDB | Winner |
> |-----------|------------|---------|--------|
> | ACID Transactions | ✓✓✓ Strong | ✓ Limited (4.0+) | PostgreSQL |
> | Schema Flexibility | ✓ (JSONB) | ✓✓✓ Native | MongoDB |
> | Query Language | SQL (powerful) | MQL (less mature) | PostgreSQL |
> | Operational Simplicity | ✓✓✓ Battle-tested | ✓✓ More complex | PostgreSQL |
> | Scaling Writes | ✓✓ Vertical + sharding | ✓✓✓ Native sharding | MongoDB |
> | Team Expertise | ? (your team) | ? (your team) | TBD |
> | Ecosystem Maturity | ✓✓✓ 30+ years | ✓✓ 15+ years | PostgreSQL |
>
> **Simplicity Principle Applied:**
> PostgreSQL is objectively simpler:
>
> - Fewer moving parts (no replica set complexity)
> - Stronger guarantees (ACID, constraints)
> - Better tooling ecosystem
> - JSONB provides schema flexibility when needed
>
> **Recommendation:**
> Start with PostgreSQL unless you have specific requirements that MongoDB solves better:
>
> - Extreme write scaling (millions/sec)
> - Highly variable schema across documents
> - Team has deep MongoDB expertise
>
> See [EVALUATOR.md](spec/EVALUATOR.md) for comparison frameworks.

## Skill Structure

```sh
tech-stack-advisor/
├── SKILL.md                    # This file - skill overview
├── README.md                   # Quick reference and installation
├── spec/
│   ├── GUIDE.md               # Educational mode - explaining technologies
│   ├── ANALYST.md             # Diagnostic mode - evaluating existing stacks
│   ├── ADVISOR.md             # Prescriptive mode - recommending solutions
│   ├── EVALUATOR.md           # Comparative mode - side-by-side comparison
│   ├── MODERNIZATION.md       # Strategic mode - migration planning
│   ├── RESEARCH.md            # Investigative mode - emerging tech analysis
│   ├── FRAMEWORKS.md          # Decision-making frameworks
│   ├── EVALUATION.md          # Assessment criteria and matrices
│   ├── PATTERNS.md            # Common patterns and anti-patterns
│   └── REFERENCES.md          # Documentation navigation guide
├── domains/
│   ├── backend/
│   │   ├── languages.md       # Backend language comparison
│   │   ├── frameworks.md      # Backend framework evaluation
│   │   ├── databases.md       # Database technology guide
│   │   └── apis.md            # API technology patterns
│   ├── frontend/
│   │   ├── frameworks.md      # Frontend framework landscape
│   │   ├── build-tools.md     # Build tool comparison
│   │   └── state-management.md # State management patterns
│   ├── infrastructure/
│   │   ├── cloud-platforms.md # Cloud provider comparison
│   │   ├── containers.md      # Container technology guide
│   │   └── cicd.md            # CI/CD platform evaluation
│   └── cross-cutting/
│       ├── monitoring.md      # Observability stack guide
│       ├── security.md        # Security technology patterns
│       └── testing.md         # Testing strategy and tools
└── examples/
    ├── e-commerce/            # E-commerce stack examples
    ├── saas/                  # SaaS platform patterns
    ├── data-platform/         # Data engineering stacks
    └── mobile/                # Mobile app technology choices
```

## Priority Hierarchy

1. **Requirements Alignment** (absolute top priority)
   - Technology must solve actual problems
   - First-principles analysis of needs
   - No technology for technology's sake
   - Business value over technical novelty

2. **Simplicity & Maintainability**
   - Prefer boring, proven technology
   - Minimize operational complexity
   - Optimize for understanding and debugging
   - Reduce cognitive load for team

3. **Team Capability**
   - Match technology to team skills
   - Consider learning curve and hiring
   - Developer experience and productivity
   - Knowledge transfer and documentation

4. **Total Cost of Ownership**
   - Licensing and infrastructure costs
   - Development and maintenance effort
   - Operational overhead and on-call burden
   - Migration and exit costs

5. **Performance & Scalability**
   - Meet actual performance requirements
   - Plan for growth, but don't over-engineer
   - Consider cost-performance trade-offs
   - Optimize when needed, not prematurely

## Key Principles

### From "Choose Boring Technology" (Dan McKinley)

- Let's say every company gets about three innovation tokens
- Spend your innovation tokens wisely
- New technology is risk that must be justified
- Boring technology = solved problems

### From First-Principles Thinking

- Start from actual requirements, not trends
- Question assumptions about what's needed
- Build solutions from fundamentals
- Validate that complexity is essential

### From Simplicity Principles

- Simple systems are easier to operate and debug
- Fewer moving parts = fewer failure modes
- Explicit over implicit, visible over hidden
- Composition over framework magic

### From "You Ain't Gonna Need It" (YAGNI)

- Don't add technology for hypothetical future needs
- Start simple, add complexity only when proven necessary
- Every dependency is a liability
- Optimize for deleting code, not adding it

### From SRE Principles

- Reliability is a feature of the stack
- Operational complexity is technical debt
- Observability is not optional
- Failure modes must be understood

## Integration with Other Skills

This skill enhances decision-making by combining:

- **First-Principles Thinking** - Break down requirements before choosing tech
- **Simplicity Principles** - Evaluate complexity objectively
- **Git Skill** - Analyze codebases to understand technology usage
- Domain-specific skills - Apply technology expertise to specific contexts

**Usage Pattern:**

```md
1. Use first-principles to understand requirements
2. Use simplicity to evaluate complexity trade-offs
3. Use tech-stack-advisor to compare options
4. Use git skill to validate with codebase analysis
5. Make informed decision based on all perspectives
```

## Meta-Circular Design

This skill practices what it preaches:

- **Documentation**: Markdown (boring, proven, simple)
- **Structure**: Clear hierarchy, separation of concerns
- **Integration**: Leverages other skills rather than reimplementing
- **Principles**: First-principles → Simplicity → Boring Tech → Right Tool

When asked "how should I structure my documentation?", this skill's own organization serves as an example!

## Documentation References

- [GUIDE.md](spec/GUIDE.md) - Educational mode for learning about technologies
- [ANALYST.md](spec/ANALYST.md) - Diagnostic mode for evaluating existing stacks
- [ADVISOR.md](spec/ADVISOR.md) - Prescriptive mode for making recommendations
- [EVALUATOR.md](spec/EVALUATOR.md) - Comparative mode for technology comparison
- [MODERNIZATION.md](spec/MODERNIZATION.md) - Strategic mode for migration planning
- [RESEARCH.md](spec/RESEARCH.md) - Investigative mode for emerging technologies
- [FRAMEWORKS.md](spec/FRAMEWORKS.md) - Decision-making frameworks and processes
- [EVALUATION.md](spec/EVALUATION.md) - Assessment criteria and evaluation matrices
- [PATTERNS.md](spec/PATTERNS.md) - Common patterns and anti-patterns
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation guide

## Version History

- **v1.0.0** (2025-12-14): Initial implementation
  - Six operational modes (Guide, Analyst, Advisor, Evaluator, Modernization, Research)
  - Comprehensive technology domain coverage (backend, frontend, infrastructure, cross-cutting)
  - Integration with first-principles, simplicity, and git skills
  - Decision frameworks based on boring technology, simplicity, and requirements alignment
  - Multi-dimensional evaluation criteria (technical, business, team)
  - Migration and modernization strategies
  - Real-world examples and patterns
