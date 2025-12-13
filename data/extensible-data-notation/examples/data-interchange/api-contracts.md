# Example: API Contracts with EDN

## Problem

A B2B API evolves quickly. JSON schemas rely on string enums and ad-hoc versioning, causing consumers to misinterpret payloads. The team wants self-describing contracts and explicit versioning.

## Conventional Approach (JSON)

```json
{
  "version": "1.3",
  "orderId": "f81d4f...",
  "status": "FULFILLED",
  "total": "99.99",
  "currency": "USD",
  "items": [
    {"sku": "sku-123", "qty": 2}
  ]
}
```

Issues:

- Version as string lacks semantics.
- Money encoded as strings.
- Status relies on uppercase string; no namespace prevents collisions.

## EDN Contract

```clojure
{:contract/version 2
 :order/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :order/status :order.status/fulfilled
 :order/total #money/usd 99.99M
 :order/items
 [{:order.line/sku "sku-123"
   :order.line/qty 2
   :order.line/price #money/usd 49.995M}]
 :order/meta
 {:meta/request-id #uuid "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
  :meta/emitted-at #inst "2025-12-11T10:01:00Z"}}
```

### Benefits

- Qualified keywords for statuses prevent collisions.
- Tagged literals enforce type semantics.
- Namespace-based grouping clarifies domain ownership.
- Contract version is numeric + namespaced, making negotiation easier.

## Implementation Steps

1. Define EDN schema per `spec/DESIGN.md`.
2. Provide JSON fallback by serializing EDN to JSON with tag hints if necessary.
3. Share contract doc referencing this example and `spec/COMPARISON.md`.
4. Register `#money/usd` reader for all consumers (`frameworks/reader-implementation.md`).
5. Validate requests using `clojure.spec` or `malli`.

## Outcome

- Consumers immediately know when schema changes via `:contract/version`.
- Money calculations moved to decimal-based types, avoiding float drift.
- Order status is now a namespaced keyword, enabling easy filtering.

## Lessons

- Document how to convert EDN to JSON for partners lacking EDN support.
- Keep contract metadata (request id, emitted timestamp) grouped in map to prevent pollution of root keys.
- Use vectored line items to preserve order, sets when uniqueness is more important than ordering.
