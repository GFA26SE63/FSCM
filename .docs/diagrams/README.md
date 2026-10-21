# Diagram catalog

Editable Mermaid diagram sources live under `.diagram/`. The C4 views describe the approved [business baseline](../business/README.md); the package views document the current source organization, including any legacy or prototype-only package identified in their explanation file. Update the relevant view with every architecture or scope decision.

## Authoritative sources

| View | Source | Purpose |
| --- | --- | --- |
| System context | `.diagram/system-context-diagram/context_diagram.mmd` | Six actors, FSCM responsibilities, and external systems |
| Container | `.diagram/c4model/container-diagram/container_diagram.mmd` | Web/mobile/API/worker/data boundaries |
| Backend overview | `.diagram/c4model/component-diagram/component_diagram_overview.mmd` | Major backend capability components |
| Sales order and allocation | `component_diagram_sales_order_allocation.mmd` | Online/offline order intake, allocation, holds, and approval |
| Goods receipt | `component_diagram_goods_receipt_management.mmd` | Receipt, batch merge, QR lineage, and inventory |
| Warehouse | `component_diagram_warehouse_management.mmd` | Warehouse master data, inventory, and central-to-regional transfers |
| Product | `component_diagram_product_management.mmd` | Category, SKU lifecycle, price, MLOR, and promotion data |
| Delivery and receipt | `component_diagram_delivery_management.mmd` | Picking/dispatch handoff, assignment, retailer receipt, and complaints |
| Platform support | `component_diagram_platform_support.mmd` | Configuration, KPI, audit, notifications, jobs, and outbox |
| Backend packages | `.diagram/package-diagram/backend-package-diagram.mmd` | Clean Architecture projects, source packages, and inward dependencies |
| Web portal packages | `.diagram/package-diagram/frontend-package-diagram.mmd` | React app, lazy feature modules, and shared client packages |
| Mobile packages | `.diagram/package-diagram/mobile-package-diagram.mmd` | Flutter app, role features, data/core layers, and offline synchronization |
| Package explanations | `.diagram/package-diagram/package-diagram-explanation.md` | Three-column package catalog for all three applications |

## Rendering and review

Open `.mmd` sources with Mermaid Live Editor or a Mermaid-capable editor. In draw.io, use **Arrange → Insert → Advanced → Mermaid**, paste the source, and choose **Diagram** when editable shapes are required. Exports used in reports should be generated from the committed source and named with the same viewpoint.

Before approval, verify that diagrams:

- show exactly the six approved business roles;
- show retailers as receipt/loyalty/complaint users, not self-ordering users;
- keep mobile SQLite as cache/offline queue and PostgreSQL as server authority;
- represent hard-filter/scored allocation and the hold-to-reservation lifecycle;
- show only central-to-regional replenishment as approved;
- exclude driver apps, sale-route planning, route optimization, returns, and partial fulfillment;
- label regional-to-regional near-expiry rebalancing as pending if it appears at all.

Generated exports are not committed. Update the Mermaid source, review the diff, then generate report assets from the reviewed commit.
