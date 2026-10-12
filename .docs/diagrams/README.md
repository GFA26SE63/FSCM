# Diagram catalog

Editable Mermaid C4 sources live under `.diagram/`. They describe the approved [business baseline](../business/README.md) and must change with the corresponding architecture or scope decision.

## Authoritative sources

| View | Source | Purpose |
| --- | --- | --- |
| System context | `.diagram/system-context-diagram/context_diagram.mmd` | Six actors, FSCM responsibilities, and external systems |
| Container | `.diagram/c4model/container-diagram/container_diagram.mmd` | Web/mobile/API/worker/data boundaries |
| Backend overview | `.diagram/c4model/component-diagram/component_diagram_overview.mmd` | Major backend capability components |
| Sales order and allocation | `component_diagram_buying_order_management.mmd` | Online/offline order intake, allocation, holds, and approval |
| Goods receipt | `component_diagram_goods_receipt_management.mmd` | Receipt, batch merge, QR lineage, and inventory |
| Warehouse | `component_diagram_warehouse_management.mmd` | Warehouse master data, inventory, and central-to-regional transfers |
| Product | `component_diagram_product_management.mmd` | Category, SKU lifecycle, price, MLOR, and promotion data |
| Delivery and receipt | `component_diagram_delivery_management.mmd` | Picking/dispatch handoff, assignment, retailer receipt, and complaints |
| Platform support | `component_diagram_system_support_management_management.mmd` | Configuration, KPI, audit, notifications, jobs, and outbox |

The existing `context_diagram.drawio.xml` and `context_diagram.drawio.png` are legacy exports from the pre-baseline model. They are retained only for history and must not be used in current reports. Regenerate current exports from `context_diagram.mmd`.

## Rendering and review

Open `.mmd` sources with Mermaid Live Editor or a Mermaid-capable editor that supports C4 diagrams. Exports used in reports should be generated from the committed source and named with the same viewpoint.

Before approval, verify that diagrams:

- show exactly the six approved business roles;
- show retailers as receipt/loyalty/complaint users, not self-ordering users;
- keep mobile SQLite as cache/offline queue and PostgreSQL as server authority;
- represent hard-filter/scored allocation and the hold-to-reservation lifecycle;
- show only central-to-regional replenishment as approved;
- exclude driver apps, sale-route planning, route optimization, returns, and partial fulfillment;
- label regional-to-regional near-expiry rebalancing as pending if it appears at all.

Do not edit only a PNG export. Update the source, review the diff, then regenerate the export.
