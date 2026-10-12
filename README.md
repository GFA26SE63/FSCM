# FSCM

FSCM is a short-shelf-life FMCG warehouse operations and distribution system. It coordinates sales-assisted ordering, expiry-aware batch inventory, multi-warehouse allocation, fulfillment, delivery confirmation, payment, loyalty, and complaints while preserving end-to-end traceability.

The approved product scope is summarized in the [business baseline](.docs/business/README.md). That document governs repository documentation and implementation decisions; older assumptions must not be reintroduced without a new scope decision.

## Project status

The workspace is in the architecture and integration stage. The .NET backend, React portal, and Flutter clients are maintained as independent repositories. Current UI slices and infrastructure are not evidence that every approved workflow is production-complete.

The only business capability still awaiting supervisor approval is regional-to-regional near-expiry inventory rebalancing. It is a proposal and is not part of the coding baseline.

## Approved scope

- Sales users create orders for retailers in their assigned territory; retailers do not place orders themselves.
- Products follow `Draft -> Published -> Inactive`; material changes to a published product require a new SKU.
- Central and regional warehouses manage expiry-dated batches, QR-tag lineage, and `On Hand`, `Held`, `Reserved`, and `Available` quantities.
- Allocation applies expiry, availability, service-radius, ETA, and retailer MLOR hard filters before weighted FEFO-oriented scoring and greedy multi-warehouse allocation.
- An order is held only when every line can be fulfilled. Insufficient supply rejects the whole order; partial fulfillment and backorders are out of scope.
- Approved orders convert held stock to reserved stock, generate warehouse picking work, and reduce physical stock at dispatch.
- Promotions and shelf-life discounts are snapshotted on order lines but never override MLOR eligibility.
- Central warehouses replenish regional warehouses through controlled FEFO transfers.
- Delivery records a vehicle and delivery person; FSCM does not optimize routes or provide a driver application.
- Payment supports prepaid, COD, and full deferred payment with configured terms of 7, 14, or 30 days.
- Retailers confirm receipt by QR, earn loyalty points under controlled conditions, redeem gifts, and submit complaints. Returns, exchanges, and reverse logistics are out of scope.
- Offline sales orders are revalidated by the server and processed first-come, first-served by server receipt time with idempotent retries.

## Roles

| Role | Primary responsibility |
| --- | --- |
| Admin | Configuration, master data, promotions, loyalty, delivery resources, approvals, and audit oversight |
| Operator | Order operations, delivery assignment, eligible payment recording, complaints, and authorized approvals |
| Sales Manager | Sales groups, territories, assignments, KPI, and performance oversight |
| Sales | Retailer declaration, territory-scoped ordering, collection follow-up, and personal KPI |
| Warehouse Keeper | Assigned-warehouse receipt, QR operations, picking, dispatch, and transfer receipt |
| Retailer | Receipt confirmation, order information, loyalty, gift redemption, and complaints |

Authorization is enforced by both role and assignment scope at the API boundary. UI visibility is not an authorization control.

## Core order flow

```text
Sales creates order for an assigned retailer
  -> server validates price, promotion, inventory, ETA, and MLOR
  -> hard-filter eligible batches
  -> score and greedily allocate across warehouses
  -> fully available? no: reject the whole order
  -> fully available? yes: hold inventory and await approval
  -> approve: held -> reserved and create picking work
  -> pick and dispatch: reduce physical stock
  -> assign vehicle and delivery person
  -> deliver and confirm receipt by QR
  -> record payment state and handle loyalty points
```

Default allocation score:

```text
S = 0.5 * shelf_life_score + 0.3 * distance_score + 0.2 * coverage_score
```

Defaults such as the 20 km service radius, allocation weights, 35-carton replenishment threshold, shelf-life discount tiers, loyalty rate, and credit terms are configuration—not hard-coded constants.

## Repository map

```text
FSCM/
|-- FSCM-Backend/  .NET 10 API and automated tests (independent repository)
|-- FSCM-Frontend/ React 19 + TypeScript + Vite portal (independent repository)
|-- FSCM-Mobile/   Flutter clients and offline sales queue (independent repository)
|-- .docs/         Business, architecture, API, data, testing, and delivery guidance
|-- .diagram/      Editable architecture diagram sources
`-- README.md
```

The application directories are intentionally ignored by this integration repository because they have separate histories, branches, and delivery pipelines. The local `temp/` directory is also ignored and must never be used as a committed source of truth.

## Documentation

- [Approved business baseline](.docs/business/README.md)
- [Architecture and repository boundaries](.docs/architecture/repository-skeleton.md)
- [API contract rules](.docs/api/README.md)
- [Database and integrity rules](.docs/database/README.md)
- [Testing strategy](.docs/testing/README.md)
- [DevOps guidance](.docs/devops/README.md)
- [Diagram catalog](.docs/diagrams/README.md)

## Prerequisites

- .NET SDK 10
- Node.js and npm compatible with the frontend lockfile
- Flutter 3.44 / Dart 3.12 or a compatible newer toolchain
- PostgreSQL for server persistence

## Run locally

### Backend

```powershell
Copy-Item FSCM-Backend/src/FSCM.API/appsettings.example.json FSCM-Backend/src/FSCM.API/appsettings.Local.json
dotnet restore FSCM-Backend/FSCM.slnx
dotnet run --project FSCM-Backend/src/FSCM.API/FSCM.API.csproj --launch-profile https
```

The development profile uses `https://localhost:7027` and `http://localhost:5246`. Development-only Swagger is available at `/swagger`, GraphQL at `/graphql`, and health checks at `/health` when enabled by the backend repository.

### Web portal

```powershell
Copy-Item FSCM-Frontend/.env.example FSCM-Frontend/.env
Set-Location FSCM-Frontend
npm ci
npm run dev
```

### Mobile client

```powershell
Set-Location FSCM-Mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=https://localhost:7027 --dart-define=GRAPHQL_ENDPOINT=https://localhost:7027/graphql
```

Use an API address reachable from the emulator or device and configure local certificate trust when using HTTPS.

## Validation

```powershell
dotnet restore FSCM-Backend/FSCM.slnx
dotnet build FSCM-Backend/FSCM.slnx --configuration Release --no-restore
dotnet test FSCM-Backend/FSCM.slnx --configuration Release --no-build

Set-Location FSCM-Frontend
npm ci
npm run lint
npm run build

Set-Location ../FSCM-Mobile
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

Passing structural tests validates the toolchain and implemented slices only. Business readiness requires the acceptance scenarios in the [testing strategy](.docs/testing/README.md).

## Explicit exclusions

The current baseline excludes retailer self-ordering, wishlists, freshness selection at checkout, partial fulfillment, returns and exchanges, reverse logistics, credit limits, partial debt collection, debt aging, warehouse revenue, member-tier discounts, trip consolidation, route optimization, driver tracking, payment gateways, and retailer POS/sell-out inventory.
