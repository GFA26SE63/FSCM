# DevOps and release guidance

FSCM is delivered from independent backend, frontend, mobile, and integration-documentation repositories. Each repository owns its pipeline and release artifact; cross-system releases record the exact commit and contract version used from every repository.

## Branch and review policy

- `main` represents reviewed, releasable work.
- Use short-lived professional branches such as `feature/...`, `fix/...`, `docs/...`, `refactor/...`, or `chore/...`.
- Require pull-request review and successful quality gates before merging.
- Use Conventional Commits to make change intent and generated release notes clear.
- Do not commit directly generated build outputs or local `temp/` context.
- A cross-repository feature links its related branches/commits in the work item or pull request.

## Pipeline ownership

| Repository | Required validation | Produced artifact |
| --- | --- | --- |
| Backend | Restore, build, unit/integration tests, migration review, publish, security/dependency checks | Versioned API package/container and migration bundle |
| Frontend | Clean install, lint, type check, tests, production build, dependency checks | Immutable static web artifact |
| Mobile | Dependency restore, format check, analyze, tests, platform build when applicable | Signed/versioned application package |
| Integration docs | Link checks, Markdown/diagram validation, scope consistency review | Versioned documentation source/export |

Path filters may reduce unrelated builds, but shared contract changes must trigger every affected consumer validation.

## Environments

Use at least development, test/staging, and production boundaries with separate credentials and data. Production deployment requires an approved environment/check and traceable release evidence.

Never use production personal or commercial data in lower environments. Seed deterministic synthetic data that follows approved business identifiers, assignment scope, batch expiry, MLOR, promotions, and order states.

## Configuration ownership

Keep these concerns separate:

| Concern | Owner/storage |
| --- | --- |
| Business parameters | Versioned FSCM database/configuration with audit and effective time |
| Service endpoints and feature wiring | Environment configuration |
| Secrets, keys, credentials, certificates | Secret store/secured pipeline variables |
| Safe local examples | Committed `.env.example` / `appsettings.example.json` |

Business parameters include allocation weights, radius, transit rules, replenishment threshold, discount tiers, credit terms, loyalty rates, and KPI thresholds. They must not be compiled as production constants.

## Database delivery

- Generate and review migrations in the backend repository.
- Validate migrations against a production-like PostgreSQL version and representative data volume.
- Back up according to the environment policy before a production schema change.
- Prefer backward-compatible expand/migrate/contract changes when API versions overlap.
- Apply migrations once through a controlled release step; concurrent API instances must not race to migrate.
- Record migration version and outcome in release evidence.
- Use an auditable repair script or command for data correction.

## Deployment order

For compatible changes:

1. Apply backward-compatible database expansion.
2. Deploy backend capable of serving old and new consumers during the transition.
3. Deploy web and mobile consumers.
4. Observe business and technical health.
5. Remove deprecated schema/contracts only after the supported client window closes.

Mobile releases require special care because offline or delayed-update clients may retry older commands. Idempotency retention and API compatibility must cover the supported client lifetime.

## Release gates

Production promotion requires:

- successful repository quality gates from the [testing strategy](../testing/README.md);
- reviewed OpenAPI/database changes and client compatibility;
- no unresolved critical security finding;
- a tested migration and rollback/forward-fix plan;
- environment approval and artifact provenance;
- smoke checks for authentication, scoped access, health, database, object storage, outbox worker, and notifications;
- confirmation that pending regional-to-regional rebalancing is not activated as approved functionality.

## Rollback and forward recovery

Application artifacts are immutable and redeployable by version. Prefer forward recovery after a schema/data change when rollback would discard committed business transactions. A rollback plan must distinguish:

- application rollback with unchanged compatible schema;
- worker pause/resume and outbox replay;
- configuration rollback by new audited effective version;
- data repair through an approved compensating operation;
- schema forward-fix when destructive rollback is unsafe.

Never roll back by deleting order, inventory, payment, loyalty, audit, or idempotency history.

## Observability

Capture structured logs, traces, and metrics with correlation IDs while excluding tokens, secrets, and evidence contents. Alert on:

- API and database availability;
- sustained error/conflict rates;
- allocation retry/rejection anomalies;
- negative/inconsistent inventory invariant checks;
- offline sync failures or backlog;
- outbox age, retries, and dead letters;
- notification/job failures;
- storage upload failures;
- overdue-job lag.

Operational dashboards must label technical metrics separately from business KPI. Warehouse revenue is not an approved business metric.

## Release evidence

For each release retain:

- repository commit identifiers and artifact versions/checksums;
- pipeline/test results and relevant performance evidence;
- OpenAPI and migration versions;
- approvals, deployment timestamps, and environment;
- smoke-test outcome and known limitations;
- rollback or forward-recovery decision if an incident occurred.

Documentation-only releases still require link/diagram validation and review against the approved [business baseline](../business/README.md).
