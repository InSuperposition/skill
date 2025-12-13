# Example: Financial Data Modeling

## Problem

A fintech product tracks ledger entries in JSON. Monetary values use floating point numbers, leading to rounding errors. Interest accruals and exchange rates are stored as strings, making reconciliation brittle.

## Conventional Approach (JSON)

```json
{
  "entryId": "txn-123",
  "postedAt": "2025-12-11T10:00:00Z",
  "amount": 99.99,
  "currency": "USD",
  "type": "INTEREST",
  "rate": "0.035"
}
```

Issues:

- Floating point for money → precision loss.
- Currency conversions require manual parsing.
- Entry type is a string; no enforced vocabulary.

## EDN Ledger Entry

```clojure
{:ledger/id "txn-123"
 :ledger/version 1
 :ledger/posted-at #inst "2025-12-11T10:00:00Z"
 :ledger/type :ledger.type/interest
 :ledger/amount #money/usd 99.99M
 :ledger/rate #interest/apr 0.035M
 :ledger/source {:source/account :account/savings
                 :source/batch-id #uuid "a1b2c3d4-e5f6-7890-abcd-ef1234567890"}
 :ledger/tags #{:ledger.tag/month-end :ledger.tag/accrual}}
```

### Advantages

- Money stored as decimal via tagged literal; no floating point surprises.
- Interest tagged literal communicates units (APR vs APY).
- Sets capture tagging/classification metadata cleanly.

## Implementation Steps

1. Define `#interest/apr` tag semantics in `reference/tagged-literal-registry.md`.
2. Register readers/writers across accounting services.
3. Ensure serialization uses arbitrary precision decimals (Java `BigDecimal`, Python `Decimal`).
4. Provide migration job: parse JSON, convert to EDN, backfill tags.
5. Document ledger versioning and type vocabulary in `spec/DESIGN.md`.

## Outcome

- Accounting reconciliations now operate on precise decimals.
- Consumers know whether rates represent APR/APY.
- Tags allow slicing ledger entries without additional indexing fields.

## Lessons

- Keep ledger identifiers as strings if they carry business meaning; use `#uuid` only when appropriate.
- Tagging interest rates avoids confusion when multiple units appear.
- Validate decimal scale in tests to catch drift (e.g., 2 decimal places for USD).
