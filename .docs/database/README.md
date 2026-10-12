# Database and integrity rules

PostgreSQL is the authoritative FSCM datastore. This document translates the approved [business baseline](../business/README.md) into persistence constraints. A physical ERD or migration may add implementation detail but must not weaken these rules.

## General conventions

- Use UUID primary keys for internal identity and separate immutable business-code columns for display identifiers.
- Use `timestamptz` for instants and store them in UTC. Use `date` for expiry when time-of-day is irrelevant.
- Store VND as an integer-valued database type; never use binary floating point.
- Store approved order/transfer quantities as whole cartons with non-negative checks.
- Store ratios and percentages as bounded fixed-precision decimals.
- Apply `NOT NULL` to required business state, timestamps, quantities, and foreign keys.
- Use explicit foreign keys and purposeful delete behavior. Do not cascade-delete business history.
- Give unique and check constraints stable names so migrations and API error mapping remain reviewable.
- Use case-normalized unique indexes for codes and email where business uniqueness is case-insensitive.

## Data ownership groups

| Group | Core records |
| --- | --- |
| Identity and scope | User, warehouse assignment, region, sales group membership, retailer assignment |
| Catalog | Category, product/SKU, effective price, retailer-product MLOR |
| Inventory | Goods receipt, batch lineage, QR label lineage, inventory balance |
| Commercial | Promotion targeting, batch discount, order, order lines, applied-promotion snapshots |
| Allocation and fulfillment | Allocation, hold, reservation, picking list/items, delivery assignment |
| Receipt and service | Receipt confirmation/items, complaint/items/evidence |
| Finance and loyalty | Payment, loyalty program, retailer ledger, reward, redemption |
| Warehouse movement | Transfer and transfer items |
| Platform | Status history, configuration versions, audit, notification, idempotency, outbox |

The logical groups do not require a table-per-item naming scheme. Aggregate and query needs should drive the physical design while preserving clear ownership.

## Master-data retention

Users, warehouses, categories, published products, retailers, regions, and sales groups are inactivated rather than hard-deleted after use. Assignment records retain effective history through assigned/unassigned timestamps or equivalent validity periods.

Draft product/category records may be deleted only when no dependent business history exists. Published product facts used by an order are copied into order-line snapshots before later inactivation.

## Business-code integrity

Server-generated codes are unique, immutable, and never reused. Generation must be concurrency-safe and must not rely on `MAX(code) + 1` without serialization.

Format validation applies at the domain/API boundary and may be reinforced with database checks for stable formats. Important examples are `DH-{6 digits}`, `OFF-{Device}-{4 digits}`, `TEM-{6 digits}`, `SKU{3 digits}`, and `{Warehouse}-{SKU}-{ddMMyyyy}`.

## Batch and QR lineage

The active batch identity is unique for warehouse, SKU, and expiry date. A repeated receipt for the same combination adds quantity through an auditable transaction rather than creating a competing active batch.

Every split or warehouse movement preserves a link to its source/root lineage. QR identifiers are immutable and unique. A split operation atomically creates the child tag and reduces the parent's active quantity so total tagged quantity is conserved.

Expired status is derived from expiry date and business time; it must not be the only protection against allocating expired stock. Allocation queries validate expiry directly in the same transaction.

## Inventory invariants

For every batch balance:

```text
on_hand >= 0
held >= 0
reserved >= 0
available = on_hand - held - reserved
available >= 0
```

`available` may be computed or persisted with database/application consistency protection. If persisted, every mutation updates it atomically with the source quantities.

| Operation | Required effect |
| --- | --- |
| Allocation success | Increase held |
| Allocation rollback/rejection | Decrease/release held |
| Order approval | Decrease held and increase reserved by the same quantity |
| Approved cancellation | Release only unconsumed reserved quantity |
| Dispatch | Decrease reserved and on-hand by the same quantity |
| Transfer dispatch | Decrease source stock and establish in-transit quantity |
| Transfer receipt | Increase destination stock by accepted received quantity |

Use a transaction plus optimistic version checks. Lock rows in deterministic order when one command touches multiple batches. A concurrency retry recomputes eligibility and allocation; it does not blindly replay quantity updates.

## Order integrity

- Order source, status, payment method, retailer, sales group, creator, and server-received time are explicit fields.
- The client order key is unique within its defined actor/device scope.
- An accepted offline command maps to at most one server order.
- Each order contains at least one line and each line has a positive whole-carton quantity.
- Persist subtotal, discount, and final amount snapshots with `final = subtotal - discount` under the approved rounding policy.
- Persist product/SKU, price, promotion, and loyalty-relevant snapshots independently from current master data.
- Status changes append history with actor, from/to state, reason, and timestamp.

The `PendingSync -> PendingApproval -> Approved -> Issued -> Delivering -> Delivered` path and `Rejected`/`Cancelled` exceptions are enforced through application commands. Direct status-column updates outside migrations/repair procedures are prohibited.

## Allocation evidence

Allocation records retain enough data to reproduce or explain the decision, including selected batch/warehouse, quantity, sequence, ETA, life remaining at arrival, and configuration version. Where thesis evaluation requires it, retain hard-filter outcomes and score components for considered candidates in a bounded decision log.

No holds may be committed unless every line of the order is fully supplied. Holds for all lines and the order transition to `PendingApproval` share one transaction.

## Promotions and configuration

Effective-dated prices, campaigns, retailer/category/SKU targeting, and batch discounts must prevent ambiguous overlapping active records unless a documented stacking rule resolves them.

Configuration changes are versioned or immutable-effective-dated records. Orders and allocations reference/snapshot the version used. At minimum this applies to allocation weights, service radius, transit rules, MLOR overrides, replenishment threshold, discount tiers, credit terms, loyalty rate, and KPI thresholds.

## Payment and loyalty ledgers

Payment is separate from order state and supports only full settlement in approved scope. Enforce non-negative VND amounts and prevent cumulative confirmed payment from exceeding the payable snapshot. A unique business guard prevents duplicate full-payment confirmation.

Loyalty balance is derived from immutable ledger transactions. If a cached current balance is stored, update it in the same transaction as the ledger row and verify:

```text
balance_after = previous_balance + signed_points
```

Each order earns once per program/earning event. Pending credit-order points convert once after full payment. Redemption deduct/hold, rejection refund, fulfillment, and expiry each produce traceable entries; records are not edited to disguise prior movement.

## Receipt confirmation and complaints

An order has at most one settled receipt confirmation. Scanned label uniqueness prevents the same active tag from satisfying multiple receipt items. Store expected and received quantities for reconciliation.

Complaints reference the order and affected batch/tag where available, with issue type, quantities, note, evidence metadata, reporter, reviewer, and timestamps. Complaint resolution does not mutate inventory unless a future, separately approved workflow defines a stock transaction.

## Idempotency

Idempotency records include scoped key, actor, operation, request fingerprint, status, result reference/response metadata, creation time, and expiry. Unique scope/key constraints prevent duplicate execution.

Do not delete a key while the related business command could still be retried from a supported offline client. Retention must exceed the maximum offline retry window and operational dispute period.

## Audit and outbox

Important commands append audit data with actor, entity, action, reason, old/new values or a structured change summary, timestamp, and correlation ID. Audit records are append-only to normal application roles and must avoid secrets or unnecessary personal data.

Outbox rows are inserted in the same transaction as the state change. Workers claim messages safely, record attempts and last error, and mark completion idempotently. At-least-once delivery means every consumer also needs a deduplication strategy.

## Index guidance

Index by measured query and constraint needs. Expected high-value access paths include:

- active assignments by user/warehouse/group/retailer;
- product/category status and normalized code;
- batch by warehouse, product, expiry, and available quantity;
- orders by retailer, sales group, creator, status, and server receipt time;
- allocations/picking by order and warehouse;
- active holds/reservations by batch;
- transfer by source/destination warehouse and status;
- payment by order and status;
- loyalty ledger by retailer and creation sequence;
- unread notifications by user;
- pending outbox messages by status and next-attempt time.

Partial indexes are appropriate for active/current rows when PostgreSQL query plans demonstrate value.

## Migration policy

1. Every schema change is represented by a reviewed migration in the backend repository.
2. Migrations are forward-safe for the supported deployment process and avoid destructive rewrites without an explicit data plan.
3. New required columns use staged backfill when existing rows are possible.
4. Constraint additions include a cleanup/validation plan for legacy data.
5. Production data correction uses an auditable repair command or reviewed script, never an undocumented manual update.
6. Seed data follows immutable business-code formats and is consistent across backend and clients.

The regional-to-regional near-expiry proposal must not introduce production tables, jobs, or state values until it is approved. Experimental evaluation data must be isolated from authoritative operational state.
