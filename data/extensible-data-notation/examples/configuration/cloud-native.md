# Example: Cloud-Native Configuration with Secrets

## Problem

A platform engineering team manages Kubernetes manifests with YAML. Secret references, rollout windows, and environment overrides are spread across multiple files. YAML's implicit typing causes accidental boolean coercion and whitespace errors.

## Conventional Approach (YAML)

```yaml
apiVersion: v1
kind: ConfigMap
data:
  rolloutWindowStart: 2025-12-11T10:00:00Z
  rolloutWindowEnd: 2025-12-11T12:00:00Z
  featureEnabled: "NO"   # intended to mean disabled
  databaseUrl: ENC[prod/postgres]
```

**Issues**

- `"NO"` becomes boolean `false` unexpectedly.
- Secrets stored as magic convention `ENC[...]`.
- Rollout windows not validated, timezone hidden.

## EDN Solution

```clojure
{:config/version 1
 :config/environment :env/prod

 :deployment/rollout
 {:rollout/start #inst "2025-12-11T10:00:00Z"
  :rollout/end #inst "2025-12-11T12:00:00Z"
  :rollout/strategy :rollout/canary}

 :feature/flags
 {:feature/service-x #feature/flag {:flag/name :service-x
                                    :flag/enabled? false
                                    :flag/rollout-percent 0}}

 :secrets
 {:secrets/database-url #secrets/encrypted {:ciphertext "ENC[prod/postgres]"
                                            :provider :aws-kms
                                            :kms-key-id "arn:aws:kms:us-west-2:123:key/abc"}}

 :infrastructure/services
 #{{:service/name :payments
    :service/dependencies #{:core-db}
    :service/config {:db/url #secrets/encrypted {:ciphertext "ENC[prod/postgres]"}}}
   {:service/name :analytics
    :service/dependencies #{:warehouse}
    :service/config {:warehouse/url "jdbc://warehouse"}}}}
```

### Highlights

- Namespaces communicate ownership (deployment, feature, secrets).
- Sets used for dependencies to prevent duplicates.
- Tagged secrets carry metadata for decryptors.

## Implementation Steps

1. Store EDN config alongside manifests; mount via ConfigMap or S3.
2. Provision sidecar that parses EDN and injects environment variables.
3. Implement decryptor using `reference/tagged-literal-registry.md` semantics.
4. Validate rollout windows before applying by checking `:rollout/start < :rollout/end`.
5. Document ingestion pipeline in runbook.

## Outcome

- Eliminated YAML-induced boolean mistakes.
- Centralized rollout metadata; SREs can reason about deployments quickly.
- Secrets pipeline now describes encryption algorithm + key id explicitly.

## Lessons

- Use sets for dependency lists to avoid duplicates across services.
- Keep EDN config small per component to limit blast radius.
- Pair EDN config with validation CI job so errors are caught before deploy.
