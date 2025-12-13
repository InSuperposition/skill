# Example: Application Configuration with Rich Types

## Problem

A SaaS application stores configuration in JSON. Timestamps, feature flags, and secrets are all encoded as strings, which leads to mistakes (typos, forgotten timezone conversions, duplicated roles).

## Conventional Approach (JSON)

```json
{
  "schedulerFrequency": "2025-12-11T10:00:00Z",
  "featureFlags": {
    "billing": "true",
    "newDashboard": "false"
  },
  "secrets": {
    "dbPassword": "ENC(xxx)"
  }
}
```

**Issues**

- Strings for booleans and timestamps → runtime parsing required.
- Secrets embed algorithm hints in strings, making rotation hard.
- No namespace separation between services.

## EDN Solution

```clojure
{:config/version 2
 :scheduler/window
 {:scheduler/frequency #inst "2025-12-11T10:00:00Z"
  :scheduler/timezone "UTC"}

 :feature/flags
 {:feature/billing #feature/flag {:flag/name :billing
                                  :flag/enabled? true
                                  :flag/rollout-percent 100}
  :feature/new-dashboard #feature/flag {:flag/name :new-dashboard
                                        :flag/enabled? false
                                        :flag/rollout-percent 10}}

 :secrets/store
 {:secrets/db-password #secrets/encrypted {:ciphertext "ENC(xxx)"
                                           :algo :aes-256-gcm
                                           :rotated-at #inst "2025-11-30T18:00:00Z"}}}
```

### Why it works

- Qualified keywords make ownership obvious (`:feature/`, `:secrets/`).
- Tagged literals encode semantics directly (`#feature/flag`, `#secrets/encrypted`).
- Timestamp stored as `#inst`, no manual parsing needed.

## Implementation Steps

1. Define tag readers for `#feature/flag` and `#secrets/encrypted` per `frameworks/reader-implementation.md`.
2. Store configuration in source control or secrets manager as EDN.
3. Load with `clojure.edn/read` (Clojure) or `jsedn.parse` (JavaScript service).
4. Validate using `spec/DESIGN.md` guidelines (ensure rollout percent between 0-100).
5. Document meaning of each namespace in onboard doc.

## Outcome

- Removed ad-hoc parsing logic (timestamp + boolean conversions).
- Enabled typed feature flag objects with metadata.
- Secrets rotation tracked with timestamps and algorithms.

## Lessons

- Invest in namespaces early; mixing config + secrets in same namespace becomes messy.
- Tagged literals make hidden semantics visible but require reader support wherever config loads.
- Keep sample config checked into repo so new engineers learn expectations quickly.
