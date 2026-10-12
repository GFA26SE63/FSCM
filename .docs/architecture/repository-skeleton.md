# FSCM architecture and repository boundaries

## Purpose

This document defines the implementation boundaries for the approved [FSCM business baseline](../business/README.md). It describes ownership and consistency requirements, not feature-completion claims.

## Workspace topology

FSCM is a workspace of four Git repositories:

```text
FSCM integration repository
|-- FSCM-Backend/   independent .NET repository
|-- FSCM-Frontend/  independent React repository
|-- FSCM-Mobile/    independent Flutter repository
|-- .docs/          cross-system decisions and acceptance guidance
`-- .diagram/       editable architecture sources
```

The integration repository owns cross-system documentation. Each application repository owns its source, tests, lockfiles, pipeline, and application-specific README. Cross-repository work must use matching branches or referenced commits; the parent repository does not vendor or version application files.

## Runtime containers

| Container | Responsibility | Must not own |
| --- | --- | --- |
| React portal | Admin, Operator, Sales Manager, and operational Warehouse Keeper workflows | Authoritative authorization or business rules |
| Flutter mobile client | Sales offline capture, Warehouse Keeper scanning, and Retailer receipt/loyalty/complaint workflows | Final prices, promotions, inventory, allocation, or points |
| .NET API | Authorization, validation, orchestration, allocation, inventory state, payments, loyalty, audit, and contracts | Client-only presentation state |
| PostgreSQL | Authoritative transactional state, history, idempotency, outbox, and configuration | Offline-only drafts that have not reached the server |
| Object storage | Evidence and attachment payloads addressed by server-managed metadata | Business status or authorization decisions |
| Background workers | Outbox delivery, expiry checks, discount/replenishment alerts, overdue evaluation, and notifications | Independent mutation that bypasses application use cases |

Mobile SQLite is a cache and offline command queue. It is never a peer database and cannot settle conflicts in favor of a device value.

## Backend dependency direction

The backend follows Clean Architecture:

```text
FSCM.Application    -> FSCM.Domain, FSCM.Shared
FSCM.Persistence    -> FSCM.Domain, Application abstractions
FSCM.Infrastructure -> Application abstractions
FSCM.API            -> Application, Persistence, Infrastructure
FSCM.Domain         -> no provider or transport project
FSCM.Shared         -> stable dependency-free technical primitives only
```

- `FSCM.Domain` owns entities, value objects, state-transition rules, and domain services that do not depend on EF Core or HTTP.
- `FSCM.Application` owns commands, queries, authorization requirements, orchestration, validators, DTOs, and ports.
- `FSCM.Persistence` owns PostgreSQL mappings, migrations, repositories, transactions, and concurrency implementation.
- `FSCM.Infrastructure` owns external identity, object storage, notification delivery, clocks, and background adapters.
- `FSCM.API` is the composition and transport boundary. It authenticates requests, maps contracts, and never exposes persistence entities.
- `FSCM.Shared` is not a miscellaneous common-code folder; code belongs there only when stable and domain-neutral.

## Business capability boundaries

Application features should be organized around these cohesive capabilities:

| Capability | Primary ownership |
| --- | --- |
| Identity and access | Six roles; warehouse, sales-group, territory, and retailer scope |
| Catalog | Category tree, product lifecycle, SKU versioning, and effective prices |
| Territory and retailer | Regions, sales groups, assignment history, declaration, review, and potential assessment |
| Warehouse inventory | Receipt, batch merging, QR lineage, inventory balance, and expiry state |
| Promotions | Campaign targeting, batch shelf-life discount, stacking policy, and price snapshot |
| Ordering and offline sync | Online/offline order intake, idempotency, FCFS server processing, and order snapshot |
| Allocation | MLOR/ETA/radius hard filters, weighted scoring, greedy allocation, and holds |
| Approval and fulfillment | Hold-to-reservation conversion, cancellation release, picking, and dispatch |
| Transfer | Central-to-regional replenishment, FEFO issue, transit, receipt, and quantity conservation |
| Delivery and receipt | Vehicle/person assignment, delivery state, retailer QR confirmation, and duplicate protection |
| Payment | Prepaid, COD, deferred due date, full-payment confirmation, and overdue status |
| Complaint | Complaint items, evidence, review, and response without automatic reverse logistics |
| Loyalty | Program, pending/earned points ledger, gift inventory, redemption, refund, and expiry |
| Reporting | Revenue after promotion, comparison periods, Sales/team KPI, ranking, and top products |
| Platform support | Configuration versions, notifications, audit, immutable IDs, idempotency, and outbox |

Regional-to-regional near-expiry rebalancing must not be placed in an approved module until its proposal is formally accepted.

## Critical transactional boundaries

### Order acceptance and allocation

One server transaction must:

1. Establish idempotency for the client command.
2. Authorize the Sales-to-retailer territory relationship.
3. Re-read current product, price, promotion, inventory, ETA, MLOR, and configuration data.
4. Hard-filter candidates and calculate deterministic scores.
5. Greedily allocate every order line, recalculating coverage against remaining demand.
6. Reject and roll back all candidate allocations when any line is short.
7. Create all holds, order snapshots, status history, and audit/outbox records when fully supplied.

Concurrent commands use row/version checks, deterministic lock ordering, bounded retry, and full rollback. A retry must recompute from current state rather than reuse stale availability.

### Approval and cancellation

Approval atomically converts the order's active holds into reservations and creates picking work grouped by warehouse. Rejection or cancellation releases only live holds/reservations and records the reason. Repeated commands return the already-settled result or a conflict; they never adjust stock twice.

### Picking and dispatch

Picking validates the allocation, warehouse scope, source tag/batch lineage, and complete requested quantity. Dispatch atomically consumes reservations, decreases physical stock, updates picking/allocation state, and derives the aggregate order state across warehouses.

### Transfer

Central dispatch and regional receipt are separate controlled transitions. Transfer items preserve source/destination batch lineage and enforce:

```text
dispatched quantity <= approved/requested quantity
received quantity <= dispatched quantity
source decrease = quantity placed in transit
destination increase = accepted received quantity
```

Cancellation and exception rules may release only quantities that have not been dispatched.

### Receipt, payment, and loyalty

Retailer receipt confirmation validates order ownership and every expected QR tag. The confirmation, payment, loyalty earning, and redemption endpoints each require independent idempotency keys because mobile retries and duplicate scans are normal operating conditions.

For deferred payment, receipt creates pending points and full payment converts them once. For prepaid/COD orders, points become earned only after the approved receipt/payment condition is satisfied. Ledger entries—not a mutable balance alone—are the accounting record.

## Offline synchronization

```text
device creates OFF code and stable client key
  -> queue persists locally
  -> API receives command and stores server_received_at
  -> server authorizes and revalidates all mutable business inputs
  -> server creates one DH order or returns a business rejection
  -> device stores the authoritative result and snapshots
```

Processing order is based on server receipt time, not device time. The response must distinguish transport failure, retriable concurrency failure, and final business rejection. A changed price or promotion is an explicit server result, not silent acceptance of the offline estimate.

## State and snapshot policy

- Master data is referenced for current validation but historical transactions retain display and calculation snapshots.
- Orders snapshot product identity, prices, discounts, promotions, and applicable loyalty inputs.
- Allocations snapshot candidate inputs, score components, configuration version, ETA, and result order when needed for explanation and evaluation.
- Delivery assignments snapshot plate number and delivery-person contact details.
- Status history and audit records are append-only from application behavior; corrections use compensating actions.
- Server business codes are immutable and never reused.

## API and client boundaries

REST/OpenAPI is the canonical command and operational-query contract. GraphQL may serve read-heavy dashboards only when it uses the same application authorization and query policies. SignalR may publish state-change notifications, but clients must re-read authoritative state after reconnecting.

React and Flutter consume versioned contracts and must not share database models. Client permission checks improve UX only; every API request is authorized independently. See [API contract rules](../api/README.md).

## Configuration ownership

Service radius, transit rules, MLOR overrides, allocation weights, replenishment thresholds, discount tiers, credit terms, loyalty rates, and KPI thresholds are versioned server configuration. Changes affect new processing; historical snapshots preserve the configuration used for an existing decision.

Secrets and environment endpoints are deployment configuration. They do not belong in business-configuration tables or committed settings files.

## Observability and asynchronous work

Every request should carry a correlation identifier through API logs, database/audit records where appropriate, outbox messages, and worker logs. Metrics should cover allocation rejection reasons, concurrency retries, outbox lag, offline-sync outcomes, overdue jobs, and notification failures without exposing personal data.

The transactional outbox is required when a durable notification or job follows a committed state change. Workers must be idempotent and safe under at-least-once delivery.

## Deliberate exclusions

Architecture must not reserve active production components for retailer checkout, returns, reverse logistics, partial shipment, credit-limit engines, partial payment, debt aging, driver applications, routing/vehicle optimization, warehouse revenue, POS inventory, or payment gateways. Such components require a new approved scope decision.

## Repository hygiene

- Commit editable diagram sources, documentation, code, tests, safe configuration examples, migrations, pipelines, and deterministic lockfiles.
- Ignore build outputs, package caches, IDE data, test results, secrets, certificates, real environment files, and the integration repository's `temp/` context directory.
- Keep commits scoped to one repository and one reviewable concern.
- Update the business baseline, affected contracts, diagrams, and acceptance scenarios together when an approved decision changes.
