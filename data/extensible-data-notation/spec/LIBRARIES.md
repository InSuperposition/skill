# EDN Libraries & Tooling

Guide to practical EDN libraries across major languages, including strengths, limitations, and ecosystem tips.

## Selection Criteria

- **Specification Fidelity** — supports full EDN grammar (keywords, sets, tagged literals).
- **Extensibility** — ability to register custom tag handlers.
- **Maintenance** — active releases or community adoption.
- **Interoperability** — serialization back to EDN, not just parsing.

## Clojure / ClojureScript

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `clojure.edn` (stdlib) | Parsing EDN safely | Default reader, allows custom `:readers`. No writer (use `pr-str`). |
| `cheshire` | JSON ↔ EDN interop | Primarily JSON but integrates with EDN workflows. |
| `cljs.reader` | ClojureScript environments | Mirrors `clojure.edn` semantics. Custom readers via `*tag-table*`. |

**Tip**: Avoid `read-string` for untrusted input; use `edn/read`. Register custom readers as maps of symbol → fn.

## Java

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `org.clojure/data.edn` | Pure Java EDN parsing | Official library. Supports tagged literals via `ReadHandler`. |
| `edn-java` | Lightweight parser | Simple API, good for embedding. |

**Tip**: For Spring or Jakarta EE apps, wrap EDN parsing in services that convert to domain POJOs.

## JavaScript / TypeScript

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `jsedn` | Full parser/writer | Mature, supports custom tags with `setTagAction`. Node + browser. |
| `edn-data` | Lightweight parser | ES modules, smaller footprint. |
| `jsedn-tagged` | Tagged literal helpers | Convenience wrappers for custom tags. |

**Tip**: Register tag handlers once per process to avoid repeated work. Convert keywords to strings or symbol wrappers depending on your app.

## Python

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `edn_format` | Parse/write EDN | pip install. Supports custom tags via hooks. |
| `pyedn` | Alternative parser | Focus on speed, fewer features. |

**Tip**: For data science pipelines, convert EDN maps to native dicts, then to pandas DataFrames as needed. Use Decimal for money values.

## Ruby

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `edn-ruby` | Parse EDN | Supports custom readers via `EDN.register_tagged_element`. |
| `clj-edn` | Minimal parser | Good for simple config ingestion. |

**Tip**: Convert EDN keywords to `EDN::Types::Keyword` or plain symbols, depending on framework compatibility.

## Rust

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `edn-rs` | Parser/serializer | Serde integration, custom tags via visitor pattern. |
| `serde_edn` | Serde data format | Serialize Rust structs directly to EDN. |

**Tip**: Use `serde` derive macros to map EDN maps to strongly typed structs; define newtypes for tagged literals.

## Go

| Library | Use Cases | Notes |
|---------|-----------|-------|
| `github.com/edn-go/edn` | Parse/write EDN | Idiomatic Go API, custom tags via `RegisterTag`. |
| `goglia/edn` | Lightweight reader | Good for configs. |

**Tip**: Convert EDN keywords to `edn.Keyword` for round-tripping; map to struct tags via `edn:"user/name"`.

## Tooling Ecosystem

- **Validation**: `clojure.spec`, `malli`, or custom validators built atop EDN data.
- **Formatting**: `zprint`, `cljfmt` handle EDN formatting as well.
- **Conversion**: `jet` (Clojure) and `ruplacer` combos for mass migration.
- **Editors**: Most Clojure/ClojureScript IDE plugins offer EDN syntax highlighting.

## Choosing a Library

1. Start with the **native implementation** (Clojure `clojure.edn`, JS `jsedn`, etc.).
2. Evaluate **tag support**—critical if you rely on custom literals.
3. Consider **serialization** needs; not all parsers can write EDN.
4. Verify **streaming** support if ingesting large payloads.
5. Confirm **license compatibility** for your project.

## References

- Implementation guidance: `spec/INTEGRATION.md`
- Custom reader recipes: `frameworks/reader-implementation.md`
- Migration steps: `frameworks/migration-guide.md`
