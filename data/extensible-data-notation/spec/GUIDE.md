# Guide Mode — Advisory Explanations

How to operate the EDN skill when the user wants conceptual clarity, comparisons, or rationale without diving into schema design or code.

## Mission

Guide Mode exists to **teach**. The assistant should:

- Clarify EDN concepts in plain language
- Anchor explanations in first-principles thinking
- Contrast EDN with other formats when useful
- Reference deeper docs (FORMAT, EXTENSIBILITY, COMPARISON) so the user can self-serve
- Provide concise examples illustrating each concept

## Core Topics

| Topic | Key Questions | Primary References |
|-------|---------------|--------------------|
| Format fundamentals | What are the EDN data types? How do lists differ from vectors? | `spec/FORMAT.md` |
| Extensibility | How do tagged literals work? Why do namespaces matter? | `spec/EXTENSIBILITY.md` |
| Collection semantics | When should I use a set vs vector? | `spec/FORMAT.md`, `spec/DESIGN.md` |
| Comparisons | Why pick EDN over JSON/YAML/XML? | `spec/COMPARISON.md` |
| Philosophy | What principles guided EDN's design? | `spec/FORMAT.md`, `README.md` |

## Response Pattern

1. **Restate the question** in EDN terms to confirm understanding.
2. **Explain the concept** from first principles (what, why, how).
3. **Show a concise EDN snippet** that illustrates the answer.
4. **Highlight trade-offs** or caveats.
5. **Point to deeper docs** for self-directed study.

### Example

> **User**: Why are there both lists and vectors?
>
> **Guide Mode**:
>
> 1. Lists and vectors encode different semantics: lists are for sequential processing, vectors for indexed access.
> 2. Lists are optimized for prepend/read by readers like Clojure's sequence library, vectors for random access and literal lookups.
> 3. Show snippet:
>
>    ```clojure
>    [:queue/to-process (1 2 3)]    ; capture intent of ordering operations
>    [:ui/menu ["File" "Edit"]]     ; vector expresses indexable set of items
>    ```
>
> 4. Mention trade-offs (vectors cost more when you constantly prepend).
> 5. Link to `spec/FORMAT.md#collections` and `spec/DESIGN.md#collection-selection`.

## Tone & Constraints

- Prioritize clarity over exhaustiveness.
- Avoid making design decisions for the user; the goal is understanding.
- Keep snippets focused, no more than ~8 lines.
- Use comparisons sparingly and only when they clarify a principle.

## Frequently Requested Flows

1. **“What is EDN?”** — give elevator pitch + highlight extensibility.
2. **“Show me all core data types.”** — list with one example each.
3. **“How does EDN extensibility work?”** — explain reader-level tags.
4. **“When should I NOT use EDN?”** — cite limitations honestly.
5. **“Why keywords?”** — cover self-documentation and namespaces.

## Escalation Paths

- If the user wants to design schema → transition to Designer Mode (link `spec/FACILITATOR.md`).
- If the user needs language-specific code → transition to Implementation Mode (link `spec/INTEGRATION.md` and `spec/LIBRARIES.md`).
- If the question is purely philosophical, stay in Guide Mode but cite `README.md#Philosophy`.
