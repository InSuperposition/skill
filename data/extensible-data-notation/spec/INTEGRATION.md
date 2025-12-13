# Implementation Mode — Integration & Code Assistance

Implementation Mode assists with concrete coding tasks: parsing, generating, validating, or migrating EDN in real systems.

## Scope

- Selecting and using EDN libraries per language
- Implementing custom tagged literal readers/writers
- Building pipelines that translate to/from EDN
- Migrating JSON/YAML payloads to EDN
- Debugging malformed EDN or reader issues

## Workflow

1. **Clarify the environment**
   - Target language/runtime
   - Deployment context (CLI tool, service, config pipeline)
   - Constraints (performance, library policy, licensing)
2. **Recommend tooling**
   - Pick library from `spec/LIBRARIES.md`
   - Note maturity, maintenance status, quirks
3. **Provide code**
   - Show minimal reproducible snippet
   - Explain reader/writer registration
   - Highlight error handling
4. **Address integration concerns**
   - Thread safety
   - Streaming vs in-memory parsing
   - Validation options (`clojure.spec`, malli, JSON Schema analogs)
5. **Outline next steps**
   - Tests to run
   - Additional docs

## Common Recipes

### Reading EDN (Clojure)

```clojure
(require '[clojure.edn :as edn])

(def custom-readers
  {'money/usd (fn [amount] {:currency :USD :amount (bigdec amount)})})

(defn load-config [path]
  (with-open [r (clojure.java.io/reader path)]
    (edn/read {:eof ::eof :readers custom-readers} r)))
```

### Reading EDN (JavaScript)

```javascript
import * as edn from 'jsedn';

edn.setTagAction(new edn.Tag('money', 'usd'), amount => ({
  currency: 'USD',
  amount
}));

const payload = edn.parse(ednString);
```

### Migrating JSON → EDN

1. Parse JSON as native data.
2. Decide which fields need richer semantics (timestamps, money, enums).
3. Map JSON keys to qualified keywords.
4. Inject tagged literals where EDN should capture richer types.
5. Serialize using EDN writer (Clojure: `pr-str`, JS: `jsedn.toString()`).

See `frameworks/migration-guide.md` for detailed steps and pitfalls.

## Troubleshooting Checklist

- **Unknown tag error** → Register reader or downgrade to fallback format.
- **Precision loss** → Use `bigdec`/`BigDecimal` or tagged decimals.
- **Keyword conflicts** → Review namespace design.
- **Performance issues** → Use streaming parsers and avoid repeated reader registration.

## References

- Library catalog: `spec/LIBRARIES.md`
- Reader implementations: `frameworks/reader-implementation.md`
- Tagged literal registry: `reference/tagged-literal-registry.md`
- Examples for context: `examples/`
