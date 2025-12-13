# JSON/YAML → EDN Migration Guide

Step-by-step approach for moving existing payloads or configurations to EDN while preserving semantics.

## 1. Inventory & Prioritize

- List files/endpoints/configs that will move to EDN.
- Rank by impact vs complexity.
- Decide if migration is big-bang or incremental.

## 2. Analyze Current Schema

- Identify implicit semantics (timestamps encoded as strings, enums, sentinel values).
- Note data cleanliness issues (duplicate roles, inconsistent casing).
- Capture validation rules currently enforced in code.

## 3. Design EDN Target

- Map JSON/YAML keys to EDN keywords.
- Assign namespaces per domain.
- Choose collection types intentionally (sets for unique data, lists for sequences).
- Decide where tagged literals add clarity (`#inst`, `#uuid`, custom tags).

## 4. Build Conversion Pipeline

1. Parse source data into host language objects.
2. Transform keys/values:
   - CamelCase → kebab-case keywords.
   - Strings → keywords when representing enums.
   - Strings representing dates/money → tagged literals.
3. Serialize to EDN (Clojure `pr-str`, JS `jsedn.toString`, etc.).

## 5. Validate & Iterate

- Use `clojure.spec`, `malli`, or tests to ensure converted EDN matches expectations.
- Diff original vs converted structures to confirm parity.
- Run sample consumers against new EDN data.

## 6. Dual-Format Strategy (Optional)

- For gradual rollout, produce both JSON and EDN for a period.
- Document toggle or configuration that selects the format.
- Ensure consumers can fall back gracefully.

## Pitfalls to Avoid

- Forgetting to convert sentinel values (e.g., `"NONE"` to `nil` or empty sets).
- Using tagged literals without implementing readers in all consuming systems.
- Mixing camelCase and kebab-case keywords.
- Leaving JSON-specific conventions (like stringified booleans) in EDN output.

## Checklist

- [ ] Namespaces assigned per bounded context.
- [ ] Tagged literals registered in each consumer.
- [ ] Tests cover round-trip serialization.
- [ ] Documentation updated (README, examples, references).

## References

- Schema planning: `frameworks/schema-design.md`
- Namespace guidance: `frameworks/namespace-design.md`
- Reader implementation: `frameworks/reader-implementation.md`
- Case studies: `examples/configuration/*`, `examples/data-interchange/*`
