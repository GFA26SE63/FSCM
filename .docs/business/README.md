# Approved business baseline

This document is the durable repository summary of the FSCM business baseline approved after Review 1. It controls implementation scope and supersedes older assumptions where they conflict. Defaults are configurable unless explicitly stated otherwise.

## Scope authority

| Classification | Meaning |
| --- | --- |
| Approved | May be designed, implemented, and tested as current scope |
| Out of scope | Must not be implemented without a new business decision |
| Pending proposal | May be analyzed but must not be treated as an acceptance requirement |

Regional-to-regional near-expiry rebalancing is the only pending proposal described here. Approved replenishment remains central warehouse to regional warehouse.

## Actors and access scope

FSCM has six business roles: Admin, Operator, Sales Manager, Sales, Warehouse Keeper, and Retailer.

- Sales can declare retailers and create orders only within assigned territories.
- Warehouse Keepers can operate only their assigned warehouses.
- Retailers receive order information, confirm receipt, use loyalty, redeem gifts, and submit complaints. Retailer self-ordering is excluded.
- Admin creation or privilege elevation is not exposed through normal user-management flows.
- Server-side authorization must combine role permissions with warehouse, sales-group, territory, and retailer assignments.

## Master data

Products follow `Draft -> Published -> Inactive`. Drafts may be edited or deleted. Published data is locked; a material commercial change creates a new SKU. Inactive products remain in history but cannot be used for new orders.

Retailers are declared by Sales, reviewed, assigned to a region and sales group, and classified for potential. Master data is inactivated instead of hard-deleted after it participates in business history.

Retailer declaration records retailer type, store size, forecast monthly revenue, expected monthly purchasing capacity, purchase frequency, and credit term. Approved potential classification is:

| Class | Qualification |
| --- | --- |
| A | Forecast revenue at least 60 million VND/month **or** purchasing capacity at least 120 cartons/month |
| B | Forecast revenue at least 30 million VND/month **or** purchasing capacity at least 60 cartons/month |
| C | All remaining approved retailers |

Store-size bands are S below 30 m², M from 30-60 m², and L above 60 m².

## Warehouses, batches, and QR lineage

- Central warehouses receive manufacturer stock and replenish regional warehouses.
- Regional warehouses hold inventory near retailers and fulfill sales orders.
- A batch is identified by warehouse, SKU, and expiry date. Repeated receipt of the same combination merges quantity into that batch.
- Moving stock creates a destination-warehouse batch while preserving QR/tag lineage.
- A QR code contains only an immutable tag identifier. Server data resolves its batch, quantity, location, and status.
- Partial use of a tag may create a child tag while the parent retains the remaining quantity.

Inventory uses four quantities:

```text
Available = On Hand - Held - Reserved
```

Successful allocation creates a hold. Approval converts held stock to reserved stock. Rejection or cancellation releases the applicable quantity. Physical stock decreases only when warehouse dispatch is confirmed. All stock transitions must be atomic and must never produce a negative balance.

## Sales order lifecycle

Sales-assisted orders follow:

```text
PendingSync -> PendingApproval -> Approved -> Issued -> Delivering -> Delivered
```

`Rejected` and `Cancelled` are controlled exception states. Every transition is authorized, validated, timestamped, and recorded in status history.

Order lines preserve immutable snapshots of the relevant SKU, product name, unit price, discounts, promotions, and applicable loyalty information. Later master-data changes do not rewrite order history.

The order unit is the carton. Business quantities are whole, non-negative cartons and cannot exceed available stock. Partial order fulfillment and backorders are not allowed.

Where a SKU uses configured buffer stock and order steps, the maximum selectable quantity is:

```text
floor((available - buffer_stock) / order_step) * order_step
```

## Allocation policy

Allocation is processed as one transaction:

```text
hard filters -> weighted scoring -> greedy allocation -> full-order check -> hold
```

A candidate batch is excluded when it is expired, has no available stock, exceeds the service radius, arrives after the requested delivery date, or fails the retailer's minimum life-on-receipt requirement (MLOR) at ETA.

```text
MLOR = retailer minimum-life ratio * total product shelf life
```

Eligible candidates are scored by shelf-life/FEFO pressure, distance, and coverage:

```text
S = wE * fE + wD * fD + wQ * fQ
default weights = 0.5 / 0.3 / 0.2
default service radius = 20 km
```

The highest-scoring candidate is allocated first. Coverage and scores are recalculated against remaining demand until every order line is satisfied or candidates are exhausted. Batch code ascending is the deterministic tie-breaker. If any line remains short, the entire allocation is rolled back and the order is rejected.

Price is not an allocation score. Shelf-life discounts and campaigns affect pricing only after eligibility; they can never make an MLOR-ineligible batch eligible.

## Promotions and replenishment

Shelf-life discounts are batch-specific. Suggested tiers are 5% at 60% remaining life, 10% at 40%, and 15% at 30%; an authorized administrator may configure a valid discount from 1% to 50%.

When regional available stock falls below the configured threshold (default 35 cartons per SKU), FSCM suggests a central-to-regional transfer. Source batches are selected FEFO, scanned out, marked in transit, scanned at destination, and received with quantity conservation.

## Fulfillment, delivery, and receipt

Approval converts holds to reservations and creates picking work per warehouse. Warehouse Keepers scan the expected tags and quantities. Dispatch consumes reservations and decreases physical stock.

An Operator assigns a vehicle and delivery person when delivery begins. The order keeps delivery identity snapshots. FSCM records delivery status only; driver accounts, driver apps, live GPS, trip consolidation, capacity optimization, and route optimization are excluded.

Retailers confirm receipt by scanning all required tags. Duplicate or cross-retailer confirmation is rejected. Differences are handled as complaints with evidence; complaints do not automatically return goods or adjust inventory.

## Payment and loyalty

Supported payment methods are prepaid, COD, and deferred payment. Deferred terms are no credit, 7, 14, or 30 days; due date is delivery date plus the retailer term. Only full payment is recorded, with `Unpaid`, `Paid`, or `Overdue` status.

Loyalty defaults to one point per 100,000 VND after promotion, with only one active program. Receipt confirmation earns points once. Credit-order points remain pending until full payment. Gift redemption holds/deducts points through approval and fulfillment; rejection refunds them. Ledger types are Earn, Pending Earn, Redeem, Refund, Adjustment, and Expired.

## Sales KPI and reporting

Sales performance uses revenue after promotion while retaining revenue before promotion and the promotion amount/rate. Default monthly KPI targets are:

| KPI | Default |
| --- | ---: |
| Successful orders | 15 |
| Retailers served | 5 |
| New retailers | 1 |
| Promotion/revenue ratio | At most 5% |

Approved reporting includes individual/team ranking, period comparison, top-selling products, cartons sold, and product revenue after promotion. Warehouse revenue and retailer POS/sell-out revenue are excluded.

## Offline sales orders

Offline values are estimates. PostgreSQL-backed server processing is authoritative and revalidates retailer access, product state, price, promotions, inventory, ETA, and MLOR. Orders are processed first-come, first-served by `server_received_at`. A stable client key makes retries idempotent and maps a temporary `OFF-*` code to one server `DH-*` order.

## Default configuration

| Group | Default |
| --- | --- |
| Allocation weights | `0.5 / 0.3 / 0.2` |
| Service radius | 20 km |
| Transit estimate | up to 10 km: 1 day; up to 20 km: 2 days |
| Regional minimum stock | 35 cartons per SKU |
| Shelf-life discount suggestions | 5% / 10% / 15% tiers |
| Loyalty rate | 1 point per 100,000 VND after promotion |
| Point expiry | Program end or 12 months after earning |
| Deferred terms | No credit / 7 / 14 / 30 days |

Configuration changes affect new processing only. Allocation, price, promotion, and assignment snapshots preserve historical decisions.

## Business identifiers

| Object | Format |
| --- | --- |
| Retailer | 8 digits |
| Retailer declaration | `KB-{4 digits}` |
| Region | 2-4 uppercase characters |
| Sales team | `{Region}-{Letter}` |
| Category | `CAT-{2 digits}` |
| SKU | `SKU{3 digits}` |
| Warehouse | `WH-{2-4 characters}` |
| Batch | `{Warehouse}-{SKU}-{ddMMyyyy}` |
| QR tag | `TEM-{6 digits}` |
| Order | `DH-{6 digits}` |
| Offline order | `OFF-{Device}-{4 digits}` |
| Picking list | `{Order}{A/B/C...}` |
| Document | `{Type}-{yyMMdd}-{2 digits}` |
| Promotion | `KM-{3 digits}` |
| Loyalty program | `LP-{3 digits}` |
| Gift | `QUA-{3 digits}` |
| Gift redemption | `DQ-{yyMMdd}-{2 digits}` |
| Delivery person | `NG-{3 digits}` |
| Vehicle | License plate |

Server-issued business identifiers are immutable and never reused.

## Integrity and audit

- The server is the source of truth; mobile SQLite is cache and an offline command queue.
- Monetary currency is VND. Persist values without floating-point arithmetic and retain amounts before discount, discount amount, and final amount.
- Persist instants in UTC and display them in Vietnam time. Treat expiry as a business date where time-of-day is irrelevant.
- Use optimistic concurrency plus transactional validation for inventory and state changes.
- Idempotency is mandatory for offline sync, receipt confirmation, payment, loyalty earning, and redemption.
- Audit approvals, rejections, product lifecycle changes, promotions, batch discounts, payment confirmation, and other material state changes.
- Use an outbox for notifications and asynchronous work that must follow a committed transaction.

## Explicitly out of scope

- Retailer self-registration, self-ordering, wishlists, and freshness selection
- Partial shipment, partial fulfillment, backorders, or automatic MLOR relaxation
- Returns, exchanges, damaged-goods return, reverse logistics, and complaint-driven stock adjustment
- Credit limits, partial payment, installment history, debt aging, and automated overdue blocking
- Warehouse revenue and retailer sell-out/POS inventory
- Loyalty cash conversion and member-tier discounting
- Driver application, live GPS, route optimization, trip consolidation, and global multi-order optimization
- Payment gateway integration

## Pending proposal: regional near-expiry rebalancing

The proposal would review batches nightly, estimate sell-through using 14-day velocity and retailer MLOR, identify excess, hard-filter destinations within 40 km, score capacity/distance/coverage, and greedily suggest transfers in 10-carton multiples. Admin would make the final decision.

This proposal is not an approved coding requirement. Insufficient history must produce no suggestion, and no implementation may present it as active scope until supervisor approval is recorded.
