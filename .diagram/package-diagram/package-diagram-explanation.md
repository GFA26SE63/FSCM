# FSCM Package Diagram Explanation

The package names below are relative to each application's source root. Generated output, platform scaffolding, dependencies, and test artifacts are intentionally excluded. Each table has exactly the requested columns: `No`, `Package`, and `Description`.

## Backend (`FSCM-Backend/src`)

| No | Package | Description |
| ---: | --- | --- |
| 1 | `FSCM.API` | ASP.NET Core transport and composition boundary; exposes REST, GraphQL, authentication, middleware, and dependency registration without owning business rules. |
| 2 | `FSCM.API.Controllers` | Thin REST controllers that authorize, bind requests, invoke one application use case, and map the response. |
| 3 | `FSCM.API.Contracts` | HTTP request models grouped by business feature. |
| 4 | `FSCM.API.GraphQL` | Read-only GraphQL query surface, GraphQL models, and data loaders. |
| 5 | `FSCM.API.Security` | Request-user accessors and authorization helpers used to enforce actor and assignment scope at the API boundary. |
| 6 | `FSCM.API.Errors` | Maps feature exceptions and stable error codes to RFC Problem Details responses. |
| 7 | `FSCM.API.Extensions` | Composes services, exception handling, authentication, middleware, and the HTTP pipeline. |
| 8 | `FSCM.API.Options` | Strongly typed settings for authentication and external integrations. |
| 9 | `FSCM.Application` | Use-case layer; owns orchestration, application contracts, policies, and ports implemented by outer adapters. |
| 10 | `FSCM.Application.Features` | Parent package for feature-oriented services, result/command contracts, operation exceptions, and store/gateway interfaces. |
| 11 | `FSCM.Application.Features.Catalog` | Category, product lifecycle, SKU replacement, publication, and effective-price use cases. |
| 12 | `FSCM.Application.Features.Deliveries` | Dispatch, delivery assignment, and retailer receipt-confirmation workflows. |
| 13 | `FSCM.Application.Features.Identity` | Sign-in, token lifecycle, user administration, identity-provider linking, and user scope operations. |
| 14 | `FSCM.Application.Features.InternalTransfers` | Legacy internal-transfer use cases retained for migration compatibility; this capability is outside the currently registered MVP. |
| 15 | `FSCM.Application.Features.Inventory` | Goods receipt, inventory balance, batch lifecycle, expiry sweep, and inventory outbox workflows. |
| 16 | `FSCM.Application.Features.ManualPayments` | Full cash or bank-transfer payment recording and validation. |
| 17 | `FSCM.Application.Features.Maps` | Geocoding, route-distance cache, and map-location orchestration through an application-owned provider port. |
| 18 | `FSCM.Application.Features.Orders` | Assisted ordering, pricing snapshots, allocation, approval, cancellation, and scoped order queries. |
| 19 | `FSCM.Application.Features.Payments` | Receivable planning, payOS checkout/webhook handling, settlement, and overdue-state rules. |
| 20 | `FSCM.Application.Features.Picking` | Picking-list planning, QR scans, completion, and dispatch preparation. |
| 21 | `FSCM.Application.Features.Promotions` | Campaigns, batch discounts, offer eligibility, and deterministic price snapshots. |
| 22 | `FSCM.Application.Features.QrLabels` | QR-label lookup, rendering, splitting, lineage, and inspection operations. |
| 23 | `FSCM.Application.Features.Retailers` | Retailer declaration, review, activation, profile, and scoped retailer management. |
| 24 | `FSCM.Application.Features.Territory` | Regions, sales groups, assignment history, and Sales-to-retailer eligibility. |
| 25 | `FSCM.Application.Features.WarehouseConfiguration` | Warehouse master data, transit-time rules, MLOR, and versioned business configuration. |
| 26 | `FSCM.Application.Abstractions` | Reserved home for cross-cutting application ports such as clocks, actor context, transactions, and gateways. |
| 27 | `FSCM.Application.Common` | Reusable application concerns such as audit, concurrency, and unit-of-measure conventions. |
| 28 | `FSCM.Domain` | Dependency-free business model and deterministic rules; it has no transport, database, or provider dependency. |
| 29 | `FSCM.Domain.Entities` | Persisted domain state, aggregate records, enums, value-like records, and domain constants. |
| 30 | `FSCM.Domain.Allocation` | Deterministic candidate filtering, scoring, and greedy stock-allocation algorithm. |
| 31 | `FSCM.Domain.Authorization` | Business roles, scope claim names, and account-token purposes. |
| 32 | `FSCM.Domain.Common` | Reserved location for domain primitives shared across aggregates. |
| 33 | `FSCM.Persistence` | EF Core/PostgreSQL adapter implementing application store ports and transaction behavior. |
| 34 | `FSCM.Persistence.DbContexts` | EF Core database context and model-configuration entry point. |
| 35 | `FSCM.Persistence.Configurations` | Entity mappings, constraints, indexes, relationships, and physical-schema configuration. |
| 36 | `FSCM.Persistence.<Feature>` | Feature-aligned store implementations for Catalog, Deliveries, Identity, InternalTransfers, Inventory, ManualPayments, Maps, Orders, Payments, Picking, Promotions, QrLabels, Retailers, Territory, and WarehouseConfiguration. |
| 37 | `FSCM.Persistence.Migrations` | Immutable EF Core migration history for the PostgreSQL schema. |
| 38 | `FSCM.Persistence.Seeding` | Deterministic development-only identity and business datasets. |
| 39 | `FSCM.Persistence.Interceptors` | Extension point for EF Core cross-cutting behavior. |
| 40 | `FSCM.Infrastructure` | Adapter layer for technical or third-party services that are not database persistence. |
| 41 | `FSCM.Infrastructure.Identity` | JWT creation/validation and password hashing implementations for application identity ports. |
| 42 | `FSCM.Infrastructure.Maps` | Google Maps provider adapter for geocoding and road-distance operations. |
| 43 | `FSCM.Infrastructure.Payments` | payOS gateway implementation. |
| 44 | `FSCM.Infrastructure.BackgroundJobs` | Hosted workers and scheduling for expiry sweeps and durable inventory-outbox dispatch. |
| 45 | `FSCM.Infrastructure.ExternalServices` | Template/extension package for additional third-party adapters. |
| 46 | `FSCM.Infrastructure.Audit` | Reserved package for infrastructure-level audit adapters. |
| 47 | `FSCM.Infrastructure.Rbac` | Reserved package for infrastructure-level role-based access-control adapters. |
| 48 | `FSCM.Shared` | Intended for small, stable, domain-neutral primitives shared across layers; currently contains no production C# types. |

## Web portal (`FSCM-Frontend/src`)

| No | Package | Description |
| ---: | --- | --- |
| 1 | `app` | React application composition root containing startup, global providers, route definitions, and top-level layout. |
| 2 | `app.layout` | Authenticated portal shell with sidebar, top bar, role navigation, and notification entry points. |
| 3 | `app.pages` | Application-level pages that are not owned by a business feature, currently login and not-found pages. |
| 4 | `features` | Parent package for independently lazy-loaded, business-oriented portal modules. |
| 5 | `features.dashboard` | Administrative overview and revenue visualization. |
| 6 | `features.orders` | Order list/detail, approval actions, and allocation-trace inspection. |
| 7 | `features.debts` | Receivable and outstanding-debt monitoring. |
| 8 | `features.picking` | Picking-list list/detail views and picking workflow visibility. |
| 9 | `features.receipts` | Goods-receipt listing, creation, and receipt details. |
| 10 | `features.whtransfer` | Warehouse-transfer listing, creation actions, and transfer details. |
| 11 | `features.rotation` | Near-expiry rotation proposal views and actions in the portal prototype. |
| 12 | `features.fleet` | Delivery vehicle and driver/person management. |
| 13 | `features.batches` | Inventory-batch list and detailed batch state. |
| 14 | `features.batchpromo` | Shelf-life discount management and batch scan workflow. |
| 15 | `features.disposal` | Expired-stock write-off listing, creation, and details. |
| 16 | `features.promos` | Promotion campaign listing, creation, editing, and details. |
| 17 | `features.retailers` | Retailer list/detail, registration review, and retailer profile actions. |
| 18 | `features.loyalty` | Loyalty account and point-ledger administration. |
| 19 | `features.gifts` | Loyalty gift catalog administration. |
| 20 | `features.redeem` | Gift-redemption request list, details, and processing actions. |
| 21 | `features.regions` | Region, Sales-group, and assignment management. |
| 22 | `features.categories` | Product-category hierarchy management. |
| 23 | `features.products` | SKU lifecycle, pricing, product actions, and product details. |
| 24 | `features.warehouses` | Warehouse master-data list, editing, and details. |
| 25 | `features.users` | User account, role, status, identity-provider, and assignment administration. |
| 26 | `features.kpi` | Sales KPI, ranking, and detailed performance views. |
| 27 | `features.complaints` | Complaint list/detail and resolution workflow. |
| 28 | `features.config` | Business configuration editors, including allocation weights and transit rules. |
| 29 | `features.notifications` | Notification retrieval, unread badges, and notification-bell UI. |
| 30 | `shared` | Cross-feature client capabilities that do not belong to one business module. |
| 31 | `shared.api` | Central Axios client, Problem Details mapping, HTTP helpers, and common API types. |
| 32 | `shared.api.mock` | In-browser API adapter, fixtures, handlers, and calculation engines used in mock mode. |
| 33 | `shared.auth` | FSCM session context, bearer-token storage, role definitions, guards, and external identity exchange. |
| 34 | `shared.hooks` | Reusable React hooks for API mutations and common UI state. |
| 35 | `shared.lib` | Environment access, identifiers, date/status helpers, and display formatting. |
| 36 | `shared.router` | React Router compatibility helpers used by application and feature packages. |
| 37 | `shared.ui` | Reusable controls, tables, dialogs, form fields, status views, and feedback components. |

## Mobile (`FSCM-Mobile/lib`)

| No | Package | Description |
| ---: | --- | --- |
| 1 | `main.dart` | Flutter bootstrap that loads preferences, device/environment configuration, and replaces the real transport with `MockApi` when mock mode is enabled. |
| 2 | `app` | Application-level Material configuration, routing, theme selection, and role-based navigation composition. |
| 3 | `app.shell` | Separate bottom-navigation shells for Sales, Warehouse Keeper, and Retailer roles. |
| 4 | `features.common` | Parent package for presentation flows shared by more than one role. |
| 5 | `features.common.auth` | Splash/session restoration and login screens. |
| 6 | `features.common.notifications` | Notification list and reusable notification-bell behavior. |
| 7 | `features.common.profile` | Shared account/profile screen and role-specific action links. |
| 8 | `features.sales` | Parent presentation package for the Sales role. |
| 9 | `features.sales.home` | Sales dashboard and shortcuts to current work. |
| 10 | `features.sales.orders` | Assisted-order listing, creation, confirmation, and details. |
| 11 | `features.sales.products` | Product, stock, and promotion browsing for Sales. |
| 12 | `features.sales.retailers` | Assigned-retailer browsing and order-entry navigation. |
| 13 | `features.sales.debts` | Customer receivable lookup and collection context. |
| 14 | `features.sales.declare` | New-retailer declaration and declaration-status screens. |
| 15 | `features.sales.kpi` | Personal Sales KPI and ranking presentation. |
| 16 | `features.sales.scan` | Sales QR-scanning flow. |
| 17 | `features.sales.sync` | Offline command queue status, retry, and synchronization UI. |
| 18 | `features.warehouse` | Parent presentation package for the Warehouse Keeper role. |
| 19 | `features.warehouse.home` | Warehouse task overview and shortcuts. |
| 20 | `features.warehouse.picking` | Picking lists, line-level scans, progress, and completion screens. |
| 21 | `features.warehouse.labels` | QR-label detail and lineage presentation. |
| 22 | `features.warehouse.scan` | Warehouse QR scanner for picking or label lookup. |
| 23 | `features.warehouse.transfers` | Transfer list and transfer-detail screens. |
| 24 | `features.retailer` | Parent presentation package for the Retailer role. |
| 25 | `features.retailer.orders` | Retailer order history and order details. |
| 26 | `features.retailer.receive` | Delivery receipt confirmation by expected QR labels. |
| 27 | `features.retailer.payments` | Payment, checkout, and receivable presentation. |
| 28 | `features.retailer.loyalty` | Loyalty balance, ledger, gifts, and redemption entry points. |
| 29 | `features.retailer.complaints` | Complaint list and complaint-submission flow. |
| 30 | `features.retailer.scan` | Retailer QR scanner used for receipt-related navigation. |
| 31 | `data` | Data-access layer that hides online, local, calculated, and mock sources from presentation packages. |
| 32 | `data.models` | Typed DTOs, enums, and JSON mapping shared by repositories and screens. |
| 33 | `data.repositories` | Riverpod-backed facades that coordinate remote calls, local cache/queue, session state, and invalidation. |
| 34 | `data.remote` | Resource-oriented REST adapters that map typed requests and responses through the central API client. |
| 35 | `data.local` | SQLite database, local providers, cached snapshots, and the offline-order queue. |
| 36 | `data.local.daos` | Focused SQLite access for products, retailers, promotions, inventory snapshots, offline orders, and sync state. |
| 37 | `data.pricing` | Provisional offline order-limit and promotion calculations; the server remains authoritative. |
| 38 | `data.mock` | In-process implementation of the REST transport contract with seeded prototype data and resource handlers. |
| 39 | `core` | Parent package for role-independent technical services and pure utilities. |
| 40 | `core.auth` | Session state and user-role definitions. |
| 41 | `core.config` | Build-time environment values and stable device identity. |
| 42 | `core.network` | Transport abstraction, Dio implementation, endpoints, connectivity monitoring, and API exception mapping. |
| 43 | `core.storage` | Secure persistence for access and refresh tokens. |
| 44 | `core.utils` | Pure clock, date, ID, money, and status-display utilities. |
| 45 | `sync` | Offline queue ordering/retry logic and service that submits queued commands then refreshes authoritative state. |
| 46 | `shared` | Cross-feature presentation assets and navigation constants. |
| 47 | `shared.routes` | Single source of route names, paths, and parameter patterns. |
| 48 | `shared.theme` | Shared application color tokens. |
| 49 | `shared.widgets` | Reusable cards, states, dialogs, scanners, filters, order widgets, status chips, and timeline components. |
