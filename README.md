# FSCM

FSCM (Short Shelf-Life FMCG Warehouse Operations and Distribution Allocation Management System with FEFO Optimization) is a graduation-thesis project for controlling expiry-sensitive FMCG inventory from warehouse receipt through allocation, dispatch, and retailer receipt reconciliation.

The system is intended to reduce expired stock, allocation conflicts, and receiving disputes by combining batch/lot traceability, FEFO allocation, role-based approvals, offline sales ordering, and evidence-backed warehouse operations.

## Project status

This multi-repository workspace is currently an **architecture and integration-stage implementation**. The solution boundaries, configuration, CI pipelines, and client dependencies are in place. Flutter contains interactive Sales, Retailer, and Warehouse feature slices, while the React portal contains role-aware Admin, Operator, Warehouse Keeper, and Sales Manager workflows backed by demonstration data. Backend business modules and production client persistence/API integration remain pending.

- [Repository skeleton assessment](.docs/architecture/repository-skeleton.md) describes the implementation boundaries and dependency rules.

## Core workflow

1. A Warehouse Keeper records an inbound receipt with SKU, batch/lot, and expiry data.
2. An Administrator approves the receipt before inventory is increased.
3. A daily tracker classifies batches as `Normal`, `Near-date`, or `Expired` and blocks expired stock from allocation.
4. A Sales Representative creates an order online or from the mobile app's offline queue.
5. After synchronization and approval, the allocation engine selects eligible stock using FEFO. Optimistic locking prevents concurrent orders from driving inventory below zero and allows fallback to the next eligible batch.
6. A Warehouse Keeper follows the generated picking list and attaches dispatch evidence.
7. A Retail Store Manager scans or enters received batch codes, reconciles quantities, attaches receipt evidence, and raises a complaint when needed. FSCM does not create store-level inventory in the current scope.
8. Administrators and managers monitor near-expiry inventory, post-promotion revenue, sales KPIs, best-selling products, complaints, write-offs, and audit history.

Supporting must-have capabilities include batch-specific near-expiry promotions, retailer loyalty, potential-retailer assessment, product category trees and lifecycle controls, Sales team access boundaries, basic driver/vehicle records, cancellation evidence, and multi-level write-off approval.

## Roles

| Role | Primary responsibility |
| --- | --- |
| Sales Representative | Retailer visits, offline order capture, synchronization, retailer assessment, and personal/team reporting within assigned access |
| Warehouse Keeper | Inbound receipt entry, batch inventory, FEFO picking, dispatch evidence, and damage reporting |
| Retail Store Manager | Receipt reconciliation, receipt evidence, complaints, order history, and loyalty |
| Administrator (Distribution Manager) | Approvals, master data, access control, inventory oversight, promotions, write-offs, and dashboards |
| Operator | Retailer review, delegated order decisions, delivery updates, complaints, and delegated batch promotions |
| Sales Manager | Sales regions/teams, assignments, team orders, revenue, and KPI reporting |
| Supply Chain Analyst | Optional forecasting, safety-stock, reorder, and loss analysis |
| Distribution/Logistics Coordinator | Optional logistics capabilities; advanced routing and cold-chain monitoring are outside the current scope |

## Repository map

```text
FSCM/
|-- FSCM-Backend/  .NET 10 API, tests, GitHub CI, and Azure Pipelines
|-- FSCM-Frontend/ React 19 + TypeScript + Vite management portal
|-- FSCM-Mobile/   Flutter clients for field and warehouse workflows
|-- .docs/         Cross-system architecture and engineering documentation
|-- diagram/       C4 and system-context diagrams
`-- README.md
```

Each application directory is an independent Git repository with its own `main` and `develop` branches, GitHub CI, and Azure Repo mirror. The backend solution contains API, Application, Domain, Infrastructure, Persistence, and Shared projects plus unit, integration, and load-test projects. The web and mobile applications are independent API consumers.

## Prerequisites

- .NET SDK 10
- Node.js and npm compatible with the lockfile
- Flutter 3.44 / Dart 3.12 or a compatible newer toolchain

## Run locally

### Backend

Create an ignored local settings file from the committed template, then replace its placeholder values:

```powershell
Copy-Item FSCM-Backend/src/FSCM.API/appsettings.example.json FSCM-Backend/src/FSCM.API/appsettings.Local.json
dotnet restore FSCM-Backend/FSCM.slnx
dotnet run --project FSCM-Backend/src/FSCM.API/FSCM.API.csproj --launch-profile https
```

The development profile uses `https://localhost:7027` and `http://localhost:5246`. Development-only OpenAPI/Swagger is at `/swagger`, GraphQL is at `/graphql`, and the health check is at `/health`.

### Web portal

```powershell
Copy-Item FSCM-Frontend/.env.example FSCM-Frontend/.env
Set-Location FSCM-Frontend
npm ci
npm run dev
```

See [FSCM-Frontend/README.md](FSCM-Frontend/README.md) for configuration and available scripts.

### Mobile client

```powershell
Set-Location FSCM-Mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=https://localhost:7027 --dart-define=GRAPHQL_ENDPOINT=https://localhost:7027/graphql
```

For an emulator or physical device, use an API address reachable from that device and configure local certificate trust when using HTTPS. See [FSCM-Mobile/README.md](FSCM-Mobile/README.md) for details.

## Validate the skeleton

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

The current test projects are structural placeholders; passing commands validate the skeleton and toolchain, not the business workflows described above.

## Scope decisions still pending

- The retailer payment model (prepaid versus postpaid/debt) must be finalized before its detailed flow is implemented.
- Batch and demo data must be standardized against the business ID rules before feature development and acceptance testing.
- Demand forecasting, advanced promotion rules, AI label translation, shelf-image analysis, advanced transport/cold-chain management, automated inter-warehouse balancing, and retailer-level recall tracing remain optional or future scope.

## Delivery

`FSCM-Backend/.azure/pipelines/application-delivery.yaml` restores, builds, tests, publishes, and packages every mirrored backend branch. Its deployment stage runs only for `main` and targets the configured Azure App Service through the `backend-production` environment.
