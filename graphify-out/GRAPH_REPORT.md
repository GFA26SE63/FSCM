# Graph Report - FSCM  (2026-10-30)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 11976 nodes · 39616 edges · 320 communities (275 shown, 45 thin omitted)
- Extraction: 91% EXTRACTED · 9% INFERRED · 0% AMBIGUOUS · INFERRED: 3429 edges (avg confidence: 0.78)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `556cead8`
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
- Community 98
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
- Community 120
- Community 121
- Community 122
- Community 123
- Community 124
- Community 125
- Community 126
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
- Community 139
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
- Community 167
- Community 168
- Community 169
- Community 170
- Community 171
- Community 172
- Community 173
- Community 174
- Community 175
- Community 176
- Community 177
- Community 178
- Community 179
- Community 180
- Community 181
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
- Community 194
- Community 195
- Community 196
- Community 197
- Community 198
- Community 200
- Community 201
- Community 202
- Community 204
- Community 206
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
- Community 230
- Community 233
- Community 234
- Community 243
- Community 244
- Community 246
- Community 248
- Community 249
- Community 250
- Community 256
- Community 261
- Community 262
- Community 268
- Community 279
- Community 291
- Community 292
- Community 293
- Community 294
- Community 295
- Community 296
- Community 297
- Community 298
- Community 299
- Community 300
- Community 301
- Community 302
- Community 303
- Community 305
- Community 306
- Community 307
- Community 308
- Community 310
- Community 311
- Community 314
- Community 317
- Community 318
- Community 320
- Community 321
- Community 323
- Community 326
- Community 327
- Community 328
- Community 329
- Community 335
- Community 336
- Community 342
- Community 343
- Community 344
- Community 345
- Community 346
- Community 347
- Community 348
- Community 349
- Community 350
- Community 351
- Community 352
- Community 353
- Community 354
- Community 355
- Community 356
- Community 357
- Community 358
- Community 359
- Community 360
- Community 361
- Community 362
- Community 364
- Community 365
- Community 366
- Community 368
- Community 369
- Community 370
- Community 372
- Community 373
- Community 376
- Community 378
- Community 382
- Community 383
- Community 391
- Community 396
- Community 397
- Community 400
- Community 402
- Community 406
- Community 409
- Community 418
- Community 421
- Community 422
- Community 429
- Community 431
- Community 437
- Community 438
- Community 444
- Community 456
- Community 466
- Community 467

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

## Communities (320 total, 45 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.08
Nodes (10): BatchDiscountCandidate, IPromotionStore, PriceProductView, TestQuoteStore, Batch, BatchDiscountQueryCount, Category, Price (+2 more)

### Community 1 - "Community 1"
Cohesion: 0.07
Nodes (11): ReservableAllocation, AvailableBatchView, EligibleOrderLineView, EligibleOrderView, RunPickingListView, RunPickingGatherResult, RunPickingGatherStatuses, RunPickingIssueService (+3 more)

### Community 2 - "Community 2"
Cohesion: 0.06
Nodes (24): Product, CreatedAt, Id, InactivatedAt, Name, NearDateThresholdHours, ProductCategoryId, PublishedAt (+16 more)

### Community 3 - "Community 3"
Cohesion: 0.14
Nodes (4): EntityQuery, EntityQueryAccess, IEntityQueryService, EntityQueryService

### Community 4 - "Community 4"
Cohesion: 0.06
Nodes (46): FSCM.API.Options, FSCM.API.Errors, AllocationRunExceptionHandler, CatalogExceptionHandler, ComplaintExceptionHandler, DeliveryEtaExceptionHandler, DeliveryExceptionHandler, IdentityExceptionHandler (+38 more)

### Community 5 - "Community 5"
Cohesion: 0.02
Nodes (95): AppDbContext, AccountTokens, AllocationLineTraceRecords, AllocationPlanPriceRecords, AllocationPlanVersionRecords, AllocationRecords, AllocationRunAllocationRecords, AllocationRunLineRecords (+87 more)

### Community 6 - "Community 6"
Cohesion: 0.12
Nodes (5): CreateCategoryRequest, UpdateCategoryRequest, CategoriesController, CategoryResult, CatalogService

### Community 7 - "Community 7"
Cohesion: 0.07
Nodes (23): FSCM.API.Contracts.AllocationRuns, ApprovePlanVersionRequest, RequestRecalculationRequest, CloseAllocationRunRequest, StartAllocationRunRequest, AllocationRunsController, AllocationPlanApprovalService, AllocationReservationService (+15 more)

### Community 8 - "Community 8"
Cohesion: 0.04
Nodes (39): AllocationRun, AlgorithmSettings, BusinessDate, CompletedAt, CreatedAt, CutoffAt, EtaScheduleVersion, FailureReason (+31 more)

### Community 9 - "Community 9"
Cohesion: 0.07
Nodes (14): GoodsReceiptApiTests, IdentityApiFactory, Admin, EntityQueries, InactiveAdmin, Sales, WarehouseKeeper, IdentityAuthorizationTests (+6 more)

### Community 10 - "Community 10"
Cohesion: 0.07
Nodes (3): IAllocationRunStore, AllocationRunStore, StubAllocationRunStore

### Community 11 - "Community 11"
Cohesion: 0.03
Nodes (58): FSCM.UnitTests.Promotions, FSCM.UnitTests.Picking, FSCM.UnitTests.MobileSnapshots, FSCM.Application.Features.Deliveries, FSCM.Application.Features.Shipments, FSCM.Persistence.MobileSnapshots, FSCM.Application.Features.QrLabels, FSCM.UnitTests.Shipments (+50 more)

### Community 12 - "Community 12"
Cohesion: 0.03
Nodes (24): FSCM.Persistence.Migrations, FSCM.Persistence.DbContexts, AddCatalogProductLifecycle, AddTerritorySalesGroups, AddRetailerManagement, AddPromotionBatchDiscount, EnforceInventoryLifecycleIdempotency, AddS1EPaymentFoundation (+16 more)

### Community 13 - "Community 13"
Cohesion: 0.10
Nodes (16): PromotionsController, AppliedPromotionSnapshot, ApplyBatchDiscountData, BatchDiscountSuggestionResult, CreatePromotionData, PriceSnapshotResult, BaseUnitPrice, IndicativeNetAmount (+8 more)

### Community 14 - "Community 14"
Cohesion: 0.04
Nodes (37): DependencyInjection, IPickingPlanService, IPickingStore, PickingItemView, PickingScanView, PickingView, PickingPlanService, PickingItem (+29 more)

### Community 15 - "Community 15"
Cohesion: 0.05
Nodes (29): OrderPriceSnapshot, OrderPricingService, CategorySeed, ConfigurationSeed, DevelopmentDataSeeder, InventorySeed, ProductSeed, QrLabelSeed (+21 more)

### Community 16 - "Community 16"
Cohesion: 0.05
Nodes (25): BatchInventoryView, GoodsReceiptApprovalLine, GoodsReceiptApprovalView, GoodsReceiptLineView, GoodsReceiptView, IInventoryStore, InventoryHistoryView, InventoryStore (+17 more)

### Community 17 - "Community 17"
Cohesion: 0.06
Nodes (10): IPaymentStore, PaymentView, PaymentStore, FakePaymentStore, FakePaymentStore, Audits, HasOpenDispute, Payments (+2 more)

### Community 18 - "Community 18"
Cohesion: 0.29
Nodes (3): FSCM.Persistence.Loyalty, FSCM.UnitTests.Loyalty, FSCM.Application.Features.Loyalty

### Community 19 - "Community 19"
Cohesion: 0.09
Nodes (16): InventoryOperationException, Code, FixedTimeProvider, Fixture, ActorId, Allocation, Balance, Service (+8 more)

### Community 20 - "Community 20"
Cohesion: 0.05
Nodes (8): AddQrLabelLineage, AddInternalTransfers, IntegratePayOsPayments, AddManualPayment, AddIdentityProviderAndRegionScope, AddShelfLifeDiscountTable, AddShipmentAssignment, AddNotificationClientContract

### Community 21 - "Community 21"
Cohesion: 0.11
Nodes (14): FSCM.API.Contracts.Promotions, FSCM.API.Contracts.Loyalty, FSCM.API.Contracts.Maps, FSCM.API.Contracts.WarehouseConfiguration, FSCM.Domain.Authorization, FSCM.API.Controllers, FSCM.API.Contracts.Territory, FSCM.API.Contracts.Identity (+6 more)

### Community 22 - "Community 22"
Cohesion: 0.03
Nodes (50): IRetailerStore, RetailerTerritoryAccess, RetailerView, Retailer, Address, AssessedAt, AssessedByUserId, AssessmentNote (+42 more)

### Community 23 - "Community 23"
Cohesion: 0.04
Nodes (51): RunPickingGather, BatchCodeSnapshot, BatchId, CreatedAt, Id, PickedQuantity, ProductId, RequiredQuantity (+43 more)

### Community 24 - "Community 24"
Cohesion: 0.08
Nodes (12): PaymentPlanService, AuditLog, Action, CreatedAt, EntityId, EntityName, Id, NewValues (+4 more)

### Community 25 - "Community 25"
Cohesion: 0.09
Nodes (10): FSCM.API.Contracts.Payments, AdjustReceivableRequest, CollectPaymentRequest, CreatePayOsCheckoutRequest, PayOsWebhookDataRequest, PayOsWebhookRequest, PaymentsController, PaymentResult (+2 more)

### Community 26 - "Community 26"
Cohesion: 0.06
Nodes (13): IQrLabelStore, QrLabelEventView, QrLabelView, QrLabelStore, TestQrLabelStore, AllowWarehouseAccess, Batch, Child (+5 more)

### Community 27 - "Community 27"
Cohesion: 0.05
Nodes (20): DeliveryEtaOperationException, Code, PhysicalSchemaModelTests, AllocationReservationTests, FixedClock, Fixture, Service, Store (+12 more)

### Community 28 - "Community 28"
Cohesion: 0.07
Nodes (16): DeliveryInventoryIssue, DeliveryOrderView, DeliveryView, IDeliveryStore, ReceiptItemView, DeliveryStore, FakeDeliveryStore, Deliveries (+8 more)

### Community 29 - "Community 29"
Cohesion: 0.11
Nodes (10): PricingController, CreateAssistedOrderData, OrderDetailResult, AllocationPlanVersion, AllocationRunCode, IndicativeAmount, OfficialAmount, OfficialPricedAt (+2 more)

### Community 30 - "Community 30"
Cohesion: 0.03
Nodes (49): UserListQuery, IIdentityStore, RefreshToken, CreatedAt, CreatedByIpAddress, ExpiresAt, Id, ReplacedByTokenId (+41 more)

### Community 31 - "Community 31"
Cohesion: 0.05
Nodes (35): RefundView, ManualRefund, Amount, CreatedAt, CreatedByUserId, CreateOperationKey, CreateRequestHash, EvidenceOperationKey (+27 more)

### Community 32 - "Community 32"
Cohesion: 0.08
Nodes (16): ICatalogStore, ProductCategory, Code, CreatedAt, Description, Id, IsActive, Name (+8 more)

### Community 33 - "Community 33"
Cohesion: 0.11
Nodes (14): FSCM.API.Contracts.Refunds, CreateRefundRequest, SubmitRefundEvidenceRequest, VerifyRefundRequest, RefundsController, IRefundStore, CreateRefundData, RefundResult (+6 more)

### Community 34 - "Community 34"
Cohesion: 0.06
Nodes (50): AutoMapper (16.2.0), BCrypt.Net-Next (4.2.0), FluentValidation (12.1.1), FluentValidation.DependencyInjectionExtensions (12.1.1), HotChocolate.AspNetCore (16.5.1), HotChocolate.AspNetCore.Authorization (16.5.1), HotChocolate.Data (16.5.1), HotChocolate.Types.Analyzers (16.5.1) (+42 more)

### Community 35 - "Community 35"
Cohesion: 0.08
Nodes (5): AddSharedTransitTable, AddAllocationRun, AddAllocationRunPlan, CompleteRunPickingWorkflow, AddLoyaltyProgramScopeAndExpiry

### Community 36 - "Community 36"
Cohesion: 0.06
Nodes (17): IRunPickingStore, RunPickingScanView, RunPickingWorkflowView, RunPickingStore, PickingContractStore, Events, Gather, InventoryIssues (+9 more)

### Community 37 - "Community 37"
Cohesion: 0.10
Nodes (16): ConfirmShipmentIssueData, ConfirmShipmentReceiptData, ConfirmShipmentReceiptLineData, ShipmentOperationException, Code, Fixture, DriverA, Order (+8 more)

### Community 38 - "Community 38"
Cohesion: 0.10
Nodes (13): CreateLoyaltyProgramRequest, UpdateLoyaltyProgramRequest, LoyaltyController, CreateLoyaltyProgramData, LoyaltyProgramResult, LoyaltyProgramView, UpdateLoyaltyProgramData, LoyaltyService (+5 more)

### Community 39 - "Community 39"
Cohesion: 0.11
Nodes (11): FSCM.Application.Features.TransitTables, FSCM.UnitTests.ShelfLifeDiscounts, FSCM.UnitTests.AllocationRuns, FSCM.UnitTests.DeliveryEta, FSCM.Application.Features.ShelfLifeDiscounts, FSCM.Application.Features.AllocationRuns, FSCM.Domain.Allocation, FSCM.Application.Features.DeliveryEta (+3 more)

### Community 40 - "Community 40"
Cohesion: 0.11
Nodes (9): FSCM.API.Contracts.ManualPayments, CancelManualPaymentRequest, ConfirmManualPaymentRequest, RecordManualPaymentRequest, ManualPaymentsController, ChangeManualPaymentData, ManualPaymentResult, RecordManualPaymentData (+1 more)

### Community 41 - "Community 41"
Cohesion: 0.12
Nodes (13): FSCM.API.Contracts.QrLabels, GenerateQrLabelRequest, ScanQrLabelRequest, SplitQrLabelRequest, QrLabelsController, GenerateQrLabelData, QrLabelDetailResult, QrLabelEventResult (+5 more)

### Community 42 - "Community 42"
Cohesion: 0.07
Nodes (27): IManualPaymentStore, ManualPaymentView, ManualPayment, Amount, ConfirmedAt, ConfirmedByUserId, CreatedAt, Id (+19 more)

### Community 43 - "Community 43"
Cohesion: 0.08
Nodes (27): FSCM.UnitTests.Allocation, AllocationBenchmark, AllocationBenchmarkResult, AllocationDecision, AllocationEngine, AllocationFilterReason, ArrivesAfterDeadline, BelowMlor (+19 more)

### Community 44 - "Community 44"
Cohesion: 0.08
Nodes (18): FSCM.API.Contracts.Inventory, CreateGoodsReceiptRequest, ReceiveGoodsLineRequest, IReportStore, ProductSalesRow, SalesKpiConfigurationRow, SalesKpiOrderRow, SalesRevenueRow (+10 more)

### Community 45 - "Community 45"
Cohesion: 0.12
Nodes (9): CreateRedemptionRequest, LoyaltyRedemptionsController, IRedemptionStore, IRedemptionWorkflowStore, CreateRedemptionData, RedemptionView, RedemptionService, DependencyInjection (+1 more)

### Community 46 - "Community 46"
Cohesion: 0.10
Nodes (17): RetailerReceivablesController, IRetailerReceivableStore, ReceivableCollectionHistory, ReceivableDisputeHistory, ReceivableRefundHistory, RetailerReceivableFilter, RetailerReceivablePage, RetailerReceivableResult (+9 more)

### Community 47 - "Community 47"
Cohesion: 0.12
Nodes (10): GoodsReceiptsController, InventoryController, BatchInventoryResult, ExpirySweepRunResult, GoodsReceiptLineResult, GoodsReceiptResult, InventoryExpiryHealthResult, InventoryHistoryResult (+2 more)

### Community 48 - "Community 48"
Cohesion: 0.09
Nodes (14): ActivateAccountRequest, ConfirmPasswordResetRequest, CreateUserRequest, LoginRequest, PasswordResetRequest, RefreshTokenRequest, UpdateUserProfileRequest, UpdateUserRoleRequest (+6 more)

### Community 49 - "Community 49"
Cohesion: 0.07
Nodes (19): AssignRetailerTerritoryRequest, CreateRegionRequest, CreateSalesGroupRequest, TransferSalesRequest, UpdateRegionRequest, UpdateSalesGroupRequest, RegionsController, SalesGroupsController (+11 more)

### Community 50 - "Community 50"
Cohesion: 0.05
Nodes (31): PickableAllocation, AllocationRunAllocation, AllocationPlanVersionId, AllocationRunId, AllocationRunLineId, BatchId, CreatedAt, EstimatedArrivalAt (+23 more)

### Community 51 - "Community 51"
Cohesion: 0.03
Nodes (61): IWarehouseConfigurationStore, MlorView, WarehouseView, SystemConfiguration, ConfigKey, ConfigValue, CreatedAt, Description (+53 more)

### Community 52 - "Community 52"
Cohesion: 0.07
Nodes (21): BatchPromotionConfiguration, BatchQrLabelConfiguration, DriverConfiguration, GoodsReceiptConfiguration, InventoryLockConfiguration, LoyaltyProgramConfiguration, LoyaltyRewardConfiguration, ManualPaymentConfiguration (+13 more)

### Community 53 - "Community 53"
Cohesion: 0.06
Nodes (14): IInternalTransferStore, TransferItemView, TransferLabelView, TransferView, InternalTransferStore, FakeStore, Events, Items (+6 more)

### Community 54 - "Community 54"
Cohesion: 0.16
Nodes (8): IInventoryOutboxStore, BatchExpiredPayload, InventoryOutboxDispatcher, InventoryOutboxStore, FakeStore, Notifications, FixedTimeProvider, InventoryOutboxDispatcherTests

### Community 55 - "Community 55"
Cohesion: 0.06
Nodes (30): IInventoryLifecycleService, IInventoryLifecycleStore, InventoryLifecycleView, Allocation, Balance, Batch, Reservation, AllocationInventoryStatuses (+22 more)

### Community 56 - "Community 56"
Cohesion: 0.09
Nodes (7): CatalogPage, TotalPages, ProductQuery, ProductSearch, ProductView, CatalogStore, ProductViewRecord

### Community 57 - "Community 57"
Cohesion: 0.04
Nodes (38): ITerritoryStore, SalesGroupMembershipView, SalesGroupView, TerritoryAccessView, Region, Code, CreatedAt, Description (+30 more)

### Community 58 - "Community 58"
Cohesion: 0.09
Nodes (17): DeliveryOperationException, Code, DeliveryServiceTests, Fixture, Allocation, Balance, Driver, Inventory (+9 more)

### Community 59 - "Community 59"
Cohesion: 0.05
Nodes (26): OrderOperationException, Code, Details, WarehouseConfigurationOperationException, Code, FakePricing, Fixture, Inventory (+18 more)

### Community 60 - "Community 60"
Cohesion: 0.06
Nodes (25): AllocationLineTraceView, AllocationOrderTraceView, AllocationPlanAllocationView, AllocationPlanVersionView, OrderPriceLineView, OrderPricePartView, OrderPriceView, AllocationPlanVersion (+17 more)

### Community 61 - "Community 61"
Cohesion: 0.03
Nodes (53): FSCM.UnitTests.Maps, MapController, IMapStore, GeocodeTarget, MapDistanceResult, MapLocationResult, MapOperationException, Code (+45 more)

### Community 62 - "Community 62"
Cohesion: 0.09
Nodes (21): ConfirmRetailerReceiptRequest, CreateDriverRequest, CreateVehicleRequest, DispatchOrderRequest, SetActiveRequest, UpdateDriverRequest, UpdateVehicleRequest, DeliveriesController (+13 more)

### Community 63 - "Community 63"
Cohesion: 0.12
Nodes (15): FSCM.API.Contracts.Picking, CompleteRunPickingRequest, RunPickingSplitQuantityRequest, ScanPickingLabelRequest, PickingListsController, CompleteRunPickingData, PickingItemStatuses, PickingListResult (+7 more)

### Community 64 - "Community 64"
Cohesion: 0.05
Nodes (26): AllocationRunView, AllocationRunStock, AllocationRunId, BatchId, CreatedAt, ExpirationDate, Id, InventoryVersion (+18 more)

### Community 65 - "Community 65"
Cohesion: 0.07
Nodes (21): LoyaltyReward, AvailableQuantity, Code, CreatedAt, Description, DiscountAmount, DiscountPercent, Id (+13 more)

### Community 66 - "Community 66"
Cohesion: 0.08
Nodes (16): FSCM.Infrastructure.Maps, FSCM.Application.Features.Notifications, FSCM.Application.Features.EntityQueries, FSCM.Infrastructure.Payments, FSCM.UnitTests.Reports, FSCM.Application.Features.Identity, FSCM.Application.Features.Reports, FSCM.IntegrationTests.Api (+8 more)

### Community 67 - "Community 67"
Cohesion: 0.21
Nodes (17): IMobileSnapshotStore, MobileSnapshotCategory, MobileSnapshotData, MobileSnapshotDefaultMlor, MobileSnapshotMlor, MobileSnapshotPrice, MobileSnapshotProduct, MobileSnapshotPromotion (+9 more)

### Community 68 - "Community 68"
Cohesion: 0.07
Nodes (14): QrLabelEvent, BatchQrLabelId, EventType, FromStatus, Id, Note, OccurredAt, OperationKey (+6 more)

### Community 69 - "Community 69"
Cohesion: 0.12
Nodes (11): NotificationsController, MarkAllNotificationsReadResult, NotificationBadgeResult, NotificationOperationException, Code, NotificationPage, NotificationResult, NotificationService (+3 more)

### Community 70 - "Community 70"
Cohesion: 0.05
Nodes (30): OrderRunResultView, AllocationLineTrace, AllocationPlanVersionId, AllocationRunLineId, CoverageWeight, CreatedAt, DistanceWeight, DrawnQuantity (+22 more)

### Community 71 - "Community 71"
Cohesion: 0.06
Nodes (30): SalesOrder, ClientOrderKey, CreatedAt, CreatedByUserId, CreditTermDays, DeliveryAddress, DiscountAmount, FinalAmount (+22 more)

### Community 72 - "Community 72"
Cohesion: 0.10
Nodes (14): Promotion, Code, CreatedAt, CreatedByUserId, DiscountPercent, EndAt, Id, IsActive (+6 more)

### Community 73 - "Community 73"
Cohesion: 0.08
Nodes (11): ProductPriceResult, ProductPrice, CreatedAt, EffectiveFrom, EffectiveTo, Id, IsActive, ProductId (+3 more)

### Community 74 - "Community 74"
Cohesion: 0.11
Nodes (8): SalesGroupMember, AssignedAt, Id, IsActive, SalesGroupId, UnassignedAt, UserAccountId, SalesGroupMemberConfiguration

### Community 75 - "Community 75"
Cohesion: 0.06
Nodes (31): Payment, AdjustedAmount, Amount, CollectionMethod, ConfirmedAmount, ConfirmedAt, ConfirmedByUserId, CreatedAt (+23 more)

### Community 76 - "Community 76"
Cohesion: 0.07
Nodes (21): FSCM.API.Contracts.ShelfLifeDiscounts, PublishShelfLifeDiscountTableRequest, ShelfLifeDiscountTierRequest, ShelfLifeDiscountsController, AllocationPricingService, PublishShelfLifeDiscountTableData, ShelfLifeDiscountMatch, ShelfLifeDiscountScopes (+13 more)

### Community 77 - "Community 77"
Cohesion: 0.11
Nodes (14): AdjustReceivableData, PaymentOperationException, Code, Fixture, Gateway, Order, Payment, Plan (+6 more)

### Community 78 - "Community 78"
Cohesion: 0.07
Nodes (18): CreateWarehouseRequest, SetMlorRequest, UpdateBusinessConfigurationRequest, UpdateWarehouseRequest, UpdateWarehouseStatusRequest, BusinessConfigurationsController, MlorConfigurationsController, WarehousesController (+10 more)

### Community 79 - "Community 79"
Cohesion: 0.12
Nodes (15): CollectPaymentData, CreatePayOsCheckoutData, IPayOsGateway, PaymentCollectionMethods, PaymentStatuses, PayOsCheckoutResult, PayOsCreateLinkData, PayOsLinkData (+7 more)

### Community 80 - "Community 80"
Cohesion: 0.08
Nodes (17): Batch, BatchCode, CreatedAt, ExpirationDate, ExpiryStatus, GoodsReceiptLineId, Id, ParentBatchId (+9 more)

### Community 81 - "Community 81"
Cohesion: 0.11
Nodes (7): INotificationStore, NotificationStore, NotificationApiTests, TestStore, OrderId, OtherNotificationId, OwnNotificationId

### Community 82 - "Community 82"
Cohesion: 0.10
Nodes (10): EstimateEtaRequest, GeocodeRequest, RefreshDistanceRequest, OrderRunResult, OrderRunResultLine, IPaymentPlanService, ExpectedWarehousePart, PendingShipmentSource (+2 more)

### Community 83 - "Community 83"
Cohesion: 0.12
Nodes (12): CloneProductRequest, CreateProductRequest, CreateReplacementProductRequest, SetProductPriceRequest, UpdateCategoryStatusRequest, UpdateProductRequest, ProductsController, CreateProductData (+4 more)

### Community 84 - "Community 84"
Cohesion: 0.13
Nodes (6): ITransitTableStore, TransitTableView, TransitTableStore, ScenarioTransitStore, EmptyTransitTableStore, FakeTransitTableStore

### Community 85 - "Community 85"
Cohesion: 0.06
Nodes (29): SalesOrderLine, CreatedAt, DiscountAmount, DiscountPercent, DiscountSourceCode, DiscountSourceType, EstimatedArrivalAt, FinalPricePendingAllocation (+21 more)

### Community 86 - "Community 86"
Cohesion: 0.28
Nodes (9): AllocationTraceService, OrderTraceDetailResult, TraceCandidateResult, TraceLineResult, TraceScoreResult, TraceWeightsResult, AllocationTraceServiceTests, FakeStore (+1 more)

### Community 87 - "Community 87"
Cohesion: 0.25
Nodes (3): FSCM.UnitTests.Catalog, FSCM.Application.Features.Catalog, FSCM.Persistence.Catalog

### Community 89 - "Community 89"
Cohesion: 0.03
Nodes (51): ShipmentIssueRow, ShipmentLabelView, ShipmentLineView, ShipmentReceiptView, ShipmentView, ReceiptConfirmationQrLabel, BatchQrLabelId, Id (+43 more)

### Community 90 - "Community 90"
Cohesion: 0.18
Nodes (9): FSCM.API.Contracts.Orders, CancelOrderRequest, CreateAssistedOrderLineRequest, CreateAssistedOrderRequest, OfflineExpectedConditionRequest, OrderDecisionRequest, RejectOrderRequest, SubmitOfflineOrderRequest (+1 more)

### Community 91 - "Community 91"
Cohesion: 0.04
Nodes (29): IIdentityTokenProvider, RefreshTokenLifetime, IPasswordHasher, AllocationRunHostedService, AllocationRunOptions, CutoffLocalTime, Enabled, TimeZone (+21 more)

### Community 92 - "Community 92"
Cohesion: 0.12
Nodes (14): EtaController, AllocationScheduleResult, EtaBreakdown, EtaRequest, EtaResult, EstimatedArrivalAt, ScheduleMilestone, DeliveryEtaService (+6 more)

### Community 93 - "Community 93"
Cohesion: 0.18
Nodes (10): SalesOrderAttachment, AttachmentType, BlobUrl, ContentType, FileName, Id, SalesOrderId, UploadedAt (+2 more)

### Community 94 - "Community 94"
Cohesion: 0.16
Nodes (9): TransitTablesController, PublishTransitTableData, TransitBandData, TransitBandResult, TransitLookupResult, TransitTableResult, TransitTableOperationException, Code (+1 more)

### Community 95 - "Community 95"
Cohesion: 0.12
Nodes (11): OrderAllocationFragmentView, OrderAllocationReadContext, OrderLineView, OrderMlorSnapshot, OrderView, AllocationContext, OrderWarehouseProgressView, OrderListQuery (+3 more)

### Community 96 - "Community 96"
Cohesion: 0.06
Nodes (20): ILoyaltyStore, LoyaltyProgram, Code, CreatedAt, CreatedByUserId, Description, EndAt, Id (+12 more)

### Community 97 - "Community 97"
Cohesion: 0.09
Nodes (15): BatchQrLabel, BatchId, BlobUrl, CurrentWarehouseId, GeneratedAt, GoodsReceiptId, Id, InvalidatedAt (+7 more)

### Community 98 - "Community 98"
Cohesion: 0.07
Nodes (4): FSCM.Persistence.Configurations.Identity, FSCM.Persistence.Configurations.PhysicalSchema, FSCM.Domain.Entities, FSCM.IntegrationTests.Persistence

### Community 99 - "Community 99"
Cohesion: 0.12
Nodes (10): CapturePlan, OrderStatusHistory, ChangedAt, ChangedByUserId, FromStatus, Id, Reason, SalesOrderId (+2 more)

### Community 100 - "Community 100"
Cohesion: 0.14
Nodes (9): CreateRewardRequest, UpdateRewardRequest, LoyaltyRewardsController, IRewardStore, CreateRewardData, RewardResult, RewardView, UpdateRewardData (+1 more)

### Community 101 - "Community 101"
Cohesion: 0.22
Nodes (8): AllocationPriceLookupService, OrderPriceLineResult, OrderPricePartResult, OrderPriceResult, AllocationRunOperationException, Code, AllocationPriceLookupTests, FakeStore

### Community 102 - "Community 102"
Cohesion: 0.08
Nodes (25): CreateOrderLineData, OfflineConditionConflictResult, OfflineConditionDifference, OfflineExpectedConditionData, OrderAllocationFragmentResult, OrderAllocationResult, OrderLineResult, AllocationFragments (+17 more)

### Community 103 - "Community 103"
Cohesion: 0.20
Nodes (5): AllocationScenarioTests, ScenarioBatch, ScenarioFixture, Service, Store

### Community 104 - "Community 104"
Cohesion: 0.09
Nodes (14): IOrderPricingService, IOrderStore, OrderCaptureApiTests, TestMobileSnapshotStore, TestOrderStore, Audits, History, Lines (+6 more)

### Community 105 - "Community 105"
Cohesion: 0.09
Nodes (15): AuthenticatedUser, CreatedUserResult, IdentityProviders, All, IdentityScope, Empty, IdentityScopeLabels, Empty (+7 more)

### Community 106 - "Community 106"
Cohesion: 0.08
Nodes (18): FSCM.API.Contracts.Retailers, DeclareRetailerRequest, RetailerMlorDeclarationRequest, ReviewRetailerRequest, UpdateRetailerDeclarationRequest, UpdateRetailerStatusRequest, RetailersController, RetailerMlorView (+10 more)

### Community 107 - "Community 107"
Cohesion: 0.08
Nodes (26): ReportsController, CurrentUser, SystemQuery, ProductRankingCriteria, ProductRankingEntryResult, ProductRankingQuery, ProductRankingResult, SalesKpiEntryResult (+18 more)

### Community 108 - "Community 108"
Cohesion: 0.09
Nodes (15): FakeStore, Assignments, Audits, Batch, Category, CategoryLinks, Price, Price2 (+7 more)

### Community 109 - "Community 109"
Cohesion: 0.09
Nodes (14): IOrderReleaseStore, OrderHeldAllocation, OrderPickingShare, OrderReleaseOutcome, OrderReleaseService, OrderReleaseStore, FakeOrderReleaseStore, Held (+6 more)

### Community 110 - "Community 110"
Cohesion: 0.09
Nodes (18): OrderInventoryCandidate, OrderRetailerContext, FakeStore, Allocations, Audits, Balance, Batch, Configurations (+10 more)

### Community 111 - "Community 111"
Cohesion: 0.09
Nodes (18): TransitTable, CreatedAt, CreatedByUserId, EffectiveFrom, EffectiveTo, Id, IsActive, MaxServingDistanceMeters (+10 more)

### Community 112 - "Community 112"
Cohesion: 0.10
Nodes (18): AllocationTraceScore, AllocationLineTraceId, BatchCodeSnapshot, BatchId, CoverageScore, CreatedAt, DistanceScore, Id (+10 more)

### Community 114 - "Community 114"
Cohesion: 0.19
Nodes (8): CloneProductData, CatalogOperationException, Code, CatalogFixture, Service, Store, CatalogServiceTests, TestTimeProvider

### Community 115 - "Community 115"
Cohesion: 0.07
Nodes (25): Allocation, AllocatedQuantity, AllocationSequence, BatchId, CoverageScore, CreatedAt, DiscountAmount, DiscountPercent (+17 more)

### Community 116 - "Community 116"
Cohesion: 0.16
Nodes (5): PromotionRetailer, Id, PromotionId, RetailerId, PromotionRetailerConfiguration

### Community 117 - "Community 117"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, jobs, validate, name, on, pull_request (+19 more)

### Community 118 - "Community 118"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 119 - "Community 119"
Cohesion: 0.08
Nodes (21): BatchExpiryCandidate, IBatchExpiryStore, InventoryExpirySweepService, ExpirySweepRun, BatchesExpired, BatchesScanned, BusinessDate, CompletedAt (+13 more)

### Community 120 - "Community 120"
Cohesion: 0.16
Nodes (5): PromotionCategory, Id, ProductCategoryId, PromotionId, PromotionCategoryConfiguration

### Community 121 - "Community 121"
Cohesion: 0.23
Nodes (8): LoyaltyOperationException, Code, Fixture, ActorId, RetailerId, Service, Store, LoyaltyServiceTests

### Community 122 - "Community 122"
Cohesion: 0.10
Nodes (11): EtaSchedule, EtaScheduleView, IDeliveryEtaStore, DeliveryEtaStore, ScenarioEtaStore, EmptyEtaStore, FakeStore, Distance (+3 more)

### Community 123 - "Community 123"
Cohesion: 0.10
Nodes (10): EntraIdentity, IdentityOperationException, Code, IdentityService, IdentityFixture, PasswordHasher, Service, Store (+2 more)

### Community 124 - "Community 124"
Cohesion: 0.12
Nodes (13): AllocationPricing, PricedOrder, PricedPart, PricingOrder, PricingPart, FakeStore, Allocations, Balances (+5 more)

### Community 125 - "Community 125"
Cohesion: 0.08
Nodes (20): InventoryTransaction, AvailableQuantityAfter, BatchId, CreatedByUserId, GoodsReceiptId, GoodsReceiptLineId, Id, Note (+12 more)

### Community 126 - "Community 126"
Cohesion: 0.09
Nodes (20): FSCM.API.Contracts.Shipments, AssignShipmentRequest, ConfirmShipmentIssueRequest, ConfirmShipmentReceiptLineRequest, ConfirmShipmentReceiptRequest, FlagShipmentExceptionRequest, ShipmentsController, IShipmentStore (+12 more)

### Community 127 - "Community 127"
Cohesion: 0.16
Nodes (5): PromotionProduct, Id, ProductId, PromotionId, PromotionProductConfiguration

### Community 128 - "Community 128"
Cohesion: 0.22
Nodes (4): FSCM.API.Security, ActiveAccountClaimsTransformation, AuthenticationSchemes, AuthorizationPolicies

### Community 129 - "Community 129"
Cohesion: 0.17
Nodes (12): AllocationPlan, Fulfilled, Short, AllocationPlanner, PlannedAllocation, PlannedLineResult, PlannedOrder, PlannerBatch (+4 more)

### Community 130 - "Community 130"
Cohesion: 0.11
Nodes (17): RewardRedemption, CancelledAt, ClientRequestId, CreatedAt, FulfilledAt, Id, LoyaltyRewardId, LoyaltyTransactionId (+9 more)

### Community 131 - "Community 131"
Cohesion: 0.19
Nodes (7): LoyaltyCardsController, ILoyaltyCardStore, LoyaltyCardData, LoyaltyCardResult, LoyaltyLedgerEntry, LoyaltyCardService, LoyaltyCardStore

### Community 132 - "Community 132"
Cohesion: 0.13
Nodes (11): UserCredential, CreatedAt, FailedLoginCount, Id, LockoutEndAt, MustChangePassword, PasswordChangedAt, PasswordHash (+3 more)

### Community 134 - "Community 134"
Cohesion: 0.10
Nodes (16): InventoryLock, BatchId, CreatedAt, Id, LockedByUserId, LockedQuantity, Note, ProductId (+8 more)

### Community 135 - "Community 135"
Cohesion: 0.10
Nodes (15): PickingOperationException, Code, Clock, Fixture, ActorId, Events, First, FirstPriceId (+7 more)

### Community 136 - "Community 136"
Cohesion: 0.12
Nodes (13): ScanQrLabelData, QrLabelOperationException, Code, Fixture, DestinationBatch, DestinationWarehouse, Product, Service (+5 more)

### Community 137 - "Community 137"
Cohesion: 0.14
Nodes (12): OutboxMessage, AggregateId, AggregateType, CreatedAt, EventType, Id, LastError, Payload (+4 more)

### Community 138 - "Community 138"
Cohesion: 0.08
Nodes (24): include, deployment, displayName, environment, job, steps, strategy, name (+16 more)

### Community 141 - "Community 141"
Cohesion: 0.37
Nodes (4): AllocationPlanApprovalTests, ApprovalFixture, Approvals, Reservations

### Community 142 - "Community 142"
Cohesion: 0.22
Nodes (5): ApplyBatchDiscountRequest, CreatePromotionRequest, UpdatePromotionRequest, BatchDiscountsController, BatchDiscountResult

### Community 143 - "Community 143"
Cohesion: 0.05
Nodes (35): IShelfLifeDiscountStore, ShelfLifeDiscountTableView, ShelfLifeDiscountTable, CreatedAt, CreatedByUserId, EffectiveFrom, EffectiveTo, Id (+27 more)

### Community 144 - "Community 144"
Cohesion: 0.10
Nodes (12): RetailerProductMlor, EffectiveFrom, EffectiveTo, Id, IsActive, MinimumLifeHours, MinimumLifeRatio, ProductCategoryId (+4 more)

### Community 145 - "Community 145"
Cohesion: 0.08
Nodes (23): AllocationPlanPrice, AllocationPlanVersionId, AllocationRunLineId, Amount, BaseNetUnitPrice, BatchExpiresAt, BatchId, CreatedAt (+15 more)

### Community 147 - "Community 147"
Cohesion: 0.09
Nodes (21): Delivery, AssignedAt, CreatedAt, DeliveredAt, DispatchedAt, DriverCodeSnapshot, DriverId, DriverLicenseSnapshot (+13 more)

### Community 148 - "Community 148"
Cohesion: 0.12
Nodes (12): FSCM.API.Contracts.Complaints, CreateComplaintRequest, ResolveComplaintRequest, ComplaintsController, ComplaintResult, CreateComplaintData, ResolveComplaintData, ComplaintOperationException (+4 more)

### Community 149 - "Community 149"
Cohesion: 0.20
Nodes (10): FSCM.API.Contracts.InternalTransfers, CreateInternalTransferLineRequest, CreateInternalTransferRequest, DispatchInternalTransferLineRequest, DispatchInternalTransferRequest, ReceiveInternalTransferRequest, RejectInternalTransferRequest, TransferDecisionRequest (+2 more)

### Community 150 - "Community 150"
Cohesion: 0.19
Nodes (8): BatchPromotion, AssignedAt, AssignedByUserId, BatchId, Id, IsActive, PromotionId, RemovedAt

### Community 151 - "Community 151"
Cohesion: 0.35
Nodes (4): FSCM.API.Contracts.InventoryLocks, CreateInventoryLockRequest, ReleaseInventoryLockRequest, InventoryLocksController

### Community 152 - "Community 152"
Cohesion: 0.12
Nodes (10): Driver, Code, CreatedAt, FullName, Id, IsActive, LicenseNumber, Phone (+2 more)

### Community 153 - "Community 153"
Cohesion: 0.13
Nodes (9): Vehicle, Capacity, CreatedAt, Id, IsActive, PlateNumber, UpdatedAt, VehicleType (+1 more)

### Community 154 - "Community 154"
Cohesion: 0.20
Nodes (9): WriteOffAttachment, BlobUrl, ContentType, FileName, Id, UploadedAt, UploadedByUserId, WriteOffId (+1 more)

### Community 155 - "Community 155"
Cohesion: 0.13
Nodes (13): RetailerOperationException, Code, FixedTimeProvider, Fixture, Category, GroupId, ParentCategory, Product (+5 more)

### Community 156 - "Community 156"
Cohesion: 0.06
Nodes (17): FSCM.UnitTests.Inventory, FSCM.Application.Features.InventoryLocks, FSCM.UnitTests.InventoryLocks, FSCM.UnitTests.Retailers, FSCM.Persistence.InventoryLocks, FSCM.Application.Features.Retailers, FSCM.Persistence.Retailers, ExpirySweepResult (+9 more)

### Community 157 - "Community 157"
Cohesion: 0.15
Nodes (12): ReceiptDiscrepancy, Id, Note, ReceiptConfirmationId, ReportedAt, ReportedByRetailerUserId, ResolvedAt, ReviewedAt (+4 more)

### Community 158 - "Community 158"
Cohesion: 0.35
Nodes (10): DbCategory, categoryDto(), catName(), find(), nextSku(), productDetail(), productSummary(), readProduct() (+2 more)

### Community 159 - "Community 159"
Cohesion: 0.09
Nodes (17): WarehouseTransfer, ApprovedAt, ApprovedByUserId, CreatedAt, CreatedByUserId, DestinationWarehouseId, DispatchedAt, Id (+9 more)

### Community 160 - "Community 160"
Cohesion: 0.18
Nodes (6): BatchLockContext, IInventoryLockStore, InventoryLockView, InventoryLockStore, FakeStore, Locks

### Community 161 - "Community 161"
Cohesion: 0.20
Nodes (11): CreateInventoryLockData, ReleaseInventoryLockData, InventoryLockOperationException, Code, FixedTimeProvider, Fixture, Batch, KeeperId (+3 more)

### Community 162 - "Community 162"
Cohesion: 0.18
Nodes (10): ManualPaymentOperationException, Code, Fixture, Ledger, OperatorId, Order, Retailer, Service (+2 more)

### Community 163 - "Community 163"
Cohesion: 0.10
Nodes (18): SalesOrderQuote, AcceptedAt, AcceptedByUserId, AllocationPlanVersionId, AllocationRunId, CreatedAt, ExpiresAt, Id (+10 more)

### Community 164 - "Community 164"
Cohesion: 0.22
Nodes (8): react-dom@^19.2.6, @types/node@^24.12.3, name, private, type, version, react-dom, @types/node

### Community 166 - "Community 166"
Cohesion: 0.10
Nodes (19): archiveFile, archiveType, arguments, artifact, command, includeRootFolder, packageType, projects (+11 more)

### Community 168 - "Community 168"
Cohesion: 0.17
Nodes (11): InternalTransferOperationException, Code, Fixture, Central, KeeperId, OperatorId, Product, Regional (+3 more)

### Community 169 - "Community 169"
Cohesion: 0.16
Nodes (10): GoodsReceiptLine, CreatedAt, ExpirationDate, GoodsReceiptId, Id, ProductId, ProductionDate, ReceivedQuantity (+2 more)

### Community 170 - "Community 170"
Cohesion: 0.12
Nodes (15): GoodsReceipt, ApprovedAt, ApprovedByUserId, CreatedAt, CreatedByUserId, Id, IdempotencyKey, ReceiptCode (+7 more)

### Community 171 - "Community 171"
Cohesion: 0.11
Nodes (13): IMapProvider, Name, GeocodeProviderResult, RouteDistanceProviderResult, GoogleMapsProvider, Name, GoogleMapsProviderTests, StubClientFactory (+5 more)

### Community 175 - "Community 175"
Cohesion: 0.15
Nodes (9): AccountToken, ConsumedAt, CreatedAt, ExpiresAt, Id, Purpose, TokenHash, UserAccountId (+1 more)

### Community 176 - "Community 176"
Cohesion: 0.11
Nodes (15): OrderPromotion, AppliedAt, DiscountAmount, DiscountPercent, EffectiveFromSnapshot, EffectiveToSnapshot, Id, IsServerFinal (+7 more)

### Community 177 - "Community 177"
Cohesion: 0.20
Nodes (4): Fixture, Service, Store, TerritoryServiceTests

### Community 178 - "Community 178"
Cohesion: 0.10
Nodes (18): WriteOff, CreatedAt, CreatedByUserId, Id, Reason, Status, UpdatedAt, WarehouseId (+10 more)

### Community 183 - "Community 183"
Cohesion: 0.08
Nodes (22): LoyaltyTransaction, BalanceAfter, CreatedAt, CreatedByUserId, Id, LoyaltyProgramId, Note, Points (+14 more)

### Community 185 - "Community 185"
Cohesion: 0.13
Nodes (11): WarehouseTransferEvent, Action, FromStatus, Id, Note, OccurredAt, OperationKey, PerformedByUserId (+3 more)

### Community 186 - "Community 186"
Cohesion: 0.12
Nodes (13): WarehouseTransferItem, CreatedAt, DestinationBatchId, DispatchedQuantity, Id, Note, ReceivedQuantity, RequestedQuantity (+5 more)

### Community 187 - "Community 187"
Cohesion: 0.14
Nodes (9): InventoryBalance, AvailableQuantity, BatchId, Id, PhysicalQuantity, ReservedQuantity, UpdatedAt, Version (+1 more)

### Community 188 - "Community 188"
Cohesion: 0.11
Nodes (15): AllocationTraceCandidate, AllocationLineTraceId, BatchCodeSnapshot, BatchId, CreatedAt, EstimatedArrivalAt, Id, Passed (+7 more)

### Community 189 - "Community 189"
Cohesion: 0.13
Nodes (15): ASPNETCORE_ENVIRONMENT, applicationUrl, commandName, dotnetRunMessages, environmentVariables, launchBrowser, applicationUrl, commandName (+7 more)

### Community 190 - "Community 190"
Cohesion: 0.16
Nodes (8): UserRegionAssignment, AssignedAt, Id, IsActive, RegionId, UnassignedAt, UserAccountId, UserRegionAssignmentConfiguration

### Community 192 - "Community 192"
Cohesion: 0.11
Nodes (12): FSCM.API.Contracts.Quotes, AcceptQuoteRequest, RejectQuoteRequest, QuotesController, IQuoteStore, QuoteIssueOrder, QuoteView, SalesOrderQuoteResult (+4 more)

### Community 194 - "Community 194"
Cohesion: 0.34
Nodes (3): LoyaltyRedemptionWorkflowController, RedemptionResult, RedemptionWorkflowService

### Community 196 - "Community 196"
Cohesion: 0.13
Nodes (13): PurchaseOrder, CreatedAt, Id, IssuedAt, IssuedByUserId, PaymentMethod, PurchaseOrderCode, SalesOrderId (+5 more)

### Community 197 - "Community 197"
Cohesion: 0.15
Nodes (11): ReceiptConfirmation, ConfirmedAt, ConfirmedByRetailerUserId, CreatedAt, Id, Note, OperationKey, RequestHash (+3 more)

### Community 198 - "Community 198"
Cohesion: 0.14
Nodes (12): ReceiptConfirmationItem, BatchId, BatchQrLabelId, DamagedQuantity, ExpectedQuantity, Id, MissingQuantity, ReceiptConfirmationId (+4 more)

### Community 200 - "Community 200"
Cohesion: 0.16
Nodes (9): TransitTableBand, CreatedAt, EstimatedCostAmount, HandlingMinutes, Id, MaxDistanceMeters, MinDistanceMeters, TransitMinutes (+1 more)

### Community 201 - "Community 201"
Cohesion: 0.12
Nodes (8): FSCM.Application, FSCM.Infrastructure, FSCM.API.Extensions, FSCM.Persistence.Seeding, FSCM.Persistence, ConfigurationExtensions, WebApplicationExtensions, Program

### Community 202 - "Community 202"
Cohesion: 0.20
Nodes (10): CreateInternalTransferData, CreateInternalTransferLineData, DispatchInternalTransferData, DispatchInternalTransferLineData, InternalTransferEventResult, InternalTransferItemResult, InternalTransferLabelResult, InternalTransferSuggestionResult (+2 more)

### Community 204 - "Community 204"
Cohesion: 0.13
Nodes (14): ReceiptDiscrepancyItem, ActualReceivedQuantity, AdjustmentAmount, AllocationPlanPriceId, BatchId, EvidenceBlobUrl, ExpectedQuantity, FinalUnitPrice (+6 more)

### Community 206 - "Community 206"
Cohesion: 0.30
Nodes (5): FakeClock, Fixture, Service, Store, TransitTableServiceTests

### Community 211 - "Community 211"
Cohesion: 0.45
Nodes (3): AllocationRunResultService, AllocationRunResultTests, FakeStore

### Community 212 - "Community 212"
Cohesion: 0.18
Nodes (5): IQrCodeRenderer, QrCoderQrCodeRenderer, QrLabelPrintApiTests, TestQrRenderer, FakeQrCodeRenderer

### Community 213 - "Community 213"
Cohesion: 0.18
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
Cohesion: 0.22
Nodes (5): FSCM.Application.Features.Quotes, AcceptQuoteRequestData, PurchaseOrderStatuses, RejectQuoteRequestData, SalesOrderQuoteStatuses

### Community 220 - "Community 220"
Cohesion: 0.20
Nodes (9): StockHold, AllocationId, BatchId, HeldAt, Id, Quantity, ReleasedAt, Status (+1 more)

### Community 222 - "Community 222"
Cohesion: 0.19
Nodes (8): WarehouseTransferLabel, BatchQrLabelId, DispatchedAt, Id, Quantity, ReceivedAt, WarehouseTransferItemId, WarehouseTransferLabelConfiguration

### Community 223 - "Community 223"
Cohesion: 0.18
Nodes (10): BatchExpiryStatuses, BatchStockStatuses, ExpirySweepStatuses, GoodsReceiptStatuses, InventoryNotificationTypes, InventoryOutboxEventTypes, InventoryTransactionSourceTypes, InventoryTransactionTypes (+2 more)

### Community 225 - "Community 225"
Cohesion: 0.20
Nodes (9): variables, apiProject, artifactName, azureServiceConnection, azureWebAppName, azureWebAppType, backendSolution, buildConfiguration (+1 more)

### Community 233 - "Community 233"
Cohesion: 0.33
Nodes (5): BusinessDocumentSequence, BusinessDate, DocumentType, LastNumber, BusinessDocumentSequenceConfiguration

### Community 268 - "Community 268"
Cohesion: 0.67
Nodes (3): FSCM.API.Contracts.TransitTables, PublishTransitTableRequest, TransitBandRequest

### Community 279 - "Community 279"
Cohesion: 0.11
Nodes (16): NotificationFilter, Notification, CreatedAt, DeepLink, Id, IsRead, Message, OutboxMessageId (+8 more)

### Community 291 - "Community 291"
Cohesion: 0.09
Nodes (74): disposal(), useBatch(), BatchDetailPage(), useCategory(), CategoryDetailPage(), useComplaint(), ComplaintDetailPage(), disposalApi (+66 more)

### Community 292 - "Community 292"
Cohesion: 0.17
Nodes (23): regionApi, AreaDialog(), GroupDialog(), TransferStaffDialog(), useAreas(), useCreateArea(), useCreateGroup(), useGroups() (+15 more)

### Community 293 - "Community 293"
Cohesion: 0.21
Nodes (21): AllocationInput, Cand, round3(), traceAllocation(), TraceLine, TraceResult, Candidate, Capacity (+13 more)

### Community 294 - "Community 294"
Cohesion: 0.13
Nodes (41): DISPATCH_DATE, MOCK_NOW, MOCK_TODAY, pad(), stamp(), db, DbOrder, actorLabel() (+33 more)

### Community 295 - "Community 295"
Cohesion: 0.11
Nodes (32): batchpromo(), batchPromoApi, DiscountDialog(), scanLabel, useCreateBatchDiscount(), useDiscountSuggestions(), usePublishShelfLife(), useShelfLifeCurrent() (+24 more)

### Community 296 - "Community 296"
Cohesion: 0.06
Nodes (44): orderApi, OrderActions(), Props, DispatchDialog(), ReasonDialog(), ReasonDialogProps, orderKeys, useApproveOrder() (+36 more)

### Community 297 - "Community 297"
Cohesion: 0.18
Nodes (17): promos(), promoApi, useActivatePromo(), useCreatePromo(), usePausePromo(), usePromoLookups(), usePromos(), PromoFormPage() (+9 more)

### Community 298 - "Community 298"
Cohesion: 0.16
Nodes (23): DbUser, areaName(), encodeToken(), DEMO, registerIdentity(), ROLES, userDto(), mlorOf() (+15 more)

### Community 299 - "Community 299"
Cohesion: 0.08
Nodes (33): gifts(), loyalty(), fleetApi, Availability, Driver, DriverDetail, DriverInput, Trip (+25 more)

### Community 300 - "Community 300"
Cohesion: 0.07
Nodes (32): concurrency, cancel-in-progress, group, name, runs-on, steps, jobs, e2e (+24 more)

### Community 301 - "Community 301"
Cohesion: 0.03
Nodes (115): axios@^1.19.0, axios, react, react-router-dom, @tanstack/react-query, App(), AppLayout(), initials() (+107 more)

### Community 302 - "Community 302"
Cohesion: 0.15
Nodes (24): products(), productApi, copy, Kind, ProductActions(), ProductDialog(), useCategoryOptions(), useCloneProduct() (+16 more)

### Community 303 - "Community 303"
Cohesion: 0.26
Nodes (21): product(), warehouse(), warehouseName(), batchDto(), disposalDto(), findBatch(), findProposal(), findTransfer() (+13 more)

### Community 305 - "Community 305"
Cohesion: 0.15
Nodes (23): retailers(), retailerApi, RegistrationActions(), KINDS, RetailerFormDialog(), useApproveRegistration(), useCreateRetailer(), useRejectRegistration() (+15 more)

### Community 306 - "Community 306"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 307 - "Community 307"
Cohesion: 0.05
Nodes (93): allocation(), runpicking(), shipments(), allocationApi, discountRule(), MLOR_SOURCES, Part, PlanOrderDetail() (+85 more)

### Community 308 - "Community 308"
Cohesion: 0.08
Nodes (43): Commercial, commercialData(), E(), Pn(), X(), D(), ddMMyyyy(), DT() (+35 more)

### Community 310 - "Community 310"
Cohesion: 0.10
Nodes (20): AppRoute, batches(), complaints(), fleet(), orders(), redeem(), regions(), rotation() (+12 more)

### Community 311 - "Community 311"
Cohesion: 0.11
Nodes (18): dependencies, @apollo/client@^4.2.9, @azure/msal-browser@^5.25.1, graphql@^16.14.2, lucide-react@^1.28.0, react@^19.2.6, react-router-dom@^5.3.4, recharts@^3.10.1 (+10 more)

### Community 314 - "Community 314"
Cohesion: 0.23
Nodes (15): transferApi, TransferDialog(), useCreateTransfer(), useReceiveTransfer(), useReplenishmentSuggestions(), useTransferLookups(), useTransfers(), TransfersPage() (+7 more)

### Community 317 - "Community 317"
Cohesion: 0.10
Nodes (19): compilerOptions, allowImportingTsExtensions, isolatedModules, jsx, lib, module, moduleDetection, moduleResolution (+11 more)

### Community 318 - "Community 318"
Cohesion: 0.06
Nodes (56): debts(), kpi(), batchApi, useBatches(), BatchesPage(), Batch, BatchDetail, BatchMovement (+48 more)

### Community 320 - "Community 320"
Cohesion: 0.06
Nodes (40): categories(), categoryApi, CategoryDialog(), useCategories(), useCreateCategory(), useUpdateCategory(), CategoriesPage(), Category (+32 more)

### Community 321 - "Community 321"
Cohesion: 0.05
Nodes (75): config(), receipts(), configApi, runScheduleApi, transitApi, FIELD_HINT, FIELD_LABEL, Key (+67 more)

### Community 323 - "Community 323"
Cohesion: 0.15
Nodes (13): devDependencies, tailwindcss@^4.3.3, @tailwindcss/vite@^4.3.3, @types/react@^19.2.14, @types/react-dom@^19.2.3, @types/react-router-dom@^5.3.3, typescript@~6.0.2, tailwindcss (+5 more)

### Community 326 - "Community 326"
Cohesion: 0.13
Nodes (14): compilerOptions, allowImportingTsExtensions, isolatedModules, lib, module, moduleDetection, moduleResolution, noEmit (+6 more)

### Community 327 - "Community 327"
Cohesion: 0.18
Nodes (12): dashboard(), dashboardApi, RevenueByDayChart(), RevenueBySalesChart(), tooltipMoney(), useDashboard(), DashboardPage(), DashboardDay (+4 more)

### Community 328 - "Community 328"
Cohesion: 0.15
Nodes (12): eslint@^10.3.0, @eslint/js@^10.0.1, eslint-plugin-react-hooks@^7.1.1, eslint-plugin-react-refresh@^0.5.2, globals@^17.6.0, typescript-eslint@^8.59.2, eslint, @eslint/js (+4 more)

### Community 329 - "Community 329"
Cohesion: 0.13
Nodes (18): whDistance(), DbDriver, DbTransitTable, DbVehicle, currentTransitTable(), findDriver(), findVehicle(), MockTransitBand (+10 more)

### Community 335 - "Community 335"
Cohesion: 0.18
Nodes (22): yymmdd(), PricedLine, PricedOrder, PricedPromotion, priceLines(), DbPromotion, actor(), nextSeq() (+14 more)

### Community 336 - "Community 336"
Cohesion: 0.22
Nodes (9): scripts, build, dev, lint, preview, test:e2e, test:e2e:install, test:e2e:report (+1 more)

### Community 342 - "Community 342"
Cohesion: 0.33
Nodes (4): vite@^8.0.12, @vitejs/plugin-react@^6.0.1, vite, @vitejs/plugin-react

### Community 343 - "Community 343"
Cohesion: 0.40
Nodes (5): GoogleCredentialResponse, GoogleIdentityApi, GoogleSignInButton(), loadGoogleIdentity(), Window

### Community 344 - "Community 344"
Cohesion: 0.33
Nodes (5): main, git, deploymentEnabled, rewrites, $schema

### Community 348 - "Community 348"
Cohesion: 0.03
Nodes (77): afterPromo, areaCode, areaName, balance, complaints, conflictApplied, createdAt, fmtTime (+69 more)

### Community 349 - "Community 349"
Cohesion: 0.03
Nodes (57): batch, batchExpiry, batchPattern, category, categoryPattern, classify, code, _ddMMyyyy (+49 more)

### Community 350 - "Community 350"
Cohesion: 0.02
Nodes (77): ApiErrorKind, ApiException, code, _defaultMessage, describe, errors, fromProblem, isNetwork (+69 more)

### Community 351 - "Community 351"
Cohesion: 0.04
Nodes (50): areas, authLogin, authLogout, authOtpRequest, authOtpVerify, authSetPassword, batches, categories (+42 more)

### Community 352 - "Community 352"
Cohesion: 0.04
Nodes (48): AppRoutes, login, notifications, rtAccount, rtComplaintFor, rtComplaintNew, rtComplaints, rtGifts (+40 more)

### Community 353 - "Community 353"
Cohesion: 0.05
Nodes (21): Cocoa, connectivity_plus, file_selector_macos, Flutter, flutter_secure_storage_darwin, FlutterMacOS, Foundation, AppDelegate (+13 more)

### Community 354 - "Community 354"
Cohesion: 0.05
Nodes (42): byRetailer, fromJson, group, isMe, name, orderCount, orders, periodLabel (+34 more)

### Community 355 - "Community 355"
Cohesion: 0.03
Nodes (25): homeRouteFor, _prefixFor, redirectFor, refresh, _retailerRoutes, router, _salesRoutes, _warehouseRoutes (+17 more)

### Community 356 - "Community 356"
Cohesion: 0.03
Nodes (76): _bearer, forceOffline, _handlers, send, store, handle, MockAuthHandler, _session (+68 more)

### Community 357 - "Community 357"
Cohesion: 0.02
Nodes (118): Order, fromJson, order, pointsEarned, pointsPending, ReceiptConfirmation, authControllerProvider, _api (+110 more)

### Community 358 - "Community 358"
Cohesion: 0.05
Nodes (39): accepted, changeReason, clientRequestId, copyWith, createdAt, creditTerm, discount, error (+31 more)

### Community 359 - "Community 359"
Cohesion: 0.03
Nodes (67): allDone, approvedAt, batchCode, childLabel, code, copyWith, doneLines, expiry (+59 more)

### Community 360 - "Community 360"
Cohesion: 0.02
Nodes (98): build, navigationShell, RetailerShell, activeIcon, build, _go, icon, label (+90 more)

### Community 361 - "Community 361"
Cohesion: 0.06
Nodes (28): apiBaseUrl, AppFlavor, connectTimeout, Env, flavorName, isProd, mockLatencyMs, receiveTimeout (+20 more)

### Community 362 - "Community 362"
Cohesion: 0.06
Nodes (34): dependencies, connectivity_plus, cupertino_icons, dio, flutter, flutter_localizations, flutter_riverpod, flutter_secure_storage (+26 more)

### Community 364 - "Community 364"
Cohesion: 0.08
Nodes (14): fl_register_plugins(), main(), first_frame_cb(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line() (+6 more)

### Community 365 - "Community 365"
Cohesion: 0.02
Nodes (95): build, FscmApp, routerProvider, ApiClient, _catalog, _d, fill, _finance (+87 more)

### Community 366 - "Community 366"
Cohesion: 0.02
Nodes (116): PickingStatus, LabelInfo, LoyaltyAccount, PointLedgerEntry, Receivable, Transfer, _client, snapshot (+108 more)

### Community 368 - "Community 368"
Cohesion: 0.07
Nodes (29): concurrency, cancel-in-progress, group, jobs, validate, name, on, pull_request (+21 more)

### Community 369 - "Community 369"
Cohesion: 0.07
Nodes (19): async, clearCache, close, databaseName, _db, inventorySnapshot, _migrations, NULL (+11 more)

### Community 370 - "Community 370"
Cohesion: 0.03
Nodes (96): build, createState, initState, navigationShell, SalesShell, _SalesShellState, networkMonitorProvider, StatusTone (+88 more)

### Community 372 - "Community 372"
Cohesion: 0.07
Nodes (27): concurrency, cancel-in-progress, group, AZURE_DEVOPS_PAT, AZURE_REPO_URL, BRANCH_NAME, jobs, mirror (+19 more)

### Community 373 - "Community 373"
Cohesion: 0.02
Nodes (126): actualQty, code, Complaint, createdAt, expectedQty, fromJson, labelCode, name (+118 more)

### Community 376 - "Community 376"
Cohesion: 0.04
Nodes (49): accessToken, AppUser, areaCode, areaName, expiresAt, fromJson, fullName, id (+41 more)

### Community 378 - "Community 378"
Cohesion: 0.02
Nodes (74): DeviceIdentity, deviceIdentityProvider, _deviceKey, _installKey, _prefs, sharedPreferencesProvider, _apply, _connectivity (+66 more)

### Community 382 - "Community 382"
Cohesion: 0.02
Nodes (106): AppDatabase, all, _appDb, deduct, InventorySnapshotDao, replaceAll, all, _appDb (+98 more)

### Community 383 - "Community 383"
Cohesion: 0.03
Nodes (59): AppClock, mockEpoch, now, today, _watch, PaymentMethod, PriceQuote, address (+51 more)

### Community 391 - "Community 391"
Cohesion: 0.04
Nodes (42): ApiRequest, ApiResponse, body, data, headers, isSuccess, method, path (+34 more)

### Community 396 - "Community 396"
Cohesion: 0.05
Nodes (30): apiClientProvider, apiTransportProvider, client, delete, _dio, DioTransport, dispose, onUnauthorized (+22 more)

### Community 397 - "Community 397"
Cohesion: 0.12
Nodes (4): FlutterWindow, flutter_controller_, FlutterWindow::FlutterWindow(), project_

### Community 400 - "Community 400"
Cohesion: 0.08
Nodes (22): RegistrationStatus, address, areaName, code, contactName, fromJson, name, NewRegistration (+14 more)

### Community 402 - "Community 402"
Cohesion: 0.11
Nodes (16): AppColors, background, border, danger, divider, foreground, primary, primaryDark (+8 more)

### Community 406 - "Community 406"
Cohesion: 0.18
Nodes (6): EnableNonClientDpiScaling, Scale(), Win32Window::Win32Window(), WindowClassRegistrar, class_registered_, instance_

### Community 418 - "Community 418"
Cohesion: 0.14
Nodes (13): available, basePrice, category, fromJson, name, pack, price, PriceEntry (+5 more)

### Community 421 - "Community 421"
Cohesion: 0.19
Nodes (4): wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 422 - "Community 422"
Cohesion: 0.15
Nodes (10): AppDates, _date, _dayMonth, daysBetween, _iso, _isoDate, isSameDay, _time (+2 more)

### Community 429 - "Community 429"
Cohesion: 0.17
Nodes (11): AppNotification, createdAt, fromJson, id, isLocal, kind, markRead, orderCode (+3 more)

### Community 431 - "Community 431"
Cohesion: 0.19
Nodes (4): Win32Window, child_content_, quit_on_close_, window_handle_

### Community 437 - "Community 437"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 438 - "Community 438"
Cohesion: 0.20
Nodes (9): analyzer, errors, exclude, language, deprecated_member_use, include, strict-raw-types, linter (+1 more)

### Community 456 - "Community 456"
Cohesion: 0.29
Nodes (6): format, minus, Money, _oneDecimal, parse, short

### Community 466 - "Community 466"
Cohesion: 0.21
Nodes (6): Point, x, y, Size, height, width

## Knowledge Gaps
- **3188 isolated node(s):** `AssignedAt`, `AssignedByUserId`, `BatchId`, `Id`, `IsActive` (+3183 more)
  These have ≤1 connection - possible missing edges. (Counts symbols only; 3970 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **45 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppDbContext` connect `Community 5` to `Community 2`, `Community 3`, `Community 8`, `Community 10`, `Community 12`, `Community 14`, `Community 15`, `Community 16`, `Community 17`, `Community 22`, `Community 23`, `Community 24`, `Community 26`, `Community 27`, `Community 28`, `Community 30`, `Community 31`, `Community 32`, `Community 36`, `Community 38`, `Community 42`, `Community 44`, `Community 45`, `Community 46`, `Community 50`, `Community 51`, `Community 53`, `Community 54`, `Community 55`, `Community 56`, `Community 57`, `Community 60`, `Community 61`, `Community 64`, `Community 65`, `Community 67`, `Community 68`, `Community 70`, `Community 71`, `Community 72`, `Community 73`, `Community 74`, `Community 75`, `Community 80`, `Community 81`, `Community 84`, `Community 85`, `Community 89`, `Community 91`, `Community 93`, `Community 95`, `Community 96`, `Community 97`, `Community 99`, `Community 109`, `Community 111`, `Community 112`, `Community 115`, `Community 116`, `Community 119`, `Community 120`, `Community 122`, `Community 125`, `Community 127`, `Community 130`, `Community 131`, `Community 132`, `Community 134`, `Community 137`, `Community 140`, `Community 143`, `Community 144`, `Community 145`, `Community 147`, `Community 148`, `Community 150`, `Community 152`, `Community 153`, `Community 154`, `Community 157`, `Community 159`, `Community 160`, `Community 163`, `Community 169`, `Community 170`, `Community 175`, `Community 176`, `Community 178`, `Community 183`, `Community 185`, `Community 186`, `Community 187`, `Community 188`, `Community 190`, `Community 192`, `Community 196`, `Community 197`, `Community 198`, `Community 200`, `Community 204`, `Community 213`, `Community 220`, `Community 222`, `Community 233`, `Community 243`, `Community 279`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **What connects `AssignedAt`, `AssignedByUserId`, `BatchId` to the rest of the system?**
  _3188 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.07777777777777778 - nodes in this community are weakly interconnected._
- **Why does `FSCM.Domain.Entities` connect `Community 98` to `Community 0`, `Community 1`, `Community 2`, `Community 7`, `Community 8`, `Community 11`, `Community 12`, `Community 13`, `Community 14`, `Community 16`, `Community 17`, `Community 18`, `Community 21`, `Community 22`, `Community 23`, `Community 24`, `Community 26`, `Community 28`, `Community 30`, `Community 31`, `Community 32`, `Community 36`, `Community 38`, `Community 39`, `Community 42`, `Community 45`, `Community 50`, `Community 51`, `Community 53`, `Community 54`, `Community 55`, `Community 57`, `Community 60`, `Community 61`, `Community 64`, `Community 65`, `Community 66`, `Community 68`, `Community 69`, `Community 70`, `Community 71`, `Community 72`, `Community 73`, `Community 74`, `Community 75`, `Community 80`, `Community 84`, `Community 85`, `Community 87`, `Community 89`, `Community 91`, `Community 93`, `Community 95`, `Community 96`, `Community 97`, `Community 99`, `Community 100`, `Community 109`, `Community 111`, `Community 112`, `Community 115`, `Community 116`, `Community 119`, `Community 120`, `Community 122`, `Community 125`, `Community 127`, `Community 130`, `Community 131`, `Community 132`, `Community 134`, `Community 137`, `Community 143`, `Community 144`, `Community 145`, `Community 147`, `Community 148`, `Community 150`, `Community 152`, `Community 153`, `Community 154`, `Community 156`, `Community 157`, `Community 159`, `Community 163`, `Community 169`, `Community 170`, `Community 175`, `Community 176`, `Community 178`, `Community 183`, `Community 185`, `Community 186`, `Community 187`, `Community 188`, `Community 190`, `Community 192`, `Community 196`, `Community 197`, `Community 198`, `Community 200`, `Community 204`, `Community 213`, `Community 218`, `Community 220`, `Community 222`, `Community 233`, `Community 279`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.06829488919041157 - nodes in this community are weakly interconnected._
- **Why does `OrderPromotion` connect `Community 176` to `Community 99`, `Community 3`, `Community 5`, `Community 104`, `Community 110`, `Community 15`, `Community 82`, `Community 29`, `Community 95`?**
  _High betweenness centrality (0.014) - this node is a cross-community bridge._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.061170212765957445 - nodes in this community are weakly interconnected._