# Graph Report - FSCM  (2026-10-30)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 11964 nodes · 39598 edges · 304 communities (271 shown, 33 thin omitted)
- Extraction: 91% EXTRACTED · 9% INFERRED · 0% AMBIGUOUS · INFERRED: 3429 edges (avg confidence: 0.78)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `83eb5dfc`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Community 0
- Community 1
- Community 2
- Community 3
- Community 4
- Community 5
- Community 6
- Community 7
- Community 8
- Community 9
- Community 10
- Community 11
- Community 12
- Community 13
- Community 14
- Community 15
- Community 16
- Community 17
- Community 18
- Community 19
- Community 20
- Community 21
- Community 22
- Community 23
- Community 24
- Community 25
- Community 26
- Community 27
- Community 28
- Community 29
- Community 30
- Community 31
- Community 32
- Community 33
- Community 34
- Community 35
- Community 36
- Community 37
- Community 38
- Community 39
- Community 40
- Community 41
- Community 42
- Community 43
- Community 44
- Community 45
- Community 46
- Community 47
- Community 48
- Community 49
- Community 50
- Community 51
- Community 52
- Community 53
- Community 54
- Community 55
- Community 56
- Community 57
- Community 58
- Community 59
- Community 60
- Community 61
- Community 62
- Community 63
- Community 64
- Community 65
- Community 66
- Community 67
- Community 68
- Community 69
- Community 70
- Community 71
- Community 72
- Community 73
- Community 74
- Community 75
- Community 76
- Community 77
- Community 78
- Community 79
- Community 80
- Community 81
- Community 82
- Community 83
- Community 84
- Community 85
- Community 86
- Community 87
- Community 88
- Community 89
- Community 90
- Community 91
- Community 92
- Community 93
- Community 94
- Community 95
- Community 96
- Community 97
- Community 99
- Community 100
- Community 101
- Community 102
- Community 103
- Community 104
- Community 105
- Community 106
- Community 107
- Community 108
- Community 109
- Community 110
- Community 111
- Community 112
- Community 113
- Community 114
- Community 115
- Community 116
- Community 117
- Community 118
- Community 119
- Community 121
- Community 123
- Community 124
- Community 125
- Community 127
- Community 128
- Community 129
- Community 130
- Community 131
- Community 132
- Community 133
- Community 134
- Community 135
- Community 136
- Community 137
- Community 138
- Community 140
- Community 141
- Community 142
- Community 143
- Community 144
- Community 145
- Community 146
- Community 147
- Community 148
- Community 149
- Community 150
- Community 151
- Community 152
- Community 153
- Community 154
- Community 155
- Community 156
- Community 157
- Community 158
- Community 159
- Community 160
- Community 161
- Community 162
- Community 163
- Community 164
- Community 165
- Community 166
- Community 168
- Community 169
- Community 170
- Community 173
- Community 174
- Community 175
- Community 176
- Community 177
- Community 178
- Community 180
- Community 182
- Community 183
- Community 184
- Community 185
- Community 186
- Community 187
- Community 188
- Community 189
- Community 190
- Community 191
- Community 192
- Community 195
- Community 196
- Community 197
- Community 198
- Community 199
- Community 202
- Community 203
- Community 204
- Community 205
- Community 211
- Community 212
- Community 213
- Community 215
- Community 216
- Community 217
- Community 218
- Community 220
- Community 222
- Community 223
- Community 224
- Community 225
- Community 226
- Community 227
- Community 228
- Community 229
- Community 230
- Community 232
- Community 233
- Community 240
- Community 268
- Community 290
- Community 291
- Community 292
- Community 293
- Community 294
- Community 295
- Community 296
- Community 297
- Community 298
- Community 300
- Community 301
- Community 302
- Community 303
- Community 304
- Community 305
- Community 307
- Community 308
- Community 310
- Community 311
- Community 312
- Community 313
- Community 316
- Community 320
- Community 321
- Community 323
- Community 326
- Community 327
- Community 328
- Community 330
- Community 331
- Community 332
- Community 333
- Community 339
- Community 340
- Community 346
- Community 348
- Community 349
- Community 350
- Community 351
- Community 352
- Community 354
- Community 355
- Community 356
- Community 357
- Community 358
- Community 359
- Community 360
- Community 361
- Community 362
- Community 363
- Community 364
- Community 365
- Community 367
- Community 368
- Community 369
- Community 370
- Community 371
- Community 374
- Community 375
- Community 378
- Community 379
- Community 380
- Community 382
- Community 384
- Community 389
- Community 395
- Community 397
- Community 402
- Community 403
- Community 408
- Community 412
- Community 415
- Community 424
- Community 427
- Community 428
- Community 437
- Community 443
- Community 444
- Community 449
- Community 462
- Community 472
- Community 473

## God Nodes (most connected - your core abstractions)
1. `FSCM.Domain.Entities` - 355 edges
2. `AppDbContext` - 233 edges
3. `Product` - 118 edges
4. `Retailer` - 114 edges
5. `Batch` - 114 edges
6. `Button()` - 114 edges
7. `SalesOrder` - 113 edges
8. `UserAccount` - 111 edges
9. `FSCM.Persistence.Migrations` - 107 edges
10. `FSCM.Domain.Authorization` - 102 edges

## Surprising Connections (you probably didn't know these)
- `ScenarioFixture` --calls--> `AllocationPlanner`  [INFERRED]
  tests/FSCM.UnitTests/AllocationRuns/AllocationScenarioTests.cs → src/FSCM.Application/Features/AllocationRuns/AllocationPlanner.cs
- `ScenarioFixture` --calls--> `AllocationPricingService`  [INFERRED]
  tests/FSCM.UnitTests/AllocationRuns/AllocationScenarioTests.cs → src/FSCM.Application/Features/AllocationRuns/AllocationPricingService.cs
- `ScenarioFixture` --calls--> `DeliveryEtaService`  [INFERRED]
  tests/FSCM.UnitTests/AllocationRuns/AllocationScenarioTests.cs → src/FSCM.Application/Features/DeliveryEta/DeliveryEtaService.cs
- `ScenarioFixture` --calls--> `PublishShelfLifeDiscountTableData`  [INFERRED]
  tests/FSCM.UnitTests/AllocationRuns/AllocationScenarioTests.cs → src/FSCM.Application/Features/ShelfLifeDiscounts/ShelfLifeDiscountContracts.cs
- `ScenarioFixture` --calls--> `ShelfLifeDiscountTierData`  [INFERRED]
  tests/FSCM.UnitTests/AllocationRuns/AllocationScenarioTests.cs → src/FSCM.Application/Features/ShelfLifeDiscounts/ShelfLifeDiscountContracts.cs

## Import Cycles
- None detected.

## Communities (304 total, 33 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.03
Nodes (61): FSCM.API.Contracts.Inventory, CreateGoodsReceiptRequest, ReceiveGoodsLineRequest, CreateLoyaltyProgramRequest, UpdateLoyaltyProgramRequest, BatchDiscountCandidate, BatchDiscountView, IPromotionStore (+53 more)

### Community 2 - "Community 2"
Cohesion: 0.02
Nodes (50): RunPickingListView, RunPickingGatherResult, RunPickingGatherStatuses, RunPickingIssueService, RunPickingListResult, RunPickingListStatuses, RunPickingSplitResult, ProductQuery (+42 more)

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (28): EntityQuery, EntityQueryAccess, IEntityQueryService, SalesOrderAttachment, AttachmentType, BlobUrl, ContentType, FileName (+20 more)

### Community 4 - "Community 4"
Cohesion: 0.06
Nodes (46): FSCM.API.Options, AllocationRunExceptionHandler, CatalogExceptionHandler, ComplaintExceptionHandler, DeliveryEtaExceptionHandler, DeliveryExceptionHandler, IdentityExceptionHandler, InternalTransferExceptionHandler (+38 more)

### Community 5 - "Community 5"
Cohesion: 0.02
Nodes (94): AppDbContext, AccountTokens, AllocationLineTraceRecords, AllocationPlanPriceRecords, AllocationPlanVersionRecords, AllocationRecords, AllocationRunAllocationRecords, AllocationRunLineRecords (+86 more)

### Community 6 - "Community 6"
Cohesion: 0.05
Nodes (28): CategoriesController, CatalogPage, TotalPages, CategoryResult, CloneProductData, CreateReplacementProductData, DeleteCategoryResult, ProductPriceResult (+20 more)

### Community 7 - "Community 7"
Cohesion: 0.10
Nodes (15): FSCM.API.Contracts.AllocationRuns, ApprovePlanVersionRequest, RequestRecalculationRequest, CloseAllocationRunRequest, StartAllocationRunRequest, AllocationRunsController, AllocationPlanApprovalService, AllocationPlanAllocationResult (+7 more)

### Community 8 - "Community 8"
Cohesion: 0.05
Nodes (30): AllocationLineTraceOutcomes, AllocationPlanVersionStatuses, AllocationRunLineResult, AllocationRunOrderResult, AllocationRunOrderStatuses, AllocationRunResult, AllocationRunStatuses, AllocationRunStockResult (+22 more)

### Community 9 - "Community 9"
Cohesion: 0.06
Nodes (20): Program, IOrderPricingService, GoodsReceiptApiTests, IdentityApiFactory, Admin, EntityQueries, InactiveAdmin, Sales (+12 more)

### Community 10 - "Community 10"
Cohesion: 0.06
Nodes (3): IAllocationRunStore, AllocationRunStore, StubAllocationRunStore

### Community 11 - "Community 11"
Cohesion: 0.05
Nodes (28): FSCM.Infrastructure.Maps, FSCM.UnitTests.MobileSnapshots, FSCM.Application.Features.Deliveries, FSCM.Application.Features.EntityQueries, FSCM.Application.Features.Shipments, FSCM.Application.Features.QrLabels, FSCM.UnitTests.Shipments, FSCM.Infrastructure.Payments (+20 more)

### Community 12 - "Community 12"
Cohesion: 0.07
Nodes (14): FSCM.Persistence.Loyalty, FSCM.Persistence.Migrations, FSCM.Persistence.EntityQueries, FSCM.Persistence.Notifications, FSCM.Persistence.TransitTables, FSCM.Persistence.DeliveryEta, FSCM.Persistence.Territory, FSCM.Persistence.Quotes (+6 more)

### Community 13 - "Community 13"
Cohesion: 0.07
Nodes (20): ApplyBatchDiscountRequest, CreatePromotionRequest, UpdatePromotionRequest, BatchDiscountsController, PromotionsController, OrderPriceSnapshot, OrderPricingService, AppliedPromotionSnapshot (+12 more)

### Community 14 - "Community 14"
Cohesion: 0.05
Nodes (34): DependencyInjection, IPaymentPlanService, IPickingPlanService, IPickingStore, PickingItemView, PickingScanView, PickingView, PickingPlanService (+26 more)

### Community 15 - "Community 15"
Cohesion: 0.05
Nodes (18): AddIdentityAuthenticationSchema, AddManualPayment, AddIdentityProviderAndRegionScope, AddS1DReceiptQrInventoryExpiry, CompleteS1COrderPricingSnapshots, AddSalesOrderQuoteAndPurchaseOrder, AppDbContextModelSnapshot, CategorySeed (+10 more)

### Community 16 - "Community 16"
Cohesion: 0.05
Nodes (23): BatchInventoryView, GoodsReceiptLineView, GoodsReceiptView, IInventoryStore, InventoryHistoryView, InventoryStore, TestInventoryStore, Balance (+15 more)

### Community 17 - "Community 17"
Cohesion: 0.07
Nodes (10): IPaymentStore, PaymentView, PaymentStore, FakePaymentStore, FakePaymentStore, Audits, HasOpenDispute, Payments (+2 more)

### Community 18 - "Community 18"
Cohesion: 0.04
Nodes (31): FSCM.Persistence.MobileSnapshots, FSCM.Persistence.AllocationRuns, FSCM.UnitTests.InternalTransfers, FSCM.Persistence.QrLabels, FSCM.Persistence.ManualPayments, FSCM.UnitTests.Reports, FSCM.Persistence.WarehouseConfiguration, FSCM.Persistence.Reports (+23 more)

### Community 19 - "Community 19"
Cohesion: 0.06
Nodes (24): InventoryOperationException, Code, PromotionOperationException, Code, FixedTimeProvider, Fixture, ActorId, Allocation (+16 more)

### Community 20 - "Community 20"
Cohesion: 0.02
Nodes (41): InitialPhysicalSchema, AddCatalogProductLifecycle, AddWarehouseConfiguration, AddTerritorySalesGroups, AddReceiptBatchInventory, AddQrLabelLineage, AddInternalTransfers, AddAssistedOrderWorkflow (+33 more)

### Community 21 - "Community 21"
Cohesion: 0.07
Nodes (15): FSCM.API.Contracts.Promotions, FSCM.API.Contracts.Loyalty, FSCM.API.Contracts.Maps, FSCM.API.Contracts.WarehouseConfiguration, FSCM.Domain.Authorization, FSCM.API.Controllers, FSCM.API.Errors, FSCM.API.Contracts.Territory (+7 more)

### Community 22 - "Community 22"
Cohesion: 0.06
Nodes (18): IRetailerStore, RetailerStore, TestRetailerStore, Category, Mlors, Product, Retailer, SalesId (+10 more)

### Community 23 - "Community 23"
Cohesion: 0.03
Nodes (50): PickableAllocation, RunPickingGather, BatchCodeSnapshot, BatchId, CreatedAt, Id, PickedQuantity, ProductId (+42 more)

### Community 24 - "Community 24"
Cohesion: 0.08
Nodes (10): AuditLog, Action, CreatedAt, EntityId, EntityName, Id, NewValues, OldValues (+2 more)

### Community 25 - "Community 25"
Cohesion: 0.09
Nodes (12): FSCM.API.Contracts.Payments, AdjustReceivableRequest, CollectPaymentRequest, CreatePayOsCheckoutRequest, PayOsWebhookDataRequest, PayOsWebhookRequest, PaymentsController, PaymentResult (+4 more)

### Community 26 - "Community 26"
Cohesion: 0.09
Nodes (7): IQrLabelStore, QrLabelEventView, QrLabelView, QrLabelStore, FakeStore, Events, Labels

### Community 27 - "Community 27"
Cohesion: 0.09
Nodes (10): DeliveryEtaOperationException, Code, AllocationRunPlanningTests, PlanningFixture, DeliveryEtaServiceTests, FixedClock, Fixture, Service (+2 more)

### Community 28 - "Community 28"
Cohesion: 0.06
Nodes (15): DeliveryInventoryIssue, DeliveryView, IDeliveryStore, ReceiptItemView, DeliveryStore, FakeDeliveryStore, Deliveries, Drivers (+7 more)

### Community 29 - "Community 29"
Cohesion: 0.12
Nodes (5): OrderRetailerContext, CreateAssistedOrderData, CreateOrderLineData, OfflineExpectedConditionData, SubmitOfflineOrderData

### Community 30 - "Community 30"
Cohesion: 0.19
Nodes (5): PagedUserResult, UserListQuery, SystemRoles, All, Assignable

### Community 31 - "Community 31"
Cohesion: 0.06
Nodes (34): RefundView, ManualRefund, Amount, CreatedAt, CreatedByUserId, CreateOperationKey, CreateRequestHash, EvidenceOperationKey (+26 more)

### Community 32 - "Community 32"
Cohesion: 0.12
Nodes (13): PricingController, OrderDetailResult, AllocationPlanVersion, AllocationRunCode, IndicativeAmount, OfficialAmount, OfficialPricedAt, WarehouseProgress (+5 more)

### Community 33 - "Community 33"
Cohesion: 0.11
Nodes (14): FSCM.API.Contracts.Refunds, CreateRefundRequest, SubmitRefundEvidenceRequest, VerifyRefundRequest, RefundsController, IRefundStore, CreateRefundData, RefundResult (+6 more)

### Community 34 - "Community 34"
Cohesion: 0.06
Nodes (50): AutoMapper (16.2.0), BCrypt.Net-Next (4.2.0), FluentValidation (12.1.1), FluentValidation.DependencyInjectionExtensions (12.1.1), HotChocolate.AspNetCore (16.5.1), HotChocolate.AspNetCore.Authorization (16.5.1), HotChocolate.Data (16.5.1), HotChocolate.Types.Analyzers (16.5.1) (+42 more)

### Community 36 - "Community 36"
Cohesion: 0.06
Nodes (17): IRunPickingStore, RunPickingScanView, RunPickingWorkflowView, RunPickingStore, PickingContractStore, Events, Gather, InventoryIssues (+9 more)

### Community 37 - "Community 37"
Cohesion: 0.06
Nodes (23): ConfirmShipmentIssueData, ConfirmShipmentReceiptData, ConfirmShipmentReceiptLineData, ShipmentOperationException, Code, PhysicalSchemaModelTests, AllocationRunServiceTests, FixedClock (+15 more)

### Community 38 - "Community 38"
Cohesion: 0.05
Nodes (30): LoyaltyController, ILoyaltyStore, CreateLoyaltyProgramData, LoyaltyProgramResult, LoyaltyProgramView, UpdateLoyaltyProgramData, LoyaltyService, LoyaltyProgram (+22 more)

### Community 39 - "Community 39"
Cohesion: 0.04
Nodes (27): FSCM.UnitTests.Promotions, FSCM.UnitTests.Picking, FSCM.UnitTests.Inventory, FSCM.Application.Features.TransitTables, FSCM.Application.Features.Quotes, FSCM.Application.Features.InventoryLocks, FSCM.UnitTests.InventoryLocks, FSCM.UnitTests.Loyalty (+19 more)

### Community 40 - "Community 40"
Cohesion: 0.14
Nodes (9): FSCM.API.Contracts.ManualPayments, CancelManualPaymentRequest, ConfirmManualPaymentRequest, RecordManualPaymentRequest, ManualPaymentsController, ChangeManualPaymentData, ManualPaymentResult, RecordManualPaymentData (+1 more)

### Community 41 - "Community 41"
Cohesion: 0.11
Nodes (13): FSCM.API.Contracts.QrLabels, GenerateQrLabelRequest, ScanQrLabelRequest, SplitQrLabelRequest, QrLabelsController, GenerateQrLabelData, QrLabelDetailResult, QrLabelEventResult (+5 more)

### Community 42 - "Community 42"
Cohesion: 0.06
Nodes (27): IManualPaymentStore, ManualPaymentView, ManualPayment, Amount, ConfirmedAt, ConfirmedByUserId, CreatedAt, Id (+19 more)

### Community 43 - "Community 43"
Cohesion: 0.08
Nodes (27): FSCM.UnitTests.Allocation, AllocationBenchmark, AllocationBenchmarkResult, AllocationDecision, AllocationEngine, AllocationFilterReason, ArrivesAfterDeadline, BelowMlor (+19 more)

### Community 44 - "Community 44"
Cohesion: 0.08
Nodes (16): IReportStore, ProductSalesRow, SalesKpiConfigurationRow, SalesKpiOrderRow, SalesRevenueRow, ReportStore, TestStore, GroupId (+8 more)

### Community 45 - "Community 45"
Cohesion: 0.07
Nodes (28): CreateRedemptionRequest, LoyaltyRedemptionsController, LoyaltyRedemptionWorkflowController, IRedemptionStore, IRedemptionWorkflowStore, CreateRedemptionData, RedemptionResult, RedemptionView (+20 more)

### Community 46 - "Community 46"
Cohesion: 0.10
Nodes (17): RetailerReceivablesController, IRetailerReceivableStore, ReceivableCollectionHistory, ReceivableDisputeHistory, ReceivableRefundHistory, RetailerReceivableFilter, RetailerReceivablePage, RetailerReceivableResult (+9 more)

### Community 47 - "Community 47"
Cohesion: 0.12
Nodes (10): GoodsReceiptsController, InventoryController, BatchInventoryResult, ExpirySweepRunResult, GoodsReceiptLineResult, GoodsReceiptResult, InventoryExpiryHealthResult, InventoryHistoryResult (+2 more)

### Community 48 - "Community 48"
Cohesion: 0.06
Nodes (31): FSCM.API.Contracts.Orders, CloneProductRequest, CreateCategoryRequest, CreateProductRequest, CreateReplacementProductRequest, SetProductPriceRequest, UpdateCategoryRequest, UpdateCategoryStatusRequest (+23 more)

### Community 49 - "Community 49"
Cohesion: 0.20
Nodes (3): RegionsController, RegionResult, TerritoryService

### Community 50 - "Community 50"
Cohesion: 0.11
Nodes (14): AllocationRunAllocation, AllocationPlanVersionId, AllocationRunId, AllocationRunLineId, BatchId, CreatedAt, EstimatedArrivalAt, Id (+6 more)

### Community 51 - "Community 51"
Cohesion: 0.11
Nodes (10): Warehouse, Address, Code, CreatedAt, Id, IsActive, MinimumStockThresholdCartons, Name (+2 more)

### Community 52 - "Community 52"
Cohesion: 0.02
Nodes (85): FSCM.Persistence.Configurations.Identity, FSCM.Persistence.Configurations.PhysicalSchema, UserAccount, CreatedAt, Email, EntraObjectId, FullName, Id (+77 more)

### Community 53 - "Community 53"
Cohesion: 0.07
Nodes (11): IInternalTransferStore, InternalTransferStore, FakeStore, Events, Items, Labels, Links, Positions (+3 more)

### Community 54 - "Community 54"
Cohesion: 0.07
Nodes (21): IInventoryOutboxStore, BatchExpiredPayload, InventoryOutboxDispatcher, InventoryOutboxDispatchResult, OutboxMessage, AggregateId, AggregateType, CreatedAt (+13 more)

### Community 55 - "Community 55"
Cohesion: 0.09
Nodes (19): IInventoryLifecycleService, IInventoryLifecycleStore, InventoryLifecycleView, Allocation, Balance, Batch, Reservation, AllocationInventoryStatuses (+11 more)

### Community 56 - "Community 56"
Cohesion: 0.06
Nodes (30): Retailer, Address, AssessedAt, AssessedByUserId, AssessmentNote, Code, ContactName, CreatedAt (+22 more)

### Community 57 - "Community 57"
Cohesion: 0.08
Nodes (12): ITerritoryStore, RetailerTerritoryAssignmentView, SalesGroupView, TerritoryAccessView, TerritoryStore, InMemoryStore, Groups, Memberships (+4 more)

### Community 58 - "Community 58"
Cohesion: 0.08
Nodes (18): DeliveryOperationException, Code, DeliveryServiceTests, FixedTimeProvider, Fixture, Allocation, Balance, Driver (+10 more)

### Community 59 - "Community 59"
Cohesion: 0.09
Nodes (17): OrderOperationException, Code, Details, FakePickingPlan, Calls, CancelCalls, FakePricing, Fixture (+9 more)

### Community 60 - "Community 60"
Cohesion: 0.04
Nodes (40): AllocationPlanAllocationView, AllocationPlanVersionView, AllocationPlanVersion, AllocationRunId, ApprovedAt, ApprovedByUserId, CreatedAt, FulfilledOrderCount (+32 more)

### Community 61 - "Community 61"
Cohesion: 0.05
Nodes (29): EtaScheduleView, IDeliveryEtaStore, MapDistanceCache, CalculatedAt, DestinationLocationId, DestinationLocationVersion, DistanceMeters, DurationSeconds (+21 more)

### Community 62 - "Community 62"
Cohesion: 0.09
Nodes (21): ConfirmRetailerReceiptRequest, CreateDriverRequest, CreateVehicleRequest, DispatchOrderRequest, SetActiveRequest, UpdateDriverRequest, UpdateVehicleRequest, DeliveriesController (+13 more)

### Community 63 - "Community 63"
Cohesion: 0.12
Nodes (14): FSCM.API.Contracts.Picking, CompleteRunPickingRequest, RunPickingSplitQuantityRequest, ScanPickingLabelRequest, PickingListsController, PickingItemStatuses, PickingListResult, PickingListStatuses (+6 more)

### Community 64 - "Community 64"
Cohesion: 0.04
Nodes (41): AllocationRunStock, AllocationRunId, BatchId, CreatedAt, ExpirationDate, Id, InventoryVersion, ProductId (+33 more)

### Community 65 - "Community 65"
Cohesion: 0.06
Nodes (30): CreateRewardRequest, UpdateRewardRequest, LoyaltyRewardsController, IRewardStore, CreateRewardData, RewardResult, RewardView, UpdateRewardData (+22 more)

### Community 66 - "Community 66"
Cohesion: 0.19
Nodes (8): BatchPromotion, AssignedAt, AssignedByUserId, BatchId, Id, IsActive, PromotionId, RemovedAt

### Community 67 - "Community 67"
Cohesion: 0.16
Nodes (18): MobileController, IMobileSnapshotStore, MobileSnapshotCategory, MobileSnapshotData, MobileSnapshotDefaultMlor, MobileSnapshotMlor, MobileSnapshotPrice, MobileSnapshotProduct (+10 more)

### Community 68 - "Community 68"
Cohesion: 0.08
Nodes (13): QrLabelEvent, BatchQrLabelId, EventType, FromStatus, Id, Note, OccurredAt, OperationKey (+5 more)

### Community 69 - "Community 69"
Cohesion: 0.13
Nodes (11): NotificationsController, MarkAllNotificationsReadResult, NotificationBadgeResult, NotificationOperationException, Code, NotificationPage, NotificationResult, NotificationService (+3 more)

### Community 70 - "Community 70"
Cohesion: 0.11
Nodes (15): AllocationLineTrace, AllocationPlanVersionId, AllocationRunLineId, CoverageWeight, CreatedAt, DistanceWeight, DrawnQuantity, Id (+7 more)

### Community 71 - "Community 71"
Cohesion: 0.06
Nodes (30): SalesOrder, ClientOrderKey, CreatedAt, CreatedByUserId, CreditTermDays, DeliveryAddress, DiscountAmount, FinalAmount (+22 more)

### Community 72 - "Community 72"
Cohesion: 0.35
Nodes (10): DbCategory, categoryDto(), catName(), find(), nextSku(), productDetail(), productSummary(), readProduct() (+2 more)

### Community 73 - "Community 73"
Cohesion: 0.09
Nodes (16): TransitTimeRuleResult, TransitTimeRule, CreatedAt, EffectiveFrom, EffectiveTo, EstimatedTransportCost, HandlingMinutes, Id (+8 more)

### Community 74 - "Community 74"
Cohesion: 0.04
Nodes (27): IIdentityStore, SalesGroupMember, AssignedAt, Id, IsActive, SalesGroupId, UnassignedAt, UserAccountId (+19 more)

### Community 75 - "Community 75"
Cohesion: 0.06
Nodes (30): Payment, AdjustedAmount, Amount, CollectionMethod, ConfirmedAmount, ConfirmedAt, ConfirmedByUserId, CreatedAt (+22 more)

### Community 76 - "Community 76"
Cohesion: 0.11
Nodes (14): FSCM.API.Contracts.ShelfLifeDiscounts, PublishShelfLifeDiscountTableRequest, ShelfLifeDiscountTierRequest, ShelfLifeDiscountsController, PublishShelfLifeDiscountTableData, ShelfLifeDiscountMatch, ShelfLifeDiscountScopes, ShelfLifeDiscountTableResult (+6 more)

### Community 77 - "Community 77"
Cohesion: 0.10
Nodes (15): AdjustReceivableData, PaymentOperationException, Code, FixedTimeProvider, Fixture, Gateway, Order, Payment (+7 more)

### Community 78 - "Community 78"
Cohesion: 0.06
Nodes (18): CreateWarehouseRequest, SetMlorRequest, UpdateBusinessConfigurationRequest, UpdateWarehouseRequest, UpdateWarehouseStatusRequest, BusinessConfigurationsController, MlorConfigurationsController, WarehousesController (+10 more)

### Community 79 - "Community 79"
Cohesion: 0.13
Nodes (14): CollectPaymentData, CreatePayOsCheckoutData, IPayOsGateway, PaymentCollectionMethods, PaymentStatuses, PayOsCreateLinkData, PayOsLinkData, PayOsVerifiedWebhook (+6 more)

### Community 80 - "Community 80"
Cohesion: 0.08
Nodes (16): Batch, BatchCode, CreatedAt, ExpirationDate, ExpiryStatus, GoodsReceiptLineId, Id, ParentBatchId (+8 more)

### Community 81 - "Community 81"
Cohesion: 0.07
Nodes (22): INotificationStore, NotificationFilter, Notification, CreatedAt, DeepLink, Id, IsRead, Message (+14 more)

### Community 82 - "Community 82"
Cohesion: 0.03
Nodes (71): FSCM.API.Contracts.Shipments, AssignShipmentRequest, ConfirmShipmentIssueRequest, ConfirmShipmentReceiptLineRequest, ConfirmShipmentReceiptRequest, FlagShipmentExceptionRequest, ShipmentsController, IShipmentStore (+63 more)

### Community 84 - "Community 84"
Cohesion: 0.05
Nodes (32): ITransitTableStore, TransitTableView, TransitTable, CreatedAt, CreatedByUserId, EffectiveFrom, EffectiveTo, Id (+24 more)

### Community 85 - "Community 85"
Cohesion: 0.06
Nodes (29): SalesOrderLine, CreatedAt, DiscountAmount, DiscountPercent, DiscountSourceCode, DiscountSourceType, EstimatedArrivalAt, FinalPricePendingAllocation (+21 more)

### Community 86 - "Community 86"
Cohesion: 0.09
Nodes (26): AllocationTraceService, OrderTraceDetailResult, TraceCandidateResult, TraceLineResult, TraceScoreResult, TraceWeightsResult, AllocationLineTraceView, AllocationOrderTraceView (+18 more)

### Community 87 - "Community 87"
Cohesion: 0.31
Nodes (4): FSCM.API.Contracts.Complaints, CreateComplaintRequest, ResolveComplaintRequest, ComplaintsController

### Community 90 - "Community 90"
Cohesion: 0.36
Nodes (3): UpdateSalesGroupRequest, SalesGroupsController, SalesGroupResult

### Community 91 - "Community 91"
Cohesion: 0.06
Nodes (22): ServiceCollectionExtensions, IPasswordHasher, AllocationRunHostedService, AllocationRunOptions, CutoffLocalTime, Enabled, TimeZone, DateTrackerHostedService (+14 more)

### Community 92 - "Community 92"
Cohesion: 0.12
Nodes (16): EstimateEtaRequest, EtaController, AllocationScheduleResult, EtaBreakdown, EtaRequest, EtaResult, EstimatedArrivalAt, EtaSchedule (+8 more)

### Community 93 - "Community 93"
Cohesion: 0.22
Nodes (8): zustand@^5.0.14, @types/react-router-dom@^5.3.3, name, private, type, version, @types/react-router-dom, zustand

### Community 94 - "Community 94"
Cohesion: 0.10
Nodes (15): TransitTablesController, PublishTransitTableData, TransitBandData, TransitBandResult, TransitLookupResult, TransitTableResult, TransitTableOperationException, Code (+7 more)

### Community 95 - "Community 95"
Cohesion: 0.17
Nodes (9): IOrderStore, OrderAllocationFragmentView, OrderAllocationReadContext, OrderLineView, OrderView, AllocationContext, OrderWarehouseProgressView, OrderListQuery (+1 more)

### Community 97 - "Community 97"
Cohesion: 0.07
Nodes (15): BatchQrLabel, BatchId, BlobUrl, CurrentWarehouseId, GeneratedAt, GoodsReceiptId, Id, InvalidatedAt (+7 more)

### Community 101 - "Community 101"
Cohesion: 0.25
Nodes (6): AllocationPriceLookupService, OrderPriceLineResult, OrderPricePartResult, OrderPriceResult, AllocationPriceLookupTests, FakeStore

### Community 102 - "Community 102"
Cohesion: 0.12
Nodes (20): OfflineConditionConflictResult, OfflineConditionDifference, OrderAllocationFragmentResult, OrderAllocationResult, OrderLineResult, AllocationFragments, BaseUnitPrice, IndicativeNetAmount (+12 more)

### Community 103 - "Community 103"
Cohesion: 0.15
Nodes (8): AllocationRunOperationException, Code, AllocationScenarioTests, FixedClock, ScenarioBatch, ScenarioFixture, Service, Store

### Community 104 - "Community 104"
Cohesion: 0.10
Nodes (10): OrderInventoryCandidate, TestOrderStore, Audits, History, Lines, Orders, Product, Promotions (+2 more)

### Community 105 - "Community 105"
Cohesion: 0.15
Nodes (9): AuthenticatedUser, CreatedUserResult, IdentityScope, Empty, IdentityScopeLabels, Empty, IssuedAccessToken, ScopeLabel (+1 more)

### Community 106 - "Community 106"
Cohesion: 0.18
Nodes (3): RetailerMlorData, RetailerInput, RetailerService

### Community 107 - "Community 107"
Cohesion: 0.16
Nodes (13): ReportsController, ProductRankingCriteria, ProductRankingEntryResult, ProductRankingQuery, ProductRankingResult, SalesKpiEntryResult, SalesKpiMetricResult, SalesKpiOrderResult (+5 more)

### Community 108 - "Community 108"
Cohesion: 0.05
Nodes (30): FSCM.UnitTests.Maps, GeocodeRequest, RefreshDistanceRequest, MapController, IMapProvider, Name, IMapStore, GeocodeProviderResult (+22 more)

### Community 109 - "Community 109"
Cohesion: 0.10
Nodes (14): IOrderReleaseStore, OrderHeldAllocation, OrderPickingShare, OrderReleaseOutcome, OrderReleaseService, OrderReleaseStore, FakeOrderReleaseStore, Held (+6 more)

### Community 110 - "Community 110"
Cohesion: 0.08
Nodes (16): FakeStore, Allocations, Audits, Balance, Batch, Configurations, History, Lines (+8 more)

### Community 112 - "Community 112"
Cohesion: 0.50
Nodes (3): FSCM.API.Contracts.InventoryLocks, CreateInventoryLockRequest, ReleaseInventoryLockRequest

### Community 113 - "Community 113"
Cohesion: 0.26
Nodes (3): InventoryLocksController, InventoryLockResult, InventoryLockService

### Community 115 - "Community 115"
Cohesion: 0.08
Nodes (24): Allocation, AllocatedQuantity, AllocationSequence, BatchId, CoverageScore, CreatedAt, DiscountAmount, DiscountPercent (+16 more)

### Community 116 - "Community 116"
Cohesion: 0.06
Nodes (26): IWarehouseConfigurationStore, WarehouseView, SystemConfiguration, ConfigKey, ConfigValue, CreatedAt, Description, EffectiveFrom (+18 more)

### Community 117 - "Community 117"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, jobs, validate, name, on, pull_request (+19 more)

### Community 118 - "Community 118"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 119 - "Community 119"
Cohesion: 0.16
Nodes (11): BatchExpiryCandidate, IBatchExpiryStore, ExpirySweepResult, InventoryExpirySweepService, FakeStore, Locks, Outbox, Runs (+3 more)

### Community 121 - "Community 121"
Cohesion: 0.24
Nodes (5): AllocationReservationTests, FixedClock, Fixture, Service, Store

### Community 124 - "Community 124"
Cohesion: 0.07
Nodes (21): AllocationReservationService, ReservableAllocation, ReservationOutcome, Reservation, AllocationId, AllocationRunAllocationId, BatchId, ConsumedAt (+13 more)

### Community 125 - "Community 125"
Cohesion: 0.08
Nodes (19): InventoryTransaction, AvailableQuantityAfter, BatchId, CreatedByUserId, GoodsReceiptId, GoodsReceiptLineId, Id, Note (+11 more)

### Community 127 - "Community 127"
Cohesion: 0.09
Nodes (13): MapLocation, CreatedAt, FormattedAddress, Id, Latitude, Longitude, NormalizedAt, Provider (+5 more)

### Community 128 - "Community 128"
Cohesion: 0.05
Nodes (13): FSCM.Application, FSCM.Application.Features.Notifications, FSCM.Infrastructure, FSCM.API.Extensions, FSCM.API.GraphQL, FSCM.UnitTests.Notifications, FSCM.API.Security, FSCM.Persistence (+5 more)

### Community 129 - "Community 129"
Cohesion: 0.14
Nodes (18): AllocationPlan, Fulfilled, Short, AllocationPlanner, PlannedAllocation, PlannedLineResult, PlannedOrder, PlannerBatch (+10 more)

### Community 130 - "Community 130"
Cohesion: 0.12
Nodes (11): ExpirySweepRun, BatchesExpired, BatchesScanned, BusinessDate, CompletedAt, Error, Id, StartedAt (+3 more)

### Community 131 - "Community 131"
Cohesion: 0.20
Nodes (7): LoyaltyCardsController, ILoyaltyCardStore, LoyaltyCardData, LoyaltyCardResult, LoyaltyLedgerEntry, LoyaltyCardService, LoyaltyCardStore

### Community 132 - "Community 132"
Cohesion: 0.12
Nodes (11): UserCredential, CreatedAt, FailedLoginCount, Id, LockoutEndAt, MustChangePassword, PasswordChangedAt, PasswordHash (+3 more)

### Community 134 - "Community 134"
Cohesion: 0.10
Nodes (16): InventoryLock, BatchId, CreatedAt, Id, LockedByUserId, LockedQuantity, Note, ProductId (+8 more)

### Community 135 - "Community 135"
Cohesion: 0.11
Nodes (16): CompleteRunPickingData, PickingOperationException, Code, Clock, Fixture, ActorId, Events, First (+8 more)

### Community 136 - "Community 136"
Cohesion: 0.11
Nodes (14): ScanQrLabelData, QrLabelOperationException, Code, FixedTimeProvider, Fixture, DestinationBatch, DestinationWarehouse, Product (+6 more)

### Community 137 - "Community 137"
Cohesion: 0.14
Nodes (9): CapturePlan, OrderStatusHistory, ChangedAt, ChangedByUserId, FromStatus, Id, Reason, SalesOrderId (+1 more)

### Community 138 - "Community 138"
Cohesion: 0.08
Nodes (24): include, deployment, displayName, environment, job, steps, strategy, name (+16 more)

### Community 140 - "Community 140"
Cohesion: 0.13
Nodes (9): AssignRetailerTerritoryRequest, CreateRegionRequest, CreateSalesGroupRequest, TransferSalesRequest, UpdateRegionRequest, TerritoryAssignmentsController, SalesGroupMembershipView, RetailerTerritoryAssignmentResult (+1 more)

### Community 141 - "Community 141"
Cohesion: 0.11
Nodes (11): RefreshToken, CreatedAt, CreatedByIpAddress, ExpiresAt, Id, ReplacedByTokenId, RevokedAt, RevokedByIpAddress (+3 more)

### Community 142 - "Community 142"
Cohesion: 0.17
Nodes (11): SalesKpiQuery, SalesRankingQuery, ReportOperationException, Code, FixedTimeProvider, Fixture, GroupA, GroupB (+3 more)

### Community 143 - "Community 143"
Cohesion: 0.22
Nodes (4): IShelfLifeDiscountStore, ShelfLifeDiscountTableView, ShelfLifeDiscountStore, FakeStore

### Community 144 - "Community 144"
Cohesion: 0.08
Nodes (21): MlorView, RetailerProductMlor, EffectiveFrom, EffectiveTo, Id, IsActive, MinimumLifeHours, MinimumLifeRatio (+13 more)

### Community 145 - "Community 145"
Cohesion: 0.05
Nodes (35): OrderRunResultView, AllocationPlanPrice, AllocationPlanVersionId, AllocationRunLineId, Amount, BaseNetUnitPrice, BatchExpiresAt, BatchId (+27 more)

### Community 146 - "Community 146"
Cohesion: 0.13
Nodes (7): WarehouseConfigurationOperationException, Code, Fixture, Service, Store, TestTimeProvider, WarehouseConfigurationServiceTests

### Community 147 - "Community 147"
Cohesion: 0.09
Nodes (20): Delivery, AssignedAt, CreatedAt, DeliveredAt, DispatchedAt, DriverCodeSnapshot, DriverId, DriverLicenseSnapshot (+12 more)

### Community 148 - "Community 148"
Cohesion: 0.18
Nodes (8): ComplaintResult, CreateComplaintData, ResolveComplaintData, ComplaintOperationException, Code, ComplaintService, IComplaintStore, ComplaintStore

### Community 149 - "Community 149"
Cohesion: 0.19
Nodes (10): FSCM.API.Contracts.InternalTransfers, CreateInternalTransferLineRequest, CreateInternalTransferRequest, DispatchInternalTransferLineRequest, DispatchInternalTransferRequest, ReceiveInternalTransferRequest, RejectInternalTransferRequest, TransferDecisionRequest (+2 more)

### Community 150 - "Community 150"
Cohesion: 0.16
Nodes (10): AuthenticationResult, EntraIdentity, IdentityOperationException, Code, IdentityFixture, PasswordHasher, Service, Store (+2 more)

### Community 152 - "Community 152"
Cohesion: 0.13
Nodes (10): Driver, Code, CreatedAt, FullName, Id, IsActive, LicenseNumber, Phone (+2 more)

### Community 153 - "Community 153"
Cohesion: 0.11
Nodes (10): Vehicle, Capacity, CreatedAt, Id, IsActive, PlateNumber, UpdatedAt, VehicleType (+2 more)

### Community 154 - "Community 154"
Cohesion: 0.12
Nodes (8): IIdentityTokenProvider, RefreshTokenLifetime, JwtIdentityTokenProvider, RefreshTokenLifetime, TestIdentityTokenProvider, RefreshTokenLifetime, TestTokenProvider, RefreshTokenLifetime

### Community 155 - "Community 155"
Cohesion: 0.13
Nodes (13): RetailerOperationException, Code, FixedTimeProvider, Fixture, Category, GroupId, ParentCategory, Product (+5 more)

### Community 156 - "Community 156"
Cohesion: 0.10
Nodes (13): FSCM.UnitTests.Retailers, FSCM.Application.Features.Retailers, IdentityProviders, All, InventoryLockReasons, InventoryLockStatuses, ManualPaymentMethods, ManualPaymentStatuses (+5 more)

### Community 157 - "Community 157"
Cohesion: 0.17
Nodes (11): ReceiptDiscrepancy, Id, Note, ReceiptConfirmationId, ReportedAt, ReportedByRetailerUserId, ResolvedAt, ReviewedAt (+3 more)

### Community 158 - "Community 158"
Cohesion: 0.12
Nodes (11): ShelfLifeDiscountTable, CreatedAt, CreatedByUserId, EffectiveFrom, EffectiveTo, Id, IsActive, Note (+3 more)

### Community 159 - "Community 159"
Cohesion: 0.09
Nodes (18): WarehouseTransfer, ApprovedAt, ApprovedByUserId, CreatedAt, CreatedByUserId, DestinationWarehouseId, DispatchedAt, Id (+10 more)

### Community 160 - "Community 160"
Cohesion: 0.17
Nodes (6): BatchLockContext, IInventoryLockStore, InventoryLockView, InventoryLockStore, FakeStore, Locks

### Community 161 - "Community 161"
Cohesion: 0.19
Nodes (11): CreateInventoryLockData, ReleaseInventoryLockData, InventoryLockOperationException, Code, FixedTimeProvider, Fixture, Batch, KeeperId (+3 more)

### Community 162 - "Community 162"
Cohesion: 0.08
Nodes (20): LoyaltyOperationException, Code, ManualPaymentOperationException, Code, FixedTimeProvider, Fixture, ActorId, RetailerId (+12 more)

### Community 163 - "Community 163"
Cohesion: 0.10
Nodes (18): SalesOrderQuote, AcceptedAt, AcceptedByUserId, AllocationPlanVersionId, AllocationRunId, CreatedAt, ExpiresAt, Id (+10 more)

### Community 164 - "Community 164"
Cohesion: 0.12
Nodes (9): Region, Code, CreatedAt, Description, Id, IsActive, Name, UpdatedAt (+1 more)

### Community 165 - "Community 165"
Cohesion: 0.15
Nodes (8): SalesGroup, Code, CreatedAt, Id, IsActive, Name, RegionId, UpdatedAt

### Community 166 - "Community 166"
Cohesion: 0.10
Nodes (19): archiveFile, archiveType, arguments, artifact, command, includeRootFolder, packageType, projects (+11 more)

### Community 168 - "Community 168"
Cohesion: 0.15
Nodes (12): InternalTransferOperationException, Code, FixedTimeProvider, Fixture, Central, KeeperId, OperatorId, Product (+4 more)

### Community 169 - "Community 169"
Cohesion: 0.15
Nodes (11): GoodsReceiptApprovalLine, GoodsReceiptApprovalView, GoodsReceiptLine, CreatedAt, ExpirationDate, GoodsReceiptId, Id, ProductId (+3 more)

### Community 170 - "Community 170"
Cohesion: 0.12
Nodes (15): GoodsReceipt, ApprovedAt, ApprovedByUserId, CreatedAt, CreatedByUserId, Id, IdempotencyKey, ReceiptCode (+7 more)

### Community 173 - "Community 173"
Cohesion: 0.14
Nodes (12): FSCM.API.Contracts.Retailers, DeclareRetailerRequest, RetailerMlorDeclarationRequest, ReviewRetailerRequest, UpdateRetailerDeclarationRequest, UpdateRetailerStatusRequest, RetailersController, RetailerDetails (+4 more)

### Community 175 - "Community 175"
Cohesion: 0.15
Nodes (9): AccountToken, ConsumedAt, CreatedAt, ExpiresAt, Id, Purpose, TokenHash, UserAccountId (+1 more)

### Community 176 - "Community 176"
Cohesion: 0.12
Nodes (14): OrderPromotion, AppliedAt, DiscountAmount, DiscountPercent, EffectiveFromSnapshot, EffectiveToSnapshot, Id, IsServerFinal (+6 more)

### Community 177 - "Community 177"
Cohesion: 0.14
Nodes (7): TerritoryOperationException, Code, Fixture, Service, Store, TerritoryServiceTests, TestTimeProvider

### Community 178 - "Community 178"
Cohesion: 0.17
Nodes (10): WriteOff, CreatedAt, CreatedByUserId, Id, Reason, Status, UpdatedAt, WarehouseId (+2 more)

### Community 180 - "Community 180"
Cohesion: 0.20
Nodes (5): EligibleOrderLineView, EligibleOrderView, OrderPriceLineView, OrderPricePartView, OrderPriceView

### Community 182 - "Community 182"
Cohesion: 0.15
Nodes (11): ShelfLifeDiscountTier, CreatedAt, DiscountType, DiscountValue, Id, MaxRemainingPercent, MinRemainingPercent, ProductCategoryId (+3 more)

### Community 183 - "Community 183"
Cohesion: 0.08
Nodes (22): LoyaltyTransaction, BalanceAfter, CreatedAt, CreatedByUserId, Id, LoyaltyProgramId, Note, Points (+14 more)

### Community 184 - "Community 184"
Cohesion: 0.16
Nodes (6): GoogleMapsProvider, Name, GoogleMapsProviderTests, StubClientFactory, StubHandler, LastRequest

### Community 185 - "Community 185"
Cohesion: 0.15
Nodes (10): WarehouseTransferEvent, Action, FromStatus, Id, Note, OccurredAt, OperationKey, PerformedByUserId (+2 more)

### Community 186 - "Community 186"
Cohesion: 0.13
Nodes (12): WarehouseTransferItem, CreatedAt, DestinationBatchId, DispatchedQuantity, Id, Note, ReceivedQuantity, RequestedQuantity (+4 more)

### Community 187 - "Community 187"
Cohesion: 0.13
Nodes (8): InventoryBalance, AvailableQuantity, BatchId, Id, PhysicalQuantity, ReservedQuantity, UpdatedAt, Version

### Community 188 - "Community 188"
Cohesion: 0.12
Nodes (14): AllocationTraceCandidate, AllocationLineTraceId, BatchCodeSnapshot, BatchId, CreatedAt, EstimatedArrivalAt, Id, Passed (+6 more)

### Community 189 - "Community 189"
Cohesion: 0.13
Nodes (15): ASPNETCORE_ENVIRONMENT, applicationUrl, commandName, dotnetRunMessages, environmentVariables, launchBrowser, applicationUrl, commandName (+7 more)

### Community 190 - "Community 190"
Cohesion: 0.17
Nodes (7): UserRegionAssignment, AssignedAt, Id, IsActive, RegionId, UnassignedAt, UserAccountId

### Community 191 - "Community 191"
Cohesion: 0.19
Nodes (6): UserWarehouseAssignment, AssignedAt, Id, IsActive, UserAccountId, WarehouseId

### Community 192 - "Community 192"
Cohesion: 0.26
Nodes (5): FSCM.API.Contracts.Quotes, AcceptQuoteRequest, RejectQuoteRequest, QuotesController, SalesOrderQuoteResult

### Community 195 - "Community 195"
Cohesion: 0.19
Nodes (4): IQuoteStore, QuoteIssueOrder, QuoteView, QuoteStore

### Community 196 - "Community 196"
Cohesion: 0.12
Nodes (13): PurchaseOrder, CreatedAt, Id, IssuedAt, IssuedByUserId, PaymentMethod, PurchaseOrderCode, SalesOrderId (+5 more)

### Community 197 - "Community 197"
Cohesion: 0.15
Nodes (11): ReceiptConfirmation, ConfirmedAt, ConfirmedByRetailerUserId, CreatedAt, Id, Note, OperationKey, RequestHash (+3 more)

### Community 198 - "Community 198"
Cohesion: 0.15
Nodes (11): ReceiptConfirmationItem, BatchId, BatchQrLabelId, DamagedQuantity, ExpectedQuantity, Id, MissingQuantity, ReceiptConfirmationId (+3 more)

### Community 199 - "Community 199"
Cohesion: 0.16
Nodes (7): RetailerSalesAssignment, AssignedAt, Id, IsActive, RetailerId, SalesGroupId, UnassignedAt

### Community 202 - "Community 202"
Cohesion: 0.20
Nodes (10): CreateInternalTransferData, CreateInternalTransferLineData, DispatchInternalTransferData, DispatchInternalTransferLineData, InternalTransferEventResult, InternalTransferItemResult, InternalTransferLabelResult, InternalTransferSuggestionResult (+2 more)

### Community 203 - "Community 203"
Cohesion: 0.19
Nodes (3): FakeStore, Tables, Tiers

### Community 204 - "Community 204"
Cohesion: 0.14
Nodes (13): ReceiptDiscrepancyItem, ActualReceivedQuantity, AdjustmentAmount, AllocationPlanPriceId, BatchId, EvidenceBlobUrl, ExpectedQuantity, FinalUnitPrice (+5 more)

### Community 205 - "Community 205"
Cohesion: 0.21
Nodes (6): FixedClock, Fixture, RunId, Service, Store, RunPickingIssueTests

### Community 211 - "Community 211"
Cohesion: 0.33
Nodes (5): OrderRunResult, OrderRunResultLine, AllocationRunResultService, AllocationRunResultTests, FakeStore

### Community 212 - "Community 212"
Cohesion: 0.13
Nodes (11): IQrCodeRenderer, QrCoderQrCodeRenderer, QrLabelPrintApiTests, TestQrLabelStore, AllowWarehouseAccess, Batch, Child, Labels (+3 more)

### Community 213 - "Community 213"
Cohesion: 0.17
Nodes (10): IdempotencyKey, CreatedAt, ExpiresAt, Id, Key, SalesOrderId, Scope, Status (+2 more)

### Community 215 - "Community 215"
Cohesion: 0.22
Nodes (8): FixedTimeProvider, Fixture, AdminId, Now, OperatorId, Service, Store, RefundServiceTests

### Community 216 - "Community 216"
Cohesion: 0.17
Nodes (11): arguments, command, packageType, projects, version, steps, checkout, displayName (+3 more)

### Community 217 - "Community 217"
Cohesion: 0.17
Nodes (11): arguments, command, packageType, projects, publishTestResults, version, steps, checkout (+3 more)

### Community 218 - "Community 218"
Cohesion: 0.36
Nodes (3): QuoteOperationException, Code, QuoteService

### Community 220 - "Community 220"
Cohesion: 0.18
Nodes (9): StockHold, AllocationId, BatchId, HeldAt, Id, Quantity, ReleasedAt, Status (+1 more)

### Community 222 - "Community 222"
Cohesion: 0.22
Nodes (7): WarehouseTransferLabel, BatchQrLabelId, DispatchedAt, Id, Quantity, ReceivedAt, WarehouseTransferItemId

### Community 223 - "Community 223"
Cohesion: 0.18
Nodes (10): BatchExpiryStatuses, BatchStockStatuses, ExpirySweepStatuses, GoodsReceiptStatuses, InventoryNotificationTypes, InventoryOutboxEventTypes, InventoryTransactionSourceTypes, InventoryTransactionTypes (+2 more)

### Community 224 - "Community 224"
Cohesion: 0.25
Nodes (4): AllocationPricingService, AllocationPricingServiceTests, FixedClock, Fixture

### Community 225 - "Community 225"
Cohesion: 0.20
Nodes (9): variables, apiProject, artifactName, azureServiceConnection, azureWebAppName, azureWebAppType, backendSolution, buildConfiguration (+1 more)

### Community 227 - "Community 227"
Cohesion: 0.29
Nodes (4): TestEntityQueryService, LastAccess, Products, ScenarioDiscountStore

### Community 228 - "Community 228"
Cohesion: 0.40
Nodes (3): TransferItemView, TransferLabelView, TransferView

### Community 233 - "Community 233"
Cohesion: 0.29
Nodes (5): BusinessDocumentSequence, BusinessDate, DocumentType, LastNumber, BusinessDocumentSequenceConfiguration

### Community 268 - "Community 268"
Cohesion: 0.67
Nodes (3): FSCM.API.Contracts.TransitTables, PublishTransitTableRequest, TransitBandRequest

### Community 291 - "Community 291"
Cohesion: 0.09
Nodes (90): batches(), useBatch(), useBatches(), BatchDetailPage(), BatchesPage(), useCategory(), CategoryDetailPage(), ResolveDialog() (+82 more)

### Community 292 - "Community 292"
Cohesion: 0.21
Nodes (21): AllocationInput, Cand, round3(), traceAllocation(), TraceLine, TraceResult, Candidate, Capacity (+13 more)

### Community 293 - "Community 293"
Cohesion: 0.05
Nodes (64): axios, react, react-router-dom, App(), AppLayout(), initials(), Sidebar(), Topbar() (+56 more)

### Community 294 - "Community 294"
Cohesion: 0.23
Nodes (12): shipments(), shipmentsApi, useOrdersReadiness(), OrderReadinessPage(), ordersOf(), PART_STATUS, ReadinessBody(), today() (+4 more)

### Community 295 - "Community 295"
Cohesion: 0.13
Nodes (41): DISPATCH_DATE, MOCK_NOW, MOCK_TODAY, pad(), stamp(), db, DbOrder, actorLabel() (+33 more)

### Community 296 - "Community 296"
Cohesion: 0.06
Nodes (59): batchpromo(), batchPromoApi, DiscountDialog(), scanLabel, useCreateBatchDiscount(), useDiscountSuggestions(), usePublishShelfLife(), useShelfLifeCurrent() (+51 more)

### Community 297 - "Community 297"
Cohesion: 0.06
Nodes (60): users(), getAssignmentNames(), scopeDetailRoots, scopeListRoots, userApi, AssignmentPicker(), Props, Props (+52 more)

### Community 298 - "Community 298"
Cohesion: 0.16
Nodes (23): DbUser, areaName(), encodeToken(), DEMO, registerIdentity(), ROLES, userDto(), mlorOf() (+15 more)

### Community 300 - "Community 300"
Cohesion: 0.03
Nodes (118): allocation(), orders(), allocationApi, discountRule(), MLOR_SOURCES, Part, PlanOrderDetail(), allocationKeys (+110 more)

### Community 301 - "Community 301"
Cohesion: 0.26
Nodes (21): product(), warehouse(), warehouseName(), batchDto(), disposalDto(), findBatch(), findProposal(), findTransfer() (+13 more)

### Community 302 - "Community 302"
Cohesion: 0.07
Nodes (28): concurrency, cancel-in-progress, group, jobs, validate, name, on, pull_request (+20 more)

### Community 303 - "Community 303"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 304 - "Community 304"
Cohesion: 0.07
Nodes (44): @tanstack/react-query, fleet(), complaintApi, useResolveComplaint(), Complaint, debtApi, useCollectReceivable(), Receivable (+36 more)

### Community 305 - "Community 305"
Cohesion: 0.08
Nodes (43): Commercial, commercialData(), E(), Pn(), X(), D(), ddMMyyyy(), DT() (+35 more)

### Community 307 - "Community 307"
Cohesion: 0.16
Nodes (24): regions(), regionApi, AreaDialog(), GroupDialog(), TransferStaffDialog(), useAreas(), useCreateArea(), useCreateGroup() (+16 more)

### Community 308 - "Community 308"
Cohesion: 0.15
Nodes (23): retailers(), retailerApi, RegistrationActions(), KINDS, RetailerFormDialog(), useApproveRegistration(), useCreateRetailer(), useRejectRegistration() (+15 more)

### Community 310 - "Community 310"
Cohesion: 0.21
Nodes (14): promos(), promoApi, useActivatePromo(), usePausePromo(), usePromos(), PromosPage(), promoStatus(), CategoryOption (+6 more)

### Community 311 - "Community 311"
Cohesion: 0.09
Nodes (38): config(), configApi, runScheduleApi, transitApi, FIELD_HINT, FIELD_LABEL, Key, minutes() (+30 more)

### Community 312 - "Community 312"
Cohesion: 0.11
Nodes (19): dependencies, @apollo/client@^4.2.9, axios@^1.19.0, @azure/msal-browser@^5.25.1, graphql@^16.14.2, lucide-react@^1.28.0, react@^19.2.6, react-dom@^19.2.6 (+11 more)

### Community 313 - "Community 313"
Cohesion: 0.15
Nodes (24): products(), productApi, copy, Kind, ProductActions(), ProductDialog(), useCategoryOptions(), useCloneProduct() (+16 more)

### Community 316 - "Community 316"
Cohesion: 0.10
Nodes (19): compilerOptions, allowImportingTsExtensions, isolatedModules, jsx, lib, module, moduleDetection, moduleResolution (+11 more)

### Community 320 - "Community 320"
Cohesion: 0.15
Nodes (14): warehouses(), warehouseApi, WarehouseDialog(), useCreateWarehouse(), useUpdateWarehouse(), useWarehouses(), WarehousesPage(), RetailerDistance (+6 more)

### Community 321 - "Community 321"
Cohesion: 0.15
Nodes (12): eslint@^10.3.0, @eslint/js@^10.0.1, eslint-plugin-react-hooks@^7.1.1, eslint-plugin-react-refresh@^0.5.2, globals@^17.6.0, typescript-eslint@^8.59.2, eslint, @eslint/js (+4 more)

### Community 323 - "Community 323"
Cohesion: 0.15
Nodes (13): devDependencies, tailwindcss@^4.3.3, @tailwindcss/vite@^4.3.3, @types/node@^24.12.3, @types/react@^19.2.14, @types/react-dom@^19.2.3, typescript@~6.0.2, tailwindcss (+5 more)

### Community 326 - "Community 326"
Cohesion: 0.25
Nodes (11): transferApi, TransferDialog(), useCreateTransfer(), useTransferLookups(), BatchOption, ReplenishmentSuggestion, Transfer, TransferInput (+3 more)

### Community 327 - "Community 327"
Cohesion: 0.13
Nodes (14): compilerOptions, allowImportingTsExtensions, isolatedModules, lib, module, moduleDetection, moduleResolution, noEmit (+6 more)

### Community 328 - "Community 328"
Cohesion: 0.05
Nodes (42): batchApi, Batch, BatchDetail, BatchMovement, ExpiryStatus, dashboardApi, tooltipMoney(), DashboardDay (+34 more)

### Community 330 - "Community 330"
Cohesion: 0.22
Nodes (13): redeem(), normalize(), redeemApi, toStatus(), RedeemActions(), done, useRedeemStep(), useRedemptions() (+5 more)

### Community 331 - "Community 331"
Cohesion: 0.14
Nodes (20): rotation(), rotationApi, ProposalActions(), useApproveProposal(), useProposals(), useRunRotation(), useSkipProposal(), useUpdateProposalQty() (+12 more)

### Community 332 - "Community 332"
Cohesion: 0.13
Nodes (18): whDistance(), DbDriver, DbTransitTable, DbVehicle, currentTransitTable(), findDriver(), findVehicle(), MockTransitBand (+10 more)

### Community 333 - "Community 333"
Cohesion: 0.26
Nodes (11): categories(), categoryApi, CategoryDialog(), useCategories(), useCreateCategory(), useUpdateCategory(), CategoriesPage(), Category (+3 more)

### Community 339 - "Community 339"
Cohesion: 0.18
Nodes (22): yymmdd(), PricedLine, PricedOrder, PricedPromotion, priceLines(), DbPromotion, actor(), nextSeq() (+14 more)

### Community 340 - "Community 340"
Cohesion: 0.19
Nodes (14): receipts(), receiptApi, useCreateReceipt(), useReceiptLookups(), useReceipts(), blank(), ReceiptFormPage(), Row (+6 more)

### Community 346 - "Community 346"
Cohesion: 0.33
Nodes (4): vite@^8.0.12, @vitejs/plugin-react@^6.0.1, vite, @vitejs/plugin-react

### Community 348 - "Community 348"
Cohesion: 0.40
Nodes (5): GoogleCredentialResponse, GoogleIdentityApi, GoogleSignInButton(), loadGoogleIdentity(), Window

### Community 349 - "Community 349"
Cohesion: 0.33
Nodes (5): main, git, deploymentEnabled, rewrites, $schema

### Community 350 - "Community 350"
Cohesion: 0.40
Nodes (5): scripts, build, dev, lint, preview

### Community 354 - "Community 354"
Cohesion: 0.03
Nodes (77): afterPromo, areaCode, areaName, balance, complaints, conflictApplied, createdAt, fmtTime (+69 more)

### Community 355 - "Community 355"
Cohesion: 0.03
Nodes (57): batch, batchExpiry, batchPattern, category, categoryPattern, classify, code, _ddMMyyyy (+49 more)

### Community 356 - "Community 356"
Cohesion: 0.03
Nodes (59): base, BatchAllocation, batchCode, batches, CartLine, changeReason, code, copyWith (+51 more)

### Community 357 - "Community 357"
Cohesion: 0.04
Nodes (50): areas, authLogin, authLogout, authOtpRequest, authOtpVerify, authSetPassword, batches, categories (+42 more)

### Community 358 - "Community 358"
Cohesion: 0.04
Nodes (48): AppRoutes, login, notifications, rtAccount, rtComplaintFor, rtComplaintNew, rtComplaints, rtGifts (+40 more)

### Community 359 - "Community 359"
Cohesion: 0.05
Nodes (21): Cocoa, connectivity_plus, file_selector_macos, Flutter, flutter_secure_storage_darwin, FlutterMacOS, Foundation, AppDelegate (+13 more)

### Community 360 - "Community 360"
Cohesion: 0.05
Nodes (42): byRetailer, fromJson, group, isMe, name, orderCount, orders, periodLabel (+34 more)

### Community 361 - "Community 361"
Cohesion: 0.03
Nodes (25): homeRouteFor, _prefixFor, redirectFor, refresh, _retailerRoutes, router, _salesRoutes, _warehouseRoutes (+17 more)

### Community 362 - "Community 362"
Cohesion: 0.03
Nodes (76): _bearer, forceOffline, _handlers, send, store, handle, MockAuthHandler, _session (+68 more)

### Community 363 - "Community 363"
Cohesion: 0.02
Nodes (107): SalesShell, _SalesShellState, LoyaltyAccount, RetailersApi, _api, collect, FinanceRepository, financeRepositoryProvider (+99 more)

### Community 364 - "Community 364"
Cohesion: 0.04
Nodes (49): accessToken, _cached, cachedSession, clear, load, save, _sessionKey, _storage (+41 more)

### Community 365 - "Community 365"
Cohesion: 0.02
Nodes (103): allDone, approvedAt, batchCode, childLabel, code, copyWith, doneLines, expiry (+95 more)

### Community 367 - "Community 367"
Cohesion: 0.06
Nodes (28): apiBaseUrl, AppFlavor, connectTimeout, Env, flavorName, isProd, mockLatencyMs, receiveTimeout (+20 more)

### Community 368 - "Community 368"
Cohesion: 0.06
Nodes (34): dependencies, connectivity_plus, cupertino_icons, dio, flutter, flutter_localizations, flutter_riverpod, flutter_secure_storage (+26 more)

### Community 369 - "Community 369"
Cohesion: 0.02
Nodes (181): build, navigationShell, RetailerShell, createState, navigationShell, activeIcon, build, _go (+173 more)

### Community 370 - "Community 370"
Cohesion: 0.08
Nodes (14): fl_register_plugins(), main(), first_frame_cb(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line() (+6 more)

### Community 371 - "Community 371"
Cohesion: 0.02
Nodes (123): build, FscmApp, routerProvider, ApiClient, _catalog, _d, fill, _finance (+115 more)

### Community 374 - "Community 374"
Cohesion: 0.07
Nodes (29): concurrency, cancel-in-progress, group, jobs, validate, name, on, pull_request (+21 more)

### Community 375 - "Community 375"
Cohesion: 0.02
Nodes (127): DeviceIdentity, deviceIdentityProvider, _deviceKey, _installKey, _prefs, sharedPreferencesProvider, AppDatabase, async (+119 more)

### Community 378 - "Community 378"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 379 - "Community 379"
Cohesion: 0.02
Nodes (106): AppNotification, createdAt, fromJson, id, isLocal, kind, markRead, orderCode (+98 more)

### Community 380 - "Community 380"
Cohesion: 0.03
Nodes (82): build, initState, networkMonitorProvider, authControllerProvider, currentUserProvider, CatalogData, catalogProvider, receivablesProvider (+74 more)

### Community 382 - "Community 382"
Cohesion: 0.03
Nodes (65): PaymentMethod, amount, applied, AppliedPromo, base, detail, discount, empty (+57 more)

### Community 384 - "Community 384"
Cohesion: 0.04
Nodes (44): _apply, _connectivity, copyWith, deviceOnline, dispose, isOnline, NetworkMonitor, NetworkState (+36 more)

### Community 389 - "Community 389"
Cohesion: 0.05
Nodes (38): RegistrationStatus, address, areaCode, areaM2, areaName, capacityCases, code, contactName (+30 more)

### Community 395 - "Community 395"
Cohesion: 0.03
Nodes (55): accessToken, AppUser, areaCode, areaName, expiresAt, fromJson, fullName, id (+47 more)

### Community 397 - "Community 397"
Cohesion: 0.03
Nodes (54): LabelStatus, batchCode, children, code, copyWith, expiry, fromJson, history (+46 more)

### Community 402 - "Community 402"
Cohesion: 0.04
Nodes (38): apiClientProvider, apiTransportProvider, client, delete, _dio, DioTransport, dispose, onUnauthorized (+30 more)

### Community 403 - "Community 403"
Cohesion: 0.12
Nodes (4): FlutterWindow, flutter_controller_, FlutterWindow::FlutterWindow(), project_

### Community 408 - "Community 408"
Cohesion: 0.08
Nodes (22): AppColors, background, border, danger, divider, foreground, primary, primaryDark (+14 more)

### Community 412 - "Community 412"
Cohesion: 0.18
Nodes (6): EnableNonClientDpiScaling, Scale(), Win32Window::Win32Window(), WindowClassRegistrar, class_registered_, instance_

### Community 424 - "Community 424"
Cohesion: 0.14
Nodes (13): available, basePrice, category, fromJson, name, pack, price, PriceEntry (+5 more)

### Community 427 - "Community 427"
Cohesion: 0.19
Nodes (4): wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 428 - "Community 428"
Cohesion: 0.15
Nodes (10): AppDates, _date, _dayMonth, daysBetween, _iso, _isoDate, isSameDay, _time (+2 more)

### Community 437 - "Community 437"
Cohesion: 0.19
Nodes (4): Win32Window, child_content_, quit_on_close_, window_handle_

### Community 443 - "Community 443"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 444 - "Community 444"
Cohesion: 0.20
Nodes (9): analyzer, errors, exclude, language, deprecated_member_use, include, strict-raw-types, linter (+1 more)

### Community 449 - "Community 449"
Cohesion: 0.20
Nodes (7): cancelLabel, confirmDialog, confirmLabel, false, messenger, result, showAppSnack

### Community 462 - "Community 462"
Cohesion: 0.29
Nodes (6): format, minus, Money, _oneDecimal, parse, short

### Community 472 - "Community 472"
Cohesion: 0.21
Nodes (6): Point, x, y, Size, height, width

## Knowledge Gaps
- **3188 isolated node(s):** `AssignedAt`, `AssignedByUserId`, `BatchId`, `Id`, `IsActive` (+3183 more)
  These have ≤1 connection - possible missing edges. (Counts symbols only; 3966 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **33 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppDbContext` connect `Community 5` to `Community 0`, `Community 2`, `Community 3`, `Community 6`, `Community 8`, `Community 10`, `Community 12`, `Community 14`, `Community 15`, `Community 16`, `Community 17`, `Community 20`, `Community 22`, `Community 23`, `Community 24`, `Community 26`, `Community 28`, `Community 31`, `Community 36`, `Community 37`, `Community 38`, `Community 42`, `Community 44`, `Community 45`, `Community 46`, `Community 50`, `Community 51`, `Community 52`, `Community 53`, `Community 54`, `Community 56`, `Community 57`, `Community 60`, `Community 61`, `Community 64`, `Community 65`, `Community 66`, `Community 67`, `Community 68`, `Community 70`, `Community 71`, `Community 73`, `Community 74`, `Community 75`, `Community 80`, `Community 81`, `Community 82`, `Community 84`, `Community 85`, `Community 86`, `Community 91`, `Community 95`, `Community 97`, `Community 108`, `Community 109`, `Community 115`, `Community 116`, `Community 124`, `Community 125`, `Community 127`, `Community 130`, `Community 131`, `Community 132`, `Community 134`, `Community 137`, `Community 141`, `Community 143`, `Community 144`, `Community 145`, `Community 147`, `Community 148`, `Community 152`, `Community 153`, `Community 157`, `Community 158`, `Community 159`, `Community 160`, `Community 163`, `Community 164`, `Community 165`, `Community 169`, `Community 170`, `Community 175`, `Community 176`, `Community 178`, `Community 182`, `Community 183`, `Community 185`, `Community 186`, `Community 187`, `Community 188`, `Community 190`, `Community 191`, `Community 195`, `Community 196`, `Community 197`, `Community 198`, `Community 199`, `Community 204`, `Community 213`, `Community 220`, `Community 222`, `Community 233`, `Community 270`, `Community 290`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **What connects `AssignedAt`, `AssignedByUserId`, `BatchId` to the rest of the system?**
  _3188 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.02804814233385662 - nodes in this community are weakly interconnected._
- **Why does `FSCM.Domain.Entities` connect `Community 39` to `Community 0`, `Community 2`, `Community 3`, `Community 6`, `Community 8`, `Community 11`, `Community 12`, `Community 14`, `Community 16`, `Community 18`, `Community 21`, `Community 23`, `Community 24`, `Community 26`, `Community 28`, `Community 31`, `Community 36`, `Community 38`, `Community 42`, `Community 45`, `Community 50`, `Community 51`, `Community 52`, `Community 54`, `Community 55`, `Community 56`, `Community 57`, `Community 60`, `Community 61`, `Community 64`, `Community 65`, `Community 66`, `Community 68`, `Community 69`, `Community 70`, `Community 71`, `Community 73`, `Community 74`, `Community 75`, `Community 80`, `Community 81`, `Community 82`, `Community 84`, `Community 85`, `Community 86`, `Community 95`, `Community 97`, `Community 108`, `Community 115`, `Community 116`, `Community 124`, `Community 125`, `Community 127`, `Community 128`, `Community 130`, `Community 131`, `Community 132`, `Community 134`, `Community 137`, `Community 141`, `Community 143`, `Community 144`, `Community 145`, `Community 147`, `Community 148`, `Community 152`, `Community 153`, `Community 156`, `Community 157`, `Community 158`, `Community 159`, `Community 163`, `Community 164`, `Community 165`, `Community 169`, `Community 170`, `Community 175`, `Community 176`, `Community 178`, `Community 180`, `Community 182`, `Community 183`, `Community 185`, `Community 186`, `Community 187`, `Community 188`, `Community 190`, `Community 191`, `Community 196`, `Community 197`, `Community 198`, `Community 199`, `Community 204`, `Community 213`, `Community 220`, `Community 222`, `Community 228`, `Community 233`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.02470734486688076 - nodes in this community are weakly interconnected._
- **Why does `OrderPromotion` connect `Community 176` to `Community 0`, `Community 3`, `Community 5`, `Community 104`, `Community 137`, `Community 9`, `Community 110`, `Community 15`, `Community 52`, `Community 29`, `Community 95`?**
  _High betweenness centrality (0.014) - this node is a cross-community bridge._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.09131652661064425 - nodes in this community are weakly interconnected._