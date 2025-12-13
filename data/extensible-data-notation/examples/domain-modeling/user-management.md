# Example: User Management Domain

## Problem

An identity platform uses JSON with camelCase fields and ad-hoc role lists. Permissions contain duplicates, and password metadata lacks structure. Migration to EDN should clarify ownership and improve extensibility.

## Conventional Approach (JSON)

```json
{
  "id": "f81d4f...",
  "name": "Alice",
  "email": "alice@example.com",
  "roles": ["ADMIN", "ADMIN", "REPORTS"],
  "password": "HASHED:...",
  "createdAt": "2025-12-11T10:00:00Z"
}
```

Issues:

- Duplicate roles require dedupe logic.
- Password encoding is ambiguous.
- Namespaces absent, so cross-team integrations misinterpret fields.

## EDN Model

```clojure
{:user/id #uuid "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
 :user/profile
 {:profile/name "Alice Smith"
  :profile/email "alice@example.com"
  :profile/created-at #inst "2025-12-11T10:00:00Z"}

 :user/credentials
 {:credentials/password #auth/password {:password/hash "HASHED:..."
                                        :password/algo :bcrypt
                                        :password/rotated-at #inst "2025-11-01T09:00:00Z"}
  :credentials/mfa {:mfa/enabled? true
                    :mfa/methods #{:mfa/app :mfa/email}}}

 :user/roles #{:role/admin :role/reports}
 :user/status :user.status/active
 :user/audit
 {:audit/source :svc/iam
  :audit/request-id #uuid "a1b2c3d4-e5f6-7890-abcd-ef1234567890"}}
```

### Highlights

- Sets remove duplicate roles automatically.
- Tagged literal `#auth/password` captures hashing metadata.
- Namespace separation clarifies context (profile, credentials, audit).

## Implementation Steps

1. Establish namespaces via `frameworks/namespace-design.md`.
2. Register `#auth/password` reader to produce a secure struct/class.
3. Validate schema with `spec/DESIGN.md` recommendations (optional vs required fields).
4. Provide translation layer for legacy JSON clients (map keywords → camelCase).
5. Document audit requirements in README or ops runbooks.

## Outcome

- Role duplication eliminated due to set semantics.
- Security team gains explicit password rotation data.
- Consumers can introspect user status via keywords rather than string enums.

## Lessons

- Keep audit metadata separated from domain fields to simplify filtering.
- Tag names should align with namespace semantics (`auth/password` for credentials).
- Provide migration scripts that convert JSON arrays to EDN sets carefully (order lost intentionally).
