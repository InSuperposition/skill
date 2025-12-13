# Tagged Literal Registry

Catalog of common tagged literals used throughout the EDN skill. Use this as inspiration and to keep semantics consistent across examples.

| Tag | Payload | Purpose | Notes |
|-----|---------|---------|-------|
| `#inst` | ISO-8601 string | Timestamp | Built-in |
| `#uuid` | UUID string | Unique identifiers | Built-in |
| `#money/usd` | Decimal number | Currency with USD semantics | Convert to Money type or map {:amount :currency} |
| `#money/eur` | Decimal | EUR currency | Example of regional tags |
| `#feature/flag` | map `{ :flag/name kw :flag/enabled? bool }` | Feature flag config | Allows metadata like rollout % |
| `#secrets/encrypted` | map `{ :ciphertext string :algo kw }` | Encrypted payload wrapper | Consumers decrypt after reading |
| `#geo/point` | vector `[lat lon]` | Geographic coordinate | Use decimal degrees |
| `#measurement/celsius` | Decimal | Sensor measurement with unit | Convert to canonical representation |
| `#address/us` | map | Structured address | Example of domain-specific tag |
| `#event/order` | map | Event sourcing payload | Namespaced per bounded context |

## Adding New Tags

1. Ensure tag name is namespaced (`namespace/tag`).
2. Document payload structure (scalar, vector, map).
3. Describe expected reader output.
4. Link to examples or frameworks using the tag.
5. Update `frameworks/reader-implementation.md` if implementation guidance changes.

## Usage Conventions

- Keep payloads minimal but expressive. If the tag only adds units, prefer scalars; if semantics complex, use maps.
- Align tag namespace with keyword namespace for related data.
- Version tags by adding suffix (`#money/v2`) only when semantics change drastically; prefer schema version fields otherwise.

## References

- `spec/EXTENSIBILITY.md`
- `examples/configuration/cloud-native.md`
- `examples/domain-modeling/financial-data.md`
