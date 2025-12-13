# Example: Event Sourcing Payloads

## Problem

An event-sourced system emits JSON events with stringified timestamps and discriminator fields. Consumers duplicate parsing logic, and new event types require coordinated deployments.

## Conventional Approach (JSON)

```json
{
  "eventType": "ORDER_PLACED",
  "occurredAt": "2025-12-11T10:00:00Z",
  "orderId": "f81d4f...",
  "total": "99.99",
  "currency": "USD"
}
```

Issues:

- Event types rely on uppercase strings; collisions likely.
- Money/time semantics hidden.
- No namespacing, so multi-domain streams are hard to manage.

## EDN Event Model

```clojure
{:event/id #uuid "c4d91438-4f16-4d46-a5d6-a04a2d8ce86f"
 :event/type :order.event/placed
 :event/occurred-at #inst "2025-12-11T10:00:00Z"
 :event/version 1
 :order/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :order/total #money/usd 99.99M
 :order/items
 #{{:order.line/sku "sku-123"
    :order.line/qty 2
    :order.line/price #money/usd 49.995M}}
 :event/metadata
 {:meta/source :svc/checkout
  :meta/request-id #uuid "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
  :meta/trace-id "trace-123"}}
```

### Why it helps

- Namespaced keyword `:event/type` conveys bounded context.
- Sets for line items remove accidental duplicates.
- Tagged literals ensure high-fidelity time/money.
- Event metadata is isolated for observability.

## Implementation Steps

1. Define event schema per `spec/DESIGN.md`.
2. Use `frameworks/schema-design.md` to document optional fields.
3. Register tag readers for consumer services (Go, JS, etc.).
4. Store events as EDN strings or transit them via EDN over HTTP.
5. For systems that require JSON, convert EDN to JSON but retain namespaced strings (`"order.event/placed"`).

## Outcome

- Event processors rely on namespaced keywords; no more brittle switch statements.
- Temporal and monetary precision preserved end-to-end.
- Adding new event types only requires new keywords/tags, not parser updates.

## Lessons

- Include `:event/version` to enable schema migrations without breaking consumers.
- Keep metadata map consistent so tracing systems can parse generically.
- Document tag semantics in `reference/tagged-literal-registry.md` to align teams.
