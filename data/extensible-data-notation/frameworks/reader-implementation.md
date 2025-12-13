# Custom Reader Implementation Framework

Use this guide when implementing tagged literal handlers or integrating EDN parsing into applications.

## Steps

1. **Define Tag Semantics**
   - What problem does the tag solve?
   - Input structure (scalar, map, collection)?
   - Output type (class, map, tuple)?
2. **Choose Representation**
   - Inline scalar (`#money/usd 99.99`)
   - Map payload (`#geo/point {:lat 0 :lon 0}`)
   - Nested structures (`#event/order {...}`)
3. **Implement Reader**
   - Register handler in language-specific way.
   - Ensure deterministic output (no side effects).
   - Support validation (throw helpful errors).
4. **Implement Writer (optional)**
   - Provide serialization for round-trip.
   - Document fallback when writer unavailable.
5. **Test**
   - Cover valid data, invalid payloads, and unknown tags.
   - Verify performance if used in hot path.

## Language Recipes

### Clojure

```clojure
(defn ->Money [amount currency]
  {:money/amount (bigdec amount)
   :money/currency currency})

(def readers
  {'money/usd #(->Money % :USD)
   'money/eur #(->Money % :EUR)})

(edn/read-string {:readers readers} "#money/usd 10.25")
```

### JavaScript

```javascript
import * as edn from 'jsedn';

class Money { /* ... */ }

edn.setTagAction(new edn.Tag('money', 'usd'), amount =>
  new Money(amount, 'USD')
);
```

### Python

```python
from edn_format import loads, add_tag

class Money:
    def __init__(self, amount, currency):
        self.amount = amount
        self.currency = currency

add_tag('money/usd', lambda value: Money(value, 'USD'))
loads('#money/usd 19.99')
```

## Validation Tips

- Reject malformed payloads early.
- Document numeric precision (use Decimal where appropriate).
- Provide fallback readers that return plain data structures when the host language lacks certain types.

## Deployment Considerations

- Register readers at process boot to avoid race conditions.
- Version tag handlers alongside schema changes.
- For multi-tenant systems, isolate reader registrations per tenant or context.

## References

- `spec/EXTENSIBILITY.md`
- `spec/INTEGRATION.md`
- `reference/tagged-literal-registry.md`
