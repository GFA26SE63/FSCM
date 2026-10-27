# FSCM class diagrams

The eighteen Mermaid files in this directory are scoped UML class diagrams generated from the current
domain entities, EF Core configurations, reporting contracts, and mobile offline models.

## Diagrams

1. `01-retailer-registration-assessment.mmd`
2. `02-purchase-order-offline-synchronization.mmd`
3. `03-fefo-mlor-allocation-availability.mmd`
4. `04-picking-retailer-receipt-confirmation.mmd`
5. `05-sales-groups-operational-reporting.mmd`
6. `06-system-configuration-notifications.mmd`
7. `07-authentication-user-account.mmd`
8. `08-product-category-management.mmd`
9. `09-promotion-batch-discount-management.mmd`
10. `10-warehouse-receiving-batch-inventory.mmd`
11. `11-payment-loyalty-management.mmd`
12. `12-delivery-operations.mmd`
13. `13-daily-allocation-run-approval-reservation.mmd`
14. `14-batch-pricing-price-traceability.mmd`
15. `15-inventory-expiry-monitoring-stock-blocking.mmd`
16. `16-shipment-readiness-dispatch-exception-handling.mmd`
17. `17-accounts-receivable-debt-collection.mmd`
18. `18-complaint-financial-adjustment-manual-refund.mmd`

## UML notation

- `-` means a private attribute; `+` is used for public DTO properties.
- `«PK»`, `«FK»`, and `«UK»` identify primary, foreign, and unique keys. `«REF»` marks a
  logical identifier retained by the domain model without an EF Core foreign-key constraint.
- `--` is an association, `*--` is composition, and `..>` is a dependency/data-flow relation.
- Cardinalities are written at both association ends (`1`, `0..1`, `0..*`, `1..*`).
- A nullable C# or Dart member is written with `?`.

## Import into draw.io

Open a `.mmd` file, copy its complete contents, then in draw.io select
**Arrange → Insert → Advanced → Mermaid**, paste the script, and choose **Insert**.

For a layout close to Visual Paradigm, keep the generated class compartments, use an orthogonal
connector style after import if desired, and export on an A3 landscape canvas for the larger
allocation and picking diagrams.
