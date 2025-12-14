---
name: skill-feature-architect
description: Expert feature design and implementation planning specialist. Transforms requirements into well-architected features through discovery, design, and detailed planning. Uses first-principles thinking for requirement analysis, simplicity principles for design decisions, and git skill for codebase integration. Produces specifications, user stories, implementation plans, architecture diagrams, and API contracts. Use for feature planning, requirement analysis, technical design, or implementation roadmaps.
allowed-tools: Read, Write, Grep, Glob, Bash, TodoWrite
---

# Feature Architect Skill - Comprehensive Feature Design and Planning

## Overview

This skill provides expert guidance for **end-to-end feature development** - from initial concept to implementation-ready specifications. It combines first-principles thinking for requirement analysis, simplicity principles for avoiding over-engineering, technical stack awareness, and codebase understanding to create well-architected, maintainable features that deliver real user value.

## Requirements

**No external dependencies required**

This skill is methodology and analysis-based, applicable to any software development context:

- Web applications (frontend, backend, full-stack)
- Mobile applications (iOS, Android, cross-platform)
- Desktop applications
- APIs and microservices
- Data platforms and pipelines
- Developer tools and libraries

## Operational Modes

### Discovery Mode (Requirements Analysis)

- Facilitates requirement gathering and clarification
- Uses first-principles thinking to understand true user needs
- Identifies constraints, assumptions, and success criteria
- Creates problem statements and user journey maps
- Validates requirements with stakeholders
- See [DISCOVERY.md](spec/DISCOVERY.md) for details

### Design Mode (Architecture & Solution Design)

- Creates technical architecture for features
- Designs data models, APIs, and system interactions
- Applies simplicity principles to avoid over-engineering
- Considers technical stack constraints and patterns
- Produces architecture diagrams and design documents
- See [DESIGN.md](spec/DESIGN.md) for details

### Planning Mode (Implementation Strategy)

- Breaks down features into implementable tasks
- Creates detailed implementation plans and sequencing
- Identifies dependencies and critical paths
- Defines testing strategies and acceptance criteria
- Estimates complexity and risk factors
- See [PLANNING.md](spec/PLANNING.md) for details

### Integration Mode (Codebase Analysis)

- Analyzes existing codebase patterns using git skill
- Identifies reusable components and services
- Ensures consistency with existing architecture
- Plans integration points and migration strategies
- Detects potential conflicts and technical debt
- See [INTEGRATION.md](spec/INTEGRATION.md) for details

### Review Mode (Feature Evaluation)

- Reviews existing feature designs and implementations
- Identifies improvement opportunities
- Assesses alignment with requirements
- Evaluates complexity and maintainability
- Recommends refactoring or optimization strategies
- See [REVIEW.md](spec/REVIEW.md) for details

### Documentation Mode (Specification Creation)

- Creates comprehensive technical specifications
- Generates API contracts and interface definitions
- Produces architecture diagrams and data flow charts
- Writes user stories and acceptance criteria
- Documents decision rationale and trade-offs
- See [DOCUMENTATION.md](spec/DOCUMENTATION.md) for details

## Core Capabilities

### 1. Requirement Analysis

Comprehensive requirement discovery and validation ([REQUIREMENTS.md](spec/REQUIREMENTS.md)):

**Discovery Techniques:**

- First-principles questioning to uncover true needs
- User story mapping and journey analysis
- Constraint identification (technical, business, regulatory)
- Success metrics and acceptance criteria definition
- Assumption validation and risk assessment

**Deliverables:**

- Problem statements and user needs documentation
- User stories and personas
- Functional and non-functional requirements
- Success criteria and KPIs
- Constraint and assumption documentation

### 2. Technical Design

Solution architecture and design ([DESIGN.md](spec/DESIGN.md)):

**Design Approaches:**

- System architecture and component design
- Data modeling (schemas, relationships, migrations)
- API design (REST, GraphQL, gRPC contracts)
- State management and data flow patterns
- Integration patterns and service boundaries
- Security and performance considerations

**Design Principles:**

- Simplicity-first: avoid unnecessary complexity
- Separation of concerns: clear component boundaries
- Composability: build reusable, orthogonal pieces
- Testability: design for easy testing and validation
- Observability: built-in monitoring and debugging
- Graceful degradation: handle failures elegantly

**Deliverables:**

- Architecture diagrams (C4 model, sequence diagrams, ERDs)
- API contracts and interface definitions
- Data models and migration plans
- Component interaction specifications
- Security and performance design docs

### 3. Implementation Planning

Detailed task breakdown and execution strategy ([PLANNING.md](spec/PLANNING.md)):

**Planning Techniques:**

- Work breakdown structure (WBS)
- Task dependency mapping and critical path analysis
- Risk identification and mitigation planning
- Incremental delivery and milestone definition
- Testing strategy (unit, integration, E2E)
- Rollout and deployment planning

**Estimation Approaches:**

- Complexity scoring (Small/Medium/Large)
- T-shirt sizing for relative estimation
- Risk-adjusted estimates
- Dependency and blocker identification
- Buffer allocation for unknowns

**Deliverables:**

- Implementation task lists with TodoWrite integration
- Task dependencies and sequencing
- Testing plans and acceptance criteria
- Deployment and rollout strategies
- Risk mitigation plans

### 4. Codebase Integration

Understanding and leveraging existing code ([INTEGRATION.md](spec/INTEGRATION.md)):

**Analysis Using Git Skill:**

- Repository structure and module organization
- Existing patterns and architectural decisions
- Reusable components and utilities
- Code quality and technical debt hotspots
- Integration points and API boundaries

**Integration Strategies:**

- Identify reusable code vs. new development
- Plan for consistent patterns and conventions
- Design migration paths for breaking changes
- Ensure backward compatibility where needed
- Document integration requirements

**Deliverables:**

- Codebase analysis reports
- Reusable component identification
- Integration point specifications
- Migration and compatibility plans

### 5. Documentation & Specifications

Comprehensive technical documentation ([DOCUMENTATION.md](spec/DOCUMENTATION.md)):

**Documentation Types:**

- Technical specifications (RFC-style documents)
- Architecture Decision Records (ADRs)
- API documentation (OpenAPI, GraphQL schema)
- User stories and acceptance criteria
- Implementation guides and runbooks
- Diagram types: C4, sequence, ERD, state machines, data flow

**Documentation Principles:**

- Clarity: write for future maintainers
- Completeness: cover all critical aspects
- Conciseness: no unnecessary verbosity
- Versionability: track changes and decisions
- Accessibility: easy to find and understand

### 6. Integration with Other Skills

Leverages foundational and specialized skills:

**First-Principles Thinking:**

- Break down feature requests to fundamental user needs
- Challenge assumptions about requirements
- Build solutions from core problems, not perceived solutions

**Simplicity Principles:**

- Evaluate design complexity objectively
- Prefer simple, composable solutions
- Avoid premature optimization and abstraction
- Question whether features are truly necessary

**Git Skill:**

- Analyze codebase structure and patterns
- Understand existing architectural decisions
- Identify integration points and reusable code
- Track feature evolution and technical debt

**Tech Stack Advisor:**

- Validate technology choices for feature requirements
- Ensure consistency with overall stack strategy
- Evaluate new dependencies and tools
- Consider operational and maintenance implications

## When to Use This Skill

### Optimal Use Cases

1. **New Feature Development** - Planning and designing greenfield features
2. **Feature Discovery** - Understanding and refining vague requirements
3. **Architecture Design** - Creating technical designs for complex features
4. **Implementation Planning** - Breaking down features into executable tasks
5. **API Design** - Designing clean, maintainable API contracts
6. **Data Modeling** - Designing database schemas and data flows
7. **Feature Reviews** - Evaluating existing feature designs
8. **Technical Specifications** - Writing comprehensive design documents
9. **Integration Planning** - Planning feature integration with existing systems
10. **Requirement Validation** - Ensuring features solve actual problems

### Signs You Need This Skill

- "We need to build [feature], where do we start?"
- "The requirements are unclear, can you help clarify?"
- "How should this feature be architected?"
- "Break this feature down into implementable tasks"
- "What's the best way to integrate this with our existing system?"
- "We keep building features that don't solve the real problem"
- "Our features are getting too complex to maintain"
- "How do we design this API for future extensibility?"
- "What are the acceptance criteria for this feature?"
- "Should we build this feature or is there a simpler solution?"

## Quick Start

### Feature Discovery and Planning

**User**: "We need to add user authentication to our app"

**Discovery Mode Response**:
> Let me help you understand the requirements using first-principles thinking.
>
> **Step 1: Understand the Core Need**
>
> - Why do you need authentication? (security, personalization, access control?)
> - What are you protecting? (data, features, resources?)
> - Who are your users? (consumers, businesses, internal employees?)
>
> **Step 2: Define Requirements**
> Let me ask clarifying questions:
>
> 1. **Authentication Methods:**
>    - Email/password only?
>    - Social login (Google, GitHub, etc.)?
>    - SSO/SAML for enterprise?
>    - Multi-factor authentication (MFA)?
>
> 2. **User Management:**
>    - Self-service registration or invite-only?
>    - Email verification required?
>    - Password reset flows?
>    - Account deletion and data export (GDPR)?
>
> 3. **Session Management:**
>    - Session duration and timeout?
>    - "Remember me" functionality?
>    - Multiple device support?
>    - Force logout on password change?
>
> 4. **Authorization:**
>    - Role-based access control (RBAC)?
>    - Fine-grained permissions?
>    - Resource-level access control?
>
> 5. **Security Requirements:**
>    - Regulatory compliance (GDPR, HIPAA, SOC2)?
>    - Password complexity requirements?
>    - Rate limiting and brute-force protection?
>    - Audit logging?
>
> **Step 3: Simplicity Check**
> Before we design, let's question assumptions:
>
> - Do you need to build auth or use a service (Auth0, Clerk, Firebase Auth)?
> - Can you start with basic email/password and add complexity later?
> - What's the minimum viable authentication for your use case?
>
> See [DISCOVERY.md](spec/DISCOVERY.md) for the complete discovery process.

**Design Mode Response** (after requirements are clear):
> Based on your requirements, here's the technical design:
>
> **Architecture Overview:**
>
> ```md
> ┌─────────────┐      ┌──────────────┐      ┌─────────────┐
> │   Client    │─────>│  API Gateway │─────>│   Auth      │
> │  (Web/App)  │      │   + Middleware│      │  Service    │
> └─────────────┘      └──────────────┘      └─────────────┘
>                              │                     │
>                              │                     v
>                              v              ┌─────────────┐
>                       ┌──────────────┐      │   User DB   │
>                       │  Protected   │      │ (PostgreSQL)│
>                       │  Resources   │      └─────────────┘
>                       └──────────────┘
> ```
>
> **Data Model:**
>
> ```sql
> -- Users table
> CREATE TABLE users (
>   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
>   email VARCHAR(255) UNIQUE NOT NULL,
>   password_hash VARCHAR(255) NOT NULL,
>   email_verified BOOLEAN DEFAULT false,
>   created_at TIMESTAMP DEFAULT NOW(),
>   updated_at TIMESTAMP DEFAULT NOW()
> );
>
> -- Sessions table
> CREATE TABLE sessions (
>   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
>   user_id UUID REFERENCES users(id) ON DELETE CASCADE,
>   token_hash VARCHAR(255) UNIQUE NOT NULL,
>   expires_at TIMESTAMP NOT NULL,
>   created_at TIMESTAMP DEFAULT NOW()
> );
>
> -- Email verification tokens
> CREATE TABLE email_verification_tokens (
>   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
>   user_id UUID REFERENCES users(id) ON DELETE CASCADE,
>   token_hash VARCHAR(255) UNIQUE NOT NULL,
>   expires_at TIMESTAMP NOT NULL,
>   created_at TIMESTAMP DEFAULT NOW()
> );
> ```
>
> **API Contract:**
>
> ```typescript
> // POST /auth/register
> interface RegisterRequest {
>   email: string;
>   password: string;
> }
> interface RegisterResponse {
>   user: { id: string; email: string };
>   message: "Verification email sent";
> }
>
> // POST /auth/login
> interface LoginRequest {
>   email: string;
>   password: string;
> }
> interface LoginResponse {
>   user: { id: string; email: string };
>   session: { token: string; expiresAt: string };
> }
>
> // POST /auth/logout
> interface LogoutRequest {
>   sessionToken: string;
> }
> interface LogoutResponse {
>   success: boolean;
> }
> ```
>
> **Security Considerations:**
>
> - Passwords hashed with bcrypt (cost factor 12)
> - Session tokens: cryptographically random, hashed in DB
> - HTTPS-only cookie for session token (HttpOnly, Secure, SameSite=Lax)
> - Rate limiting: 5 login attempts per 15 minutes per IP
> - Email verification required before account activation
> - Password requirements: min 12 chars, complexity check
>
> **Technology Recommendations** (from tech-stack-advisor):
>
> - Don't roll your own crypto - use established libraries
> - Consider Auth0/Clerk for faster development (vs. building from scratch)
> - If building: use Passport.js (Node) or similar established library
>
> See [DESIGN.md](spec/DESIGN.md) for complete design process.

**Planning Mode Response**:
> Let me break this feature into implementable tasks:
>
> **Phase 1: Core Authentication (Week 1)**
>
> - [ ] Set up user and session tables (migrations)
> - [ ] Implement password hashing utility (bcrypt)
> - [ ] Create registration endpoint with email validation
> - [ ] Create login endpoint with session creation
> - [ ] Create logout endpoint with session deletion
> - [ ] Add authentication middleware for protected routes
> - [ ] Write unit tests for auth logic
>
> **Phase 2: Email Verification (Week 1-2)**
>
> - [ ] Set up email service (SendGrid/SES/SMTP)
> - [ ] Create email verification token generation
> - [ ] Implement email verification endpoint
> - [ ] Add email templates for verification
> - [ ] Prevent unverified users from logging in
> - [ ] Add resend verification email endpoint
>
> **Phase 3: Password Reset (Week 2)**
>
> - [ ] Create password reset token table
> - [ ] Implement "forgot password" endpoint
> - [ ] Create password reset email template
> - [ ] Implement password reset endpoint with token validation
> - [ ] Add password strength validation
> - [ ] Invalidate sessions on password change
>
> **Phase 4: Security Hardening (Week 2-3)**
>
> - [ ] Implement rate limiting (login, registration)
> - [ ] Add brute-force protection (account lockout)
> - [ ] Set up audit logging for auth events
> - [ ] Configure secure cookie settings
> - [ ] Add CSRF protection
> - [ ] Security audit and penetration testing
>
> **Phase 5: Integration & Testing (Week 3)**
>
> - [ ] Integrate auth with frontend
> - [ ] Write integration tests for auth flows
> - [ ] Write E2E tests for registration/login/logout
> - [ ] Test password reset flow end-to-end
> - [ ] Performance testing (session lookup, token validation)
> - [ ] Documentation and deployment
>
> **Dependencies:**
>
> - Database migrations must complete before API development
> - Email service must be configured before verification/reset
> - Security hardening should be done before production deployment
>
> **Risks:**
>
> - Email deliverability issues (mitigation: use reliable service, SPF/DKIM)
> - Session management bugs (mitigation: thorough testing, use proven patterns)
> - Security vulnerabilities (mitigation: security audit, use established libraries)
>
> See [PLANNING.md](spec/PLANNING.md) for detailed planning frameworks.

### Reviewing an Existing Feature

**User**: "Review our search feature - it's slow and hard to maintain"

**Review Mode Response**:
> I'll analyze the search feature using git skill and evaluation frameworks.
>
> **Analysis Process:**
>
> 1. Understand original requirements and design
> 2. Review current implementation (code, architecture, data flow)
> 3. Identify problems and root causes
> 4. Propose improvements
>
> *[Uses git skill to analyze search-related code]*
>
> **Findings:**
>
> **Architecture Issues:**
>
> - ❌ Search logic scattered across 12 different files
> - ❌ Direct database queries in UI components (tight coupling)
> - ❌ No caching layer for repeated searches
> - ❌ Full table scans on large datasets (no indexes)
>
> **Complexity Issues (Simplicity Analysis):**
>
> - ❌ Custom search parser instead of using Postgres full-text search
> - ❌ Premature optimization: complex ranking algorithm not used
> - ❌ Over-abstraction: 5 layers between query and results
>
> **Performance Issues:**
>
> - ❌ N+1 query problem when loading related data
> - ❌ No pagination - loads all results at once
> - ❌ Client-side filtering instead of database-level
>
> **Root Cause:**
> The feature was over-engineered for hypothetical future requirements (full-text search, fuzzy matching, advanced ranking) but doesn't implement the basics well (indexes, caching, pagination).
>
> **Recommendations:**
>
> **Quick Wins (1-2 days):**
>
> 1. Add database indexes on search columns
> 2. Implement pagination (limit results to 50)
> 3. Add Redis caching for popular searches
>
> **Medium-term Refactor (1-2 weeks):**
>
> 1. Consolidate search logic into single service module
> 2. Use PostgreSQL full-text search (built-in, proven)
> 3. Remove custom parser and ranking (use pg_trgm)
> 4. Simplify data flow: UI → API → Search Service → DB
>
> **Long-term Improvement (if needed):**
>
> 1. Consider Elasticsearch only if PostgreSQL can't handle scale
> 2. Implement search analytics to understand actual user needs
> 3. Add features based on real usage patterns, not assumptions
>
> **Simplicity Principle Applied:**
> Start with boring, proven technology (PostgreSQL full-text) instead of complex custom solutions. Add complexity only when proven necessary.
>
> See [REVIEW.md](spec/REVIEW.md) for review frameworks.

## Skill Structure

```sh
feature-architect/
├── SKILL.md                      # This file - skill overview
├── README.md                     # Quick reference and installation
├── spec/
│   ├── DISCOVERY.md             # Requirements analysis and discovery
│   ├── DESIGN.md                # Architecture and solution design
│   ├── PLANNING.md              # Implementation task breakdown
│   ├── INTEGRATION.md           # Codebase analysis and integration
│   ├── REVIEW.md                # Feature evaluation and improvement
│   ├── DOCUMENTATION.md         # Specification creation
│   ├── REQUIREMENTS.md          # Requirement gathering techniques
│   └── REFERENCES.md            # Documentation navigation guide
├── frameworks/
│   ├── user-story-mapping.md    # User story mapping techniques
│   ├── c4-diagrams.md           # C4 model architecture diagrams
│   ├── api-design.md            # API design best practices
│   ├── data-modeling.md         # Database design patterns
│   ├── testing-strategy.md      # Testing pyramid and approaches
│   └── adr-template.md          # Architecture Decision Records
├── templates/
│   ├── technical-spec.md        # RFC-style technical specification
│   ├── user-story.md            # User story template
│   ├── api-contract.md          # API documentation template
│   ├── architecture-diagram.md  # Diagram guidelines and tools
│   └── acceptance-criteria.md   # Definition of done template
└── examples/
    ├── authentication/          # Auth feature example (full lifecycle)
    ├── search/                  # Search feature example
    ├── payment-processing/      # Payment feature example
    ├── real-time-notifications/ # Real-time features
    └── data-import/            # Batch processing features
```

## Priority Hierarchy

1. **User Value** (absolute top priority)
   - Solve real user problems, not imagined ones
   - First-principles analysis of actual needs
   - Question whether feature is necessary
   - Validate assumptions with users/stakeholders

2. **Simplicity** (close second)
   - Avoid over-engineering and premature optimization
   - Build minimum viable feature first
   - Add complexity only when proven necessary
   - Prefer boring, proven patterns

3. **Maintainability**
   - Clear, understandable architecture
   - Consistent with existing codebase patterns
   - Well-documented design decisions
   - Testable and debuggable design

4. **Integration Quality**
   - Fits naturally with existing systems
   - Reuses existing components when appropriate
   - Minimal disruption to current architecture
   - Clear migration path for changes

5. **Performance & Scalability**
   - Meet actual performance requirements
   - Design for current scale, plan for growth
   - Optimize when needed, not prematurely
   - Measure and validate performance assumptions

## Key Principles

### From First-Principles Thinking

- Start with user problems, not proposed solutions
- Question every requirement - is it necessary?
- Break down complex features to fundamental needs
- Build solutions from validated requirements

### From Simplicity Principles

- Simple is better than easy
- Fewer moving parts = easier to maintain
- Explicit is better than implicit
- Start simple, add complexity only when needed

### From YAGNI (You Aren't Gonna Need It)

- Build for current requirements, not hypothetical future
- Don't add features "just in case"
- Optimize for deleting code, not adding it
- Every feature is a maintenance burden

### From Unix Philosophy

- Do one thing well
- Compose simple tools into complex behaviors
- Design for composition and reuse
- Avoid monolithic feature design

### From Domain-Driven Design

- Ubiquitous language: align technical and business terms
- Bounded contexts: clear feature boundaries
- Core domain focus: prioritize business value
- Anti-corruption layers: protect from external complexity

## Integration with Other Skills

This skill orchestrates multiple skills for comprehensive feature development:

**First-Principles Thinking:**

- Requirement analysis and validation
- Problem deconstruction
- Solution building from fundamentals

**Simplicity Principles:**

- Design complexity evaluation
- Over-engineering detection
- Simplification strategies

**Git Skill:**

- Codebase pattern analysis
- Integration point identification
- Technical debt assessment

**Tech Stack Advisor:**

- Technology selection for features
- Library and framework recommendations
- Operational complexity assessment

**Usage Pattern:**

```md
1. Use first-principles (discovery) to understand true requirements
2. Use git skill (integration) to analyze existing codebase
3. Use simplicity (design) to create maintainable architecture
4. Use tech-stack-advisor to validate technology choices
5. Use feature-architect to orchestrate and document
```

## Meta-Circular Design

This skill demonstrates its own principles:

- **User Value**: Solves real feature development problems
- **Simplicity**: Clear structure, no over-abstraction
- **Maintainability**: Well-documented, easy to understand
- **Integration**: Leverages other skills rather than reimplementing

When asked "how should I design a feature?", this skill's own structure and approach serve as an example!

## Documentation References

- [DISCOVERY.md](spec/DISCOVERY.md) - Requirements analysis and discovery techniques
- [DESIGN.md](spec/DESIGN.md) - Architecture and solution design approaches
- [PLANNING.md](spec/PLANNING.md) - Implementation planning and task breakdown
- [INTEGRATION.md](spec/INTEGRATION.md) - Codebase analysis and integration strategies
- [REVIEW.md](spec/REVIEW.md) - Feature evaluation and improvement recommendations
- [DOCUMENTATION.md](spec/DOCUMENTATION.md) - Specification and documentation creation
- [REQUIREMENTS.md](spec/REQUIREMENTS.md) - Detailed requirement gathering frameworks
- [REFERENCES.md](spec/REFERENCES.md) - Documentation navigation guide

## Version History

- **v1.0.0** (2025-12-14): Initial implementation
  - Six operational modes (Discovery, Design, Planning, Integration, Review, Documentation)
  - Comprehensive requirement analysis using first-principles thinking
  - Architecture design with simplicity principles
  - Implementation planning with task breakdown and risk assessment
  - Codebase integration using git skill
  - Full documentation and specification creation
  - Integration with first-principles, simplicity, git, and tech-stack-advisor skills
  - Real-world examples and templates
