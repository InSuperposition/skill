# Reference Map & Learning Paths

This document helps users and contributors navigate the EDN skill. Use it to chart study plans, quickly locate documents, or onboard teammates.

## Learning Paths

### 1. Format Fundamentals (2 hours)

1. `spec/FORMAT.md` — Read top to bottom, run through examples.
2. `spec/COMPARISON.md` — Understand when to apply EDN.
3. `spec/EXTENSIBILITY.md` — Skim tagged literal sections.
4. Practice with `examples/configuration/app-config.md`.

### 2. Schema Designer (half day)

1. Review `spec/DESIGN.md`.
2. Study `frameworks/schema-design.md` + `frameworks/namespace-design.md`.
3. Walk through `examples/domain-modeling/user-management.md`.
4. Use `spec/FACILITATOR.md` guidelines when collaborating.

### 3. Implementation Engineer (half day)

1. Read `spec/LIBRARIES.md` and `spec/INTEGRATION.md`.
2. Follow `frameworks/reader-implementation.md` to register custom tags.
3. Complete exercises in `examples/data-interchange/api-contracts.md`.
4. Reference `frameworks/migration-guide.md` for JSON/YAML conversions.

## Document Catalog

| Area | Purpose | Files |
|------|---------|-------|
| Overview | High-level description | `README.md`, `SKILL.md` |
| Format & Semantics | Core language of EDN | `spec/FORMAT.md`, `spec/COMPARISON.md` |
| Extensibility | Tagged literals, namespaces | `spec/EXTENSIBILITY.md`, `reference/tagged-literal-registry.md` |
| Operational Modes | Interaction styles | `spec/GUIDE.md`, `spec/FACILITATOR.md`, `spec/INTEGRATION.md` |
| Design Patterns | Schema architecture | `spec/DESIGN.md`, `frameworks/*.md` |
| Examples | Real-world validation | `spec/EXAMPLES.md`, `examples/` |

## Cross-References

- When discussing **collection selection**, cite `spec/DESIGN.md#collection-selection`.
- When advising on **namespaces**, cite `frameworks/namespace-design.md`.
- When describing **custom tags**, cite both `spec/EXTENSIBILITY.md` and `reference/tagged-literal-registry.md`.
- For **migration** tips, cite `frameworks/migration-guide.md`.

## Terminology

- **Qualified Keyword** — Keyword with namespace prefix (e.g., `:order/id`).
- **Tagged Literal** — `#namespace/tag value`, interpreted by registered reader.
- **Namespace** — Logical grouping of keywords or tags.
- **Facilitator** — Designer Mode persona guiding schema creation.

## Contributor Checklist

1. Update relevant spec/framework/example when introducing new concepts.
2. Ensure README + SKILL references point to real files.
3. Maintain ASCII encoding and consistent Markdown headings.
4. Add yourself to example metadata if needed.

## External References

- EDN Spec: https://github.com/edn-format/edn
- Clojure Docs: https://clojure.org/reference/reader
- Community tags: https://github.com/edn-format/edn/wiki/Tagged-Literals
