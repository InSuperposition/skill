# Code Quality Guardian

**Expert code quality assessment and improvement across all dimensions**

Comprehensive code review, security analysis, performance optimization, and technical debt management using first-principles thinking, simplicity principles, and git skill integration.

## Quick Start

### What This Skill Provides

- **🔍 Code Review (Reviewer Mode)** - Interactive pull request and code reviews with severity-based findings
- **🛡️ Quality Gates (Guardian Mode)** - Automated quality enforcement, linting rules, and CI/CD integration
- **👨‍🏫 Mentorship (Mentor Mode)** - Educational guidance and constructive feedback for teams
- **📊 Codebase Audits (Auditor Mode)** - Comprehensive technical debt and quality assessments
- **🔐 Security Assessment** - OWASP Top 10, vulnerability detection, exploit identification
- **⚡ Performance Analysis** - Algorithmic complexity, database optimization, bottleneck detection
- **✅ Correctness Verification** - Logic validation, bug detection using first-principles
- **🧹 Maintainability** - Code clarity assessment using simplicity principles
- **🧪 Test Quality** - Coverage analysis, flaky test detection, testability improvement
- **🏗️ Architecture Review** - Design patterns, SOLID principles, anti-pattern detection
- **💳 Technical Debt** - Debt identification, prioritization, and paydown strategies using git skill

### Installation

No external dependencies required - this is a methodology and analysis-based skill.

Works with any programming language and technology stack.

### When to Use This Skill

✅ **Pull Request Reviews** - "Review this PR before I merge it"
✅ **Security Audits** - "Is this authentication code secure?"
✅ **Performance Problems** - "Why is this API endpoint so slow?"
✅ **Quality Gates** - "Set up automated quality checks for our CI/CD"
✅ **Technical Debt** - "Assess our codebase health and identify debt"
✅ **Team Education** - "Teach my team to write better code"
✅ **Architecture Reviews** - "Evaluate our system design"
✅ **Refactoring** - "How should we improve this legacy code?"
✅ **Compliance** - "Audit code for compliance requirements"
✅ **Onboarding** - "Help new developers understand our standards"

## Quick Examples

### Example 1: Code Review (Reviewer Mode)

**User**: "Review this login function"

**Code Quality Guardian**:

```md
🔴 CRITICAL - Security Vulnerabilities:

1. SQL Injection (OWASP #3)
   - Issue: Direct string interpolation in query
   - Exploit: "' OR '1'='1'; --" bypasses auth
   - Fix: Use parameterized queries

2. Plain Text Passwords (OWASP #2)
   - Issue: Password comparison without hashing
   - Fix: Use bcrypt/argon2

3. Weak Session Token (OWASP #7)
   - Issue: Predictable 4-digit session ID
   - Fix: Use secrets.token_urlsafe(32)

🟡 MEDIUM - Logic Issues:
- No rate limiting (brute force risk)
- No input validation

Recommendation: DO NOT merge until critical issues fixed.
```

### Example 2: Performance Audit (Auditor Mode)

**User**: "Our dashboard loads in 3.2 seconds - why?"

**Code Quality Guardian**:

```md
Performance Analysis:

🔴 CRITICAL:
1. N+1 Query Problem - 21 queries instead of 2
   Impact: 10x slower (2s → 0.2s)

2. Missing Database Index - Full table scan on 10M rows
   Impact: 40x slower (2s → 0.05s)

🟡 MEDIUM:
3. O(n²) Algorithm - Nested loop processing
   Impact: 100x slower (1s → 0.01s)

Total improvement: 3.2s → 0.07s (45x faster)

Recommended order:
1. Add indexes (immediate, low risk)
2. Fix N+1 queries (high impact)
3. Optimize O(n²) algorithm (low effort)
```

### Example 3: Technical Debt Assessment (Auditor Mode)

**User**: "What's our technical debt situation?"

**Code Quality Guardian**:

```md
Codebase Health: ⚠️ MODERATE RISK

Critical Hotspots (git skill analysis):
- payment_processor.py: 150 commits, complexity 45
- user_service.py: 120 commits, complexity 38

Security Debt:
- 8 dependencies with CVEs ⚠️
- Hardcoded secrets in 3 files
- No rate limiting on APIs

Test Debt:
- Payment processing: 0% coverage ⚠️
- Overall coverage: 45% (target: 80%)

Prioritized Roadmap:
Phase 1 (Weeks 1-2): Fix CVEs, add payment tests
Phase 2 (Weeks 3-5): Refactor hotspots, increase coverage
Phase 3 (Weeks 6-10): Reduce duplication, update docs
```

## Architecture

```sh
code-quality-guardian/
├── SKILL.md                # Complete skill specification (938 lines)
├── README.md               # This file - Quick start
└── spec/
    ├── REFERENCES.md       # Navigation guide (you are here for details)
    ├── REVIEWER.md         # Code review operational mode
    ├── GUARDIAN.md         # Prevention and standards enforcement
    ├── MENTOR.md           # Educational and mentorship mode
    └── AUDITOR.md          # Comprehensive assessment mode
```

**Phase 2 (Planned)**: Quality dimension files (SECURITY.md, PERFORMANCE.md, ARCHITECTURE.md, etc.)

## Key Capabilities

### Operational Modes

**Reviewer Mode** - [spec/REVIEWER.md](spec/REVIEWER.md)

- Interactive code reviews for pull requests
- Severity-based findings (Critical, High, Medium, Low)
- Security, performance, and maintainability assessment
- Integration with git skill for context

**Guardian Mode** - [spec/GUARDIAN.md](spec/GUARDIAN.md)

- Automated quality enforcement
- CI/CD integration and pre-commit hooks
- Linting rules and static analysis
- Quality gates and blocking checks

**Mentor Mode** - [spec/MENTOR.md](spec/MENTOR.md)

- Educational guidance and teaching
- Constructive feedback techniques
- Team onboarding and training
- Explaining "why" not just "what"

**Auditor Mode** - [spec/AUDITOR.md](spec/AUDITOR.md)

- Comprehensive codebase assessment
- Technical debt identification
- Git skill integration for hotspot analysis
- Quality metrics and reporting

### Quality Dimensions

**Security** - OWASP Top 10, CWE vulnerabilities, threat modeling
**Performance** - Algorithmic analysis, database optimization, bottleneck detection
**Correctness** - Logic validation, bug detection, first-principles verification
**Maintainability** - Code clarity, simplicity assessment, refactoring guidance
**Testability** - Coverage analysis, test quality, flaky test detection
**Architecture** - Design patterns, SOLID principles, anti-patterns
**Technical Debt** - Debt categorization, prioritization, paydown strategies

## Priority Hierarchy

1. **Security** (Absolute Top Priority)
   - Critical vulnerabilities must be fixed immediately
   - OWASP Top 10 compliance
   - No compromises on authentication, authorization, encryption

2. **Correctness**
   - Code must work as intended
   - Logic validation from first-principles
   - Edge cases and error handling

3. **Maintainability**
   - Code clarity and readability
   - Simplicity over cleverness
   - Future developer experience

4. **Performance**
   - Meet actual requirements
   - Fix critical bottlenecks
   - Don't prematurely optimize

5. **Test Quality**
   - Critical paths must be tested
   - Reliable, fast tests
   - Coverage for regressions

## Integration with Other Skills

**First-Principles Thinking** - Verify logic correctness from fundamental truths, challenge code assumptions, root cause analysis for bugs

**Simplicity Principles** - Objective complexity assessment, over-engineering detection, simplification strategies

**Git Skill** - Hotspot analysis, code evolution tracking, contributor patterns, change coupling detection

**Tech Stack Advisor** - Technology-specific best practices, tool recommendations, dependency security

## Common Questions

**Q: Which mode do I use for daily code review?**
A: [Reviewer Mode](spec/REVIEWER.md) - Interactive reviews for pull requests and manual code reviews.

**Q: How do I prevent bad code from merging?**
A: [Guardian Mode](spec/GUARDIAN.md) - Set up quality gates, pre-commit hooks, and CI/CD checks.

**Q: How do I teach my team better practices?**
A: [Mentor Mode](spec/MENTOR.md) - Educational mode with constructive feedback techniques.

**Q: How do I assess our codebase health?**
A: [Auditor Mode](spec/AUDITOR.md) - Comprehensive audits with git skill integration.

**Q: Where are language-specific standards (Python, JS, etc.)?**
A: Language standards will be a separate skill. This skill focuses on universal quality principles.

**Q: Does this work with my programming language?**
A: Yes - the principles apply to all languages. Concrete examples use Python, JavaScript, and others.

## Getting Started

### For Beginners (New to Code Review)

1. Read this README to understand capabilities
2. Review [SKILL.md](SKILL.md) for complete specification
3. Start with [spec/REVIEWER.md](spec/REVIEWER.md) for basic review workflow
4. Practice constructive feedback with [spec/MENTOR.md](spec/MENTOR.md)

### For Practitioners (Regular Code Review)

1. Quick scan [spec/REFERENCES.md](spec/REFERENCES.md) for navigation
2. Deep dive [spec/REVIEWER.md](spec/REVIEWER.md) for advanced techniques
3. Set up automation with [spec/GUARDIAN.md](spec/GUARDIAN.md)
4. Reference quality dimensions as needed

### For Teams (Quality Culture)

1. Leadership: Read [spec/AUDITOR.md](spec/AUDITOR.md) for assessment approach
2. Team leads: Review [spec/MENTOR.md](spec/MENTOR.md) for teaching techniques
3. DevOps: Set up [spec/GUARDIAN.md](spec/GUARDIAN.md) for automation
4. Everyone: Standardize reviews with [spec/REVIEWER.md](spec/REVIEWER.md)
5. Regularly audit using [spec/AUDITOR.md](spec/AUDITOR.md)

## Key Principles at a Glance

**From Security Best Practices**

- Security is not optional
- Defense in depth
- Never trust user input
- Don't roll your own crypto

**From First-Principles Thinking**

- Verify logic from fundamental truths
- Challenge assumptions in code
- Understand root causes, not symptoms

**From Simplicity Principles**

- Simple code is easier to maintain
- Complexity is a liability
- Explicit is better than implicit
- Clever code is usually bad code

**From Code Review Best Practices**

- Be kind, be constructive
- Explain "why", not just "what"
- Suggest alternatives, don't just criticize
- Focus on learning, not blame

## Documentation Navigation

**Complete Documentation Map**: [spec/REFERENCES.md](spec/REFERENCES.md)

**Operational Modes**:

- [REVIEWER.md](spec/REVIEWER.md) - Code review mode
- [GUARDIAN.md](spec/GUARDIAN.md) - Prevention and standards
- [MENTOR.md](spec/MENTOR.md) - Educational mode
- [AUDITOR.md](spec/AUDITOR.md) - Assessment mode

**Complete Specification**: [SKILL.md](SKILL.md)

## Version History

- **v1.0.0** (2025-12-14): Phase 1 - Core operational modes
  - REVIEWER, GUARDIAN, MENTOR, AUDITOR modes
  - Integration with first-principles, simplicity, git skills
  - Security, performance, correctness, maintainability coverage
  - Simple, well-organized documentation structure

## License

This skill is part of the Claude Code skill ecosystem.
