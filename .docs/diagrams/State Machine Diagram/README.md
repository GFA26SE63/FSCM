# FSCM State Machine Diagrams (Mermaid)

One Mermaid `.mmd` state diagram per object (file name = object name). Renders with any Mermaid tool (mermaid.live, VS Code Mermaid preview, `@mermaid-js/mermaid-cli`).

| File | Object | Source of truth |
|---|---|---|
| `SalesOrder.mmd` | SalesOrder (the "purchase order") | Implemented (code) |
| `GoodsReceipt.mmd` | GoodsReceipt (inbound stock-in) | Implemented (code) |
| `Product.mmd` | Product lifecycle | Implemented (code) |
| `AllocationRun.mmd` | AllocationRun | Implemented (code) |
| `AllocationPlanVersion.mmd` | AllocationPlanVersion | Implemented (code) |
| `AllocationRunOrder.mmd` | AllocationRunOrder (per-order outcome) | Implemented (code) |
| `Reservation.mmd` | Reservation / allocation inventory | Implemented (code) |
| `RunPickingList.mmd` | RunPickingList (active picking model) | Implemented (code) |
| `Shipment.mmd` | Shipment (per order, per warehouse) | Implemented; Delivering/Received transitions pending in code |
| `Complaint.mmd` | Complaint (ReceiptDiscrepancy) | Code: Open→Resolved only; review/approve flow proposed from docs |
| `ManualRefund.mmd` | ManualRefund | Implemented (code) |
| `RewardRedemption.mmd` | RewardRedemption (loyalty) | Implemented (code) |
| `WriteOff.mmd` | WriteOff | Proposed from docs — no transition logic in code yet |

## Implementation gaps surfaced by these diagrams

1. **Shipment** — `WaitingToPick`, `Delivering`, `Received` exist as `ShipmentStatuses` constants but only `Ready`, `Issued`, `Exception` are assigned by code today. The post-dispatch delivery/receipt transitions (F96 issue confirmation + per-warehouse actual receipt) are pending.
2. **Complaint (ReceiptDiscrepancy)** — code implements only `Open → Resolved` (string literals, no constants class). The review/approve/reject + financial-adjustment flow is drawn from the SRS/design.
3. **Write-Off** — the `WriteOff` entity has a `Status` column but no service/store/controller or transition logic. The whole lifecycle is drawn from the docs; needs a `WriteOffStatuses` constant class + a `WriteOffService`.

## Status values per object (as in code unless noted)

- **SalesOrder** (`OrderStatuses`): PendingApproval, PendingAllocation, Approved, Picking, Rejected, Cancelled, Issued, Delivering, Delivered
- **GoodsReceipt** (`GoodsReceiptStatuses`): Pending, Received
- **Product** (`ProductStatuses`): Draft, Published, Inactive
- **AllocationRun** (`AllocationRunStatuses`): Snapshotted, Planning, AwaitingApproval, Approved, Closed, Failed
- **AllocationPlanVersion** (`AllocationPlanVersionStatuses`): AwaitingApproval, Approved, RecalculationRequested, Superseded
- **AllocationRunOrder** (`AllocationRunOrderStatuses`): Pending, Fulfilled, Short
- **Reservation** (`AllocationInventoryStatuses` / `ReservationStatuses`): Tentative, Reserved, Released, Issued / Active, Released, Consumed
- **RunPickingList** (`RunPickingListStatuses`): Issued, Picking, Ready, NeedsHandling
- **Shipment** (`ShipmentStatuses`): WaitingToPick, Ready, Issued, Delivering, Received, Exception
- **ManualRefund** (`RefundStatuses`): PendingRefund, AwaitingVerification, Refunded
- **RewardRedemption** (string literals): Pending, Approved, Delivered, Completed, Rejected
- **Complaint (ReceiptDiscrepancy)**: Open, Resolved _(code)_ · + UnderReview, Approved, Rejected _(from docs)_
- **WriteOff**: _(from docs)_ Draft, Submitted, Approved, Rejected, Processed, Cancelled
