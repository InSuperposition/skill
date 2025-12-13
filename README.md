# Claude Code Skills Collection

A personal collection of specialized AI skills for Claude Code, designed to
enhance Claude's capabilities across different domains and methodologies.

## What Are Skills?

Skills are specialized knowledge packages that extend Claude Code's
capabilities in specific domains. Each skill provides:

- **Domain Expertise**: Deep knowledge in a specific area (Git workflows,
  EDN format, thinking methodologies)
- **Operational Modes**: Different modes of operation (Guide, Worker,
  Facilitator, etc.)
- **Structured Knowledge**: Organized specifications, frameworks, and examples
- **Tool Integration**: Controlled access to specific tools for safe operation

For more information about Claude Code skills, see the
[official documentation](https://docs.anthropic.com/en/docs/claude-code).

## Available Skills

| Skill | Documentation | Description |
| ----- | ----------- | ------------- |
| **extensible-data-notation** | [SKILL.md](data/extensible-data-notation/SKILL.md) • [README.md](data/extensible-data-notation/README.md) | Expert guide for Extensible Data Notation (EDN) format. Covers syntax, schema design, and implementation across multiple languages. |
| **first-principles** | [SKILL.md](data/first-principles/SKILL.md) • [README.md](data/first-principles/README.md) | Expert guide for first principles thinking methodology. Helps break down complex problems into fundamental truths and build innovative solutions. |
| **git** | [SKILL.md](data/git/SKILL.md) • [README.md](data/git/README.md) | Expert Git workflow assistant with dual modes (Guide/Worker). Master of worktrees, submodules, and modern Git features with safety-first operations. |

## Installation & Usage

### Installing Skills

Skills in this collection are managed through the
`.claude-plugin/marketplace.json` registry. To use these skills with
Claude Code:

1. Clone this repository:

   ```bash
   git clone https://github.com/InSuperposition/skill.git
   cd skill
   ```

2. Skills are automatically available through the plugin marketplace registry

### Using Skills

Invoke skills in your Claude Code sessions using the skill invocation
syntax:

```bash
# Example: Using the first-principles skill
claude skill first-principles

# Example: Using the git skill
claude skill git
```

Each skill has its own README.md with detailed usage instructions, examples,
and operational modes.

## Repository Structure

```sh
skill/
├── .claude-plugin/
│   └── marketplace.json      # Plugin registry with skill definitions
├── data/
│   ├── first-principles/     # First principles thinking skill
│   │   ├── SKILL.md         # Skill definition
│   │   ├── README.md        # Usage guide
│   │   ├── spec/            # Specification documents
│   │   ├── frameworks/      # Thinking frameworks
│   │   └── examples/        # Case studies
│   ├── git/                  # Git workflow skill
│   │   ├── SKILL.md
│   │   ├── README.md
│   │   ├── spec/
│   │   ├── scripts/         # Utility scripts
│   │   └── submodules/      # Git repo for version-aware docs
│   └── extensible-data-notation/  # EDN format skill
│       ├── SKILL.md
│       ├── README.md
│       ├── spec/
│       ├── frameworks/
│       ├── examples/
│       └── reference/
└── README.md                 # This file
```

Each skill follows a consistent structure:

- **SKILL.md**: Technical skill definition with allowed tools and modes
- **README.md**: User-facing documentation with installation and usage
- **spec/**: Detailed specification documents (9-12 per skill)
- **frameworks/**: Practical templates and patterns
- **examples/**: Real-world case studies organized by domain

## Development

This is a personal collection of curated AI skills. Each skill is
self-contained and can be used independently.

### Adding New Skills

To add a new skill to this collection:

1. Create a new directory in `data/{skill-name}/`
2. Follow the established structure (SKILL.md, README.md, spec/, etc.)
3. Add an entry to `.claude-plugin/marketplace.json`
4. Document the skill's purpose, modes, and allowed tools

## License

See individual skill directories for specific licensing information.

## Contact

**Owner**: Forrest Galloway
**Email**: <f.galloway@gmail.com>
**Repository**: <https://github.com/InSuperposition/skill>
