# Testing strategy

FSCM testing must prove the approved [business baseline](../business/README.md), especially the expiry, inventory, authorization, and retry behaviors that can create financial or stock errors. A passing build or placeholder test suite is not business acceptance.

## Test levels

| Level | Focus |
| --- | --- |
| Domain unit | State transitions, formulas, eligibility, scoring, money, points, and identifiers |
| Application unit | Use-case orchestration, authorization policy, rollback decisions, and emitted events |
| Persistence integration | PostgreSQL constraints, mappings, transactions, isolation, concurrency, migrations, idempotency, and outbox |
| API contract | OpenAPI shape, status/error model, authentication, assignment scope, ETags/versioning, and idempotency |
| Client component | Form validation, status rendering, offline queue behavior, scans, and permission-aware UX |
| End-to-end | Cross-client business flows against real API and PostgreSQL |
| Performance/reliability | Allocation contention, sync bursts, outbox backlog, retry safety, and response objectives |

Use real PostgreSQL for transaction and constraint tests. In-memory providers cannot validate the concurrency and query behavior required by FSCM.

## Required business acceptance scenarios

### Authorization and scope

- Each of the six roles can perform only approved actions.
- Sales cannot view or order for a retailer outside assigned territory.
- Reassignment changes future access without rewriting the original order creator or assignment history.
- Warehouse Keepers cannot receive, pick, dispatch, or transfer stock for an unassigned warehouse.
- Retailers can confirm only their own delivered order and see only their own points, rewards, and complaints.
- Direct identifier access is denied even when list filtering or UI controls are bypassed.
- Normal user management cannot create or elevate an Admin account.

### Product and retailer lifecycle

- Draft products can be edited/deleted/published.
- Published products cannot be materially edited; a new SKU is required.
- Inactive products cannot enter a new order but remain correct in historical snapshots.
- Retailer codes and classifications follow approved formats/rules.
- Inactive or unapproved retailers cannot receive new orders.

### Batch, QR, and inventory

- Same warehouse + SKU + expiry receipt merges into one batch and preserves receipt history.
- A warehouse transfer creates/updates the destination batch and preserves root/QR lineage.
- Tag split conserves total quantity and prevents parent/child double use.
- `Available = On Hand - Held - Reserved` after every transition.
- Allocation, approval, release, dispatch, transfer, and receipt never produce negative quantities.
- Expired batches are rejected even when a stored expiry status is stale.
- Duplicate scan, dispatch, or receipt retries do not adjust stock twice.

### Allocation

Build deterministic fixtures covering every hard filter independently:

- expired batch;
- zero availability;
- distance beyond configured `Dmax`;
- ETA after requested delivery date;
- remaining life at ETA below retailer MLOR.

For eligible candidates, verify each score component, configured weights, batch-code tie-break, and recalculation of coverage after every greedy selection. Include allocations across multiple batches and warehouses.

Critical results:

- Complete supply creates holds for every line.
- A shortage on any line rejects/rolls back the entire order with no leaked hold.
- Discounts do not make an MLOR-ineligible batch eligible.
- Price is not included in allocation scoring.
- Changing configuration affects new allocations only; an existing allocation retains its snapshot.

### Concurrency

- Two simultaneous orders competing for the same last cartons cannot oversell.
- A bounded retry recomputes candidates and may select a valid fallback batch.
- Exhausted retries leave no order fragment or hold leak.
- Simultaneous approve/cancel settles in exactly one valid final result.
- Repeated dispatch and transfer receipt commands are idempotent.
- Multi-batch locking has no deadlock under the agreed deterministic order, or deadlocks are safely retried without duplication.

### Ordering and offline sync

- An online order receives server price, promotions, allocation, snapshots, and final code.
- An offline order remains a local draft until accepted by the server.
- Server processing order uses `server_received_at`, not device-created time.
- Repeated upload with the same key and payload returns the same `DH-*` result.
- Reusing the key with a different payload returns a conflict.
- Changed price/promotion is reported; client estimates never override server values.
- Loss of the response after commit followed by retry does not create a second order.
- Permanent business rejection and retryable technical failure are distinguishable.

### Approval, picking, and dispatch

- Approval converts equal held quantity to reserved quantity and creates picking work per warehouse.
- Rejection/cancellation releases only the applicable unconsumed quantity and records the reason.
- Picking rejects the wrong warehouse, order, batch, tag, or duplicate tag.
- Incomplete picking cannot dispatch.
- Dispatch decreases both reserved and on-hand quantities exactly once.
- Multi-warehouse order state advances only when all required warehouse work satisfies the transition rule.

### Promotion and replenishment

- Effective dates, target retailer/category/SKU, minimum quantity, and stacking/precedence rules are enforced.
- Order lines retain subtotal, discount, final amount, and applied-promotion snapshots.
- Suggested shelf-life tiers are configurable and manual discount remains within 1%-50%.
- Regional stock below the configured threshold generates the approved central-to-regional suggestion.
- Transfer source selection is FEFO and quantity is conserved through in-transit and receipt states.
- No active flow silently creates regional-to-regional rebalancing.

### Delivery, receipt, and complaint

- Delivery transition requires an authorized assignment and stores vehicle/person snapshots.
- No route optimization, driver-app, or GPS dependency is required for completion.
- Retailer receipt validates all expected tags and the owning retailer.
- Duplicate confirmation returns the original result and earns no duplicate points.
- A complaint records affected items and evidence without creating a return or changing inventory.

### Payment and loyalty

- Prepaid, COD, and deferred methods follow their allowed transition rules.
- Deferred due date equals delivery date plus 7, 14, or 30 configured days.
- Only full payment is accepted; duplicate confirmation cannot overpay.
- Overdue evaluation occurs after due date without automatically blocking new orders.
- Eligible prepaid/COD receipt earns points once.
- Deferred receipt creates pending points; full payment converts them once.
- Redemption holds/deducts points, rejection refunds once, fulfillment completes once, and expiry is ledger-backed.
- Only one loyalty program is active at a time and balance equals the signed ledger total.

### Audit, notification, and history

- Every material transition records actor, time, reason, correlation, and before/after meaning.
- Order status history is append-only and correctly ordered.
- A committed event produces one logical notification despite worker retries.
- A rolled-back transaction produces neither audit side effects nor an outbox message for the failed state.
- Sensitive credentials and evidence contents never appear in logs/audit payloads.

## Formula verification

Use table-driven boundary tests around exact cutoffs:

- retailer potential A/B/C thresholds;
- MLOR equality at ETA (eligible at the approved inclusive boundary);
- 20 km service-radius boundary;
- shelf-life discount thresholds at 60%, 40%, and 30%;
- replenishment at and immediately below 35 cartons;
- loyalty earning around each 100,000 VND increment;
- due-date behavior across month/year boundaries and Vietnam-local calendar dates.

Allocation formula tests should use decimal expectations and an explicit rounding policy. Never assert using binary floating-point equality.

## Non-functional evaluation

Record objectives and measured results rather than claiming unmeasured performance. At minimum evaluate:

- concurrent allocation throughput and rejection/retry rate;
- offline sync burst handling and FCFS ordering;
- p95/p99 command and query latency for agreed dataset sizes;
- outbox processing lag and duplicate-delivery behavior;
- database constraint/index performance for FEFO candidate queries;
- recovery after API/worker restart between commit and response/delivery;
- authorization isolation under direct API access.

Load data must represent multiple warehouses, retailers with different MLOR values, overlapping orders, expiry distributions, promotions, and assignment histories.

## Test data and clocks

- Use builders/fixtures with valid immutable business codes.
- Inject a controllable clock; do not make expiry, overdue, or program tests depend on wall-clock time.
- Keep time-zone conversion tests explicit for Asia/Ho_Chi_Minh while storing instants in UTC.
- Never copy production personal data into automated test environments.
- Keep deterministic seeds synchronized across backend and client demonstrations.

## Quality gates

A change is merge-ready when:

1. Formatting, static analysis, build, and existing tests pass in the affected repositories.
2. New/changed business rules have unit and integration coverage at the correct boundary.
3. Database changes include migration and rollback/forward-safety review.
4. API changes pass contract and authorization tests and update client contracts.
5. Critical stock, money, point, idempotency, and concurrency paths have failure/rollback tests.
6. Documentation and diagrams remain aligned with the approved baseline.
7. No test or implementation treats the pending rebalancing proposal as approved behavior.

Coverage percentage is supporting evidence, not the acceptance target. Prioritize invariant, branch, boundary, concurrency, and recovery coverage.

## Traceability

Acceptance evidence should map each approved capability to:

```text
business rule -> use case/API -> automated test -> result/artifact
```

Record pending and out-of-scope items separately so prototypes or experiments cannot be mistaken for completed requirements.
