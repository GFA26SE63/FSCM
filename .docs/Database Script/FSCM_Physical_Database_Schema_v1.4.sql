-- FSCM PostgreSQL physical database schema
-- Generated from: physical_erd_v1.4.drawio.xml
-- Source version: Physical ERD v1.4
-- Generated on: 2026-10-28 (Asia/Ho_Chi_Minh)
-- This script creates structure only; it does not insert seed data.

BEGIN;

CREATE SCHEMA IF NOT EXISTS "public";

CREATE TABLE "public"."ACCOUNT_TOKEN" (
    "Id" uuid NOT NULL,
    "UserAccountId" uuid NOT NULL,
    "ConsumedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "ExpiresAt" timestamptz NOT NULL,
    "Purpose" varchar(30) NOT NULL,
    "TokenHash" varchar(128) NOT NULL,
    CONSTRAINT "PK_ACCOUNT_TOKEN" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_LINE_TRACE" (
    "Id" uuid NOT NULL,
    "AllocationPlanVersionId" uuid NOT NULL,
    "AllocationRunLineId" uuid NOT NULL,
    "CoverageWeight" numeric(5,4) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DistanceWeight" numeric(5,4) NOT NULL,
    "DrawnQuantity" numeric(18,3) NOT NULL,
    "MaximumDistanceMeters" numeric(18,3) NOT NULL,
    "Note" varchar(500),
    "OrderedQuantity" numeric(18,3) NOT NULL,
    "Outcome" varchar(30) NOT NULL,
    "RequiredShelfLifeHours" numeric(18,3) NOT NULL,
    "ShelfLifeWeight" numeric(5,4) NOT NULL,
    "ShortageQuantity" numeric(18,3) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_LINE_TRACE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_PLAN_PRICE" (
    "Id" uuid NOT NULL,
    "AllocationPlanVersionId" uuid NOT NULL,
    "AllocationRunLineId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "ShelfLifeDiscountTierId" uuid,
    "WarehouseId" uuid NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "BaseNetUnitPrice" numeric(18,2) NOT NULL,
    "BatchExpiresAt" timestamptz NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DiscountTableVersion" integer NOT NULL,
    "DiscountType" varchar(30),
    "DiscountValue" numeric(18,2),
    "Explanation" varchar(500) NOT NULL,
    "FinalNetUnitPrice" numeric(18,2) NOT NULL,
    "ListUnitPrice" numeric(18,2) NOT NULL,
    "PricedAt" timestamptz NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "RemainingShelfLifePercent" numeric(5,2) NOT NULL,
    "ShelfLifeDiscountPerUnit" numeric(18,2) NOT NULL,
    "TotalShelfLifeHours" integer NOT NULL,
    CONSTRAINT "PK_ALLOCATION_PLAN_PRICE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_PLAN_VERSION" (
    "Id" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "ApprovedByUserId" uuid,
    "RecalculationRequestedByUserId" uuid,
    "ApprovedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "FulfilledOrderCount" integer NOT NULL,
    "PricedAt" timestamptz NOT NULL,
    "RecalculationReason" varchar(1000),
    "RecalculationRequestedAt" timestamptz,
    "ShortOrderCount" integer NOT NULL,
    "Status" varchar(30) NOT NULL,
    "TotalFinalAmount" numeric(18,2) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    "VersionNumber" integer NOT NULL,
    CONSTRAINT "PK_ALLOCATION_PLAN_VERSION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_RUN" (
    "Id" uuid NOT NULL,
    "AlgorithmSettings" jsonb NOT NULL,
    "BusinessDate" date NOT NULL,
    "CompletedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "CutoffAt" timestamptz NOT NULL,
    "EtaScheduleVersion" integer NOT NULL,
    "FailureReason" varchar(1000),
    "OrderCount" integer NOT NULL,
    "RunCode" varchar(40) NOT NULL,
    "SnapshotCompletedAt" timestamptz,
    "StartedAt" timestamptz NOT NULL,
    "Status" varchar(30) NOT NULL,
    "TransitTableVersion" integer NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_ALLOCATION_RUN" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_RUN_ALLOCATION" (
    "Id" uuid NOT NULL,
    "AllocationPlanVersionId" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "AllocationRunLineId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EstimatedArrivalAt" timestamptz NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "RemainingShelfLifeHours" numeric(18,2) NOT NULL,
    "Sequence" integer NOT NULL,
    "WeightedScore" numeric(18,6) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_RUN_ALLOCATION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_RUN_LINE" (
    "Id" uuid NOT NULL,
    "AllocationRunOrderId" uuid NOT NULL,
    "NearExpiryOfferId" uuid,
    "OfferVersion" integer,
    "ProductId" uuid NOT NULL,
    "SalesOrderLineId" uuid NOT NULL,
    "AllocatedQuantity" numeric(18,3) NOT NULL,
    "BaseNetUnitPrice" numeric(18,2) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EffectiveMlorRatio" numeric(5,4) NOT NULL,
    "LineNumber" integer NOT NULL,
    "LineType" varchar(30) NOT NULL,
    "ListUnitPrice" numeric(18,2) NOT NULL,
    "MlorSource" varchar(30) NOT NULL,
    "OrderedQuantity" numeric(18,3) NOT NULL,
    "SkuSnapshot" varchar(40) NOT NULL,
    "TotalShelfLifeHours" integer NOT NULL,
    CONSTRAINT "PK_ALLOCATION_RUN_LINE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_ALLOCATION_RUN_LINE_OfferVersion" CHECK (("LineType" = 'Standard' AND "NearExpiryOfferId" IS NULL AND "OfferVersion" IS NULL) OR ("LineType" = 'NearExpiryOffer' AND "NearExpiryOfferId" IS NOT NULL AND "OfferVersion" IS NOT NULL AND "OfferVersion" > 0))
);

CREATE TABLE "public"."ALLOCATION_RUN_ORDER" (
    "Id" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "AcceptedAt" timestamptz NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DeliveryDeadline" date,
    "OrderCodeSnapshot" varchar(40) NOT NULL,
    "PriorityRank" integer NOT NULL,
    "ShortageReason" varchar(1000),
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_RUN_ORDER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_RUN_STOCK" (
    "Id" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "ExpirationDate" date NOT NULL,
    "InventoryVersion" integer NOT NULL,
    "RemainingQuantity" numeric(18,3) NOT NULL,
    "SnapshotQuantity" numeric(18,3) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_RUN_STOCK" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_TRACE_CANDIDATE" (
    "Id" uuid NOT NULL,
    "AllocationLineTraceId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "BatchCodeSnapshot" varchar(50) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EstimatedArrivalAt" timestamptz,
    "Passed" boolean NOT NULL,
    "Reason" varchar(30) NOT NULL,
    "RemainingShelfLifeHours" numeric(18,3),
    "RequiredShelfLifeHours" numeric(18,3),
    "Stage" varchar(30) NOT NULL,
    "WarehouseCodeSnapshot" varchar(50) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_TRACE_CANDIDATE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ALLOCATION_TRACE_SCORE" (
    "Id" uuid NOT NULL,
    "AllocationLineTraceId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "BatchCodeSnapshot" varchar(50) NOT NULL,
    "CoverageScore" numeric(9,6) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DistanceScore" numeric(9,6) NOT NULL,
    "Iteration" integer NOT NULL,
    "Rank" integer NOT NULL,
    "RemainingDemand" numeric(18,3) NOT NULL,
    "Selected" boolean NOT NULL,
    "SelectedQuantity" numeric(18,3) NOT NULL,
    "ShelfLifeScore" numeric(9,6) NOT NULL,
    "WarehouseCodeSnapshot" varchar(50) NOT NULL,
    "WeightedScore" numeric(9,6) NOT NULL,
    CONSTRAINT "PK_ALLOCATION_TRACE_SCORE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."AUDIT_LOG" (
    "Id" uuid NOT NULL,
    "UserAccountId" uuid,
    "Action" varchar(50) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EntityId" uuid NOT NULL,
    "EntityName" varchar(100) NOT NULL,
    "NewValues" jsonb,
    "OldValues" jsonb,
    "Reason" text,
    CONSTRAINT "PK_AUDIT_LOG" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."BATCH" (
    "Id" uuid NOT NULL,
    "GoodsReceiptLineId" uuid,
    "ParentBatchId" uuid,
    "ProductId" uuid NOT NULL,
    "RootBatchId" uuid,
    "WarehouseId" uuid NOT NULL,
    "BatchCode" varchar(80) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "ExpirationDate" date NOT NULL,
    "ExpiryStatus" varchar(30) NOT NULL,
    "ProductionDate" date NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "StockStatus" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_BATCH" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_BATCH_Dates" CHECK ("ProductionDate" < "ExpirationDate"),
    CONSTRAINT "CK_BATCH_Quantity" CHECK ("Quantity" >= 0 AND TRUNC("Quantity") = "Quantity")
);

CREATE TABLE "public"."BATCH_PROMOTION" (
    "Id" uuid NOT NULL,
    "AssignedByUserId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "NearExpiryOfferId" uuid NOT NULL,
    "AssignedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "RemovedAt" timestamptz,
    CONSTRAINT "PK_BATCH_PROMOTION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."BATCH_QR_LABEL" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "CurrentWarehouseId" uuid NOT NULL,
    "GoodsReceiptId" uuid,
    "ParentLabelId" uuid,
    "RootLabelId" uuid,
    "BlobUrl" text,
    "GeneratedAt" timestamptz NOT NULL,
    "InvalidatedAt" timestamptz,
    "QrCode" varchar(120) NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_BATCH_QR_LABEL" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."BUSINESS_DOCUMENT_SEQUENCE" (
    "BusinessDate" date NOT NULL,
    "DocumentType" varchar(10) NOT NULL,
    "LastNumber" integer NOT NULL,
    CONSTRAINT "PK_BUSINESS_DOCUMENT_SEQUENCE" PRIMARY KEY ("DocumentType", "BusinessDate"),
    CONSTRAINT "CK_BUSINESS_DOCUMENT_SEQUENCE_LastNumber" CHECK ("LastNumber" > 0)
);

CREATE TABLE "public"."DRIVER" (
    "Id" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "Code" varchar(20) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "FullName" varchar(150) NOT NULL,
    "IsActive" boolean NOT NULL,
    "LicenseNumber" varchar(80) NOT NULL,
    "Phone" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_DRIVER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."EXPIRY_SWEEP_RUN" (
    "Id" uuid NOT NULL,
    "BatchesExpired" integer NOT NULL,
    "BatchesScanned" integer NOT NULL,
    "BusinessDate" date NOT NULL,
    "CompletedAt" timestamptz,
    "Error" text,
    "StartedAt" timestamptz NOT NULL,
    "Status" varchar(30) NOT NULL,
    "StatusesUpdated" integer NOT NULL,
    CONSTRAINT "PK_EXPIRY_SWEEP_RUN" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."GOODS_RECEIPT" (
    "Id" uuid NOT NULL,
    "ApprovedByUserId" uuid,
    "CreatedByUserId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "ApprovedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "IdempotencyKey" varchar(150),
    "ReceiptCode" varchar(40) NOT NULL,
    "ReceivedAt" timestamptz,
    "RejectionReason" text,
    "RequestHash" varchar(64),
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_GOODS_RECEIPT" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_GOODS_RECEIPT_Status" CHECK ("Status" IN ('Pending', 'Received'))
);

CREATE TABLE "public"."GOODS_RECEIPT_LINE" (
    "Id" uuid NOT NULL,
    "GoodsReceiptId" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "ExpirationDate" date NOT NULL,
    "ProductionDate" date NOT NULL,
    "ReceivedQuantity" numeric(18,3) NOT NULL,
    "SourceLotCode" varchar(80),
    CONSTRAINT "PK_GOODS_RECEIPT_LINE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_GOODS_RECEIPT_LINE_Dates" CHECK ("ProductionDate" < "ExpirationDate"),
    CONSTRAINT "CK_GOODS_RECEIPT_LINE_ReceivedQuantity" CHECK ("ReceivedQuantity" > 0 AND TRUNC("ReceivedQuantity") = "ReceivedQuantity")
);

CREATE TABLE "public"."IDEMPOTENCY_KEY" (
    "Id" uuid NOT NULL,
    "SalesOrderId" uuid,
    "UserAccountId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "ExpiresAt" timestamptz NOT NULL,
    "Key" varchar(150) NOT NULL,
    "Scope" varchar(100) NOT NULL,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_IDEMPOTENCY_KEY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."INVENTORY_BALANCE" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "AvailableQuantity" numeric(18,3) NOT NULL,
    "PhysicalQuantity" numeric(18,3) NOT NULL,
    "ReservedQuantity" numeric(18,3) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_INVENTORY_BALANCE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_INVENTORY_BALANCE_AvailableQuantity" CHECK ("AvailableQuantity" = "PhysicalQuantity" - "ReservedQuantity" AND "AvailableQuantity" >= 0),
    CONSTRAINT "CK_INVENTORY_BALANCE_PhysicalQuantity" CHECK ("PhysicalQuantity" >= 0),
    CONSTRAINT "CK_INVENTORY_BALANCE_ReservedQuantity" CHECK ("ReservedQuantity" >= 0)
);

CREATE TABLE "public"."INVENTORY_LOCK" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "LockedByUserId" uuid,
    "ProductId" uuid NOT NULL,
    "ReleasedByUserId" uuid,
    "WarehouseId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "LockedQuantity" numeric(18,3) NOT NULL,
    "Note" text,
    "Reason" varchar(30) NOT NULL,
    "ReleasedAt" timestamptz,
    "RequiresResolution" boolean NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_INVENTORY_LOCK" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_INVENTORY_LOCK_LockedQuantity" CHECK ("LockedQuantity" > 0 AND TRUNC("LockedQuantity") = "LockedQuantity")
);

CREATE TABLE "public"."INVENTORY_TRANSACTION" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "GoodsReceiptId" uuid,
    "GoodsReceiptLineId" uuid,
    "ProductId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "AvailableQuantityAfter" numeric(18,3) NOT NULL,
    "Note" text,
    "OccurredAt" timestamptz NOT NULL,
    "PhysicalQuantityAfter" numeric(18,3) NOT NULL,
    "PhysicalQuantityDelta" numeric(18,3) NOT NULL,
    "ReferenceCode" varchar(80) NOT NULL,
    "ReservedQuantityAfter" numeric(18,3) NOT NULL,
    "ReservedQuantityDelta" numeric(18,3) NOT NULL,
    "SourceId" uuid NOT NULL,
    "SourceType" varchar(50) NOT NULL,
    "TransactionType" varchar(30) NOT NULL,
    CONSTRAINT "PK_INVENTORY_TRANSACTION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."LOYALTY_PROGRAM" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "Code" varchar(40) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Description" text,
    "EndAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "MinimumRedeemPoints" integer NOT NULL,
    "Name" varchar(200) NOT NULL,
    "PointsExpireAt" timestamptz,
    "SpendAmountPerPoint" numeric(18,2) NOT NULL,
    "StartAt" timestamptz NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_LOYALTY_PROGRAM" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."LOYALTY_PROGRAM_RETAILER" (
    "Id" uuid NOT NULL,
    "LoyaltyProgramId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    CONSTRAINT "PK_LOYALTY_PROGRAM_RETAILER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."LOYALTY_REWARD" (
    "Id" uuid NOT NULL,
    "LoyaltyProgramId" uuid NOT NULL,
    "AvailableQuantity" integer,
    "Code" varchar(40) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Description" text,
    "DiscountAmount" numeric(18,2),
    "DiscountPercent" numeric(5,2),
    "ImageUrl" varchar(500),
    "IsActive" boolean NOT NULL,
    "Name" varchar(200) NOT NULL,
    "RequiredPoints" integer NOT NULL,
    "RewardType" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_LOYALTY_REWARD" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."LOYALTY_TRANSACTION" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid,
    "FinancialAdjustmentId" uuid,
    "LoyaltyProgramId" uuid NOT NULL,
    "OriginalTransactionId" uuid,
    "RetailerLoyaltyId" uuid NOT NULL,
    "RewardRedemptionId" uuid,
    "SalesOrderId" uuid,
    "BalanceAfter" integer NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "ExpiresAt" timestamptz,
    "Note" text,
    "Points" integer NOT NULL,
    "TransactionType" varchar(30) NOT NULL,
    CONSTRAINT "PK_LOYALTY_TRANSACTION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."MANUAL_PAYMENT" (
    "Id" uuid NOT NULL,
    "ConfirmedByUserId" uuid,
    "PaymentId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "ConfirmedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "EvidenceReference" varchar(500) NOT NULL,
    "Method" varchar(30) NOT NULL,
    "Note" text,
    "OperationKey" varchar(80) NOT NULL,
    "RequestHash" varchar(64) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "TransactionReference" varchar(100),
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_MANUAL_PAYMENT" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_MANUAL_PAYMENT_Amount" CHECK ("Amount" > 0)
);

CREATE TABLE "public"."MANUAL_REFUND" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "FinancialAdjustmentId" uuid,
    "PaymentId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "SubmittedByUserId" uuid,
    "VerifiedByUserId" uuid,
    "Amount" numeric(18,2) NOT NULL,
    "CreateOperationKey" varchar(80) NOT NULL,
    "CreateRequestHash" varchar(64) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EvidenceOperationKey" varchar(80),
    "EvidenceReference" varchar(500),
    "EvidenceRequestHash" varchar(64),
    "Reason" varchar(500) NOT NULL,
    "Recipient" varchar(200) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "SubmittedAt" timestamptz,
    "TransactionReference" varchar(100),
    "TransferredAt" timestamptz,
    "UpdatedAt" timestamptz NOT NULL,
    "VerificationNote" varchar(500),
    "VerificationOperationKey" varchar(80),
    "VerificationRequestHash" varchar(64),
    "VerifiedAt" timestamptz,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_MANUAL_REFUND" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_MANUAL_REFUND_Amount" CHECK ("Amount" > 0)
);

CREATE TABLE "public"."MAP_DISTANCE_CACHE" (
    "Id" uuid NOT NULL,
    "DestinationLocationId" uuid NOT NULL,
    "OriginLocationId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "CalculatedAt" timestamptz NOT NULL,
    "DestinationLocationVersion" integer NOT NULL,
    "DistanceMeters" integer NOT NULL,
    "DurationSeconds" integer NOT NULL,
    "ExpiresAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "OriginLocationVersion" integer NOT NULL,
    "Provider" varchar(50) NOT NULL,
    "ProviderStatus" varchar(50) NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_MAP_DISTANCE_CACHE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_MAP_DISTANCE_CACHE_Distance" CHECK ("DistanceMeters" > 0),
    CONSTRAINT "CK_MAP_DISTANCE_CACHE_Duration" CHECK ("DurationSeconds" > 0)
);

CREATE TABLE "public"."MAP_LOCATION" (
    "Id" uuid NOT NULL,
    "RetailerId" uuid,
    "WarehouseId" uuid,
    "CreatedAt" timestamptz NOT NULL,
    "FormattedAddress" varchar(300),
    "Latitude" numeric(10,7) NOT NULL,
    "Longitude" numeric(10,7) NOT NULL,
    "NormalizedAt" timestamptz,
    "Provider" varchar(50) NOT NULL,
    "ProviderPlaceId" varchar(200),
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_MAP_LOCATION" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_MAP_LOCATION_Entity" CHECK (("WarehouseId" IS NOT NULL) <> ("RetailerId" IS NOT NULL))
);

CREATE TABLE "public"."NOTIFICATION" (
    "Id" uuid NOT NULL,
    "OutboxMessageId" uuid,
    "SalesOrderId" uuid,
    "UserAccountId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DeepLink" varchar(500),
    "IsRead" boolean NOT NULL,
    "Message" text NOT NULL,
    "ReadAt" timestamptz,
    "RelatedEntityId" uuid,
    "RelatedEntityType" varchar(50),
    "Title" varchar(200) NOT NULL,
    "Type" varchar(50) NOT NULL,
    CONSTRAINT "PK_NOTIFICATION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ORDER_PROMOTION" (
    "Id" uuid NOT NULL,
    "PromotionId" uuid NOT NULL,
    "SalesOrderLineId" uuid NOT NULL,
    "AppliedAt" timestamptz NOT NULL,
    "DiscountAmount" numeric(18,2) NOT NULL,
    "DiscountPercent" numeric(5,2) NOT NULL,
    "EffectiveFromSnapshot" timestamptz NOT NULL,
    "EffectiveToSnapshot" timestamptz NOT NULL,
    "IsServerFinal" boolean NOT NULL,
    "MinimumQuantitySnapshot" numeric(18,3) NOT NULL,
    "PromotionCodeSnapshot" varchar(40) NOT NULL,
    "PromotionNameSnapshot" varchar(200) NOT NULL,
    "PromotionTypeSnapshot" varchar(30) NOT NULL,
    CONSTRAINT "PK_ORDER_PROMOTION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."ORDER_STATUS_HISTORY" (
    "Id" uuid NOT NULL,
    "ChangedByUserId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "ChangedAt" timestamptz NOT NULL,
    "FromStatus" varchar(30),
    "Reason" text,
    "ToStatus" varchar(30) NOT NULL,
    CONSTRAINT "PK_ORDER_STATUS_HISTORY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."OUTBOX_MESSAGE" (
    "Id" uuid NOT NULL,
    "AggregateId" uuid NOT NULL,
    "AggregateType" varchar(100) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EventType" varchar(100) NOT NULL,
    "LastError" text,
    "Payload" jsonb NOT NULL,
    "ProcessedAt" timestamptz,
    "RetryCount" integer NOT NULL,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_OUTBOX_MESSAGE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PAYMENT" (
    "Id" uuid NOT NULL,
    "AllocationPlanVersionId" uuid NOT NULL,
    "ConfirmedByUserId" uuid,
    "SalesOrderId" uuid NOT NULL,
    "AdjustedAmount" numeric(18,2) NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "CollectionMethod" varchar(30),
    "ConfirmedAmount" numeric(18,2) NOT NULL,
    "ConfirmedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "DeliveredDate" date,
    "DueDate" date,
    "FinalApprovalReference" varchar(100) NOT NULL,
    "FinalApprovedAt" timestamptz NOT NULL,
    "Method" varchar(30) NOT NULL,
    "Note" text,
    "OperationKey" varchar(80),
    "PaidDate" date,
    "RequestHash" varchar(64),
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_PAYMENT" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_PAYMENT_AdjustedAmount" CHECK ("AdjustedAmount" >= 0 AND "AdjustedAmount" <= "Amount"),
    CONSTRAINT "CK_PAYMENT_Amount" CHECK ("Amount" > 0),
    CONSTRAINT "CK_PAYMENT_ConfirmedAmount" CHECK ("ConfirmedAmount" >= 0 AND "ConfirmedAmount" <= "Amount")
);

CREATE TABLE "public"."PRODUCT" (
    "Id" uuid NOT NULL,
    "ProductCategoryId" uuid NOT NULL,
    "ReplacesProductId" uuid,
    "CreatedAt" timestamptz NOT NULL,
    "DefaultMlorRatio" numeric(5,4) NOT NULL,
    "InactivatedAt" timestamptz,
    "Name" varchar(200) NOT NULL,
    "NearDateThresholdHours" integer NOT NULL,
    "PublishedAt" timestamptz,
    "ShelfLifeHours" integer NOT NULL,
    "Sku" varchar(50) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "Unit" varchar(50) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_PRODUCT" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_PRODUCT_NearDateThresholdHours" CHECK ("NearDateThresholdHours" >= 0 AND "NearDateThresholdHours" < "ShelfLifeHours"),
    CONSTRAINT "CK_PRODUCT_Replacement" CHECK ("ReplacesProductId" IS NULL OR "ReplacesProductId" <> "Id"),
    CONSTRAINT "CK_PRODUCT_ShelfLifeHours" CHECK ("ShelfLifeHours" > 0),
    CONSTRAINT "CK_PRODUCT_Status" CHECK ("Status" IN ('Draft', 'Published', 'Inactive')),
    CONSTRAINT "CK_PRODUCT_DefaultMlorRatio" CHECK ("DefaultMlorRatio" > 0 AND "DefaultMlorRatio" < 1)
);

CREATE TABLE "public"."PRODUCT_CATEGORY" (
    "Id" uuid NOT NULL,
    "ParentCategoryId" uuid,
    "Code" varchar(30) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Description" text,
    "IsActive" boolean NOT NULL,
    "Name" varchar(150) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_PRODUCT_CATEGORY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PRODUCT_PRICE" (
    "Id" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EffectiveFrom" timestamptz NOT NULL,
    "EffectiveTo" timestamptz,
    "IsActive" boolean NOT NULL,
    "UnitPrice" numeric(18,2) NOT NULL,
    CONSTRAINT "PK_PRODUCT_PRICE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_PRODUCT_PRICE_EffectiveRange" CHECK ("EffectiveTo" IS NULL OR "EffectiveTo" >= "EffectiveFrom"),
    CONSTRAINT "CK_PRODUCT_PRICE_UnitPrice" CHECK ("UnitPrice" > 0)
);

CREATE TABLE "public"."PROMOTION" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "Code" varchar(40) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DiscountPercent" numeric(5,2) NOT NULL,
    "EndAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "MinimumQuantity" numeric(18,3) NOT NULL,
    "Name" varchar(200) NOT NULL,
    "PromotionType" varchar(30) NOT NULL,
    "StartAt" timestamptz NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_PROMOTION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PROMOTION_CATEGORY" (
    "Id" uuid NOT NULL,
    "ProductCategoryId" uuid NOT NULL,
    "PromotionId" uuid NOT NULL,
    CONSTRAINT "PK_PROMOTION_CATEGORY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PROMOTION_PRODUCT" (
    "Id" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "PromotionId" uuid NOT NULL,
    CONSTRAINT "PK_PROMOTION_PRODUCT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PROMOTION_RETAILER" (
    "Id" uuid NOT NULL,
    "PromotionId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    CONSTRAINT "PK_PROMOTION_RETAILER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."PURCHASE_ORDER" (
    "Id" uuid NOT NULL,
    "IssuedByUserId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "SalesOrderQuoteId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "IssuedAt" timestamptz NOT NULL,
    "PaymentMethod" varchar(30) NOT NULL,
    "PurchaseOrderCode" varchar(40) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_PURCHASE_ORDER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."QR_LABEL_EVENT" (
    "Id" uuid NOT NULL,
    "BatchQrLabelId" uuid NOT NULL,
    "PerformedByUserId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "EventType" varchar(30) NOT NULL,
    "FromStatus" varchar(30) NOT NULL,
    "Note" varchar(500),
    "OccurredAt" timestamptz NOT NULL,
    "OperationKey" varchar(100) NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "ReferenceCode" varchar(100),
    "ToStatus" varchar(30) NOT NULL,
    CONSTRAINT "PK_QR_LABEL_EVENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RECEIPT_CONFIRMATION" (
    "Id" uuid NOT NULL,
    "ConfirmedByRetailerUserId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "ShipmentId" uuid NOT NULL,
    "ConfirmedAt" timestamptz NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Note" text,
    "OperationKey" varchar(80) NOT NULL,
    "RequestHash" varchar(64) NOT NULL,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_RECEIPT_CONFIRMATION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RECEIPT_CONFIRMATION_ITEM" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "BatchQrLabelId" uuid NOT NULL,
    "ReceiptConfirmationId" uuid NOT NULL,
    "SalesOrderLineId" uuid,
    "DamagedQuantity" numeric(18,3) NOT NULL,
    "ExpectedQuantity" numeric(18,3) NOT NULL,
    "MissingQuantity" numeric(18,3) NOT NULL,
    "ReceivedQuantity" numeric(18,3) NOT NULL,
    "ScannedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_RECEIPT_CONFIRMATION_ITEM" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_RECEIPT_CONFIRMATION_ITEM_ACTUAL_QUANTITY" CHECK ("DamagedQuantity" >= 0 AND "ReceivedQuantity" >= "DamagedQuantity" AND "ExpectedQuantity" >= "ReceivedQuantity" AND "MissingQuantity" = "ExpectedQuantity" - "ReceivedQuantity")
);

CREATE TABLE "public"."RECEIPT_CONFIRMATION_QR_LABEL" (
    "Id" uuid NOT NULL,
    "BatchQrLabelId" uuid NOT NULL,
    "ReceiptConfirmationId" uuid NOT NULL,
    "ScannedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_RECEIPT_CONFIRMATION_QR_LABEL" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RECEIPT_DISCREPANCY" (
    "Id" uuid NOT NULL,
    "ReceiptConfirmationId" uuid NOT NULL,
    "ReportedByRetailerUserId" uuid NOT NULL,
    "ReviewedByUserId" uuid,
    "SalesOrderId" uuid NOT NULL,
    "Note" text,
    "ReportedAt" timestamptz NOT NULL,
    "ResolvedAt" timestamptz,
    "ReviewedAt" timestamptz,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_RECEIPT_DISCREPANCY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RECEIPT_DISCREPANCY_ITEM" (
    "Id" uuid NOT NULL,
    "AllocationPlanPriceId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "ReceiptDiscrepancyId" uuid NOT NULL,
    "ShipmentId" uuid NOT NULL,
    "ActualReceivedQuantity" numeric(18,3) NOT NULL,
    "AdjustmentAmount" numeric(18,2) NOT NULL,
    "EvidenceBlobUrl" text,
    "ExpectedQuantity" numeric(18,3) NOT NULL,
    "FinalUnitPrice" numeric(18,2) NOT NULL,
    "IssueType" varchar(30) NOT NULL,
    "Note" text,
    CONSTRAINT "PK_RECEIPT_DISCREPANCY_ITEM" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."REFRESH_TOKEN" (
    "Id" uuid NOT NULL,
    "ReplacedByTokenId" uuid,
    "UserAccountId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "CreatedByIpAddress" varchar(64),
    "ExpiresAt" timestamptz NOT NULL,
    "RevokedAt" timestamptz,
    "RevokedByIpAddress" varchar(64),
    "TokenHash" varchar(128) NOT NULL,
    CONSTRAINT "PK_REFRESH_TOKEN" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."REGION" (
    "Id" uuid NOT NULL,
    "Code" varchar(30) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Description" text,
    "IsActive" boolean NOT NULL,
    "Name" varchar(150) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_REGION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RESERVATION" (
    "Id" uuid NOT NULL,
    "AllocationRunAllocationId" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "ConsumedAt" timestamptz,
    "Quantity" numeric(18,3) NOT NULL,
    "ReleasedAt" timestamptz,
    "ReservedAt" timestamptz NOT NULL,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_RESERVATION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RETAILER" (
    "Id" uuid NOT NULL,
    "AssessedByUserId" uuid,
    "DeclaredByUserId" uuid NOT NULL,
    "RegionId" uuid NOT NULL,
    "ReviewedByUserId" uuid,
    "UserAccountId" uuid,
    "Address" text,
    "AssessedAt" timestamptz,
    "AssessmentNote" text,
    "Code" varchar(30) NOT NULL,
    "ContactName" varchar(200),
    "CreatedAt" timestamptz NOT NULL,
    "CreditTermDays" integer NOT NULL,
    "Email" varchar(150),
    "ForecastRevenue" numeric(18,2),
    "Name" varchar(200) NOT NULL,
    "Phone" varchar(30),
    "PotentialScore" numeric(5,2),
    "PotentialStatus" varchar(30),
    "PurchaseFrequencyPerMonth" integer NOT NULL,
    "PurchasingCapacity" numeric(18,2),
    "RequestedCreditTermDays" integer,
    "RetailerType" varchar(30) NOT NULL,
    "ReviewReason" text,
    "ReviewedAt" timestamptz,
    "Status" varchar(30) NOT NULL,
    "StoreSizeCategory" varchar(1) NOT NULL,
    "StoreSizeSquareMeters" numeric(12,2),
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_RETAILER" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_RETAILER_CreditTermDays" CHECK ("CreditTermDays" IN (0, 7, 14, 30)),
    CONSTRAINT "CK_RETAILER_PurchaseFrequencyPerMonth" CHECK ("PurchaseFrequencyPerMonth" > 0),
    CONSTRAINT "CK_RETAILER_RequestedCreditTermDays" CHECK ("RequestedCreditTermDays" IS NULL OR "RequestedCreditTermDays" IN (0, 7, 14, 30)),
    CONSTRAINT "CK_RETAILER_StoreSizeCategory" CHECK ("StoreSizeCategory" IN ('S', 'M', 'L'))
);

CREATE TABLE "public"."RETAILER_LOYALTY" (
    "Id" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "CurrentPoints" integer NOT NULL,
    "HeldPoints" integer NOT NULL,
    "LifetimeEarnedPoints" integer NOT NULL,
    "LifetimeRedeemedPoints" integer NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_RETAILER_LOYALTY" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RETAILER_PRODUCT_MLOR" (
    "Id" uuid NOT NULL,
    "ProductCategoryId" uuid,
    "ProductId" uuid,
    "RetailerId" uuid NOT NULL,
    "UpdatedByUserId" uuid NOT NULL,
    "EffectiveFrom" timestamptz NOT NULL,
    "EffectiveTo" timestamptz,
    "IsActive" boolean NOT NULL,
    "MinimumLifeHours" integer,
    "MinimumLifeRatio" numeric(5,4) NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_RETAILER_PRODUCT_MLOR" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_RETAILER_PRODUCT_MLOR_Ratio" CHECK ("MinimumLifeRatio" > 0 AND "MinimumLifeRatio" < 1),
    CONSTRAINT "CK_RETAILER_PRODUCT_MLOR_Scope" CHECK (("ProductCategoryId" IS NOT NULL) <> ("ProductId" IS NOT NULL))
);

CREATE TABLE "public"."RETAILER_SALES_ASSIGNMENT" (
    "Id" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "SalesGroupId" uuid NOT NULL,
    "AssignedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "UnassignedAt" timestamptz,
    CONSTRAINT "PK_RETAILER_SALES_ASSIGNMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."REWARD_REDEMPTION" (
    "Id" uuid NOT NULL,
    "ApprovedByUserId" uuid,
    "CompletedByUserId" uuid,
    "DeliveredByUserId" uuid,
    "LoyaltyRewardId" uuid NOT NULL,
    "LoyaltyTransactionId" uuid,
    "RedeemedByUserId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "SalesOrderId" uuid,
    "ApprovedAt" timestamptz,
    "CancelledAt" timestamptz,
    "ClientRequestId" varchar(100) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DeliveredAt" timestamptz,
    "FulfilledAt" timestamptz,
    "Note" text,
    "RedeemedAt" timestamptz NOT NULL,
    "RedeemedPoints" integer NOT NULL,
    "RequiredPointsSnapshot" integer NOT NULL,
    "RewardQuantity" integer NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_REWARD_REDEMPTION" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_REWARD_REDEMPTION_QuantityAndPoints" CHECK ("RewardQuantity" > 0 AND "RequiredPointsSnapshot" > 0 AND "RedeemedPoints" = "RewardQuantity" * "RequiredPointsSnapshot")
);

CREATE TABLE "public"."RUN_PICKING_GATHER" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "RunPickingListId" uuid NOT NULL,
    "BatchCodeSnapshot" varchar(40) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "PickedQuantity" numeric(18,3) NOT NULL,
    "RequiredQuantity" numeric(18,3) NOT NULL,
    "SkuSnapshot" varchar(40) NOT NULL,
    "Status" varchar(30) NOT NULL,
    CONSTRAINT "PK_RUN_PICKING_GATHER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RUN_PICKING_LIST" (
    "Id" uuid NOT NULL,
    "AllocationPlanVersionId" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "AssignedToUserId" uuid,
    "CompletedByUserId" uuid,
    "WarehouseId" uuid NOT NULL,
    "CompletedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "ExceptionNote" varchar(500),
    "ExceptionType" varchar(30),
    "IssuedAt" timestamptz NOT NULL,
    "PickingCode" varchar(40) NOT NULL,
    "StartedAt" timestamptz,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_RUN_PICKING_LIST" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."RUN_PICKING_SPLIT" (
    "Id" uuid NOT NULL,
    "AllocationPlanPriceId" uuid NOT NULL,
    "AllocationRunAllocationId" uuid NOT NULL,
    "AllocationRunLineId" uuid NOT NULL,
    "RunPickingGatherId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "SalesOrderLineId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "OrderCodeSnapshot" varchar(40) NOT NULL,
    "PickedQuantity" numeric(18,3) NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    CONSTRAINT "PK_RUN_PICKING_SPLIT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SALES_GROUP" (
    "Id" uuid NOT NULL,
    "RegionId" uuid NOT NULL,
    "Code" varchar(30) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "Name" varchar(150) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_SALES_GROUP" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SALES_GROUP_MEMBER" (
    "Id" uuid NOT NULL,
    "SalesGroupId" uuid NOT NULL,
    "UserAccountId" uuid NOT NULL,
    "AssignedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "UnassignedAt" timestamptz,
    CONSTRAINT "PK_SALES_GROUP_MEMBER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SALES_ORDER" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "RetailerId" uuid NOT NULL,
    "ReviewedByUserId" uuid,
    "SalesGroupId" uuid NOT NULL,
    "ClientOrderKey" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "CreditTermDays" integer NOT NULL,
    "DeliveryAddress" text NOT NULL,
    "DiscountAmount" numeric(18,2) NOT NULL,
    "FinalAmount" numeric(18,2) NOT NULL,
    "FinalPricePendingAllocation" boolean NOT NULL,
    "HasOfflineDifference" boolean NOT NULL,
    "Note" text,
    "OfflineEstimatedAmount" numeric(18,2),
    "OrderCode" varchar(40) NOT NULL,
    "PaymentMethod" varchar(30) NOT NULL,
    "RejectionReason" text,
    "RequestHash" varchar(64) NOT NULL,
    "RequestedDeliveryDate" date,
    "RetailerCodeSnapshot" varchar(40) NOT NULL,
    "RetailerNameSnapshot" varchar(200) NOT NULL,
    "ReviewedAt" timestamptz,
    "ServerReceivedAt" timestamptz NOT NULL,
    "Source" varchar(30) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "SubtotalAmount" numeric(18,2) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_SALES_ORDER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SALES_ORDER_ATTACHMENT" (
    "Id" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "UploadedByUserId" uuid NOT NULL,
    "AttachmentType" varchar(30) NOT NULL,
    "BlobUrl" text NOT NULL,
    "ContentType" varchar(100) NOT NULL,
    "FileName" varchar(255) NOT NULL,
    "UploadedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_SALES_ORDER_ATTACHMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SALES_ORDER_LINE" (
    "Id" uuid NOT NULL,
    "MlorProductCategoryId" uuid,
    "MlorSourceRuleId" uuid,
    "NearExpiryOfferId" uuid,
    "OfferAcceptedByUserId" uuid,
    "OfferVersion" integer,
    "ProductId" uuid NOT NULL,
    "ProductPriceId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "AcceptedOfferUnitPrice" numeric(18,2),
    "CreatedAt" timestamptz NOT NULL,
    "DiscountAmount" numeric(18,2) NOT NULL,
    "DiscountPercent" numeric(5,2) NOT NULL,
    "DiscountSourceCode" varchar(40),
    "DiscountSourceType" varchar(30),
    "EffectiveMlorRatio" numeric(5,4) NOT NULL,
    "EstimatedArrivalAt" timestamptz,
    "FinalPricePendingAllocation" boolean NOT NULL,
    "GrossAmount" numeric(18,2) NOT NULL,
    "LineNumber" integer NOT NULL,
    "LineType" varchar(30) NOT NULL,
    "MlorMinimumLifeHours" integer,
    "MlorMinimumLifeRatio" numeric(6,5) NOT NULL,
    "MlorResolvedAt" timestamptz NOT NULL,
    "MlorSourceScope" varchar(20) NOT NULL,
    "MlorSourceVersion" integer NOT NULL,
    "NetAmount" numeric(18,2) NOT NULL,
    "OfferAcceptedAt" timestamptz,
    "OfferMinimumLifeRatio" numeric(5,4),
    "OrderedQuantity" numeric(18,3) NOT NULL,
    "PricedAt" timestamptz NOT NULL,
    "ProductNameSnapshot" varchar(200) NOT NULL,
    "ProductPriceEffectiveFrom" timestamptz NOT NULL,
    "ProductPriceEffectiveTo" timestamptz,
    "SkuSnapshot" varchar(40) NOT NULL,
    "UnitPrice" numeric(18,2) NOT NULL,
    CONSTRAINT "PK_SALES_ORDER_LINE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_SALES_ORDER_LINE_MLOR_RATIO" CHECK ("MlorMinimumLifeRatio" > 0 AND "MlorMinimumLifeRatio" < 1),
    CONSTRAINT "CK_SALES_ORDER_LINE_EffectiveMlor" CHECK ("EffectiveMlorRatio" > 0 AND "EffectiveMlorRatio" < 1),
    CONSTRAINT "CK_SALES_ORDER_LINE_AcceptedOffer" CHECK (("LineType" = 'Standard' AND "NearExpiryOfferId" IS NULL AND "OfferVersion" IS NULL AND "AcceptedOfferUnitPrice" IS NULL AND "OfferMinimumLifeRatio" IS NULL AND "OfferAcceptedByUserId" IS NULL AND "OfferAcceptedAt" IS NULL) OR ("LineType" = 'NearExpiryOffer' AND "NearExpiryOfferId" IS NOT NULL AND "OfferVersion" IS NOT NULL AND "OfferVersion" > 0 AND "AcceptedOfferUnitPrice" IS NOT NULL AND "AcceptedOfferUnitPrice" >= 0 AND "OfferMinimumLifeRatio" IS NOT NULL AND "OfferMinimumLifeRatio" > 0 AND "OfferMinimumLifeRatio" < 1 AND "OfferAcceptedByUserId" IS NOT NULL AND "OfferAcceptedAt" IS NOT NULL))
);

CREATE TABLE "public"."SALES_ORDER_QUOTE" (
    "Id" uuid NOT NULL,
    "AcceptedByUserId" uuid,
    "AllocationPlanVersionId" uuid NOT NULL,
    "AllocationRunId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "AcceptedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "ExpiresAt" timestamptz NOT NULL,
    "IssuedAt" timestamptz NOT NULL,
    "RejectionReason" text,
    "RevisionNumber" integer NOT NULL,
    "Status" varchar(40) NOT NULL,
    "TotalAmount" numeric(18,2) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_SALES_ORDER_QUOTE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SHELF_LIFE_DISCOUNT_TABLE" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EffectiveFrom" timestamptz NOT NULL,
    "EffectiveTo" timestamptz,
    "IsActive" boolean NOT NULL,
    "Note" varchar(500),
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_SHELF_LIFE_DISCOUNT_TABLE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SHELF_LIFE_DISCOUNT_TIER" (
    "Id" uuid NOT NULL,
    "ProductCategoryId" uuid,
    "ProductId" uuid,
    "ShelfLifeDiscountTableId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "DiscountType" varchar(30) NOT NULL,
    "DiscountValue" numeric(18,2) NOT NULL,
    "MaxRemainingPercent" numeric(5,2) NOT NULL,
    "MinRemainingPercent" numeric(5,2) NOT NULL,
    "Scope" varchar(30) NOT NULL,
    CONSTRAINT "PK_SHELF_LIFE_DISCOUNT_TIER" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SHIPMENT" (
    "Id" uuid NOT NULL,
    "DriverId" uuid,
    "RunPickingListId" uuid NOT NULL,
    "SalesOrderId" uuid NOT NULL,
    "VehicleId" uuid,
    "WarehouseId" uuid NOT NULL,
    "AssignedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "DispatchedAt" timestamptz,
    "DriverCodeSnapshot" varchar(20),
    "DriverLicenseSnapshot" varchar(80),
    "DriverNameSnapshot" varchar(150),
    "DriverPhoneSnapshot" varchar(30),
    "ExceptionReason" text,
    "IssuedAt" timestamptz,
    "PlateNumberSnapshot" varchar(30),
    "ReadyAt" timestamptz,
    "ReceivedAt" timestamptz,
    "ReceivedQuantity" numeric(18,3) NOT NULL,
    "ShipmentCode" varchar(60) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "TotalQuantity" numeric(18,3) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "VehicleTypeSnapshot" varchar(50),
    "Version" integer NOT NULL,
    CONSTRAINT "PK_SHIPMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."SYSTEM_CONFIGURATION" (
    "Id" uuid NOT NULL,
    "UpdatedByUserId" uuid,
    "ConfigKey" varchar(150) NOT NULL,
    "ConfigValue" jsonb NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Description" text NOT NULL,
    "EffectiveFrom" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "ValueType" varchar(50) NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_SYSTEM_CONFIGURATION" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."TRANSIT_TABLE" (
    "Id" uuid NOT NULL,
    "CreatedByUserId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EffectiveFrom" timestamptz NOT NULL,
    "EffectiveTo" timestamptz,
    "IsActive" boolean NOT NULL,
    "MaxServingDistanceMeters" integer NOT NULL,
    "Note" varchar(500),
    "UpdatedAt" timestamptz NOT NULL,
    "Version" integer NOT NULL,
    CONSTRAINT "PK_TRANSIT_TABLE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."TRANSIT_TABLE_BAND" (
    "Id" uuid NOT NULL,
    "TransitTableId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EstimatedCostAmount" numeric(18,2) NOT NULL,
    "HandlingMinutes" integer NOT NULL,
    "MaxDistanceMeters" integer NOT NULL,
    "MinDistanceMeters" integer NOT NULL,
    "TransitMinutes" integer NOT NULL,
    CONSTRAINT "PK_TRANSIT_TABLE_BAND" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."USER_ACCOUNT" (
    "Id" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Email" varchar(150) NOT NULL,
    "EntraObjectId" varchar(150),
    "FullName" varchar(150) NOT NULL,
    "IdentityProvider" varchar(20) NOT NULL,
    "IsActive" boolean NOT NULL,
    "Role" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_USER_ACCOUNT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."USER_CREDENTIAL" (
    "Id" uuid NOT NULL,
    "UserAccountId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "FailedLoginCount" integer NOT NULL,
    "LockoutEndAt" timestamptz,
    "MustChangePassword" boolean NOT NULL,
    "PasswordChangedAt" timestamptz,
    "PasswordHash" varchar(200) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_USER_CREDENTIAL" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."USER_REGION_ASSIGNMENT" (
    "Id" uuid NOT NULL,
    "RegionId" uuid NOT NULL,
    "UserAccountId" uuid NOT NULL,
    "AssignedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "UnassignedAt" timestamptz,
    CONSTRAINT "PK_USER_REGION_ASSIGNMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."USER_WAREHOUSE_ASSIGNMENT" (
    "Id" uuid NOT NULL,
    "UserAccountId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "AssignedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    CONSTRAINT "PK_USER_WAREHOUSE_ASSIGNMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."VEHICLE" (
    "Id" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "Capacity" numeric(18,3) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "PlateNumber" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "VehicleType" varchar(50) NOT NULL,
    CONSTRAINT "PK_VEHICLE" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."WAREHOUSE" (
    "Id" uuid NOT NULL,
    "Address" text,
    "Code" varchar(30) NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "IsActive" boolean NOT NULL,
    "MinimumStockThresholdCartons" integer NOT NULL,
    "Name" varchar(150) NOT NULL,
    "Type" varchar(20) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_WAREHOUSE" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_WAREHOUSE_MinimumStockThresholdCartons" CHECK ("MinimumStockThresholdCartons" >= 0)
);

CREATE TABLE "public"."WRITE_OFF" (
    "Id" uuid NOT NULL,
    "ApprovedByUserId" uuid,
    "CreatedByUserId" uuid NOT NULL,
    "WarehouseId" uuid NOT NULL,
    "ApprovedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "Reason" text,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "WriteOffCode" varchar(40) NOT NULL,
    CONSTRAINT "PK_WRITE_OFF" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."WRITE_OFF_ATTACHMENT" (
    "Id" uuid NOT NULL,
    "UploadedByUserId" uuid NOT NULL,
    "WriteOffId" uuid NOT NULL,
    "BlobUrl" text NOT NULL,
    "ContentType" varchar(100) NOT NULL,
    "FileName" varchar(255) NOT NULL,
    "UploadedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_WRITE_OFF_ATTACHMENT" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."WRITE_OFF_ITEM" (
    "Id" uuid NOT NULL,
    "BatchId" uuid NOT NULL,
    "WriteOffId" uuid NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "Quantity" numeric(18,3) NOT NULL,
    "Reason" text,
    CONSTRAINT "PK_WRITE_OFF_ITEM" PRIMARY KEY ("Id")
);

CREATE TABLE "public"."FINANCIAL_ADJUSTMENT" (
    "Id" uuid NOT NULL,
    "AllocationPlanPriceId" uuid NOT NULL,
    "ApprovedByUserId" uuid NOT NULL,
    "PaymentId" uuid NOT NULL,
    "ReceiptDiscrepancyItemId" uuid NOT NULL,
    "ShipmentId" uuid NOT NULL,
    "AcceptedQuantity" numeric(18,3) NOT NULL,
    "ActualNetUnitPrice" numeric(18,2) NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "ApprovedAt" timestamptz NOT NULL,
    "CreatedAt" timestamptz NOT NULL,
    "EvidenceReference" varchar(500) NOT NULL,
    "OperationKey" varchar(80) NOT NULL,
    "Reason" varchar(500) NOT NULL,
    "RoundingRule" varchar(50) NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    CONSTRAINT "PK_FINANCIAL_ADJUSTMENT" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_FINANCIAL_ADJUSTMENT_QuantityAndValue" CHECK ("AcceptedQuantity" > 0 AND "ActualNetUnitPrice" >= 0 AND "Amount" >= 0)
);

CREATE TABLE "public"."NEAR_EXPIRY_OFFER" (
    "Id" uuid NOT NULL,
    "ApprovedByUserId" uuid,
    "ProductId" uuid NOT NULL,
    "ApprovedAt" timestamptz,
    "CreatedAt" timestamptz NOT NULL,
    "DiscountType" varchar(30) NOT NULL,
    "DiscountValue" numeric(18,2) NOT NULL,
    "EndAt" timestamptz NOT NULL,
    "MinimumLifeRatio" numeric(5,4) NOT NULL,
    "OfferCode" varchar(40) NOT NULL,
    "OfferUnitPrice" numeric(18,2),
    "StartAt" timestamptz NOT NULL,
    "Status" varchar(30) NOT NULL,
    "UpdatedAt" timestamptz NOT NULL,
    "VersionNumber" integer NOT NULL,
    CONSTRAINT "PK_NEAR_EXPIRY_OFFER" PRIMARY KEY ("Id"),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_MlorRatio" CHECK ("MinimumLifeRatio" > 0 AND "MinimumLifeRatio" < 1),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_Validity" CHECK ("StartAt" < "EndAt"),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_Version" CHECK ("VersionNumber" > 0),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_Discount" CHECK ("DiscountType" IN ('Percent', 'FixedPerUnit') AND "DiscountValue" >= 0 AND ("DiscountType" <> 'Percent' OR "DiscountValue" <= 100)),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_Price" CHECK ("OfferUnitPrice" IS NULL OR "OfferUnitPrice" >= 0),
    CONSTRAINT "CK_NEAR_EXPIRY_OFFER_Approval" CHECK ("Status" <> 'Published' OR ("ApprovedByUserId" IS NOT NULL AND "ApprovedAt" IS NOT NULL))
);

-- Foreign keys are added after all tables so cyclic relationships are supported.
ALTER TABLE "public"."ACCOUNT_TOKEN"
    ADD CONSTRAINT "FK_ACCOUNT_TOKEN_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE CASCADE;
ALTER TABLE "public"."ALLOCATION_LINE_TRACE"
    ADD CONSTRAINT "FK_ALLOCATION_LINE_TRACE_ALLOCATION_PLAN_VERSION_Alloc_8a4e81f3"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_LINE_TRACE"
    ADD CONSTRAINT "FK_ALLOCATION_LINE_TRACE_ALLOCATION_RUN_LINE_Allocatio_b6da7517"
    FOREIGN KEY ("AllocationRunLineId")
    REFERENCES "public"."ALLOCATION_RUN_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_PRICE"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_PRICE_ALLOCATION_PLAN_VERSION_Alloc_a2a7eff0"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_PRICE"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_PRICE_ALLOCATION_RUN_LINE_Allocatio_15484ee5"
    FOREIGN KEY ("AllocationRunLineId")
    REFERENCES "public"."ALLOCATION_RUN_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_PRICE"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_PRICE_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_PRICE"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_PRICE_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_PRICE"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_PRICE_SHELF_LIFE_DISCOUNT_TIER_Shel_8a250633"
    FOREIGN KEY ("ShelfLifeDiscountTierId")
    REFERENCES "public"."SHELF_LIFE_DISCOUNT_TIER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_VERSION"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_VERSION_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_VERSION"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_VERSION_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_PLAN_VERSION"
    ADD CONSTRAINT "FK_ALLOCATION_PLAN_VERSION_USER_ACCOUNT_RecalculationR_fa0cdfa7"
    FOREIGN KEY ("RecalculationRequestedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ALLOCATION"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ALLOCATION_ALLOCATION_PLAN_VERSION_A_18e5fd6c"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ALLOCATION"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ALLOCATION_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ALLOCATION"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ALLOCATION_ALLOCATION_RUN_LINE_Alloc_6f882ec4"
    FOREIGN KEY ("AllocationRunLineId")
    REFERENCES "public"."ALLOCATION_RUN_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ALLOCATION"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ALLOCATION_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ALLOCATION"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ALLOCATION_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_LINE"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_LINE_ALLOCATION_RUN_ORDER_Allocation_7b9b2f69"
    FOREIGN KEY ("AllocationRunOrderId")
    REFERENCES "public"."ALLOCATION_RUN_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_LINE"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_LINE_SALES_ORDER_LINE_SalesOrderLineId"
    FOREIGN KEY ("SalesOrderLineId")
    REFERENCES "public"."SALES_ORDER_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_LINE"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_LINE_NEAR_EXPIRY_OFFER_NearExpiryOff_cd614ae7"
    FOREIGN KEY ("NearExpiryOfferId", "OfferVersion")
    REFERENCES "public"."NEAR_EXPIRY_OFFER" ("Id", "VersionNumber")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_LINE"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_LINE_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ORDER"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ORDER_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ORDER"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ORDER_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_ORDER"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_ORDER_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_STOCK"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_STOCK_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_STOCK"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_STOCK_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_STOCK"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_STOCK_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_RUN_STOCK"
    ADD CONSTRAINT "FK_ALLOCATION_RUN_STOCK_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_CANDIDATE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_CANDIDATE_ALLOCATION_LINE_TRACE_Al_26009487"
    FOREIGN KEY ("AllocationLineTraceId")
    REFERENCES "public"."ALLOCATION_LINE_TRACE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_CANDIDATE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_CANDIDATE_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_CANDIDATE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_CANDIDATE_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_SCORE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_SCORE_ALLOCATION_LINE_TRACE_Alloca_38d90e19"
    FOREIGN KEY ("AllocationLineTraceId")
    REFERENCES "public"."ALLOCATION_LINE_TRACE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_SCORE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_SCORE_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ALLOCATION_TRACE_SCORE"
    ADD CONSTRAINT "FK_ALLOCATION_TRACE_SCORE_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."AUDIT_LOG"
    ADD CONSTRAINT "FK_AUDIT_LOG_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH"
    ADD CONSTRAINT "FK_BATCH_GOODS_RECEIPT_LINE_GoodsReceiptLineId"
    FOREIGN KEY ("GoodsReceiptLineId")
    REFERENCES "public"."GOODS_RECEIPT_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH"
    ADD CONSTRAINT "FK_BATCH_BATCH_ParentBatchId"
    FOREIGN KEY ("ParentBatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH"
    ADD CONSTRAINT "FK_BATCH_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH"
    ADD CONSTRAINT "FK_BATCH_BATCH_RootBatchId"
    FOREIGN KEY ("RootBatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH"
    ADD CONSTRAINT "FK_BATCH_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_PROMOTION"
    ADD CONSTRAINT "FK_BATCH_PROMOTION_USER_ACCOUNT_AssignedByUserId"
    FOREIGN KEY ("AssignedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_PROMOTION"
    ADD CONSTRAINT "FK_BATCH_PROMOTION_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_PROMOTION"
    ADD CONSTRAINT "FK_BATCH_PROMOTION_NEAR_EXPIRY_OFFER_NearExpiryOfferId"
    FOREIGN KEY ("NearExpiryOfferId")
    REFERENCES "public"."NEAR_EXPIRY_OFFER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_QR_LABEL"
    ADD CONSTRAINT "FK_BATCH_QR_LABEL_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_QR_LABEL"
    ADD CONSTRAINT "FK_BATCH_QR_LABEL_WAREHOUSE_CurrentWarehouseId"
    FOREIGN KEY ("CurrentWarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_QR_LABEL"
    ADD CONSTRAINT "FK_BATCH_QR_LABEL_GOODS_RECEIPT_GoodsReceiptId"
    FOREIGN KEY ("GoodsReceiptId")
    REFERENCES "public"."GOODS_RECEIPT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_QR_LABEL"
    ADD CONSTRAINT "FK_BATCH_QR_LABEL_BATCH_QR_LABEL_ParentLabelId"
    FOREIGN KEY ("ParentLabelId")
    REFERENCES "public"."BATCH_QR_LABEL" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."BATCH_QR_LABEL"
    ADD CONSTRAINT "FK_BATCH_QR_LABEL_BATCH_QR_LABEL_RootLabelId"
    FOREIGN KEY ("RootLabelId")
    REFERENCES "public"."BATCH_QR_LABEL" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."DRIVER"
    ADD CONSTRAINT "FK_DRIVER_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."GOODS_RECEIPT"
    ADD CONSTRAINT "FK_GOODS_RECEIPT_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."GOODS_RECEIPT"
    ADD CONSTRAINT "FK_GOODS_RECEIPT_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."GOODS_RECEIPT"
    ADD CONSTRAINT "FK_GOODS_RECEIPT_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."GOODS_RECEIPT_LINE"
    ADD CONSTRAINT "FK_GOODS_RECEIPT_LINE_GOODS_RECEIPT_GoodsReceiptId"
    FOREIGN KEY ("GoodsReceiptId")
    REFERENCES "public"."GOODS_RECEIPT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."GOODS_RECEIPT_LINE"
    ADD CONSTRAINT "FK_GOODS_RECEIPT_LINE_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."IDEMPOTENCY_KEY"
    ADD CONSTRAINT "FK_IDEMPOTENCY_KEY_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."IDEMPOTENCY_KEY"
    ADD CONSTRAINT "FK_IDEMPOTENCY_KEY_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_BALANCE"
    ADD CONSTRAINT "FK_INVENTORY_BALANCE_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_LOCK"
    ADD CONSTRAINT "FK_INVENTORY_LOCK_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_LOCK"
    ADD CONSTRAINT "FK_INVENTORY_LOCK_USER_ACCOUNT_LockedByUserId"
    FOREIGN KEY ("LockedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_LOCK"
    ADD CONSTRAINT "FK_INVENTORY_LOCK_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_LOCK"
    ADD CONSTRAINT "FK_INVENTORY_LOCK_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_LOCK"
    ADD CONSTRAINT "FK_INVENTORY_LOCK_USER_ACCOUNT_ReleasedByUserId"
    FOREIGN KEY ("ReleasedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_GOODS_RECEIPT_GoodsReceiptId"
    FOREIGN KEY ("GoodsReceiptId")
    REFERENCES "public"."GOODS_RECEIPT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_GOODS_RECEIPT_LINE_GoodsReceiptLineId"
    FOREIGN KEY ("GoodsReceiptLineId")
    REFERENCES "public"."GOODS_RECEIPT_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."INVENTORY_TRANSACTION"
    ADD CONSTRAINT "FK_INVENTORY_TRANSACTION_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_PROGRAM"
    ADD CONSTRAINT "FK_LOYALTY_PROGRAM_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_PROGRAM_RETAILER"
    ADD CONSTRAINT "FK_LOYALTY_PROGRAM_RETAILER_LOYALTY_PROGRAM_LoyaltyProgramId"
    FOREIGN KEY ("LoyaltyProgramId")
    REFERENCES "public"."LOYALTY_PROGRAM" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_PROGRAM_RETAILER"
    ADD CONSTRAINT "FK_LOYALTY_PROGRAM_RETAILER_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_REWARD"
    ADD CONSTRAINT "FK_LOYALTY_REWARD_LOYALTY_PROGRAM_LoyaltyProgramId"
    FOREIGN KEY ("LoyaltyProgramId")
    REFERENCES "public"."LOYALTY_PROGRAM" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_LOYALTY_PROGRAM_LoyaltyProgramId"
    FOREIGN KEY ("LoyaltyProgramId")
    REFERENCES "public"."LOYALTY_PROGRAM" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_RETAILER_LOYALTY_RetailerLoyaltyId"
    FOREIGN KEY ("RetailerLoyaltyId")
    REFERENCES "public"."RETAILER_LOYALTY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_FINANCIAL_ADJUSTMENT_FinancialA_9b58421c"
    FOREIGN KEY ("FinancialAdjustmentId")
    REFERENCES "public"."FINANCIAL_ADJUSTMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_LOYALTY_TRANSACTION_OriginalTra_97e89d46"
    FOREIGN KEY ("OriginalTransactionId")
    REFERENCES "public"."LOYALTY_TRANSACTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."LOYALTY_TRANSACTION"
    ADD CONSTRAINT "FK_LOYALTY_TRANSACTION_REWARD_REDEMPTION_RewardRedemptionId"
    FOREIGN KEY ("RewardRedemptionId")
    REFERENCES "public"."REWARD_REDEMPTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_PAYMENT"
    ADD CONSTRAINT "FK_MANUAL_PAYMENT_USER_ACCOUNT_ConfirmedByUserId"
    FOREIGN KEY ("ConfirmedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_PAYMENT"
    ADD CONSTRAINT "FK_MANUAL_PAYMENT_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_PAYMENT"
    ADD CONSTRAINT "FK_MANUAL_PAYMENT_PAYMENT_PaymentId"
    FOREIGN KEY ("PaymentId")
    REFERENCES "public"."PAYMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_PAYMENT_PaymentId"
    FOREIGN KEY ("PaymentId")
    REFERENCES "public"."PAYMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_USER_ACCOUNT_SubmittedByUserId"
    FOREIGN KEY ("SubmittedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_USER_ACCOUNT_VerifiedByUserId"
    FOREIGN KEY ("VerifiedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MANUAL_REFUND"
    ADD CONSTRAINT "FK_MANUAL_REFUND_FINANCIAL_ADJUSTMENT_FinancialAdjustmentId"
    FOREIGN KEY ("FinancialAdjustmentId")
    REFERENCES "public"."FINANCIAL_ADJUSTMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_DISTANCE_CACHE"
    ADD CONSTRAINT "FK_MAP_DISTANCE_CACHE_MAP_LOCATION_DestinationLocationId"
    FOREIGN KEY ("DestinationLocationId")
    REFERENCES "public"."MAP_LOCATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_DISTANCE_CACHE"
    ADD CONSTRAINT "FK_MAP_DISTANCE_CACHE_MAP_LOCATION_OriginLocationId"
    FOREIGN KEY ("OriginLocationId")
    REFERENCES "public"."MAP_LOCATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_DISTANCE_CACHE"
    ADD CONSTRAINT "FK_MAP_DISTANCE_CACHE_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_DISTANCE_CACHE"
    ADD CONSTRAINT "FK_MAP_DISTANCE_CACHE_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_LOCATION"
    ADD CONSTRAINT "FK_MAP_LOCATION_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."MAP_LOCATION"
    ADD CONSTRAINT "FK_MAP_LOCATION_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."NOTIFICATION"
    ADD CONSTRAINT "FK_NOTIFICATION_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."NOTIFICATION"
    ADD CONSTRAINT "FK_NOTIFICATION_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."NOTIFICATION"
    ADD CONSTRAINT "FK_NOTIFICATION_OUTBOX_MESSAGE_OutboxMessageId"
    FOREIGN KEY ("OutboxMessageId")
    REFERENCES "public"."OUTBOX_MESSAGE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ORDER_PROMOTION"
    ADD CONSTRAINT "FK_ORDER_PROMOTION_PROMOTION_PromotionId"
    FOREIGN KEY ("PromotionId")
    REFERENCES "public"."PROMOTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ORDER_PROMOTION"
    ADD CONSTRAINT "FK_ORDER_PROMOTION_SALES_ORDER_LINE_SalesOrderLineId"
    FOREIGN KEY ("SalesOrderLineId")
    REFERENCES "public"."SALES_ORDER_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ORDER_STATUS_HISTORY"
    ADD CONSTRAINT "FK_ORDER_STATUS_HISTORY_USER_ACCOUNT_ChangedByUserId"
    FOREIGN KEY ("ChangedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."ORDER_STATUS_HISTORY"
    ADD CONSTRAINT "FK_ORDER_STATUS_HISTORY_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PAYMENT"
    ADD CONSTRAINT "FK_PAYMENT_USER_ACCOUNT_ConfirmedByUserId"
    FOREIGN KEY ("ConfirmedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PAYMENT"
    ADD CONSTRAINT "FK_PAYMENT_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PAYMENT"
    ADD CONSTRAINT "FK_PAYMENT_ALLOCATION_PLAN_VERSION_AllocationPlanVersionId"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PRODUCT"
    ADD CONSTRAINT "FK_PRODUCT_PRODUCT_CATEGORY_ProductCategoryId"
    FOREIGN KEY ("ProductCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PRODUCT"
    ADD CONSTRAINT "FK_PRODUCT_PRODUCT_ReplacesProductId"
    FOREIGN KEY ("ReplacesProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PRODUCT_CATEGORY"
    ADD CONSTRAINT "FK_PRODUCT_CATEGORY_PRODUCT_CATEGORY_ParentCategoryId"
    FOREIGN KEY ("ParentCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PRODUCT_PRICE"
    ADD CONSTRAINT "FK_PRODUCT_PRICE_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION"
    ADD CONSTRAINT "FK_PROMOTION_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_CATEGORY"
    ADD CONSTRAINT "FK_PROMOTION_CATEGORY_PRODUCT_CATEGORY_ProductCategoryId"
    FOREIGN KEY ("ProductCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_CATEGORY"
    ADD CONSTRAINT "FK_PROMOTION_CATEGORY_PROMOTION_PromotionId"
    FOREIGN KEY ("PromotionId")
    REFERENCES "public"."PROMOTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_PRODUCT"
    ADD CONSTRAINT "FK_PROMOTION_PRODUCT_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_PRODUCT"
    ADD CONSTRAINT "FK_PROMOTION_PRODUCT_PROMOTION_PromotionId"
    FOREIGN KEY ("PromotionId")
    REFERENCES "public"."PROMOTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_RETAILER"
    ADD CONSTRAINT "FK_PROMOTION_RETAILER_PROMOTION_PromotionId"
    FOREIGN KEY ("PromotionId")
    REFERENCES "public"."PROMOTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PROMOTION_RETAILER"
    ADD CONSTRAINT "FK_PROMOTION_RETAILER_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PURCHASE_ORDER"
    ADD CONSTRAINT "FK_PURCHASE_ORDER_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PURCHASE_ORDER"
    ADD CONSTRAINT "FK_PURCHASE_ORDER_SALES_ORDER_QUOTE_SalesOrderQuoteId"
    FOREIGN KEY ("SalesOrderQuoteId")
    REFERENCES "public"."SALES_ORDER_QUOTE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."PURCHASE_ORDER"
    ADD CONSTRAINT "FK_PURCHASE_ORDER_USER_ACCOUNT_IssuedByUserId"
    FOREIGN KEY ("IssuedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."QR_LABEL_EVENT"
    ADD CONSTRAINT "FK_QR_LABEL_EVENT_BATCH_QR_LABEL_BatchQrLabelId"
    FOREIGN KEY ("BatchQrLabelId")
    REFERENCES "public"."BATCH_QR_LABEL" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."QR_LABEL_EVENT"
    ADD CONSTRAINT "FK_QR_LABEL_EVENT_USER_ACCOUNT_PerformedByUserId"
    FOREIGN KEY ("PerformedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."QR_LABEL_EVENT"
    ADD CONSTRAINT "FK_QR_LABEL_EVENT_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_USER_ACCOUNT_ConfirmedByRetailerUserId"
    FOREIGN KEY ("ConfirmedByRetailerUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_SHIPMENT_ShipmentId"
    FOREIGN KEY ("ShipmentId")
    REFERENCES "public"."SHIPMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_ITEM_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_ITEM_BATCH_QR_LABEL_BatchQrLabelId"
    FOREIGN KEY ("BatchQrLabelId")
    REFERENCES "public"."BATCH_QR_LABEL" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_ITEM_RECEIPT_CONFIRMATION_Rece_ef4df6b1"
    FOREIGN KEY ("ReceiptConfirmationId")
    REFERENCES "public"."RECEIPT_CONFIRMATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_ITEM_SALES_ORDER_LINE_SalesOrderLineId"
    FOREIGN KEY ("SalesOrderLineId")
    REFERENCES "public"."SALES_ORDER_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_QR_LABEL"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_QR_LABEL_BATCH_QR_LABEL_BatchQrLabelId"
    FOREIGN KEY ("BatchQrLabelId")
    REFERENCES "public"."BATCH_QR_LABEL" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_CONFIRMATION_QR_LABEL"
    ADD CONSTRAINT "FK_RECEIPT_CONFIRMATION_QR_LABEL_RECEIPT_CONFIRMATION__47e55b1c"
    FOREIGN KEY ("ReceiptConfirmationId")
    REFERENCES "public"."RECEIPT_CONFIRMATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_RECEIPT_CONFIRMATION_ReceiptCon_42b69ed6"
    FOREIGN KEY ("ReceiptConfirmationId")
    REFERENCES "public"."RECEIPT_CONFIRMATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_USER_ACCOUNT_ReportedByRetailerUserId"
    FOREIGN KEY ("ReportedByRetailerUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_USER_ACCOUNT_ReviewedByUserId"
    FOREIGN KEY ("ReviewedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_ITEM_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_ITEM_RECEIPT_DISCREPANCY_Receip_7b1ce3aa"
    FOREIGN KEY ("ReceiptDiscrepancyId")
    REFERENCES "public"."RECEIPT_DISCREPANCY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_ITEM_SHIPMENT_ShipmentId"
    FOREIGN KEY ("ShipmentId")
    REFERENCES "public"."SHIPMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RECEIPT_DISCREPANCY_ITEM"
    ADD CONSTRAINT "FK_RECEIPT_DISCREPANCY_ITEM_ALLOCATION_PLAN_PRICE_Allo_851737e5"
    FOREIGN KEY ("AllocationPlanPriceId")
    REFERENCES "public"."ALLOCATION_PLAN_PRICE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REFRESH_TOKEN"
    ADD CONSTRAINT "FK_REFRESH_TOKEN_REFRESH_TOKEN_ReplacedByTokenId"
    FOREIGN KEY ("ReplacedByTokenId")
    REFERENCES "public"."REFRESH_TOKEN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REFRESH_TOKEN"
    ADD CONSTRAINT "FK_REFRESH_TOKEN_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE CASCADE;
ALTER TABLE "public"."RESERVATION"
    ADD CONSTRAINT "FK_RESERVATION_ALLOCATION_RUN_ALLOCATION_AllocationRun_03b23da0"
    FOREIGN KEY ("AllocationRunAllocationId")
    REFERENCES "public"."ALLOCATION_RUN_ALLOCATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RESERVATION"
    ADD CONSTRAINT "FK_RESERVATION_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER"
    ADD CONSTRAINT "FK_RETAILER_USER_ACCOUNT_AssessedByUserId"
    FOREIGN KEY ("AssessedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER"
    ADD CONSTRAINT "FK_RETAILER_USER_ACCOUNT_DeclaredByUserId"
    FOREIGN KEY ("DeclaredByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER"
    ADD CONSTRAINT "FK_RETAILER_REGION_RegionId"
    FOREIGN KEY ("RegionId")
    REFERENCES "public"."REGION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER"
    ADD CONSTRAINT "FK_RETAILER_USER_ACCOUNT_ReviewedByUserId"
    FOREIGN KEY ("ReviewedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER"
    ADD CONSTRAINT "FK_RETAILER_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_LOYALTY"
    ADD CONSTRAINT "FK_RETAILER_LOYALTY_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_PRODUCT_MLOR"
    ADD CONSTRAINT "FK_RETAILER_PRODUCT_MLOR_PRODUCT_CATEGORY_ProductCategoryId"
    FOREIGN KEY ("ProductCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_PRODUCT_MLOR"
    ADD CONSTRAINT "FK_RETAILER_PRODUCT_MLOR_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_PRODUCT_MLOR"
    ADD CONSTRAINT "FK_RETAILER_PRODUCT_MLOR_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_PRODUCT_MLOR"
    ADD CONSTRAINT "FK_RETAILER_PRODUCT_MLOR_USER_ACCOUNT_UpdatedByUserId"
    FOREIGN KEY ("UpdatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_SALES_ASSIGNMENT"
    ADD CONSTRAINT "FK_RETAILER_SALES_ASSIGNMENT_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RETAILER_SALES_ASSIGNMENT"
    ADD CONSTRAINT "FK_RETAILER_SALES_ASSIGNMENT_SALES_GROUP_SalesGroupId"
    FOREIGN KEY ("SalesGroupId")
    REFERENCES "public"."SALES_GROUP" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_LOYALTY_REWARD_LoyaltyRewardId"
    FOREIGN KEY ("LoyaltyRewardId")
    REFERENCES "public"."LOYALTY_REWARD" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_LOYALTY_TRANSACTION_LoyaltyTransactionId"
    FOREIGN KEY ("LoyaltyTransactionId")
    REFERENCES "public"."LOYALTY_TRANSACTION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_USER_ACCOUNT_RedeemedByUserId"
    FOREIGN KEY ("RedeemedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_USER_ACCOUNT_DeliveredByUserId"
    FOREIGN KEY ("DeliveredByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."REWARD_REDEMPTION"
    ADD CONSTRAINT "FK_REWARD_REDEMPTION_USER_ACCOUNT_CompletedByUserId"
    FOREIGN KEY ("CompletedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_GATHER"
    ADD CONSTRAINT "FK_RUN_PICKING_GATHER_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_GATHER"
    ADD CONSTRAINT "FK_RUN_PICKING_GATHER_RUN_PICKING_LIST_RunPickingListId"
    FOREIGN KEY ("RunPickingListId")
    REFERENCES "public"."RUN_PICKING_LIST" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_GATHER"
    ADD CONSTRAINT "FK_RUN_PICKING_GATHER_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_LIST"
    ADD CONSTRAINT "FK_RUN_PICKING_LIST_ALLOCATION_PLAN_VERSION_Allocation_0263a3a7"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_LIST"
    ADD CONSTRAINT "FK_RUN_PICKING_LIST_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_LIST"
    ADD CONSTRAINT "FK_RUN_PICKING_LIST_USER_ACCOUNT_CompletedByUserId"
    FOREIGN KEY ("CompletedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_LIST"
    ADD CONSTRAINT "FK_RUN_PICKING_LIST_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_LIST"
    ADD CONSTRAINT "FK_RUN_PICKING_LIST_USER_ACCOUNT_AssignedToUserId"
    FOREIGN KEY ("AssignedToUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_ALLOCATION_PLAN_PRICE_AllocationP_d7fa8ddc"
    FOREIGN KEY ("AllocationPlanPriceId")
    REFERENCES "public"."ALLOCATION_PLAN_PRICE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_ALLOCATION_RUN_ALLOCATION_Allocat_0d30f551"
    FOREIGN KEY ("AllocationRunAllocationId")
    REFERENCES "public"."ALLOCATION_RUN_ALLOCATION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_RUN_PICKING_GATHER_RunPickingGatherId"
    FOREIGN KEY ("RunPickingGatherId")
    REFERENCES "public"."RUN_PICKING_GATHER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_SALES_ORDER_LINE_SalesOrderLineId"
    FOREIGN KEY ("SalesOrderLineId")
    REFERENCES "public"."SALES_ORDER_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."RUN_PICKING_SPLIT"
    ADD CONSTRAINT "FK_RUN_PICKING_SPLIT_ALLOCATION_RUN_LINE_AllocationRunLineId"
    FOREIGN KEY ("AllocationRunLineId")
    REFERENCES "public"."ALLOCATION_RUN_LINE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_GROUP"
    ADD CONSTRAINT "FK_SALES_GROUP_REGION_RegionId"
    FOREIGN KEY ("RegionId")
    REFERENCES "public"."REGION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_GROUP_MEMBER"
    ADD CONSTRAINT "FK_SALES_GROUP_MEMBER_SALES_GROUP_SalesGroupId"
    FOREIGN KEY ("SalesGroupId")
    REFERENCES "public"."SALES_GROUP" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_GROUP_MEMBER"
    ADD CONSTRAINT "FK_SALES_GROUP_MEMBER_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER"
    ADD CONSTRAINT "FK_SALES_ORDER_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER"
    ADD CONSTRAINT "FK_SALES_ORDER_RETAILER_RetailerId"
    FOREIGN KEY ("RetailerId")
    REFERENCES "public"."RETAILER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER"
    ADD CONSTRAINT "FK_SALES_ORDER_USER_ACCOUNT_ReviewedByUserId"
    FOREIGN KEY ("ReviewedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER"
    ADD CONSTRAINT "FK_SALES_ORDER_SALES_GROUP_SalesGroupId"
    FOREIGN KEY ("SalesGroupId")
    REFERENCES "public"."SALES_GROUP" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_ATTACHMENT"
    ADD CONSTRAINT "FK_SALES_ORDER_ATTACHMENT_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_ATTACHMENT"
    ADD CONSTRAINT "FK_SALES_ORDER_ATTACHMENT_USER_ACCOUNT_UploadedByUserId"
    FOREIGN KEY ("UploadedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_PRODUCT_CATEGORY_MlorProductCategoryId"
    FOREIGN KEY ("MlorProductCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_RETAILER_PRODUCT_MLOR_MlorSourceRuleId"
    FOREIGN KEY ("MlorSourceRuleId")
    REFERENCES "public"."RETAILER_PRODUCT_MLOR" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_PRODUCT_PRICE_ProductPriceId"
    FOREIGN KEY ("ProductPriceId")
    REFERENCES "public"."PRODUCT_PRICE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_NEAR_EXPIRY_OFFER_NearExpiryOfferI_d2d05800"
    FOREIGN KEY ("NearExpiryOfferId", "OfferVersion")
    REFERENCES "public"."NEAR_EXPIRY_OFFER" ("Id", "VersionNumber")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_LINE"
    ADD CONSTRAINT "FK_SALES_ORDER_LINE_USER_ACCOUNT_OfferAcceptedByUserId"
    FOREIGN KEY ("OfferAcceptedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_QUOTE"
    ADD CONSTRAINT "FK_SALES_ORDER_QUOTE_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_QUOTE"
    ADD CONSTRAINT "FK_SALES_ORDER_QUOTE_ALLOCATION_RUN_AllocationRunId"
    FOREIGN KEY ("AllocationRunId")
    REFERENCES "public"."ALLOCATION_RUN" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_QUOTE"
    ADD CONSTRAINT "FK_SALES_ORDER_QUOTE_ALLOCATION_PLAN_VERSION_Allocatio_7d463265"
    FOREIGN KEY ("AllocationPlanVersionId")
    REFERENCES "public"."ALLOCATION_PLAN_VERSION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SALES_ORDER_QUOTE"
    ADD CONSTRAINT "FK_SALES_ORDER_QUOTE_USER_ACCOUNT_AcceptedByUserId"
    FOREIGN KEY ("AcceptedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHELF_LIFE_DISCOUNT_TABLE"
    ADD CONSTRAINT "FK_SHELF_LIFE_DISCOUNT_TABLE_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHELF_LIFE_DISCOUNT_TIER"
    ADD CONSTRAINT "FK_SHELF_LIFE_DISCOUNT_TIER_PRODUCT_CATEGORY_ProductCategoryId"
    FOREIGN KEY ("ProductCategoryId")
    REFERENCES "public"."PRODUCT_CATEGORY" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHELF_LIFE_DISCOUNT_TIER"
    ADD CONSTRAINT "FK_SHELF_LIFE_DISCOUNT_TIER_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHELF_LIFE_DISCOUNT_TIER"
    ADD CONSTRAINT "FK_SHELF_LIFE_DISCOUNT_TIER_SHELF_LIFE_DISCOUNT_TABLE__ebcac271"
    FOREIGN KEY ("ShelfLifeDiscountTableId")
    REFERENCES "public"."SHELF_LIFE_DISCOUNT_TABLE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHIPMENT"
    ADD CONSTRAINT "FK_SHIPMENT_DRIVER_DriverId"
    FOREIGN KEY ("DriverId")
    REFERENCES "public"."DRIVER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHIPMENT"
    ADD CONSTRAINT "FK_SHIPMENT_RUN_PICKING_LIST_RunPickingListId"
    FOREIGN KEY ("RunPickingListId")
    REFERENCES "public"."RUN_PICKING_LIST" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHIPMENT"
    ADD CONSTRAINT "FK_SHIPMENT_SALES_ORDER_SalesOrderId"
    FOREIGN KEY ("SalesOrderId")
    REFERENCES "public"."SALES_ORDER" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHIPMENT"
    ADD CONSTRAINT "FK_SHIPMENT_VEHICLE_VehicleId"
    FOREIGN KEY ("VehicleId")
    REFERENCES "public"."VEHICLE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SHIPMENT"
    ADD CONSTRAINT "FK_SHIPMENT_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."SYSTEM_CONFIGURATION"
    ADD CONSTRAINT "FK_SYSTEM_CONFIGURATION_USER_ACCOUNT_UpdatedByUserId"
    FOREIGN KEY ("UpdatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."TRANSIT_TABLE"
    ADD CONSTRAINT "FK_TRANSIT_TABLE_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."TRANSIT_TABLE_BAND"
    ADD CONSTRAINT "FK_TRANSIT_TABLE_BAND_TRANSIT_TABLE_TransitTableId"
    FOREIGN KEY ("TransitTableId")
    REFERENCES "public"."TRANSIT_TABLE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."USER_CREDENTIAL"
    ADD CONSTRAINT "FK_USER_CREDENTIAL_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE CASCADE;
ALTER TABLE "public"."USER_REGION_ASSIGNMENT"
    ADD CONSTRAINT "FK_USER_REGION_ASSIGNMENT_REGION_RegionId"
    FOREIGN KEY ("RegionId")
    REFERENCES "public"."REGION" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."USER_REGION_ASSIGNMENT"
    ADD CONSTRAINT "FK_USER_REGION_ASSIGNMENT_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."USER_WAREHOUSE_ASSIGNMENT"
    ADD CONSTRAINT "FK_USER_WAREHOUSE_ASSIGNMENT_USER_ACCOUNT_UserAccountId"
    FOREIGN KEY ("UserAccountId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."USER_WAREHOUSE_ASSIGNMENT"
    ADD CONSTRAINT "FK_USER_WAREHOUSE_ASSIGNMENT_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."VEHICLE"
    ADD CONSTRAINT "FK_VEHICLE_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF"
    ADD CONSTRAINT "FK_WRITE_OFF_USER_ACCOUNT_CreatedByUserId"
    FOREIGN KEY ("CreatedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF"
    ADD CONSTRAINT "FK_WRITE_OFF_WAREHOUSE_WarehouseId"
    FOREIGN KEY ("WarehouseId")
    REFERENCES "public"."WAREHOUSE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF"
    ADD CONSTRAINT "FK_WRITE_OFF_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF_ATTACHMENT"
    ADD CONSTRAINT "FK_WRITE_OFF_ATTACHMENT_USER_ACCOUNT_UploadedByUserId"
    FOREIGN KEY ("UploadedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF_ATTACHMENT"
    ADD CONSTRAINT "FK_WRITE_OFF_ATTACHMENT_WRITE_OFF_WriteOffId"
    FOREIGN KEY ("WriteOffId")
    REFERENCES "public"."WRITE_OFF" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF_ITEM"
    ADD CONSTRAINT "FK_WRITE_OFF_ITEM_BATCH_BatchId"
    FOREIGN KEY ("BatchId")
    REFERENCES "public"."BATCH" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."WRITE_OFF_ITEM"
    ADD CONSTRAINT "FK_WRITE_OFF_ITEM_WRITE_OFF_WriteOffId"
    FOREIGN KEY ("WriteOffId")
    REFERENCES "public"."WRITE_OFF" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."FINANCIAL_ADJUSTMENT"
    ADD CONSTRAINT "FK_FINANCIAL_ADJUSTMENT_PAYMENT_PaymentId"
    FOREIGN KEY ("PaymentId")
    REFERENCES "public"."PAYMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."FINANCIAL_ADJUSTMENT"
    ADD CONSTRAINT "FK_FINANCIAL_ADJUSTMENT_RECEIPT_DISCREPANCY_ITEM_Recei_2c95bb0b"
    FOREIGN KEY ("ReceiptDiscrepancyItemId")
    REFERENCES "public"."RECEIPT_DISCREPANCY_ITEM" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."FINANCIAL_ADJUSTMENT"
    ADD CONSTRAINT "FK_FINANCIAL_ADJUSTMENT_SHIPMENT_ShipmentId"
    FOREIGN KEY ("ShipmentId")
    REFERENCES "public"."SHIPMENT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."FINANCIAL_ADJUSTMENT"
    ADD CONSTRAINT "FK_FINANCIAL_ADJUSTMENT_ALLOCATION_PLAN_PRICE_Allocati_69212109"
    FOREIGN KEY ("AllocationPlanPriceId")
    REFERENCES "public"."ALLOCATION_PLAN_PRICE" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."FINANCIAL_ADJUSTMENT"
    ADD CONSTRAINT "FK_FINANCIAL_ADJUSTMENT_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."NEAR_EXPIRY_OFFER"
    ADD CONSTRAINT "FK_NEAR_EXPIRY_OFFER_PRODUCT_ProductId"
    FOREIGN KEY ("ProductId")
    REFERENCES "public"."PRODUCT" ("Id")
    ON DELETE RESTRICT;
ALTER TABLE "public"."NEAR_EXPIRY_OFFER"
    ADD CONSTRAINT "FK_NEAR_EXPIRY_OFFER_USER_ACCOUNT_ApprovedByUserId"
    FOREIGN KEY ("ApprovedByUserId")
    REFERENCES "public"."USER_ACCOUNT" ("Id")
    ON DELETE RESTRICT;

-- Indexes declared in the ERD metadata.
CREATE UNIQUE INDEX "UX_ACCOUNT_TOKEN_TokenHash" ON "public"."ACCOUNT_TOKEN" ("TokenHash");
CREATE INDEX "IX_ACCOUNT_TOKEN_UserAccountId_Purpose_ExpiresAt" ON "public"."ACCOUNT_TOKEN" ("UserAccountId", "Purpose", "ExpiresAt");
CREATE INDEX "IX_ALLOCATION_LINE_TRACE_AllocationRunLineId" ON "public"."ALLOCATION_LINE_TRACE" ("AllocationRunLineId");
CREATE UNIQUE INDEX "UX_ALLOCATION_LINE_TRACE_AllocationPlanVersionId_Alloc_9d9c6e8a" ON "public"."ALLOCATION_LINE_TRACE" ("AllocationPlanVersionId", "AllocationRunLineId");
CREATE INDEX "IX_ALLOCATION_PLAN_PRICE_AllocationRunLineId" ON "public"."ALLOCATION_PLAN_PRICE" ("AllocationRunLineId");
CREATE UNIQUE INDEX "UX_ALLOCATION_PLAN_PRICE_AllocationPlanVersionId_Alloc_7b2786a2" ON "public"."ALLOCATION_PLAN_PRICE" ("AllocationPlanVersionId", "AllocationRunLineId", "BatchId");
CREATE INDEX "IX_ALLOCATION_PLAN_PRICE_BatchId" ON "public"."ALLOCATION_PLAN_PRICE" ("BatchId");
CREATE INDEX "IX_ALLOCATION_PLAN_PRICE_WarehouseId" ON "public"."ALLOCATION_PLAN_PRICE" ("WarehouseId");
CREATE INDEX "IX_ALLOCATION_PLAN_PRICE_ShelfLifeDiscountTierId" ON "public"."ALLOCATION_PLAN_PRICE" ("ShelfLifeDiscountTierId");
CREATE UNIQUE INDEX "UX_ALLOCATION_PLAN_VERSION_AllocationRunId" ON "public"."ALLOCATION_PLAN_VERSION" ("AllocationRunId") WHERE "Status" = 'AwaitingApproval';
CREATE INDEX "IX_ALLOCATION_PLAN_VERSION_ApprovedByUserId" ON "public"."ALLOCATION_PLAN_VERSION" ("ApprovedByUserId");
CREATE UNIQUE INDEX "UX_ALLOCATION_PLAN_VERSION_AllocationRunId_VersionNumber" ON "public"."ALLOCATION_PLAN_VERSION" ("AllocationRunId", "VersionNumber");
CREATE INDEX "IX_ALLOCATION_PLAN_VERSION_RecalculationRequestedByUserId" ON "public"."ALLOCATION_PLAN_VERSION" ("RecalculationRequestedByUserId");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_BusinessDate" ON "public"."ALLOCATION_RUN" ("BusinessDate");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_RunCode" ON "public"."ALLOCATION_RUN" ("RunCode");
CREATE INDEX "IX_ALLOCATION_RUN_ALLOCATION_AllocationRunLineId" ON "public"."ALLOCATION_RUN_ALLOCATION" ("AllocationRunLineId");
CREATE INDEX "IX_ALLOCATION_RUN_ALLOCATION_BatchId" ON "public"."ALLOCATION_RUN_ALLOCATION" ("BatchId");
CREATE INDEX "IX_ALLOCATION_RUN_ALLOCATION_AllocationRunId_BatchId" ON "public"."ALLOCATION_RUN_ALLOCATION" ("AllocationRunId", "BatchId");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_ALLOCATION_AllocationPlanVersionId_A_047ab87d" ON "public"."ALLOCATION_RUN_ALLOCATION" ("AllocationPlanVersionId", "AllocationRunLineId", "BatchId");
CREATE INDEX "IX_ALLOCATION_RUN_ALLOCATION_WarehouseId" ON "public"."ALLOCATION_RUN_ALLOCATION" ("WarehouseId");
CREATE INDEX "IX_ALLOCATION_RUN_LINE_SalesOrderLineId" ON "public"."ALLOCATION_RUN_LINE" ("SalesOrderLineId");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_LINE_AllocationRunOrderId_SalesOrderLineId" ON "public"."ALLOCATION_RUN_LINE" ("AllocationRunOrderId", "SalesOrderLineId");
CREATE INDEX "IX_ALLOCATION_RUN_LINE_NearExpiryOfferId_OfferVersion" ON "public"."ALLOCATION_RUN_LINE" ("NearExpiryOfferId", "OfferVersion");
CREATE INDEX "IX_ALLOCATION_RUN_LINE_ProductId" ON "public"."ALLOCATION_RUN_LINE" ("ProductId");
CREATE INDEX "IX_ALLOCATION_RUN_ORDER_SalesOrderId" ON "public"."ALLOCATION_RUN_ORDER" ("SalesOrderId");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_ORDER_AllocationRunId_PriorityRank" ON "public"."ALLOCATION_RUN_ORDER" ("AllocationRunId", "PriorityRank");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_ORDER_AllocationRunId_SalesOrderId" ON "public"."ALLOCATION_RUN_ORDER" ("AllocationRunId", "SalesOrderId");
CREATE INDEX "IX_ALLOCATION_RUN_ORDER_RetailerId" ON "public"."ALLOCATION_RUN_ORDER" ("RetailerId");
CREATE INDEX "IX_ALLOCATION_RUN_STOCK_BatchId" ON "public"."ALLOCATION_RUN_STOCK" ("BatchId");
CREATE UNIQUE INDEX "UX_ALLOCATION_RUN_STOCK_AllocationRunId_BatchId" ON "public"."ALLOCATION_RUN_STOCK" ("AllocationRunId", "BatchId");
CREATE INDEX "IX_ALLOCATION_RUN_STOCK_AllocationRunId_ProductId" ON "public"."ALLOCATION_RUN_STOCK" ("AllocationRunId", "ProductId");
CREATE INDEX "IX_ALLOCATION_RUN_STOCK_ProductId" ON "public"."ALLOCATION_RUN_STOCK" ("ProductId");
CREATE INDEX "IX_ALLOCATION_RUN_STOCK_WarehouseId" ON "public"."ALLOCATION_RUN_STOCK" ("WarehouseId");
CREATE UNIQUE INDEX "UX_ALLOCATION_TRACE_CANDIDATE_AllocationLineTraceId_St_c2c69cb1" ON "public"."ALLOCATION_TRACE_CANDIDATE" ("AllocationLineTraceId", "Stage", "BatchId");
CREATE INDEX "IX_ALLOCATION_TRACE_CANDIDATE_BatchId" ON "public"."ALLOCATION_TRACE_CANDIDATE" ("BatchId");
CREATE INDEX "IX_ALLOCATION_TRACE_CANDIDATE_WarehouseId" ON "public"."ALLOCATION_TRACE_CANDIDATE" ("WarehouseId");
CREATE UNIQUE INDEX "UX_ALLOCATION_TRACE_SCORE_AllocationLineTraceId_Iterat_c7bbce75" ON "public"."ALLOCATION_TRACE_SCORE" ("AllocationLineTraceId", "Iteration", "BatchId");
CREATE INDEX "IX_ALLOCATION_TRACE_SCORE_BatchId" ON "public"."ALLOCATION_TRACE_SCORE" ("BatchId");
CREATE INDEX "IX_ALLOCATION_TRACE_SCORE_WarehouseId" ON "public"."ALLOCATION_TRACE_SCORE" ("WarehouseId");
CREATE INDEX "IX_AUDIT_LOG_UserAccountId" ON "public"."AUDIT_LOG" ("UserAccountId");
CREATE UNIQUE INDEX "UX_BATCH_BatchCode" ON "public"."BATCH" ("BatchCode");
CREATE INDEX "IX_BATCH_GoodsReceiptLineId" ON "public"."BATCH" ("GoodsReceiptLineId");
CREATE INDEX "IX_BATCH_ParentBatchId" ON "public"."BATCH" ("ParentBatchId");
CREATE INDEX "IX_BATCH_ProductId" ON "public"."BATCH" ("ProductId");
CREATE INDEX "IX_BATCH_RootBatchId" ON "public"."BATCH" ("RootBatchId");
CREATE UNIQUE INDEX "UX_BATCH_WarehouseId_ProductId_ProductionDate_ExpirationDate" ON "public"."BATCH" ("WarehouseId", "ProductId", "ProductionDate", "ExpirationDate");
CREATE INDEX "IX_BATCH_PROMOTION_AssignedByUserId" ON "public"."BATCH_PROMOTION" ("AssignedByUserId");
CREATE UNIQUE INDEX "UX_BATCH_PROMOTION_NearExpiryOfferId_BatchId" ON "public"."BATCH_PROMOTION" ("NearExpiryOfferId", "BatchId");
CREATE INDEX "IX_BATCH_PROMOTION_BatchId" ON "public"."BATCH_PROMOTION" ("BatchId");
CREATE INDEX "IX_BATCH_QR_LABEL_BatchId" ON "public"."BATCH_QR_LABEL" ("BatchId");
CREATE INDEX "IX_BATCH_QR_LABEL_CurrentWarehouseId" ON "public"."BATCH_QR_LABEL" ("CurrentWarehouseId");
CREATE INDEX "IX_BATCH_QR_LABEL_GoodsReceiptId" ON "public"."BATCH_QR_LABEL" ("GoodsReceiptId");
CREATE INDEX "IX_BATCH_QR_LABEL_ParentLabelId" ON "public"."BATCH_QR_LABEL" ("ParentLabelId");
CREATE UNIQUE INDEX "UX_BATCH_QR_LABEL_QrCode" ON "public"."BATCH_QR_LABEL" ("QrCode");
CREATE INDEX "IX_BATCH_QR_LABEL_RootLabelId" ON "public"."BATCH_QR_LABEL" ("RootLabelId");
CREATE UNIQUE INDEX "UX_DRIVER_Code" ON "public"."DRIVER" ("Code");
CREATE INDEX "IX_DRIVER_WarehouseId" ON "public"."DRIVER" ("WarehouseId");
CREATE INDEX "IX_EXPIRY_SWEEP_RUN_StartedAt" ON "public"."EXPIRY_SWEEP_RUN" ("StartedAt");
CREATE INDEX "IX_GOODS_RECEIPT_ApprovedByUserId" ON "public"."GOODS_RECEIPT" ("ApprovedByUserId");
CREATE INDEX "IX_GOODS_RECEIPT_CreatedByUserId" ON "public"."GOODS_RECEIPT" ("CreatedByUserId");
CREATE UNIQUE INDEX "UX_GOODS_RECEIPT_IdempotencyKey" ON "public"."GOODS_RECEIPT" ("IdempotencyKey") WHERE "IdempotencyKey" IS NOT NULL;
CREATE UNIQUE INDEX "UX_GOODS_RECEIPT_ReceiptCode" ON "public"."GOODS_RECEIPT" ("ReceiptCode");
CREATE INDEX "IX_GOODS_RECEIPT_WarehouseId" ON "public"."GOODS_RECEIPT" ("WarehouseId");
CREATE INDEX "IX_GOODS_RECEIPT_LINE_GoodsReceiptId" ON "public"."GOODS_RECEIPT_LINE" ("GoodsReceiptId");
CREATE INDEX "IX_GOODS_RECEIPT_LINE_ProductId" ON "public"."GOODS_RECEIPT_LINE" ("ProductId");
CREATE UNIQUE INDEX "UX_IDEMPOTENCY_KEY_Key" ON "public"."IDEMPOTENCY_KEY" ("Key");
CREATE UNIQUE INDEX "UX_IDEMPOTENCY_KEY_SalesOrderId" ON "public"."IDEMPOTENCY_KEY" ("SalesOrderId");
CREATE INDEX "IX_IDEMPOTENCY_KEY_UserAccountId" ON "public"."IDEMPOTENCY_KEY" ("UserAccountId");
CREATE UNIQUE INDEX "UX_INVENTORY_BALANCE_BatchId" ON "public"."INVENTORY_BALANCE" ("BatchId");
CREATE INDEX "IX_INVENTORY_LOCK_BatchId" ON "public"."INVENTORY_LOCK" ("BatchId");
CREATE INDEX "IX_INVENTORY_LOCK_LockedByUserId" ON "public"."INVENTORY_LOCK" ("LockedByUserId");
CREATE INDEX "IX_INVENTORY_LOCK_ProductId" ON "public"."INVENTORY_LOCK" ("ProductId");
CREATE INDEX "IX_INVENTORY_LOCK_BatchId_Status" ON "public"."INVENTORY_LOCK" ("BatchId", "Status");
CREATE INDEX "IX_INVENTORY_LOCK_WarehouseId_Status" ON "public"."INVENTORY_LOCK" ("WarehouseId", "Status");
CREATE INDEX "IX_INVENTORY_LOCK_ReleasedByUserId" ON "public"."INVENTORY_LOCK" ("ReleasedByUserId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_CreatedByUserId" ON "public"."INVENTORY_TRANSACTION" ("CreatedByUserId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_GoodsReceiptId" ON "public"."INVENTORY_TRANSACTION" ("GoodsReceiptId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_GoodsReceiptLineId" ON "public"."INVENTORY_TRANSACTION" ("GoodsReceiptLineId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_ProductId" ON "public"."INVENTORY_TRANSACTION" ("ProductId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_WarehouseId" ON "public"."INVENTORY_TRANSACTION" ("WarehouseId");
CREATE INDEX "IX_INVENTORY_TRANSACTION_BatchId_OccurredAt" ON "public"."INVENTORY_TRANSACTION" ("BatchId", "OccurredAt");
CREATE INDEX "IX_INVENTORY_TRANSACTION_SourceType_SourceId" ON "public"."INVENTORY_TRANSACTION" ("SourceType", "SourceId");
CREATE UNIQUE INDEX "UX_LOYALTY_PROGRAM_Code" ON "public"."LOYALTY_PROGRAM" ("Code");
CREATE INDEX "IX_LOYALTY_PROGRAM_CreatedByUserId" ON "public"."LOYALTY_PROGRAM" ("CreatedByUserId");
CREATE INDEX "IX_LOYALTY_PROGRAM_RETAILER_RetailerId" ON "public"."LOYALTY_PROGRAM_RETAILER" ("RetailerId");
CREATE UNIQUE INDEX "UX_LOYALTY_PROGRAM_RETAILER_LoyaltyProgramId_RetailerId" ON "public"."LOYALTY_PROGRAM_RETAILER" ("LoyaltyProgramId", "RetailerId");
CREATE UNIQUE INDEX "UX_LOYALTY_REWARD_Code" ON "public"."LOYALTY_REWARD" ("Code");
CREATE INDEX "IX_LOYALTY_REWARD_LoyaltyProgramId" ON "public"."LOYALTY_REWARD" ("LoyaltyProgramId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_CreatedByUserId" ON "public"."LOYALTY_TRANSACTION" ("CreatedByUserId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_LoyaltyProgramId" ON "public"."LOYALTY_TRANSACTION" ("LoyaltyProgramId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_RetailerLoyaltyId" ON "public"."LOYALTY_TRANSACTION" ("RetailerLoyaltyId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_SalesOrderId" ON "public"."LOYALTY_TRANSACTION" ("SalesOrderId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_FinancialAdjustmentId" ON "public"."LOYALTY_TRANSACTION" ("FinancialAdjustmentId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_OriginalTransactionId" ON "public"."LOYALTY_TRANSACTION" ("OriginalTransactionId");
CREATE INDEX "IX_LOYALTY_TRANSACTION_RewardRedemptionId" ON "public"."LOYALTY_TRANSACTION" ("RewardRedemptionId");
CREATE INDEX "IX_MANUAL_PAYMENT_ConfirmedByUserId" ON "public"."MANUAL_PAYMENT" ("ConfirmedByUserId");
CREATE UNIQUE INDEX "UX_MANUAL_PAYMENT_OperationKey" ON "public"."MANUAL_PAYMENT" ("OperationKey");
CREATE INDEX "IX_MANUAL_PAYMENT_SalesOrderId" ON "public"."MANUAL_PAYMENT" ("SalesOrderId");
CREATE INDEX "IX_MANUAL_PAYMENT_SalesOrderId_Status" ON "public"."MANUAL_PAYMENT" ("SalesOrderId", "Status");
CREATE INDEX "IX_MANUAL_PAYMENT_PaymentId" ON "public"."MANUAL_PAYMENT" ("PaymentId");
CREATE UNIQUE INDEX "UX_MANUAL_REFUND_CreateOperationKey" ON "public"."MANUAL_REFUND" ("CreateOperationKey");
CREATE INDEX "IX_MANUAL_REFUND_CreatedByUserId" ON "public"."MANUAL_REFUND" ("CreatedByUserId");
CREATE UNIQUE INDEX "UX_MANUAL_REFUND_EvidenceOperationKey" ON "public"."MANUAL_REFUND" ("EvidenceOperationKey") WHERE "EvidenceOperationKey" IS NOT NULL;
CREATE INDEX "IX_MANUAL_REFUND_PaymentId" ON "public"."MANUAL_REFUND" ("PaymentId");
CREATE INDEX "IX_MANUAL_REFUND_SubmittedByUserId" ON "public"."MANUAL_REFUND" ("SubmittedByUserId");
CREATE UNIQUE INDEX "UX_MANUAL_REFUND_VerificationOperationKey" ON "public"."MANUAL_REFUND" ("VerificationOperationKey") WHERE "VerificationOperationKey" IS NOT NULL;
CREATE INDEX "IX_MANUAL_REFUND_VerifiedByUserId" ON "public"."MANUAL_REFUND" ("VerifiedByUserId");
CREATE INDEX "IX_MANUAL_REFUND_SalesOrderId_Status" ON "public"."MANUAL_REFUND" ("SalesOrderId", "Status");
CREATE INDEX "IX_MANUAL_REFUND_FinancialAdjustmentId" ON "public"."MANUAL_REFUND" ("FinancialAdjustmentId");
CREATE INDEX "IX_MAP_DISTANCE_CACHE_DestinationLocationId" ON "public"."MAP_DISTANCE_CACHE" ("DestinationLocationId");
CREATE INDEX "IX_MAP_DISTANCE_CACHE_OriginLocationId" ON "public"."MAP_DISTANCE_CACHE" ("OriginLocationId");
CREATE INDEX "IX_MAP_DISTANCE_CACHE_RetailerId" ON "public"."MAP_DISTANCE_CACHE" ("RetailerId");
CREATE UNIQUE INDEX "UX_MAP_DISTANCE_CACHE_WarehouseId_RetailerId" ON "public"."MAP_DISTANCE_CACHE" ("WarehouseId", "RetailerId") WHERE "IsActive" = TRUE;
CREATE UNIQUE INDEX "UX_MAP_DISTANCE_CACHE_WarehouseId_RetailerId_Version" ON "public"."MAP_DISTANCE_CACHE" ("WarehouseId", "RetailerId", "Version");
CREATE UNIQUE INDEX "UX_MAP_LOCATION_RetailerId" ON "public"."MAP_LOCATION" ("RetailerId");
CREATE UNIQUE INDEX "UX_MAP_LOCATION_WarehouseId" ON "public"."MAP_LOCATION" ("WarehouseId");
CREATE INDEX "IX_NOTIFICATION_OutboxMessageId" ON "public"."NOTIFICATION" ("OutboxMessageId");
CREATE INDEX "IX_NOTIFICATION_SalesOrderId" ON "public"."NOTIFICATION" ("SalesOrderId");
CREATE UNIQUE INDEX "UX_NOTIFICATION_UserAccountId_OutboxMessageId" ON "public"."NOTIFICATION" ("UserAccountId", "OutboxMessageId") WHERE "OutboxMessageId" IS NOT NULL;
CREATE INDEX "IX_NOTIFICATION_UserAccountId_IsRead_CreatedAt" ON "public"."NOTIFICATION" ("UserAccountId", "IsRead", "CreatedAt");
CREATE INDEX "IX_ORDER_PROMOTION_PromotionId" ON "public"."ORDER_PROMOTION" ("PromotionId");
CREATE INDEX "IX_ORDER_PROMOTION_SalesOrderLineId" ON "public"."ORDER_PROMOTION" ("SalesOrderLineId");
CREATE INDEX "IX_ORDER_STATUS_HISTORY_ChangedByUserId" ON "public"."ORDER_STATUS_HISTORY" ("ChangedByUserId");
CREATE INDEX "IX_ORDER_STATUS_HISTORY_SalesOrderId" ON "public"."ORDER_STATUS_HISTORY" ("SalesOrderId");
CREATE INDEX "IX_PAYMENT_ConfirmedByUserId" ON "public"."PAYMENT" ("ConfirmedByUserId");
CREATE UNIQUE INDEX "UX_PAYMENT_OperationKey" ON "public"."PAYMENT" ("OperationKey") WHERE "OperationKey" IS NOT NULL;
CREATE UNIQUE INDEX "UX_PAYMENT_SalesOrderId" ON "public"."PAYMENT" ("SalesOrderId");
CREATE INDEX "IX_PAYMENT_Status_DueDate" ON "public"."PAYMENT" ("Status", "DueDate");
CREATE INDEX "IX_PAYMENT_AllocationPlanVersionId" ON "public"."PAYMENT" ("AllocationPlanVersionId");
CREATE INDEX "IX_PRODUCT_ProductCategoryId" ON "public"."PRODUCT" ("ProductCategoryId");
CREATE UNIQUE INDEX "UX_PRODUCT_ReplacesProductId" ON "public"."PRODUCT" ("ReplacesProductId");
CREATE UNIQUE INDEX "UX_PRODUCT_Sku" ON "public"."PRODUCT" ("Sku");
CREATE UNIQUE INDEX "UX_PRODUCT_CATEGORY_Code" ON "public"."PRODUCT_CATEGORY" ("Code");
CREATE INDEX "IX_PRODUCT_CATEGORY_ParentCategoryId" ON "public"."PRODUCT_CATEGORY" ("ParentCategoryId");
CREATE UNIQUE INDEX "UX_PRODUCT_PRICE_ProductId" ON "public"."PRODUCT_PRICE" ("ProductId") WHERE "IsActive" = TRUE;
CREATE UNIQUE INDEX "UX_PROMOTION_Code" ON "public"."PROMOTION" ("Code");
CREATE INDEX "IX_PROMOTION_CreatedByUserId" ON "public"."PROMOTION" ("CreatedByUserId");
CREATE INDEX "IX_PROMOTION_CATEGORY_ProductCategoryId" ON "public"."PROMOTION_CATEGORY" ("ProductCategoryId");
CREATE UNIQUE INDEX "UX_PROMOTION_CATEGORY_PromotionId_ProductCategoryId" ON "public"."PROMOTION_CATEGORY" ("PromotionId", "ProductCategoryId");
CREATE INDEX "IX_PROMOTION_PRODUCT_ProductId" ON "public"."PROMOTION_PRODUCT" ("ProductId");
CREATE UNIQUE INDEX "UX_PROMOTION_PRODUCT_PromotionId_ProductId" ON "public"."PROMOTION_PRODUCT" ("PromotionId", "ProductId");
CREATE INDEX "IX_PROMOTION_RETAILER_RetailerId" ON "public"."PROMOTION_RETAILER" ("RetailerId");
CREATE UNIQUE INDEX "UX_PROMOTION_RETAILER_PromotionId_RetailerId" ON "public"."PROMOTION_RETAILER" ("PromotionId", "RetailerId");
CREATE UNIQUE INDEX "UX_PURCHASE_ORDER_PurchaseOrderCode" ON "public"."PURCHASE_ORDER" ("PurchaseOrderCode");
CREATE UNIQUE INDEX "UX_PURCHASE_ORDER_SalesOrderQuoteId" ON "public"."PURCHASE_ORDER" ("SalesOrderQuoteId");
CREATE INDEX "IX_PURCHASE_ORDER_SalesOrderId" ON "public"."PURCHASE_ORDER" ("SalesOrderId");
CREATE INDEX "IX_PURCHASE_ORDER_IssuedByUserId" ON "public"."PURCHASE_ORDER" ("IssuedByUserId");
CREATE UNIQUE INDEX "UX_QR_LABEL_EVENT_OperationKey" ON "public"."QR_LABEL_EVENT" ("OperationKey");
CREATE INDEX "IX_QR_LABEL_EVENT_PerformedByUserId" ON "public"."QR_LABEL_EVENT" ("PerformedByUserId");
CREATE INDEX "IX_QR_LABEL_EVENT_WarehouseId" ON "public"."QR_LABEL_EVENT" ("WarehouseId");
CREATE INDEX "IX_QR_LABEL_EVENT_BatchQrLabelId_OccurredAt" ON "public"."QR_LABEL_EVENT" ("BatchQrLabelId", "OccurredAt");
CREATE INDEX "IX_RECEIPT_CONFIRMATION_ConfirmedByRetailerUserId" ON "public"."RECEIPT_CONFIRMATION" ("ConfirmedByRetailerUserId");
CREATE UNIQUE INDEX "UX_RECEIPT_CONFIRMATION_OperationKey" ON "public"."RECEIPT_CONFIRMATION" ("OperationKey");
CREATE INDEX "IX_RECEIPT_CONFIRMATION_SalesOrderId" ON "public"."RECEIPT_CONFIRMATION" ("SalesOrderId");
CREATE UNIQUE INDEX "UX_RECEIPT_CONFIRMATION_ShipmentId" ON "public"."RECEIPT_CONFIRMATION" ("ShipmentId") WHERE "ShipmentId" IS NOT NULL;
CREATE INDEX "IX_RECEIPT_CONFIRMATION_ITEM_BatchId" ON "public"."RECEIPT_CONFIRMATION_ITEM" ("BatchId");
CREATE INDEX "IX_RECEIPT_CONFIRMATION_ITEM_BatchQrLabelId" ON "public"."RECEIPT_CONFIRMATION_ITEM" ("BatchQrLabelId");
CREATE INDEX "IX_RECEIPT_CONFIRMATION_ITEM_SalesOrderLineId" ON "public"."RECEIPT_CONFIRMATION_ITEM" ("SalesOrderLineId");
CREATE UNIQUE INDEX "UX_RECEIPT_CONFIRMATION_ITEM_ReceiptConfirmationId_Sal_c42282bc" ON "public"."RECEIPT_CONFIRMATION_ITEM" ("ReceiptConfirmationId", "SalesOrderLineId", "BatchId") WHERE "SalesOrderLineId" IS NOT NULL;
CREATE UNIQUE INDEX "UX_RECEIPT_CONFIRMATION_QR_LABEL_BatchQrLabelId" ON "public"."RECEIPT_CONFIRMATION_QR_LABEL" ("BatchQrLabelId");
CREATE UNIQUE INDEX "UX_RECEIPT_CONFIRMATION_QR_LABEL_ReceiptConfirmationId_fa5f8b28" ON "public"."RECEIPT_CONFIRMATION_QR_LABEL" ("ReceiptConfirmationId", "BatchQrLabelId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ReceiptConfirmationId" ON "public"."RECEIPT_DISCREPANCY" ("ReceiptConfirmationId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ReportedByRetailerUserId" ON "public"."RECEIPT_DISCREPANCY" ("ReportedByRetailerUserId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ReviewedByUserId" ON "public"."RECEIPT_DISCREPANCY" ("ReviewedByUserId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_SalesOrderId" ON "public"."RECEIPT_DISCREPANCY" ("SalesOrderId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ITEM_BatchId" ON "public"."RECEIPT_DISCREPANCY_ITEM" ("BatchId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ITEM_ReceiptDiscrepancyId" ON "public"."RECEIPT_DISCREPANCY_ITEM" ("ReceiptDiscrepancyId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ITEM_ShipmentId" ON "public"."RECEIPT_DISCREPANCY_ITEM" ("ShipmentId");
CREATE INDEX "IX_RECEIPT_DISCREPANCY_ITEM_AllocationPlanPriceId" ON "public"."RECEIPT_DISCREPANCY_ITEM" ("AllocationPlanPriceId");
CREATE INDEX "IX_REFRESH_TOKEN_ReplacedByTokenId" ON "public"."REFRESH_TOKEN" ("ReplacedByTokenId");
CREATE UNIQUE INDEX "UX_REFRESH_TOKEN_TokenHash" ON "public"."REFRESH_TOKEN" ("TokenHash");
CREATE INDEX "IX_REFRESH_TOKEN_UserAccountId_ExpiresAt" ON "public"."REFRESH_TOKEN" ("UserAccountId", "ExpiresAt");
CREATE UNIQUE INDEX "UX_REGION_Code" ON "public"."REGION" ("Code");
CREATE UNIQUE INDEX "UX_RESERVATION_AllocationRunAllocationId" ON "public"."RESERVATION" ("AllocationRunAllocationId") WHERE "AllocationRunAllocationId" IS NOT NULL;
CREATE INDEX "IX_RESERVATION_BatchId" ON "public"."RESERVATION" ("BatchId");
CREATE INDEX "IX_RETAILER_AssessedByUserId" ON "public"."RETAILER" ("AssessedByUserId");
CREATE UNIQUE INDEX "UX_RETAILER_Code" ON "public"."RETAILER" ("Code");
CREATE INDEX "IX_RETAILER_DeclaredByUserId" ON "public"."RETAILER" ("DeclaredByUserId");
CREATE INDEX "IX_RETAILER_RegionId" ON "public"."RETAILER" ("RegionId");
CREATE INDEX "IX_RETAILER_ReviewedByUserId" ON "public"."RETAILER" ("ReviewedByUserId");
CREATE UNIQUE INDEX "UX_RETAILER_UserAccountId" ON "public"."RETAILER" ("UserAccountId");
CREATE UNIQUE INDEX "UX_RETAILER_LOYALTY_RetailerId" ON "public"."RETAILER_LOYALTY" ("RetailerId");
CREATE INDEX "IX_RETAILER_PRODUCT_MLOR_ProductCategoryId" ON "public"."RETAILER_PRODUCT_MLOR" ("ProductCategoryId");
CREATE INDEX "IX_RETAILER_PRODUCT_MLOR_ProductId" ON "public"."RETAILER_PRODUCT_MLOR" ("ProductId");
CREATE INDEX "IX_RETAILER_PRODUCT_MLOR_UpdatedByUserId" ON "public"."RETAILER_PRODUCT_MLOR" ("UpdatedByUserId");
CREATE UNIQUE INDEX "UX_RETAILER_PRODUCT_MLOR_RetailerId_ProductCategoryId" ON "public"."RETAILER_PRODUCT_MLOR" ("RetailerId", "ProductCategoryId") WHERE "IsActive" = TRUE AND "ProductCategoryId" IS NOT NULL;
CREATE UNIQUE INDEX "UX_RETAILER_PRODUCT_MLOR_RetailerId_ProductId" ON "public"."RETAILER_PRODUCT_MLOR" ("RetailerId", "ProductId") WHERE "IsActive" = TRUE AND "ProductId" IS NOT NULL;
CREATE INDEX "IX_RETAILER_PRODUCT_MLOR_RetailerId_Version" ON "public"."RETAILER_PRODUCT_MLOR" ("RetailerId", "Version");
CREATE UNIQUE INDEX "UX_RETAILER_SALES_ASSIGNMENT_RetailerId" ON "public"."RETAILER_SALES_ASSIGNMENT" ("RetailerId") WHERE "IsActive" = TRUE;
CREATE INDEX "IX_RETAILER_SALES_ASSIGNMENT_SalesGroupId_AssignedAt" ON "public"."RETAILER_SALES_ASSIGNMENT" ("SalesGroupId", "AssignedAt");
CREATE INDEX "IX_REWARD_REDEMPTION_LoyaltyRewardId" ON "public"."REWARD_REDEMPTION" ("LoyaltyRewardId");
CREATE UNIQUE INDEX "UX_REWARD_REDEMPTION_LoyaltyTransactionId" ON "public"."REWARD_REDEMPTION" ("LoyaltyTransactionId");
CREATE INDEX "IX_REWARD_REDEMPTION_RedeemedByUserId" ON "public"."REWARD_REDEMPTION" ("RedeemedByUserId");
CREATE INDEX "IX_REWARD_REDEMPTION_SalesOrderId" ON "public"."REWARD_REDEMPTION" ("SalesOrderId");
CREATE UNIQUE INDEX "UX_REWARD_REDEMPTION_RetailerId_ClientRequestId" ON "public"."REWARD_REDEMPTION" ("RetailerId", "ClientRequestId");
CREATE INDEX "IX_REWARD_REDEMPTION_ApprovedByUserId" ON "public"."REWARD_REDEMPTION" ("ApprovedByUserId");
CREATE INDEX "IX_REWARD_REDEMPTION_DeliveredByUserId" ON "public"."REWARD_REDEMPTION" ("DeliveredByUserId");
CREATE INDEX "IX_REWARD_REDEMPTION_CompletedByUserId" ON "public"."REWARD_REDEMPTION" ("CompletedByUserId");
CREATE INDEX "IX_RUN_PICKING_GATHER_BatchId" ON "public"."RUN_PICKING_GATHER" ("BatchId");
CREATE UNIQUE INDEX "UX_RUN_PICKING_GATHER_RunPickingListId_BatchId" ON "public"."RUN_PICKING_GATHER" ("RunPickingListId", "BatchId");
CREATE INDEX "IX_RUN_PICKING_GATHER_ProductId" ON "public"."RUN_PICKING_GATHER" ("ProductId");
CREATE INDEX "IX_RUN_PICKING_LIST_AllocationPlanVersionId" ON "public"."RUN_PICKING_LIST" ("AllocationPlanVersionId");
CREATE INDEX "IX_RUN_PICKING_LIST_CompletedByUserId" ON "public"."RUN_PICKING_LIST" ("CompletedByUserId");
CREATE UNIQUE INDEX "UX_RUN_PICKING_LIST_PickingCode" ON "public"."RUN_PICKING_LIST" ("PickingCode");
CREATE INDEX "IX_RUN_PICKING_LIST_WarehouseId" ON "public"."RUN_PICKING_LIST" ("WarehouseId");
CREATE UNIQUE INDEX "UX_RUN_PICKING_LIST_AllocationRunId_WarehouseId" ON "public"."RUN_PICKING_LIST" ("AllocationRunId", "WarehouseId");
CREATE INDEX "IX_RUN_PICKING_LIST_AssignedToUserId" ON "public"."RUN_PICKING_LIST" ("AssignedToUserId");
CREATE INDEX "IX_RUN_PICKING_SPLIT_AllocationPlanPriceId" ON "public"."RUN_PICKING_SPLIT" ("AllocationPlanPriceId");
CREATE UNIQUE INDEX "UX_RUN_PICKING_SPLIT_AllocationRunAllocationId" ON "public"."RUN_PICKING_SPLIT" ("AllocationRunAllocationId");
CREATE INDEX "IX_RUN_PICKING_SPLIT_RunPickingGatherId" ON "public"."RUN_PICKING_SPLIT" ("RunPickingGatherId");
CREATE INDEX "IX_RUN_PICKING_SPLIT_SalesOrderId" ON "public"."RUN_PICKING_SPLIT" ("SalesOrderId");
CREATE INDEX "IX_RUN_PICKING_SPLIT_SalesOrderLineId" ON "public"."RUN_PICKING_SPLIT" ("SalesOrderLineId");
CREATE INDEX "IX_RUN_PICKING_SPLIT_AllocationRunLineId" ON "public"."RUN_PICKING_SPLIT" ("AllocationRunLineId");
CREATE UNIQUE INDEX "UX_SALES_GROUP_Code" ON "public"."SALES_GROUP" ("Code");
CREATE INDEX "IX_SALES_GROUP_RegionId" ON "public"."SALES_GROUP" ("RegionId");
CREATE UNIQUE INDEX "UX_SALES_GROUP_MEMBER_UserAccountId" ON "public"."SALES_GROUP_MEMBER" ("UserAccountId") WHERE "IsActive" = TRUE;
CREATE INDEX "IX_SALES_GROUP_MEMBER_SalesGroupId_AssignedAt" ON "public"."SALES_GROUP_MEMBER" ("SalesGroupId", "AssignedAt");
CREATE UNIQUE INDEX "UX_SALES_ORDER_ClientOrderKey" ON "public"."SALES_ORDER" ("ClientOrderKey");
CREATE UNIQUE INDEX "UX_SALES_ORDER_OrderCode" ON "public"."SALES_ORDER" ("OrderCode");
CREATE INDEX "IX_SALES_ORDER_RetailerId" ON "public"."SALES_ORDER" ("RetailerId");
CREATE INDEX "IX_SALES_ORDER_ReviewedByUserId" ON "public"."SALES_ORDER" ("ReviewedByUserId");
CREATE INDEX "IX_SALES_ORDER_SalesGroupId" ON "public"."SALES_ORDER" ("SalesGroupId");
CREATE INDEX "IX_SALES_ORDER_CreatedByUserId_ServerReceivedAt" ON "public"."SALES_ORDER" ("CreatedByUserId", "ServerReceivedAt");
CREATE INDEX "IX_SALES_ORDER_ATTACHMENT_SalesOrderId" ON "public"."SALES_ORDER_ATTACHMENT" ("SalesOrderId");
CREATE INDEX "IX_SALES_ORDER_ATTACHMENT_UploadedByUserId" ON "public"."SALES_ORDER_ATTACHMENT" ("UploadedByUserId");
CREATE INDEX "IX_SALES_ORDER_LINE_MlorProductCategoryId" ON "public"."SALES_ORDER_LINE" ("MlorProductCategoryId");
CREATE INDEX "IX_SALES_ORDER_LINE_MlorSourceRuleId" ON "public"."SALES_ORDER_LINE" ("MlorSourceRuleId");
CREATE INDEX "IX_SALES_ORDER_LINE_ProductId" ON "public"."SALES_ORDER_LINE" ("ProductId");
CREATE INDEX "IX_SALES_ORDER_LINE_ProductPriceId" ON "public"."SALES_ORDER_LINE" ("ProductPriceId");
CREATE UNIQUE INDEX "UX_SALES_ORDER_LINE_SalesOrderId_LineNumber" ON "public"."SALES_ORDER_LINE" ("SalesOrderId", "LineNumber");
CREATE INDEX "IX_SALES_ORDER_LINE_NearExpiryOfferId_OfferVersion" ON "public"."SALES_ORDER_LINE" ("NearExpiryOfferId", "OfferVersion");
CREATE INDEX "IX_SALES_ORDER_LINE_OfferAcceptedByUserId" ON "public"."SALES_ORDER_LINE" ("OfferAcceptedByUserId");
CREATE INDEX "IX_SALES_ORDER_QUOTE_AllocationPlanVersionId_Status" ON "public"."SALES_ORDER_QUOTE" ("AllocationPlanVersionId", "Status");
CREATE UNIQUE INDEX "UX_SALES_ORDER_QUOTE_SalesOrderId_RevisionNumber" ON "public"."SALES_ORDER_QUOTE" ("SalesOrderId", "RevisionNumber");
CREATE INDEX "IX_SALES_ORDER_QUOTE_AllocationRunId" ON "public"."SALES_ORDER_QUOTE" ("AllocationRunId");
CREATE INDEX "IX_SALES_ORDER_QUOTE_AcceptedByUserId" ON "public"."SALES_ORDER_QUOTE" ("AcceptedByUserId");
CREATE INDEX "IX_SHELF_LIFE_DISCOUNT_TABLE_CreatedByUserId" ON "public"."SHELF_LIFE_DISCOUNT_TABLE" ("CreatedByUserId");
CREATE UNIQUE INDEX "UX_SHELF_LIFE_DISCOUNT_TABLE_IsActive" ON "public"."SHELF_LIFE_DISCOUNT_TABLE" ("IsActive") WHERE "IsActive" = TRUE;
CREATE UNIQUE INDEX "UX_SHELF_LIFE_DISCOUNT_TABLE_Version" ON "public"."SHELF_LIFE_DISCOUNT_TABLE" ("Version");
CREATE INDEX "IX_SHELF_LIFE_DISCOUNT_TIER_ProductCategoryId" ON "public"."SHELF_LIFE_DISCOUNT_TIER" ("ProductCategoryId");
CREATE INDEX "IX_SHELF_LIFE_DISCOUNT_TIER_ProductId" ON "public"."SHELF_LIFE_DISCOUNT_TIER" ("ProductId");
CREATE INDEX "IX_SHELF_LIFE_DISCOUNT_TIER_ShelfLifeDiscountTableId_S_cc77202d" ON "public"."SHELF_LIFE_DISCOUNT_TIER" ("ShelfLifeDiscountTableId", "Scope", "ProductId", "MinRemainingPercent");
CREATE INDEX "IX_SHIPMENT_DriverId" ON "public"."SHIPMENT" ("DriverId");
CREATE INDEX "IX_SHIPMENT_RunPickingListId" ON "public"."SHIPMENT" ("RunPickingListId");
CREATE UNIQUE INDEX "UX_SHIPMENT_ShipmentCode" ON "public"."SHIPMENT" ("ShipmentCode");
CREATE INDEX "IX_SHIPMENT_VehicleId" ON "public"."SHIPMENT" ("VehicleId");
CREATE INDEX "IX_SHIPMENT_WarehouseId" ON "public"."SHIPMENT" ("WarehouseId");
CREATE UNIQUE INDEX "UX_SHIPMENT_SalesOrderId_WarehouseId" ON "public"."SHIPMENT" ("SalesOrderId", "WarehouseId");
CREATE UNIQUE INDEX "UX_SYSTEM_CONFIGURATION_ConfigKey" ON "public"."SYSTEM_CONFIGURATION" ("ConfigKey") WHERE "IsActive" = TRUE;
CREATE INDEX "IX_SYSTEM_CONFIGURATION_UpdatedByUserId" ON "public"."SYSTEM_CONFIGURATION" ("UpdatedByUserId");
CREATE UNIQUE INDEX "UX_SYSTEM_CONFIGURATION_ConfigKey_Version" ON "public"."SYSTEM_CONFIGURATION" ("ConfigKey", "Version");
CREATE INDEX "IX_TRANSIT_TABLE_CreatedByUserId" ON "public"."TRANSIT_TABLE" ("CreatedByUserId");
CREATE UNIQUE INDEX "UX_TRANSIT_TABLE_IsActive" ON "public"."TRANSIT_TABLE" ("IsActive") WHERE "IsActive" = TRUE;
CREATE UNIQUE INDEX "UX_TRANSIT_TABLE_Version" ON "public"."TRANSIT_TABLE" ("Version");
CREATE UNIQUE INDEX "UX_TRANSIT_TABLE_BAND_TransitTableId_MinDistanceMeters" ON "public"."TRANSIT_TABLE_BAND" ("TransitTableId", "MinDistanceMeters");
CREATE UNIQUE INDEX "UX_USER_ACCOUNT_Email" ON "public"."USER_ACCOUNT" ("Email");
CREATE UNIQUE INDEX "UX_USER_ACCOUNT_EntraObjectId" ON "public"."USER_ACCOUNT" ("EntraObjectId") WHERE "EntraObjectId" IS NOT NULL;
CREATE UNIQUE INDEX "UX_USER_CREDENTIAL_UserAccountId" ON "public"."USER_CREDENTIAL" ("UserAccountId");
CREATE INDEX "IX_USER_REGION_ASSIGNMENT_RegionId_IsActive" ON "public"."USER_REGION_ASSIGNMENT" ("RegionId", "IsActive");
CREATE UNIQUE INDEX "UX_USER_REGION_ASSIGNMENT_UserAccountId_RegionId" ON "public"."USER_REGION_ASSIGNMENT" ("UserAccountId", "RegionId");
CREATE INDEX "IX_USER_WAREHOUSE_ASSIGNMENT_UserAccountId" ON "public"."USER_WAREHOUSE_ASSIGNMENT" ("UserAccountId");
CREATE INDEX "IX_USER_WAREHOUSE_ASSIGNMENT_WarehouseId" ON "public"."USER_WAREHOUSE_ASSIGNMENT" ("WarehouseId");
CREATE UNIQUE INDEX "UX_VEHICLE_PlateNumber" ON "public"."VEHICLE" ("PlateNumber");
CREATE INDEX "IX_VEHICLE_WarehouseId" ON "public"."VEHICLE" ("WarehouseId");
CREATE UNIQUE INDEX "UX_WAREHOUSE_Code" ON "public"."WAREHOUSE" ("Code");
CREATE INDEX "IX_WRITE_OFF_CreatedByUserId" ON "public"."WRITE_OFF" ("CreatedByUserId");
CREATE INDEX "IX_WRITE_OFF_WarehouseId" ON "public"."WRITE_OFF" ("WarehouseId");
CREATE UNIQUE INDEX "UX_WRITE_OFF_WriteOffCode" ON "public"."WRITE_OFF" ("WriteOffCode");
CREATE INDEX "IX_WRITE_OFF_ApprovedByUserId" ON "public"."WRITE_OFF" ("ApprovedByUserId");
CREATE INDEX "IX_WRITE_OFF_ATTACHMENT_UploadedByUserId" ON "public"."WRITE_OFF_ATTACHMENT" ("UploadedByUserId");
CREATE INDEX "IX_WRITE_OFF_ATTACHMENT_WriteOffId" ON "public"."WRITE_OFF_ATTACHMENT" ("WriteOffId");
CREATE INDEX "IX_WRITE_OFF_ITEM_BatchId" ON "public"."WRITE_OFF_ITEM" ("BatchId");
CREATE INDEX "IX_WRITE_OFF_ITEM_WriteOffId" ON "public"."WRITE_OFF_ITEM" ("WriteOffId");
CREATE UNIQUE INDEX "UX_FINANCIAL_ADJUSTMENT_OperationKey" ON "public"."FINANCIAL_ADJUSTMENT" ("OperationKey");
CREATE INDEX "IX_FINANCIAL_ADJUSTMENT_ReceiptDiscrepancyItemId_ApprovedAt" ON "public"."FINANCIAL_ADJUSTMENT" ("ReceiptDiscrepancyItemId", "ApprovedAt");
CREATE INDEX "IX_FINANCIAL_ADJUSTMENT_PaymentId" ON "public"."FINANCIAL_ADJUSTMENT" ("PaymentId");
CREATE INDEX "IX_FINANCIAL_ADJUSTMENT_ShipmentId" ON "public"."FINANCIAL_ADJUSTMENT" ("ShipmentId");
CREATE INDEX "IX_FINANCIAL_ADJUSTMENT_AllocationPlanPriceId" ON "public"."FINANCIAL_ADJUSTMENT" ("AllocationPlanPriceId");
CREATE INDEX "IX_FINANCIAL_ADJUSTMENT_ApprovedByUserId" ON "public"."FINANCIAL_ADJUSTMENT" ("ApprovedByUserId");
CREATE UNIQUE INDEX "UX_NEAR_EXPIRY_OFFER_OfferCode_VersionNumber" ON "public"."NEAR_EXPIRY_OFFER" ("OfferCode", "VersionNumber");
CREATE INDEX "IX_NEAR_EXPIRY_OFFER_Status_StartAt_EndAt" ON "public"."NEAR_EXPIRY_OFFER" ("Status", "StartAt", "EndAt");
CREATE UNIQUE INDEX "UX_NEAR_EXPIRY_OFFER_Id_VersionNumber" ON "public"."NEAR_EXPIRY_OFFER" ("Id", "VersionNumber");
CREATE INDEX "IX_NEAR_EXPIRY_OFFER_ProductId" ON "public"."NEAR_EXPIRY_OFFER" ("ProductId");
CREATE INDEX "IX_NEAR_EXPIRY_OFFER_ApprovedByUserId" ON "public"."NEAR_EXPIRY_OFFER" ("ApprovedByUserId");

COMMIT;

