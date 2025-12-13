# EDN Case Study Index

Use this index to find real-world examples demonstrating EDN patterns across configuration, data interchange, and domain modeling.

## Structure

Each example follows the same structure:

1. **Problem Statement** — business context and pain with current format.
2. **Conventional Approach** — typical JSON/YAML solution and its limits.
3. **EDN Solution** — schema, tagged literals, namespaces.
4. **Implementation Steps** — how to apply it.
5. **Outcome & Lessons** — measurable benefits.

## Configuration Examples

| File | Focus | Highlights |
|------|-------|------------|
| `examples/configuration/app-config.md` | Application configuration with rich types | Shows `#inst` for scheduling, `#feature/flag` tags, environment overrides. |
| `examples/configuration/cloud-native.md` | Cloud-native config + secrets | Demonstrates encrypted tagged literals and namespace isolation for services. |

## Data Interchange Examples

| File | Focus | Highlights |
|------|-------|------------|
| `examples/data-interchange/api-contracts.md` | API request/response contracts | Uses qualified keywords for versioning, `#uuid` ids, and schema evolution tips. |
| `examples/data-interchange/event-sourcing.md` | Event stream payloads | Models events with namespaced keywords, set-based metadata, and tagged currency/time types. |

## Domain Modeling Examples

| File | Focus | Highlights |
|------|-------|------------|
| `examples/domain-modeling/user-management.md` | User + permissions domain | Qualified keywords per bounded context, tagged literal for hashed passwords, permission sets. |
| `examples/domain-modeling/financial-data.md` | Financial ledger entries | Tagged money/interest types, vector vs list discussion, precision maintenance. |

## How to Use These Examples

- Start with the **category closest to your domain**.
- Mirror the structure when adding your own examples to keep consistency.
- Cross-reference relevant specs (`spec/DESIGN.md`, `spec/EXTENSIBILITY.md`) as you adapt patterns.

## Contribution Guidelines

1. Place new examples in the appropriate subdirectory.
2. Follow the Problem → Conventional → EDN Solution → Implementation → Outcome → Lessons template.
3. Link back to supporting specs or frameworks.
4. Update this index with a one-line summary.
