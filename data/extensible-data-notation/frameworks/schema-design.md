# Schema Design Framework

Structured process for creating EDN schemas that communicate intent, evolve safely, and take advantage of extensibility.

## 1. Clarify Scope

- What domain/problem does the schema solve?
- Who produces/consumes the data?
- Requirements for versioning, validation, tooling.

Document answers before writing EDN.

## 2. Identify Entities & Contexts

- List entities (user, order, sensor, config).
- Define bounded contexts → namespace prefixes (`:user/`, `:order/`, etc.).
- Capture relationships (one-to-many, many-to-many).

## 3. Choose Collection Shapes

| Need | Recommended Collection |
|------|------------------------|
| Ordered list of items | Vector `[]` |
| Queue or lazy sequence | List `()` |
| Key/value attributes | Map `{}` |
| Unique membership | Set `#{}` |

Evaluate semantics, not just structure.

## 4. Define Keywords

- Use qualified keywords for clarity.
- Prefer consistent prefix ordering (`:domain/entity-attribute`).
- Reserve unqualified keywords for shared vocab.

## 5. Apply Tagged Literals

- Identify data that benefits from richer typing (timestamps, money, coordinates).
- Define tag namespace (e.g., `#money/usd`, `#geo/point`).
- Capture transformation expectations (reader outputs).
- Reference `reference/tagged-literal-registry.md` for common tags.

## 6. Model Optionality & Defaults

- Use `nil` for explicit absence.
- Provide default vectors/maps where helpful.
- Document optional keys via `:field/optional? true` or docstring.

## 7. Plan for Evolution

- Include `:entity/version` keyword for major schema versions.
- Prefer additive changes (new keys) over destructive ones.
- For breaking changes, introduce new namespace or tag.

## 8. Validate & Document

- Provide canonical EDN sample.
- Reference supporting specs (FORMAT, EXTENSIBILITY, DESIGN).
- List validation strategies (manual, spec, schema libraries).

## Template

```clojure
{:entity/version 1
 :entity/id #uuid "..."
 :entity/attributes {:domain/field "value"}
 :entity/timestamp #inst "..."
 :entity/tags #{:example/tag}}
```

## References

- Core guidance: `spec/DESIGN.md`
- Namespaces: `frameworks/namespace-design.md`
- Tagged literals: `spec/EXTENSIBILITY.md`
- Migration/evolution: `frameworks/migration-guide.md`
