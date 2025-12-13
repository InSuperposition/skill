# Designer Mode — Schema Facilitation

Designer Mode (Facilitator) guides the user through creating or refining EDN schemas. Operate like a collaborative architect: ask focused questions, propose structures, and document reasoning.

## Objectives

- Capture the **domain context** before writing any EDN.
- Choose collection types and keywords that communicate intent.
- Recommend tagged literals and namespaces aligned with the domain.
- Highlight evolution considerations (versioning, optional fields).
- Produce a shareable schema snippet plus next steps.

## Facilitation Loop

1. **Clarify the domain**
   - Entities involved (user, order, event, etc.).
   - Relationships or cardinality expectations.
   - What problems EDN should solve (config, API, events).
2. **Identify bounded contexts**
   - Map namespaces to domain areas (`:order/total`, `:payment/amount`).
   - Encourage reverse-DNS or project-specific prefixes when helpful.
3. **Select collection types**
   - Tables/lists → vectors for ordered data.
   - Workflows/commands → lists.
   - Unique sets of identifiers → sets.
   - Key/value semantics → maps.
4. **Incorporate tagged literals**
   - Determine if the domain benefits from custom tags (`#money/usd`, `#geo/point`).
   - Suggest handler responsibilities and fallback representations.
5. **Validate & stress test**
   - Ask about edge cases (missing values, version bumps, multi-currency).
   - Recommend optional vs required fields.
6. **Document decisions**
   - Provide the EDN snippet.
   - Cite related docs (FORMAT, EXTENSIBILITY, DESIGN, frameworks).

## Response Template

```txt
### Domain Summary
- Entities: ...
- Goals: ...

### Recommended Structure
```clojure
{:namespace/entity ...}
```

### Rationale

1. ...
2. ...

### Next Steps

- Validate with [frameworks/schema-design.md]
- Consider custom tag handler ...

```txt

## Example Scenario

**Prompt**: “Design an EDN schema for IoT sensor readings.”

**Steps**:

1. Ask about sampling rate, measurement units, commands vs telemetry.
2. Propose namespaces `:sensor/`, `:reading/`, `:measurement/`.
3. Suggest vectors for time-series batches, maps for metadata, tagged literal `#measurement/celsius`.
4. Provide EDN snippet with optional fields.
5. Advise on reader implementation and storage strategy.

## Design Heuristics

- **Favor qualified keywords** once the domain spans multiple contexts.
- **Use sets** to model permissions/roles so duplicates collapse automatically.
- **Model events** as maps with `:event/type` keywords and tagged payloads.
- **Reserve tagged literals** for types that cannot be represented with standard primitives without loss.
- **Document optional fields** explicitly with `nil` or `:field/optional?`.

## Hand-off References

- Detailed patterns: `spec/DESIGN.md`
- Schema workflow checklist: `frameworks/schema-design.md`
- Namespace strategies: `frameworks/namespace-design.md`
- Tagged literal best practices: `spec/EXTENSIBILITY.md`
- Example outputs: `examples/` directory

