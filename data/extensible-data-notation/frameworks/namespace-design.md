# Namespace Design Framework

Consistent namespaces make EDN schemas self-documenting and prevent collisions. Use this guide to design namespaces intentionally.

## Principles

1. **Meaningful Boundaries** — Map namespaces to bounded contexts or subsystems.
2. **Predictability** — Follow a repeatable pattern (`:domain/entity-attribute`).
3. **Scalability** — Support growth without renaming existing keys.
4. **Interoperability** — Avoid reserved prefixes unless necessary (`clojure.*`).

## Naming Strategies

| Strategy | Pattern | Use When |
|----------|---------|----------|
| Reverse DNS | `:com.acme/user/name` | Company-wide schemas, public APIs |
| Domain-Centric | `:order/id`, `:payment/amount` | Internal projects with clear bounded contexts |
| Layered | `:app.config/db/url` | Configuration files that mirror folder structures |

## Process

1. **Inventory Domains** — List high-level areas (user, billing, infra).
2. **Assign Prefixes** — Choose short, memorable namespace stems (`:user/`, `:billing/`).
3. **Document Examples** — Provide sample keywords for each namespace.
4. **Reserve Future Space** — Keep some prefixes unused for future modules.
5. **Align Tagged Literals** — Use the same namespace stems for tags (`#billing/money`).

## Common Patterns

- `:entity/id` — Unique identifier (often `#uuid`).
- `:entity/type` — Qualified keyword describing entity type.
- `:entity/status` — Use keywords or sets for states.
- `:context/meta` — Metadata maps scoped per namespace.
- `#namespace/tag` — Pair tags with namespaces for discoverability.

## Anti-Patterns

- Mixing unrelated concepts in the same namespace.
- Using generic prefixes like `:data/` everywhere.
- Embedding version numbers directly in namespaces (use dedicated field instead).
- Copying JSON camelCase naming into EDN keywords.

## Checklist

- [ ] Each namespace has a short description.
- [ ] Keywords are lower-case, hyphen-separated.
- [ ] Namespaces align with ownership boundaries.
- [ ] Tags share namespace semantics.
- [ ] Documented in schema file or README.

## References

- `spec/DESIGN.md#namespace-conventions`
- `examples/domain-modeling/user-management.md`
- `reference/tagged-literal-registry.md`
