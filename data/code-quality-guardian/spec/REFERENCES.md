# Code Quality Guardian - Documentation Reference Guide

Complete navigation and reference guide for the Code Quality Guardian skill documentation.

## Quick Navigation

| File | Purpose | Lines | Priority |
|------|---------|-------|----------|
| [SKILL.md](../SKILL.md) | Complete skill specification | 938 | Essential |
| [README.md](../README.md) | Quick start and installation | ~300 | Start Here |
| [REVIEWER.md](REVIEWER.md) | Code review operational mode | ~450 | High |
| [GUARDIAN.md](GUARDIAN.md) | Prevention and standards enforcement | ~450 | High |
| [MENTOR.md](MENTOR.md) | Educational and mentorship mode | ~400 | Medium |
| [AUDITOR.md](AUDITOR.md) | Comprehensive assessment mode | ~450 | High |
| [REFERENCES.md](REFERENCES.md) | This file - navigation guide | ~250 | Reference |

## Documentation by Operational Mode

### Reviewer Mode - Interactive Code Review
**File**: [REVIEWER.md](REVIEWER.md)

**When to Use**:
- Pull request reviews
- Manual code reviews before merge
- Spot-checking code quality
- Security vulnerability identification
- Performance issue detection

**Key Topics**:
- Review workflow and process
- Severity levels (Critical, High, Medium, Low)
- Output formats and reports
- Integration with git skill for context
- Example reviews (security, performance, maintainability)

### Guardian Mode - Automated Quality Enforcement
**File**: [GUARDIAN.md](GUARDIAN.md)

**When to Use**:
- Setting up quality gates
- CI/CD integration
- Pre-commit hooks
- Automated linting and checks
- Preventing bad code from merging

**Key Topics**:
- Quality gate configuration
- Linting rules and static analysis
- Pre-commit and CI/CD integration
- Automated vs. manual checks
- Tool recommendations (ESLint, Pylint, etc.)

### Mentor Mode - Educational Guidance
**File**: [MENTOR.md](MENTOR.md)

**When to Use**:
- Teaching best practices
- Explaining anti-patterns
- Code review education
- Team onboarding
- Constructive feedback delivery

**Key Topics**:
- Teaching approach and philosophy
- Constructive feedback techniques
- Explaining "why" not just "what"
- Growth mindset and learning
- Example mentorship scenarios

### Auditor Mode - Comprehensive Assessment
**File**: [AUDITOR.md](AUDITOR.md)

**When to Use**:
- Technical debt assessment
- Codebase health audits
- Legacy code evaluation
- Architecture reviews
- Compliance and security audits

**Key Topics**:
- Audit methodology
- Quality metrics and reporting
- Technical debt identification
- Git skill integration for hotspots
- Prioritization frameworks

## Documentation by Quality Dimension

**Note**: Phase 2 quality dimension files are planned but not yet created. These will include:
- REFACTOR.md - Code improvement and refactoring strategies
- SECURITY.md - Security vulnerability assessment (OWASP Top 10, CWE)
- PERFORMANCE.md - Performance optimization and algorithmic analysis
- CORRECTNESS.md - Logic validation and bug detection
- MAINTAINABILITY.md - Code clarity and simplicity assessment
- TESTABILITY.md - Test coverage and quality evaluation
- ARCHITECTURE.md - Design patterns and architectural review
- TECHNICAL-DEBT.md - Debt management and paydown strategies

## Quick Reference by Use Case

### "I need to review a pull request"
1. Start: [REVIEWER.md](REVIEWER.md) - Review workflow
2. See also: [SKILL.md](../SKILL.md#reviewer-mode-code-review) - Mode specification
3. Integration: Use git skill for context, first-principles for logic verification

### "I want to set up automated quality checks"
1. Start: [GUARDIAN.md](GUARDIAN.md) - Quality gates and CI/CD
2. See also: [SKILL.md](../SKILL.md#guardian-mode-prevention--standards) - Mode specification
3. Tools: Linting rules, pre-commit hooks, static analysis

### "I need to explain best practices to my team"
1. Start: [MENTOR.md](MENTOR.md) - Teaching approach
2. See also: [SKILL.md](../SKILL.md#mentor-mode-education--guidance) - Mode specification
3. Integration: Use simplicity skill for complexity explanation

### "I want to assess our technical debt"
1. Start: [AUDITOR.md](AUDITOR.md) - Audit methodology
2. See also: [SKILL.md](../SKILL.md#auditor-mode-comprehensive-assessment) - Mode specification
3. Integration: Use git skill for hotspot analysis, churn detection

### "How do I identify security vulnerabilities?"
1. Start: [REVIEWER.md](REVIEWER.md#security-review) - Security review process
2. See also: [SKILL.md](../SKILL.md#2-security-assessment) - OWASP Top 10 coverage
3. Future: SECURITY.md (Phase 2) - Comprehensive security assessment

### "Our code is slow, how do I find bottlenecks?"
1. Start: [REVIEWER.md](REVIEWER.md#performance-review) - Performance review
2. See also: [SKILL.md](../SKILL.md#3-performance-analysis) - Performance dimensions
3. Future: PERFORMANCE.md (Phase 2) - Detailed optimization strategies

## Learning Paths

### For Beginners (New to Code Review)
1. Read [README.md](../README.md) - Understand what the skill provides
2. Review [SKILL.md](../SKILL.md) - Complete capability overview
3. Start with [REVIEWER.md](REVIEWER.md) - Learn basic review workflow
4. Practice with [MENTOR.md](MENTOR.md) - Understand constructive feedback
5. Explore examples in each mode file

### For Practitioners (Regular Code Review)
1. Quick scan [REFERENCES.md](REFERENCES.md) - This file for navigation
2. Deep dive [REVIEWER.md](REVIEWER.md) - Advanced review techniques
3. Set up [GUARDIAN.md](GUARDIAN.md) - Automate quality checks
4. Reference specific quality dimensions as needed

### For Teams (Establishing Quality Culture)
1. Leadership reads [AUDITOR.md](AUDITOR.md) - Understand assessment approach
2. Team leads read [MENTOR.md](MENTOR.md) - Learn teaching techniques
3. Set up automated checks with [GUARDIAN.md](GUARDIAN.md)
4. Standardize review process with [REVIEWER.md](REVIEWER.md)
5. Regular audits using [AUDITOR.md](AUDITOR.md) methodology

## Integration with Other Skills

### First-Principles Thinking
- **Logic Correctness**: Use first-principles to verify logic from fundamental truths
- **Root Cause Analysis**: Break down bugs to their fundamental causes
- **Challenge Assumptions**: Question why code is written a certain way
- **See**: [REVIEWER.md](REVIEWER.md#integration-with-other-skills)

### Simplicity Principles
- **Complexity Assessment**: Evaluate code complexity objectively
- **Over-Engineering Detection**: Identify unnecessary complexity
- **Simplification Strategies**: Reduce accidental complexity
- **See**: [MENTOR.md](MENTOR.md#integration-with-other-skills)

### Git Skill
- **Hotspot Analysis**: Identify frequently changing code
- **Code Evolution**: Understand how code has changed over time
- **Contributor Patterns**: See who owns what code
- **Change Coupling**: Find files that change together
- **See**: [AUDITOR.md](AUDITOR.md#git-skill-integration)

### Tech Stack Advisor
- **Technology Standards**: Language and framework-specific best practices
- **Tool Recommendations**: Linting, static analysis, security scanning
- **Dependency Analysis**: Security vulnerabilities in dependencies
- **See**: [GUARDIAN.md](GUARDIAN.md#integration-with-other-skills)

## Common Questions

### Q: Which mode should I use for daily code review?
**A**: [REVIEWER.md](REVIEWER.md) - Interactive code review mode for pull requests and manual reviews.

### Q: How do I prevent bad code from getting merged?
**A**: [GUARDIAN.md](GUARDIAN.md) - Set up quality gates, pre-commit hooks, and CI/CD checks.

### Q: How do I teach my team to write better code?
**A**: [MENTOR.md](MENTOR.md) - Educational mode with constructive feedback techniques.

### Q: How do I assess the health of our codebase?
**A**: [AUDITOR.md](AUDITOR.md) - Comprehensive audit methodology with git skill integration.

### Q: Where are the language-specific standards (Python, JavaScript, etc.)?
**A**: Language-specific standards will be a separate skill. The code-quality-guardian skill focuses on universal quality principles applicable across all languages.

### Q: Where are the detailed security/performance/architecture guides?
**A**: These are planned for Phase 2. Current Phase 1 files include overview sections, with detailed deep-dives coming in Phase 2 spec files (SECURITY.md, PERFORMANCE.md, ARCHITECTURE.md, etc.).

### Q: How do I use this skill with other skills?
**A**: Each mode file has an "Integration with Other Skills" section. Use first-principles for logic verification, simplicity for complexity assessment, git for code evolution analysis, and tech-stack-advisor for technology standards.

## File Format and Conventions

### Heading Hierarchy
- `#` - File title
- `##` - Major sections
- `###` - Subsections
- `####` - Detailed topics

### Link Format
- Internal links: `[FILENAME.md](FILENAME.md)`
- Section links: `[Section Name](FILENAME.md#section-anchor)`
- External links: `[Link Text](https://url)`

### Code Examples
- Use language-specific code blocks: ` ```python `, ` ```javascript `, etc.
- Include comments explaining key points
- Show before/after for refactoring examples

### Lists and Tables
- Bullet lists for features, capabilities, topics
- Numbered lists for sequential steps, workflows
- Tables for comparisons, references, metrics

## Maintenance and Updates

### Version History
- **v1.0.0** (2025-12-14): Phase 1 - Core operational modes
  - REVIEWER.md - Code review mode
  - GUARDIAN.md - Prevention and standards
  - MENTOR.md - Educational mode
  - AUDITOR.md - Assessment mode
  - REFERENCES.md - Navigation guide
  - README.md - Quick start

### Future Phases
- **Phase 2** (Pending): Quality dimension files
  - REFACTOR.md
  - SECURITY.md
  - PERFORMANCE.md
  - CORRECTNESS.md
  - MAINTAINABILITY.md
  - TESTABILITY.md
  - ARCHITECTURE.md
  - TECHNICAL-DEBT.md

### Feedback and Contributions
- Report issues or suggest improvements via git workflow
- Follow existing file structure and format
- Maintain concise, well-organized content
- Include concrete examples
- Cross-reference related files

## See Also

- [SKILL.md](../SKILL.md) - Complete skill specification
- [README.md](../README.md) - Quick start and installation
- [REVIEWER.md](REVIEWER.md) - Code review operational mode
- [GUARDIAN.md](GUARDIAN.md) - Prevention and standards enforcement
- [MENTOR.md](MENTOR.md) - Educational and mentorship mode
- [AUDITOR.md](AUDITOR.md) - Comprehensive assessment mode
