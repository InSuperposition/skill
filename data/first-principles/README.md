# First Principles Thinking Skill

A comprehensive AI skill providing expert guidance on first principles thinking methodology - breaking down complex problems into fundamental truths and building innovative solutions from the ground up.

## Overview

This skill transforms reasoning from **analogical** (copying what others do) to **foundational** (building from fundamental truths). It provides:

- **Three Operational Modes**: Guide (explanatory), Facilitator (interactive), Integration (domain-specific)
- **Comprehensive Frameworks**: Socratic Method, 5 Whys, Cartesian Doubt, Feynman Technique, Simple Made Easy
- **Systematic Methodology**: Deconstruction → Questioning → Reconstruction
- **Real-World Applications**: Technical, business, product, and system design examples
- **Domain Integration**: Designed to enhance any domain-specific skill

## Features

### Core Capabilities

- **🧠 Methodology Mastery** - Complete first principles thinking framework and process
- **❓ Questioning Frameworks** - Socratic, 5 Whys, Cartesian Doubt, Feynman Technique, Simple Made Easy
- **🔍 Problem Deconstruction** - Systematic breakdown into fundamental components
- **🏗️ Solution Reconstruction** - Building novel solutions from validated truths
- **💡 Real-World Examples** - Technical, business, and product case studies
- **🔗 Domain Integration** - Patterns for enhancing specialized skills
- **📋 Interactive Facilitation** - Guided problem-solving sessions
- **🎯 Decision Frameworks** - Systematic decision-making from first principles

### Operational Modes

**Guide Mode** (Advisory):

- Explains first principles methodology
- Recommends questioning strategies
- Teaches systematic approaches
- Provides conceptual clarity

**Facilitator Mode** (Interactive):

- Guides through structured problem-solving
- Challenges assumptions interactively
- Tracks reasoning chains
- Validates logical steps

**Integration Mode** (Domain-Specific):

- Applies FPT to specific domains
- Enhances technical/business skills
- Provides systematic analysis frameworks

## Requirements

**No external dependencies**

This is a pure methodology skill applicable to any domain:

- Software engineering
- Business strategy
- Product development
- System architecture
- Scientific problem-solving

## Installation

### Installing as a Claude Skill (Recommended)

Skills are automatically discovered by Claude Code when placed in the correct directory. Choose one option below:

#### Option A: Personal Installation (For Individual Use)

Install the skill for personal use across all your projects:

```bash
# Create skills directory if it doesn't exist
mkdir -p ~/.claude/skills

# Clone the repository
cd ~/.claude/skills
git clone <repository-url> skill-first-principles-thinking
```

#### Option B: Project Installation (For Team Sharing)

Install the skill for a specific project and share it with your team via git:

**Standard Installation:**

```bash
# Create project skills directory if it doesn't exist
mkdir -p .claude/skills

# Clone the repository
cd .claude/skills
git clone <repository-url> skill-first-principles-thinking

# Optionally checkout a specific version tag
cd skill-first-principles-thinking
git checkout v1.0.0  # Use specific version

# Commit to share with your team
cd ../..
git add .claude/skills/skill-first-principles-thinking
git commit -m "Add first principles thinking skill"
git push
```

**As a Git Submodule (Recommended for Projects):**

Using submodules allows your team to track specific versions and manage updates more easily:

```bash
# Add as submodule at specific version
git submodule add <repository-url> .claude/skills/skill-first-principles-thinking
cd .claude/skills/skill-first-principles-thinking
git checkout v1.0.0  # Pin to specific version
cd ../../..
git add .gitmodules .claude/skills/skill-first-principles-thinking
git commit -m "Add first principles thinking skill as submodule at v1.0.0"
git push

# Team members clone with submodules
git clone --recurse-submodules <your-project-url>

# Or initialize submodules after cloning
git submodule update --init --recursive

# Update to a newer version later
cd .claude/skills/skill-first-principles-thinking
git fetch --tags
git checkout v1.1.0  # Update to newer version
cd ../../..
git add .claude/skills/skill-first-principles-thinking
git commit -m "Update first principles thinking skill to v1.1.0"
git push
```

**How It Works:**

- Skills are **automatically discovered** - no installation command needed
- Claude decides when to invoke skills based on your request and the skill's description
- Personal skills (`~/.claude/skills/`) are available across all projects
- Project skills (`.claude/skills/`) are shared with your team via git

### Alternative: Direct Repository Access

For development or testing, work directly in the skill repository:

```bash
cd /Users/tensor/code/skill
git clone <repository-url> skill-first-principles-thinking
cd skill-first-principles-thinking
```

The skill will be automatically discovered when working in this directory or its parent.

### Versioning

This skill uses semantic versioning with git tags. To use a specific version:

```bash
# View available versions
git ls-remote --tags <repository-url>

# Or after cloning
cd skill-first-principles-thinking
git tag -l

# Checkout a specific version
git checkout v1.0.0

# Always use the latest stable release
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
```

**Sparse Checkout (Minimal Download):**

Sparse checkout downloads only specified files while maintaining full version control capabilities. This is smaller than a full clone and fully functional (unlike bare repositories).

```bash
# Clone with sparse checkout (smallest functional option)
git clone --filter=blob:none --sparse <repository-url> skill-first-principles-thinking
cd skill-first-principles-thinking

# Only checkout essential skill directories
git sparse-checkout set SKILL.md spec/ frameworks/ examples/

# Checkout a specific version (works with sparse checkout)
git fetch --tags
git checkout v1.0.0

# Switch to a different tagged version anytime
git checkout v1.1.0

# Or checkout everything except large files/directories
git sparse-checkout set --no-cone '/*' '!.git' '!tests' '!docs/images'
```

**Switching versions with sparse checkout:**

```bash
# Fetch latest tags
git fetch --tags

# List available versions
git tag -l

# Switch to any version (sparse pattern is preserved)
git checkout v1.2.0

# Return to latest release
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))

# Adjust sparse pattern without changing version
git sparse-checkout set SKILL.md spec/ frameworks/
```

**Version Guidelines:**

- Use tagged versions for production projects (e.g., `v1.0.0`)
- Pin to specific versions in submodules for stability
- Check release notes before updating to new versions
- Use `main` branch only for development/testing
- Consider sparse checkout for reduced disk usage in CI/CD environments

### Verification

To verify the skill is available, ask Claude:

```txt
What skills are available?
```

## Quick Start

### Learning the Methodology

Ask conceptual questions:

```txt
"Explain first principles thinking"
"What's the difference between analogical and foundational reasoning?"
"When should I use first principles thinking?"
"Show me the step-by-step methodology"
```

### Solving a Problem

Request interactive facilitation:

```txt
"Help me apply first principles to [your problem]"
"Guide me through deconstructing this challenge"
"I need to make a decision about [topic] using first principles"
"Walk me through questioning my assumptions about [subject]"
```

### Studying Examples

Explore real-world applications:

```txt
"Show me a technical problem solved with first principles"
"How did SpaceX apply first principles to rocket costs?"
"Give me a business strategy example"
"Show system architecture designed from fundamentals"
```

### Integrating with Domain Skills

Learn integration patterns:

```txt
"How can I use this with software architecture?"
"Apply first principles to my product decisions"
"Integrate this methodology with security analysis"
"How does this enhance problem-solving in [domain]?"
```

## Documentation

### Main Documentation

- **[SKILL.md](SKILL.md)** - Skill definition and overview
- **[spec/](spec/)** - Detailed specifications (8 comprehensive guides)

### Specification Files

| File | Purpose |
|------|---------|
| **[GUIDE.md](spec/GUIDE.md)** | Conceptual explanations and advisory guidance |
| **[FACILITATOR.md](spec/FACILITATOR.md)** | Interactive problem-solving facilitation |
| **[INTEGRATION.md](spec/INTEGRATION.md)** | Domain integration patterns |
| **[METHODOLOGY.md](spec/METHODOLOGY.md)** | Core first principles thinking process |
| **[FRAMEWORKS.md](spec/FRAMEWORKS.md)** | Questioning frameworks and techniques |
| **[DECONSTRUCTION.md](spec/DECONSTRUCTION.md)** | Problem breakdown strategies |
| **[RECONSTRUCTION.md](spec/RECONSTRUCTION.md)** | Solution building from fundamentals |
| **[EXAMPLES.md](spec/EXAMPLES.md)** | Real-world case studies |
| **[REFERENCES.md](spec/REFERENCES.md)** | Documentation navigation |

### Framework Templates

All questioning frameworks live under `frameworks/`. See [spec/REFERENCES.md](spec/REFERENCES.md) for the canonical list and descriptions.

### Example Case Studies

- [Technical Examples](examples/technical/)
- [Business Examples](examples/business/)
- [Product Examples](examples/product/)

## Architecture

### Repository Structure

```sh
skill-first-principles-thinking/
├── SKILL.md                      # Main skill definition
├── README.md                     # This file
├── spec/                         # Detailed specifications
│   ├── GUIDE.md                 # Guide mode documentation
│   ├── FACILITATOR.md           # Facilitator mode documentation
│   ├── INTEGRATION.md           # Integration patterns
│   ├── METHODOLOGY.md           # Core methodology
│   ├── FRAMEWORKS.md            # Questioning frameworks
│   ├── DECONSTRUCTION.md        # Problem breakdown
│   ├── RECONSTRUCTION.md        # Solution building
│   ├── EXAMPLES.md              # Case study index
│   └── REFERENCES.md            # Documentation map
├── frameworks/                   # Framework templates
│   ├── socratic-method.md
│   ├── five-whys.md
│   ├── cartesian-doubt.md
│   ├── feynman-technique.md
│   └── simple-made-easy.md
└── examples/                     # Detailed case studies
    ├── technical/
    │   ├── rocket-costs.md
    │   ├── battery-technology.md
    │   ├── software-architecture.md
    │   └── performance-optimization.md
    ├── business/
    │   ├── meeting-culture.md
    │   ├── pricing-strategy.md
    │   └── market-entry.md
    └── product/
        ├── feature-decisions.md
        ├── user-experience.md
        └── platform-design.md
```

## Usage Patterns

### Pattern 1: Learning the Methodology

```txt
User: "I want to understand first principles thinking"

Skill (Guide Mode):
- Explains core concepts
- Distinguishes from analogical reasoning
- Provides simple examples
- Links to detailed methodology
```

### Pattern 2: Interactive Problem-Solving

```txt
User: "Our API is slow, help me think through this from first principles"

Skill (Facilitator Mode):
1. Clarify the problem definition
2. Guide through deconstruction
3. Question assumptions systematically
4. Help identify fundamental truths
5. Facilitate reconstruction of solutions
6. Validate logical consistency
```

### Pattern 3: Domain Integration

```txt
User: "I'm designing a system, use first principles with architecture patterns"

Skill (Integration Mode):
- Applies FPT to architecture decisions
- Questions inherited design patterns
- Validates actual requirements
- Combines with domain expertise
- Provides systematic framework
```

## Examples

### Technical Problem-Solving

```txt
"Why is deployment taking 45 minutes? Let's apply first principles"
"Design authentication system from fundamental requirements"
"Optimize database queries starting from what we know is true"
```

### Business Strategy

```txt
"Should we enter this market? Use first principles"
"Rethink our pricing from fundamental value proposition"
"Challenge our meeting culture from first principles"
```

### Product Development

```txt
"Do we need this feature? Reason from user problems"
"Design the UX from fundamental user goals"
"Build platform architecture from actual use cases"
```

## Integration with Other Skills

This skill is designed to enhance domain-specific skills:

- **Software Skills**: Apply to architecture, performance, security
- **Business Skills**: Enhance strategy, operations, decision-making
- **Product Skills**: Strengthen feature decisions, UX design
- **Technical Skills**: Improve system design, problem-solving
- **Agent Skills**: Provide systematic reasoning framework

See [INTEGRATION.md](spec/INTEGRATION.md) for detailed patterns.

## Contributing

We welcome contributions! Here's how:

### Reporting Issues

- Provide clear problem description
- Include context and domain
- Describe expected vs actual guidance
- Suggest improvements

### Submitting Changes

1. Fork the repository
2. Create feature branch: `git checkout -b feature/your-addition`
3. Follow documentation patterns from existing files
4. Add examples where applicable
5. Update REFERENCES.md if adding new files
6. Commit with clear messages
7. Create pull request

### Adding Examples

We especially welcome real-world case studies:

1. Create file in appropriate `examples/` subdirectory
2. Follow the case study template
3. Include problem, deconstruction, reconstruction
4. Show actual outcomes
5. Add to [EXAMPLES.md](spec/EXAMPLES.md) index

### Documentation Standards

- Use clear, simple language
- Provide concrete examples
- Link related concepts
- Follow existing file structure
- Add "See Also" sections

## Philosophy

This skill embodies first principles thinking in its design:

1. **Starts from fundamentals** - Methodology built from core concepts
2. **Questions conventions** - Challenges typical problem-solving approaches
3. **Modular components** - Atomic documentation pieces
4. **Systematic structure** - Logical organization from basics to advanced
5. **Practical application** - Every concept tied to real-world use

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [spec/REFERENCES.md](spec/REFERENCES.md)
- **Issues**: Report via your repository's issue tracker
- **Discussions**: Use repository discussions for methodology questions

## Acknowledgments

- Inspired by innovators who exemplify first principles thinking (Elon Musk, Richard Feynman, Charlie Munger)
- Based on classical philosophical methods (Socratic questioning, Cartesian methodology)
- Designed for integration with Claude Agent SDK and skills ecosystem

---

**Start thinking from first principles. Question everything. Build from what you know is true.**
