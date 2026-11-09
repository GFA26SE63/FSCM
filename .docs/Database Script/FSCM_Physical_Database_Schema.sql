-- ============================================================================
-- FSCM | ALL-IN-ONE POSTGRESQL DATABASE SCHEMA (RECONSTRUCTED FROM GRAPHML)
-- ============================================================================
-- Contains: 89 CREATE TABLE, 195 FOREIGN KEY constraints, 195 suggested indexes.
-- For an EMPTY testing database only. NO data INSERTs are included.
--
-- DBeaver usage (IMPORTANT):
--   1) Create an EMPTY database using DBeaver's Create Database UI, naming it
--      fscm_reconstructed (or your own chosen name).
--      Alternatively, execute the following ONE statement ONCE while connected
--      to the maintenance DB (e.g. postgres), then switch connections:
--
--      CREATE DATABASE fscm_reconstructed ENCODING 'UTF8' TEMPLATE template0;
--
--   2) Open a SQL editor CONNECTED TO THE NEW DATABASE.
--   3) Copy/paste this WHOLE SQL file and execute it as a script.
--
-- Why isn't CREATE DATABASE an executable statement in this script?
-- PostgreSQL does not provide a normal SQL USE/CONNECT command. DBeaver cannot
-- execute CREATE DATABASE, switch to it, and run CREATE TABLE in one standard
-- PostgreSQL SQL script. If CREATE DATABASE were run first without switching,
-- the tables would be created in the WRONG database. The commented command
-- above is deliberately separated for safety.
--
-- IMPORTANT LIMITATION: This is NOT an exact backup of your live database.
-- DBeaver GraphML does not include real PostgreSQL types, nullability, defaults,
-- indexes, uniqueness, check constraints, FK column mappings, or delete actions.
-- Types and primary keys here are INFERRED. Indexes here are SUGGESTIONS.
-- Do NOT run against the existing/prod FSCM database. Do NOT apply EF Core
-- migrations to this reconstruction until migration history is reconciled.
-- All names are quoted to preserve the export's case-sensitive identifiers.
--
-- Source: postgres - postgres - public(2).graphml
-- ============================================================================

BEGIN;
SET search_path TO public;

-- Prevent accidental execution on an existing FSCM schema. A failure here
-- rolls back the whole script without modifying tables.
DO $$
BEGIN
    IF to_regclass('public."SALES_ORDER"') IS NOT NULL
       OR to_regclass('public."USER_ACCOUNT"') IS NOT NULL
       OR to_regclass('public."BATCH"') IS NOT NULL
    THEN
        RAISE EXCEPTION 'FSCM tables already exist here. Run this script only on a NEW EMPTY database.';
    END IF;
END
$$;

-- ============================================================
-- PHASE 1: Create all tables before adding foreign keys
-- ============================================================
CREATE TABLE public."ACCOUNT_TOKEN" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "Purpose" TEXT,
    "TokenHash" TEXT,
    "ExpiresAt" TIMESTAMPTZ,
    "ConsumedAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_account_token" PRIMARY KEY ("Id")
);

CREATE TABLE public."COMPLAINT_EVIDENCE" (
    "Id" UUID NOT NULL,
    "ReceiptDiscrepancyId" UUID,
    "UploadedByUserId" UUID,
    "FileName" TEXT,
    "ContentType" TEXT,
    "BlobKey" TEXT,
    "UploadedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_complaint_evidence" PRIMARY KEY ("Id")
);

CREATE TABLE public."LOYALTY_PROGRAM_RETAILER" (
    "Id" UUID NOT NULL,
    "LoyaltyProgramId" UUID,
    "RetailerId" UUID,
    CONSTRAINT "pk_loyalty_program_retailer" PRIMARY KEY ("Id")
);

CREATE TABLE public."PAYMENT_RECEIPT" (
    "Id" UUID NOT NULL,
    "ReceiptCode" TEXT,
    "RetailerId" UUID,
    "ReceivedAmount" NUMERIC(18,2),
    "UnappliedCreditAmount" NUMERIC(18,2),
    "Status" TEXT,
    "Reference" TEXT,
    "Note" TEXT,
    "ConfirmedByUserId" UUID,
    "ConfirmedAt" TIMESTAMPTZ,
    "ReversedByUserId" UUID,
    "ReversedAt" TIMESTAMPTZ,
    "ReversalReason" TEXT,
    "OperationKey" TEXT,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_payment_receipt" PRIMARY KEY ("Id")
);

CREATE TABLE public."PAYMENT_RECEIPT_ALLOCATION" (
    "Id" UUID NOT NULL,
    "PaymentReceiptId" UUID,
    "PaymentId" UUID,
    "Amount" NUMERIC(18,2),
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_payment_receipt_allocation" PRIMARY KEY ("Id")
);

CREATE TABLE public."PURCHASE_ORDER" (
    "Id" UUID NOT NULL,
    "PurchaseOrderCode" TEXT,
    "SalesOrderId" UUID,
    "SalesOrderQuoteId" UUID,
    "Status" TEXT,
    "PaymentMethod" TEXT,
    "IssuedAt" TIMESTAMPTZ,
    "IssuedByUserId" UUID,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_purchase_order" PRIMARY KEY ("Id")
);

CREATE TABLE public."REPLACEMENT_CASE" (
    "Id" UUID NOT NULL,
    "ReceiptDiscrepancyId" UUID,
    "WarehouseId" UUID,
    "Status" TEXT,
    "ApprovedAt" TIMESTAMPTZ,
    "ShippedAt" TIMESTAMPTZ,
    "ReceivedAt" TIMESTAMPTZ,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_replacement_case" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER_ACTIVATION_CHALLENGE" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "OtpHash" TEXT,
    "SetupTokenHash" TEXT,
    "RequestedIpAddress" VARCHAR(64),
    "FailedAttemptCount" BIGINT,
    "ExpiresAt" TIMESTAMPTZ,
    "VerifiedAt" TIMESTAMPTZ,
    "SetupTokenExpiresAt" TIMESTAMPTZ,
    "ConsumedAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_retailer_activation_challenge" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER_DECLARATION_CONTACT" (
    "RetailerId" UUID NOT NULL,
    "ContactName" TEXT,
    "Phone" VARCHAR(64),
    "Email" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_retailer_declaration_contact" PRIMARY KEY ("RetailerId")
);

CREATE TABLE public."SALES_ORDER_QUOTE" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "AllocationRunId" UUID,
    "RevisionNumber" INTEGER,
    "Status" TEXT,
    "TotalAmount" NUMERIC(18,2),
    "IssuedAt" TIMESTAMPTZ,
    "ExpiresAt" TIMESTAMPTZ,
    "AcceptedByUserId" UUID,
    "AcceptedAt" TIMESTAMPTZ,
    "RejectionReason" TEXT,
    "PurchaseOrderId" UUID,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_sales_order_quote" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION" (
    "Id" UUID NOT NULL,
    "SalesOrderLineId" UUID,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "AllocatedQuantity" BIGINT,
    "AllocationSequence" TEXT,
    "DistanceMeters" BIGINT,
    "EstimatedArrivalAt" TIMESTAMPTZ,
    "RemainingLifeHoursAtArrival" NUMERIC(18,6),
    "Status" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "CoverageScore" NUMERIC(18,6),
    "DiscountAmount" NUMERIC(18,2),
    "DiscountPercent" NUMERIC(18,6),
    "DiscountSourceCode" TEXT,
    "DiscountSourceType" TEXT,
    "DistanceScore" NUMERIC(18,6),
    "GrossAmount" NUMERIC(18,2),
    "NetAmount" NUMERIC(18,2),
    "PromotionId" UUID,
    "ShelfLifeScore" NUMERIC(18,6),
    "UnitPrice" NUMERIC(18,2),
    "WeightedScore" NUMERIC(18,6),
    "PostPromotionUnitPrice" NUMERIC(18,2),
    "PricedAt" TIMESTAMPTZ,
    "PricingExplanation" TEXT,
    "RemainingShelfLifePercent" NUMERIC(18,6),
    "ShelfLifeDiscountPerUnit" NUMERIC(18,2),
    "ShelfLifeDiscountTableVersion" BIGINT,
    "ShelfLifeDiscountTierId" UUID,
    "ShelfLifeDiscountType" TEXT,
    "ShelfLifeDiscountValue" NUMERIC(18,6),
    CONSTRAINT "pk_allocation" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_LINE_TRACE" (
    "Id" UUID NOT NULL,
    "AllocationRunId" UUID,
    "AllocationRunLineId" UUID,
    "Outcome" TEXT,
    "OrderedQuantity" BIGINT,
    "DrawnQuantity" BIGINT,
    "ShortageQuantity" BIGINT,
    "RequiredShelfLifeHours" NUMERIC(18,6),
    "ShelfLifeWeight" NUMERIC(18,6),
    "DistanceWeight" NUMERIC(18,6),
    "CoverageWeight" NUMERIC(18,6),
    "MaximumDistanceMeters" BIGINT,
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_line_trace" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_PLAN_PRICE" (
    "Id" UUID NOT NULL,
    "AllocationRunId" UUID,
    "AllocationRunLineId" UUID,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "Quantity" BIGINT,
    "BaseNetUnitPrice" NUMERIC(18,2),
    "RemainingShelfLifePercent" NUMERIC(18,6),
    "ShelfLifeDiscountTierId" UUID,
    "DiscountType" TEXT,
    "DiscountValue" NUMERIC(18,6),
    "ShelfLifeDiscountPerUnit" NUMERIC(18,2),
    "FinalNetUnitPrice" NUMERIC(18,2),
    "Amount" NUMERIC(18,2),
    "DiscountTableVersion" BIGINT,
    "Explanation" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "BatchExpiresAt" TIMESTAMPTZ,
    "ListUnitPrice" NUMERIC(18,2),
    "PricedAt" TIMESTAMPTZ,
    "TotalShelfLifeHours" NUMERIC(18,6),
    CONSTRAINT "pk_allocation_plan_price" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_RUN" (
    "Id" UUID NOT NULL,
    "RunCode" TEXT,
    "Status" TEXT,
    "AlgorithmSettings" JSONB,
    "AttemptNumber" INTEGER,
    "FailureReason" TEXT,
    "StartedAt" TIMESTAMPTZ,
    "SnapshotCompletedAt" TIMESTAMPTZ,
    "CompletedAt" TIMESTAMPTZ,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "RetryOfAllocationRunId" UUID,
    "SalesOrderId" UUID,
    "TechnicalErrorCode" TEXT,
    CONSTRAINT "pk_allocation_run" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_RUN_ALLOCATION" (
    "Id" UUID NOT NULL,
    "AllocationRunId" UUID,
    "AllocationRunLineId" UUID,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "Quantity" BIGINT,
    "Sequence" INTEGER,
    "EstimatedArrivalAt" TIMESTAMPTZ,
    "RemainingShelfLifeHours" NUMERIC(18,6),
    "WeightedScore" NUMERIC(18,6),
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_run_allocation" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_RUN_LINE" (
    "Id" UUID NOT NULL,
    "AllocationRunOrderId" UUID,
    "SalesOrderLineId" UUID,
    "ProductId" UUID,
    "SkuSnapshot" TEXT,
    "LineNumber" INTEGER,
    "OrderedQuantity" BIGINT,
    "TotalShelfLifeHours" NUMERIC(18,6),
    "EffectiveMlorRatio" NUMERIC(18,6),
    "MlorSource" TEXT,
    "BaseNetUnitPrice" NUMERIC(18,2),
    "AllocatedQuantity" BIGINT,
    "CreatedAt" TIMESTAMPTZ,
    "ListUnitPrice" NUMERIC(18,2),
    CONSTRAINT "pk_allocation_run_line" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_RUN_ORDER" (
    "Id" UUID NOT NULL,
    "AllocationRunId" UUID,
    "SalesOrderId" UUID,
    "OrderCodeSnapshot" TEXT,
    "RetailerId" UUID,
    "AcceptedAt" TIMESTAMPTZ,
    "DeliveryDeadline" TEXT,
    "PriorityRank" INTEGER,
    "Status" TEXT,
    "ShortageReason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_run_order" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_RUN_STOCK" (
    "Id" UUID NOT NULL,
    "AllocationRunId" UUID,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "ProductId" UUID,
    "ExpirationDate" DATE,
    "SnapshotQuantity" BIGINT,
    "RemainingQuantity" BIGINT,
    "InventoryVersion" BIGINT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_run_stock" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_TRACE_CANDIDATE" (
    "Id" UUID NOT NULL,
    "AllocationLineTraceId" UUID,
    "BatchId" UUID,
    "BatchCodeSnapshot" TEXT,
    "WarehouseId" UUID,
    "WarehouseCodeSnapshot" TEXT,
    "Stage" TEXT,
    "Passed" BOOLEAN,
    "Reason" TEXT,
    "EstimatedArrivalAt" TIMESTAMPTZ,
    "RemainingShelfLifeHours" NUMERIC(18,6),
    "RequiredShelfLifeHours" NUMERIC(18,6),
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_trace_candidate" PRIMARY KEY ("Id")
);

CREATE TABLE public."ALLOCATION_TRACE_SCORE" (
    "Id" UUID NOT NULL,
    "AllocationLineTraceId" UUID,
    "Iteration" INTEGER,
    "Rank" INTEGER,
    "BatchId" UUID,
    "BatchCodeSnapshot" TEXT,
    "WarehouseId" UUID,
    "WarehouseCodeSnapshot" TEXT,
    "RemainingDemand" BIGINT,
    "ShelfLifeScore" NUMERIC(18,6),
    "DistanceScore" NUMERIC(18,6),
    "CoverageScore" NUMERIC(18,6),
    "WeightedScore" NUMERIC(18,6),
    "Selected" BOOLEAN,
    "SelectedQuantity" BIGINT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_allocation_trace_score" PRIMARY KEY ("Id")
);

CREATE TABLE public."AUDIT_LOG" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "EntityName" TEXT,
    "EntityId" UUID,
    "Action" TEXT,
    "OldValues" JSONB,
    "NewValues" JSONB,
    "Reason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_audit_log" PRIMARY KEY ("Id")
);

CREATE TABLE public."BATCH" (
    "Id" UUID NOT NULL,
    "ParentBatchId" UUID,
    "RootBatchId" UUID,
    "WarehouseId" UUID,
    "ProductId" UUID,
    "GoodsReceiptLineId" UUID,
    "BatchCode" TEXT,
    "Quantity" BIGINT,
    "ExpirationDate" DATE,
    "ExpiryStatus" TEXT,
    "StockStatus" TEXT,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "ProductionDate" DATE,
    CONSTRAINT "pk_batch" PRIMARY KEY ("Id")
);

CREATE TABLE public."BATCH_QR_LABEL" (
    "Id" UUID NOT NULL,
    "BatchId" UUID,
    "QrCode" TEXT,
    "Quantity" BIGINT,
    "Status" TEXT,
    "BlobUrl" TEXT,
    "GeneratedAt" TIMESTAMPTZ,
    "InvalidatedAt" TIMESTAMPTZ,
    "CurrentWarehouseId" UUID,
    "ParentLabelId" UUID,
    "RootLabelId" UUID,
    "UpdatedAt" TIMESTAMPTZ,
    "Version" INTEGER,
    "GoodsReceiptId" UUID,
    CONSTRAINT "pk_batch_qr_label" PRIMARY KEY ("Id")
);

CREATE TABLE public."BUSINESS_DOCUMENT_SEQUENCE" (
    "DocumentType" TEXT NOT NULL,
    "BusinessDate" DATE NOT NULL,
    "LastNumber" BIGINT,
    CONSTRAINT "pk_business_document_sequence" PRIMARY KEY ("DocumentType", "BusinessDate")
);

CREATE TABLE public."DELIVERY" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "DriverId" UUID,
    "VehicleId" UUID,
    "Status" TEXT,
    "AssignedAt" TIMESTAMPTZ,
    "DispatchedAt" TIMESTAMPTZ,
    "DeliveredAt" TIMESTAMPTZ,
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "DriverCodeSnapshot" TEXT,
    "DriverLicenseSnapshot" TEXT,
    "DriverNameSnapshot" TEXT,
    "DriverPhoneSnapshot" TEXT,
    "OperationKey" TEXT,
    "PlateNumberSnapshot" TEXT,
    "VehicleTypeSnapshot" TEXT,
    "Version" INTEGER,
    CONSTRAINT "pk_delivery" PRIMARY KEY ("Id")
);

CREATE TABLE public."DRIVER" (
    "Id" UUID NOT NULL,
    "FullName" TEXT,
    "Phone" VARCHAR(64),
    "LicenseNumber" BIGINT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "Code" TEXT,
    "WarehouseId" UUID,
    CONSTRAINT "pk_driver" PRIMARY KEY ("Id")
);

CREATE TABLE public."EXPIRY_SWEEP_RUN" (
    "Id" UUID NOT NULL,
    "BusinessDate" DATE,
    "Status" TEXT,
    "BatchesScanned" TEXT,
    "StatusesUpdated" BIGINT,
    "BatchesExpired" BIGINT,
    "Error" TEXT,
    "StartedAt" TIMESTAMPTZ,
    "CompletedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_expiry_sweep_run" PRIMARY KEY ("Id")
);

CREATE TABLE public."GOODS_RECEIPT" (
    "Id" UUID NOT NULL,
    "ReceiptCode" TEXT,
    "WarehouseId" UUID,
    "CreatedByUserId" UUID,
    "ApprovedByUserId" UUID,
    "Status" TEXT,
    "ReceivedAt" TIMESTAMPTZ,
    "ApprovedAt" TIMESTAMPTZ,
    "RejectionReason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "IdempotencyKey" TEXT,
    "RequestHash" TEXT,
    "Version" INTEGER,
    CONSTRAINT "pk_goods_receipt" PRIMARY KEY ("Id")
);

CREATE TABLE public."GOODS_RECEIPT_LINE" (
    "Id" UUID NOT NULL,
    "GoodsReceiptId" UUID,
    "ProductId" UUID,
    "SourceLotCode" TEXT,
    "ReceivedQuantity" BIGINT,
    "ExpirationDate" DATE,
    "CreatedAt" TIMESTAMPTZ,
    "ProductionDate" DATE,
    CONSTRAINT "pk_goods_receipt_line" PRIMARY KEY ("Id")
);

CREATE TABLE public."IDEMPOTENCY_KEY" (
    "Id" UUID NOT NULL,
    "Key" TEXT,
    "Scope" TEXT,
    "UserAccountId" UUID,
    "SalesOrderId" UUID,
    "Status" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "ExpiresAt" TIMESTAMPTZ,
    CONSTRAINT "pk_idempotency_key" PRIMARY KEY ("Id")
);

CREATE TABLE public."INVENTORY_BALANCE" (
    "Id" UUID NOT NULL,
    "BatchId" UUID,
    "PhysicalQuantity" BIGINT,
    "ReservedQuantity" BIGINT,
    "AvailableQuantity" BIGINT,
    "Version" INTEGER,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_inventory_balance" PRIMARY KEY ("Id")
);

CREATE TABLE public."INVENTORY_LOCK" (
    "Id" UUID NOT NULL,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "ProductId" UUID,
    "LockedQuantity" BIGINT,
    "Status" TEXT,
    "Reason" TEXT,
    "RequiresResolution" BOOLEAN,
    "LockedByUserId" UUID,
    "ReleasedByUserId" UUID,
    "ReleasedAt" TIMESTAMPTZ,
    "Note" TEXT,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_inventory_lock" PRIMARY KEY ("Id")
);

CREATE TABLE public."INVENTORY_TRANSACTION" (
    "Id" UUID NOT NULL,
    "BatchId" UUID,
    "WarehouseId" UUID,
    "ProductId" UUID,
    "GoodsReceiptId" UUID,
    "GoodsReceiptLineId" UUID,
    "CreatedByUserId" UUID,
    "TransactionType" TEXT,
    "ReferenceCode" TEXT,
    "PhysicalQuantityDelta" BIGINT,
    "ReservedQuantityDelta" BIGINT,
    "PhysicalQuantityAfter" BIGINT,
    "ReservedQuantityAfter" BIGINT,
    "AvailableQuantityAfter" BIGINT,
    "Note" TEXT,
    "OccurredAt" TIMESTAMPTZ,
    "SourceId" UUID,
    "SourceType" TEXT,
    CONSTRAINT "pk_inventory_transaction" PRIMARY KEY ("Id")
);

CREATE TABLE public."LOYALTY_PROGRAM" (
    "Id" UUID NOT NULL,
    "Code" TEXT,
    "Name" TEXT,
    "Description" TEXT,
    "SpendAmountPerPoint" NUMERIC(18,2),
    "MinimumRedeemPoints" BIGINT,
    "StartAt" TIMESTAMPTZ,
    "EndAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "CreatedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "PointsExpireAt" TIMESTAMPTZ,
    CONSTRAINT "pk_loyalty_program" PRIMARY KEY ("Id")
);

CREATE TABLE public."LOYALTY_REWARD" (
    "Id" UUID NOT NULL,
    "LoyaltyProgramId" UUID,
    "Code" TEXT,
    "Name" TEXT,
    "Description" TEXT,
    "RewardType" TEXT,
    "RequiredPoints" BIGINT,
    "DiscountAmount" NUMERIC(18,2),
    "DiscountPercent" NUMERIC(18,6),
    "AvailableQuantity" BIGINT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "ImageUrl" TEXT,
    CONSTRAINT "pk_loyalty_reward" PRIMARY KEY ("Id")
);

CREATE TABLE public."LOYALTY_TRANSACTION" (
    "Id" UUID NOT NULL,
    "LoyaltyProgramId" UUID,
    "RetailerLoyaltyId" UUID,
    "SalesOrderId" UUID,
    "CreatedByUserId" UUID,
    "TransactionType" TEXT,
    "Points" BIGINT,
    "BalanceAfter" NUMERIC(18,2),
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_loyalty_transaction" PRIMARY KEY ("Id")
);

CREATE TABLE public."MANUAL_REFUND" (
    "Id" UUID NOT NULL,
    "PaymentId" UUID,
    "SalesOrderId" UUID,
    "Amount" NUMERIC(18,2),
    "Recipient" TEXT,
    "Reason" TEXT,
    "Status" TEXT,
    "CreateOperationKey" TEXT,
    "CreateRequestHash" TEXT,
    "EvidenceOperationKey" TEXT,
    "EvidenceRequestHash" TEXT,
    "TransferredAt" TIMESTAMPTZ,
    "TransactionReference" TEXT,
    "EvidenceReference" TEXT,
    "SubmittedByUserId" UUID,
    "SubmittedAt" TIMESTAMPTZ,
    "VerificationOperationKey" TEXT,
    "VerificationRequestHash" TEXT,
    "VerifiedByUserId" UUID,
    "VerifiedAt" TIMESTAMPTZ,
    "VerificationNote" TEXT,
    "CreatedByUserId" UUID,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "ReceiptDiscrepancyId" UUID,
    CONSTRAINT "pk_manual_refund" PRIMARY KEY ("Id")
);

CREATE TABLE public."MAP_DISTANCE_CACHE" (
    "Id" UUID NOT NULL,
    "WarehouseId" UUID,
    "RetailerId" UUID,
    "OriginLocationId" UUID,
    "DestinationLocationId" UUID,
    "OriginLocationVersion" BIGINT,
    "DestinationLocationVersion" BIGINT,
    "DistanceMeters" BIGINT,
    "DurationSeconds" BIGINT,
    "Provider" TEXT,
    "ProviderStatus" TEXT,
    "Version" INTEGER,
    "CalculatedAt" TIMESTAMPTZ,
    "ExpiresAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    CONSTRAINT "pk_map_distance_cache" PRIMARY KEY ("Id")
);

CREATE TABLE public."MAP_LOCATION" (
    "Id" UUID NOT NULL,
    "WarehouseId" UUID,
    "RetailerId" UUID,
    "Latitude" NUMERIC(10,7),
    "Longitude" NUMERIC(10,7),
    "FormattedAddress" TEXT,
    "ProviderPlaceId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "NormalizedAt" TIMESTAMPTZ,
    "Provider" TEXT,
    "Version" INTEGER,
    CONSTRAINT "pk_map_location" PRIMARY KEY ("Id")
);

CREATE TABLE public."NOTIFICATION" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "SalesOrderId" UUID,
    "Type" TEXT,
    "Title" TEXT,
    "Message" TEXT,
    "IsRead" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "ReadAt" TIMESTAMPTZ,
    "OutboxMessageId" UUID,
    "DeepLink" TEXT,
    "RelatedEntityId" UUID,
    "RelatedEntityType" TEXT,
    CONSTRAINT "pk_notification" PRIMARY KEY ("Id")
);

CREATE TABLE public."ORDER_PROMOTION" (
    "Id" UUID NOT NULL,
    "SalesOrderLineId" UUID,
    "PromotionId" UUID,
    "DiscountPercent" NUMERIC(18,6),
    "DiscountAmount" NUMERIC(18,2),
    "IsServerFinal" BOOLEAN,
    "AppliedAt" TIMESTAMPTZ,
    "EffectiveFromSnapshot" TEXT,
    "EffectiveToSnapshot" TEXT,
    "MinimumQuantitySnapshot" BIGINT,
    "PromotionCodeSnapshot" TEXT,
    "PromotionNameSnapshot" TEXT,
    "PromotionTypeSnapshot" TEXT,
    CONSTRAINT "pk_order_promotion" PRIMARY KEY ("Id")
);

CREATE TABLE public."ORDER_STATUS_HISTORY" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "ChangedByUserId" UUID,
    "FromStatus" TEXT,
    "ToStatus" TEXT,
    "Reason" TEXT,
    "ChangedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_order_status_history" PRIMARY KEY ("Id")
);

CREATE TABLE public."OUTBOX_MESSAGE" (
    "Id" UUID NOT NULL,
    "EventType" TEXT,
    "AggregateType" TEXT,
    "AggregateId" UUID,
    "Payload" JSONB,
    "Status" TEXT,
    "RetryCount" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "ProcessedAt" TIMESTAMPTZ,
    "LastError" TEXT,
    CONSTRAINT "pk_outbox_message" PRIMARY KEY ("Id")
);

CREATE TABLE public."PAYMENT" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "Method" TEXT,
    "Status" TEXT,
    "Amount" NUMERIC(18,2),
    "ConfirmedByUserId" UUID,
    "ConfirmedAt" TIMESTAMPTZ,
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "CollectionMethod" TEXT,
    "DeliveredDate" DATE,
    "DueDate" DATE,
    "OperationKey" TEXT,
    "PaidDate" DATE,
    "RequestHash" TEXT,
    "Version" INTEGER,
    "PayOsCheckoutUrl" TEXT,
    "PayOsExpiredAt" TIMESTAMPTZ,
    "PayOsLinkStatus" TEXT,
    "PayOsOrderCode" TEXT,
    "PayOsPaymentLinkId" UUID,
    "PayOsQrCode" TEXT,
    "PayOsReference" TEXT,
    "ConfirmedAmount" NUMERIC(18,2),
    "FinalApprovalReference" TEXT,
    "FinalApprovedAt" TIMESTAMPTZ,
    "PayOsWebhookHash" TEXT,
    "AdjustedAmount" NUMERIC(18,2),
    CONSTRAINT "pk_payment" PRIMARY KEY ("Id")
);

CREATE TABLE public."PICKING_ITEM" (
    "Id" UUID NOT NULL,
    "PickingListId" UUID,
    "AllocationId" UUID,
    "SourceBatchId" UUID,
    "StockOutBatchId" UUID,
    "RequestedQuantity" BIGINT,
    "PickedQuantity" BIGINT,
    "Status" TEXT,
    "ScannedAt" TIMESTAMPTZ,
    "CompletedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_picking_item" PRIMARY KEY ("Id")
);

CREATE TABLE public."PICKING_LIST" (
    "Id" UUID NOT NULL,
    "PickingCode" TEXT,
    "PurchaseOrderId" UUID,
    "WarehouseId" UUID,
    "AssignedToUserId" UUID,
    "Status" TEXT,
    "StartedAt" TIMESTAMPTZ,
    "ConfirmedAt" TIMESTAMPTZ,
    "ConfirmedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "Version" INTEGER,
    CONSTRAINT "pk_picking_list" PRIMARY KEY ("Id")
);

CREATE TABLE public."PRODUCT" (
    "Id" UUID NOT NULL,
    "ProductCategoryId" UUID,
    "Sku" TEXT,
    "Name" TEXT,
    "Unit" TEXT,
    "ShelfLifeHours" BIGINT,
    "NearDateThresholdHours" BIGINT,
    "Status" TEXT,
    "PublishedAt" TIMESTAMPTZ,
    "InactivatedAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "ReplacesProductId" UUID,
    "ImageBlobKey" TEXT,
    CONSTRAINT "pk_product" PRIMARY KEY ("Id")
);

CREATE TABLE public."PRODUCT_CATEGORY" (
    "Id" UUID NOT NULL,
    "ParentCategoryId" UUID,
    "Code" TEXT,
    "Name" TEXT,
    "Description" TEXT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_product_category" PRIMARY KEY ("Id")
);

CREATE TABLE public."PRODUCT_PRICE" (
    "Id" UUID NOT NULL,
    "ProductId" UUID,
    "UnitPrice" NUMERIC(18,2),
    "EffectiveFrom" TIMESTAMPTZ,
    "EffectiveTo" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_product_price" PRIMARY KEY ("Id")
);

CREATE TABLE public."PROMOTION" (
    "Id" UUID NOT NULL,
    "Code" TEXT,
    "Name" TEXT,
    "PromotionType" TEXT,
    "MinimumQuantity" BIGINT,
    "DiscountPercent" NUMERIC(18,6),
    "StartAt" TIMESTAMPTZ,
    "EndAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "CreatedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "CampaignMode" TEXT,
    CONSTRAINT "pk_promotion" PRIMARY KEY ("Id")
);

CREATE TABLE public."PROMOTION_CATEGORY" (
    "Id" UUID NOT NULL,
    "PromotionId" UUID,
    "ProductCategoryId" UUID,
    CONSTRAINT "pk_promotion_category" PRIMARY KEY ("Id")
);

CREATE TABLE public."PROMOTION_PRODUCT" (
    "Id" UUID NOT NULL,
    "PromotionId" UUID,
    "ProductId" UUID,
    "DiscountPercent" NUMERIC(18,6),
    "MinimumQuantity" BIGINT,
    CONSTRAINT "pk_promotion_product" PRIMARY KEY ("Id")
);

CREATE TABLE public."PROMOTION_RETAILER" (
    "Id" UUID NOT NULL,
    "PromotionId" UUID,
    "RetailerId" UUID,
    CONSTRAINT "pk_promotion_retailer" PRIMARY KEY ("Id")
);

CREATE TABLE public."QR_LABEL_EVENT" (
    "Id" UUID NOT NULL,
    "BatchQrLabelId" UUID,
    "WarehouseId" UUID,
    "PerformedByUserId" UUID,
    "OperationKey" TEXT,
    "EventType" TEXT,
    "FromStatus" TEXT,
    "ToStatus" TEXT,
    "Quantity" BIGINT,
    "ReferenceCode" TEXT,
    "Note" TEXT,
    "OccurredAt" TIMESTAMPTZ,
    CONSTRAINT "pk_qr_label_event" PRIMARY KEY ("Id")
);

CREATE TABLE public."RECEIPT_CONFIRMATION" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "ConfirmedByRetailerUserId" UUID,
    "Status" TEXT,
    "ConfirmedAt" TIMESTAMPTZ,
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "OperationKey" TEXT,
    "RequestHash" TEXT,
    "ShipmentId" UUID,
    CONSTRAINT "pk_receipt_confirmation" PRIMARY KEY ("Id")
);

CREATE TABLE public."RECEIPT_CONFIRMATION_ITEM" (
    "Id" UUID NOT NULL,
    "ReceiptConfirmationId" UUID,
    "BatchId" UUID,
    "BatchQrLabelId" UUID,
    "ExpectedQuantity" BIGINT,
    "ReceivedQuantity" BIGINT,
    "ScannedAt" TIMESTAMPTZ,
    "DamagedQuantity" BIGINT,
    "MissingQuantity" BIGINT,
    "SalesOrderLineId" UUID,
    CONSTRAINT "pk_receipt_confirmation_item" PRIMARY KEY ("Id")
);

CREATE TABLE public."RECEIPT_CONFIRMATION_QR_LABEL" (
    "Id" UUID NOT NULL,
    "ReceiptConfirmationId" UUID,
    "BatchQrLabelId" UUID,
    "ScannedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_receipt_confirmation_qr_label" PRIMARY KEY ("Id")
);

CREATE TABLE public."RECEIPT_DISCREPANCY" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "ReceiptConfirmationId" UUID,
    "ReportedByRetailerUserId" UUID,
    "ReviewedByUserId" UUID,
    "Status" TEXT,
    "Note" TEXT,
    "ReportedAt" TIMESTAMPTZ,
    "ReviewedAt" TIMESTAMPTZ,
    "ResolvedAt" TIMESTAMPTZ,
    "ResolutionType" TEXT,
    CONSTRAINT "pk_receipt_discrepancy" PRIMARY KEY ("Id")
);

CREATE TABLE public."RECEIPT_DISCREPANCY_ITEM" (
    "Id" UUID NOT NULL,
    "ReceiptDiscrepancyId" UUID,
    "BatchId" UUID,
    "IssueType" TEXT,
    "ExpectedQuantity" BIGINT,
    "ActualReceivedQuantity" BIGINT,
    "EvidenceBlobUrl" TEXT,
    "Note" TEXT,
    "AdjustmentAmount" NUMERIC(18,2),
    "AllocationPlanPriceId" UUID,
    "FinalUnitPrice" NUMERIC(18,2),
    "ShipmentId" UUID,
    "AllocationId" UUID,
    CONSTRAINT "pk_receipt_discrepancy_item" PRIMARY KEY ("Id")
);

CREATE TABLE public."REFRESH_TOKEN" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "TokenHash" TEXT,
    "ExpiresAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    "RevokedAt" TIMESTAMPTZ,
    "ReplacedByTokenId" UUID,
    "CreatedByIpAddress" TEXT,
    "RevokedByIpAddress" TEXT,
    CONSTRAINT "pk_refresh_token" PRIMARY KEY ("Id")
);

CREATE TABLE public."REGION" (
    "Id" UUID NOT NULL,
    "Code" TEXT,
    "Name" TEXT,
    "Description" TEXT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_region" PRIMARY KEY ("Id")
);

CREATE TABLE public."RESERVATION" (
    "Id" UUID NOT NULL,
    "AllocationId" UUID,
    "BatchId" UUID,
    "Quantity" BIGINT,
    "Status" TEXT,
    "ReservedAt" TIMESTAMPTZ,
    "ReleasedAt" TIMESTAMPTZ,
    "ConsumedAt" TIMESTAMPTZ,
    "AllocationRunAllocationId" UUID,
    CONSTRAINT "pk_reservation" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER" (
    "Id" UUID NOT NULL,
    "RegionId" UUID,
    "Code" TEXT,
    "Name" TEXT,
    "Address" TEXT,
    "Status" TEXT,
    "ForecastRevenue" TEXT,
    "StoreSizeSquareMeters" NUMERIC(18,2),
    "PurchasingCapacity" NUMERIC(18,2),
    "PotentialStatus" TEXT,
    "PotentialScore" NUMERIC(18,6),
    "AssessmentNote" TEXT,
    "DeclaredByUserId" UUID,
    "ReviewedByUserId" UUID,
    "AssessedByUserId" UUID,
    "ReviewedAt" TIMESTAMPTZ,
    "AssessedAt" TIMESTAMPTZ,
    "ReviewReason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "CreditTermDays" BIGINT,
    "PurchaseFrequencyPerMonth" TEXT,
    "RetailerType" TEXT,
    "StoreSizeCategory" TEXT,
    "UserAccountId" UUID,
    "RequestedCreditTermDays" BIGINT,
    "StorefrontImageBlobKey" TEXT,
    CONSTRAINT "pk_retailer" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER_LOYALTY" (
    "Id" UUID NOT NULL,
    "RetailerId" UUID,
    "CurrentPoints" BIGINT,
    "LifetimeEarnedPoints" BIGINT,
    "LifetimeRedeemedPoints" BIGINT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "HeldPoints" BIGINT,
    CONSTRAINT "pk_retailer_loyalty" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER_PRODUCT_MLOR" (
    "Id" UUID NOT NULL,
    "RetailerId" UUID,
    "ProductId" UUID,
    "MinimumLifeRatio" NUMERIC(18,6),
    "MinimumLifeHours" NUMERIC(18,6),
    "EffectiveFrom" TIMESTAMPTZ,
    "EffectiveTo" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "ProductCategoryId" UUID,
    "UpdatedByUserId" UUID,
    "Version" INTEGER,
    CONSTRAINT "pk_retailer_product_mlor" PRIMARY KEY ("Id")
);

CREATE TABLE public."RETAILER_SALES_ASSIGNMENT" (
    "Id" UUID NOT NULL,
    "RetailerId" UUID,
    "SalesGroupId" UUID,
    "AssignedAt" TIMESTAMPTZ,
    "UnassignedAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    CONSTRAINT "pk_retailer_sales_assignment" PRIMARY KEY ("Id")
);

CREATE TABLE public."REWARD_REDEMPTION" (
    "Id" UUID NOT NULL,
    "RetailerId" UUID,
    "LoyaltyRewardId" UUID,
    "LoyaltyTransactionId" UUID,
    "SalesOrderId" UUID,
    "RedeemedPoints" BIGINT,
    "Status" TEXT,
    "RedeemedByUserId" UUID,
    "RedeemedAt" TIMESTAMPTZ,
    "FulfilledAt" TIMESTAMPTZ,
    "CancelledAt" TIMESTAMPTZ,
    "Note" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "ClientRequestId" UUID,
    CONSTRAINT "pk_reward_redemption" PRIMARY KEY ("Id")
);

CREATE TABLE public."SALES_GROUP" (
    "Id" UUID NOT NULL,
    "RegionId" UUID,
    "Code" TEXT,
    "Name" TEXT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_sales_group" PRIMARY KEY ("Id")
);

CREATE TABLE public."SALES_GROUP_MEMBER" (
    "Id" UUID NOT NULL,
    "SalesGroupId" UUID,
    "UserAccountId" UUID,
    "AssignedAt" TIMESTAMPTZ,
    "UnassignedAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    CONSTRAINT "pk_sales_group_member" PRIMARY KEY ("Id")
);

CREATE TABLE public."SALES_ORDER" (
    "Id" UUID NOT NULL,
    "OrderCode" TEXT,
    "RetailerId" UUID,
    "SalesGroupId" UUID,
    "CreatedByUserId" UUID,
    "ReviewedByUserId" UUID,
    "ClientOrderKey" TEXT,
    "Source" TEXT,
    "Status" TEXT,
    "PaymentMethod" TEXT,
    "DeliveryAddress" TEXT,
    "SubtotalAmount" NUMERIC(18,2),
    "DiscountAmount" NUMERIC(18,2),
    "FinalAmount" NUMERIC(18,2),
    "OfflineEstimatedAmount" NUMERIC(18,2),
    "HasOfflineDifference" BOOLEAN,
    "ServerReceivedAt" TIMESTAMPTZ,
    "ReviewedAt" TIMESTAMPTZ,
    "RejectionReason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "CreditTermDays" BIGINT,
    "Note" TEXT,
    "RequestHash" TEXT,
    "RequestedDeliveryDate" DATE,
    "RetailerCodeSnapshot" TEXT,
    "RetailerNameSnapshot" TEXT,
    "Version" INTEGER,
    "FinalPricePendingAllocation" BOOLEAN,
    "AcceptedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_sales_order" PRIMARY KEY ("Id")
);

CREATE TABLE public."SALES_ORDER_ATTACHMENT" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "UploadedByUserId" UUID,
    "AttachmentType" TEXT,
    "FileName" TEXT,
    "ContentType" TEXT,
    "BlobUrl" TEXT,
    "UploadedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_sales_order_attachment" PRIMARY KEY ("Id")
);

CREATE TABLE public."SALES_ORDER_LINE" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "ProductId" UUID,
    "OrderedQuantity" BIGINT,
    "UnitPrice" NUMERIC(18,2),
    "GrossAmount" NUMERIC(18,2),
    "DiscountAmount" NUMERIC(18,2),
    "NetAmount" NUMERIC(18,2),
    "EstimatedArrivalAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    "DiscountPercent" NUMERIC(18,6),
    "DiscountSourceCode" TEXT,
    "DiscountSourceType" TEXT,
    "LineNumber" INTEGER,
    "ProductNameSnapshot" TEXT,
    "SkuSnapshot" TEXT,
    "FinalPricePendingAllocation" BOOLEAN,
    "MlorMinimumLifeHours" BIGINT,
    "MlorMinimumLifeRatio" NUMERIC(18,6),
    "MlorProductCategoryId" UUID,
    "MlorResolvedAt" TIMESTAMPTZ,
    "MlorSourceRuleId" UUID,
    "MlorSourceScope" TEXT,
    "MlorSourceVersion" BIGINT,
    "PricedAt" TIMESTAMPTZ,
    "ProductPriceEffectiveFrom" TIMESTAMPTZ,
    "ProductPriceEffectiveTo" TIMESTAMPTZ,
    "ProductPriceId" UUID,
    CONSTRAINT "pk_sales_order_line" PRIMARY KEY ("Id")
);

CREATE TABLE public."SHELF_LIFE_DISCOUNT_TABLE" (
    "Id" UUID NOT NULL,
    "Version" INTEGER,
    "EffectiveFrom" TIMESTAMPTZ,
    "EffectiveTo" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "Note" TEXT,
    "CreatedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_shelf_life_discount_table" PRIMARY KEY ("Id")
);

CREATE TABLE public."SHELF_LIFE_DISCOUNT_TIER" (
    "Id" UUID NOT NULL,
    "ShelfLifeDiscountTableId" UUID,
    "Scope" TEXT,
    "ProductId" UUID,
    "ProductCategoryId" UUID,
    "MinRemainingPercent" NUMERIC(18,6),
    "MaxRemainingPercent" NUMERIC(18,6),
    "DiscountType" TEXT,
    "DiscountValue" NUMERIC(18,6),
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_shelf_life_discount_tier" PRIMARY KEY ("Id")
);

CREATE TABLE public."SHIPMENT" (
    "Id" UUID NOT NULL,
    "SalesOrderId" UUID,
    "WarehouseId" UUID,
    "ShipmentCode" TEXT,
    "Status" TEXT,
    "TotalQuantity" BIGINT,
    "ReceivedQuantity" BIGINT,
    "ReadyAt" TIMESTAMPTZ,
    "IssuedAt" TIMESTAMPTZ,
    "DispatchedAt" TIMESTAMPTZ,
    "ReceivedAt" TIMESTAMPTZ,
    "ExceptionReason" TEXT,
    "Version" INTEGER,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "AssignedAt" TIMESTAMPTZ,
    "DriverCodeSnapshot" TEXT,
    "DriverId" UUID,
    "DriverLicenseSnapshot" TEXT,
    "DriverNameSnapshot" TEXT,
    "DriverPhoneSnapshot" TEXT,
    "PlateNumberSnapshot" TEXT,
    "VehicleId" UUID,
    "VehicleTypeSnapshot" TEXT,
    "PickingListId" UUID,
    CONSTRAINT "pk_shipment" PRIMARY KEY ("Id")
);

CREATE TABLE public."SYSTEM_CONFIGURATION" (
    "Id" UUID NOT NULL,
    "ConfigKey" TEXT,
    "ConfigValue" TEXT,
    "Description" TEXT,
    "ValueType" TEXT,
    "IsActive" BOOLEAN,
    "UpdatedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "EffectiveFrom" TIMESTAMPTZ,
    "Version" INTEGER,
    CONSTRAINT "pk_system_configuration" PRIMARY KEY ("Id")
);

CREATE TABLE public."TRANSIT_TABLE" (
    "Id" UUID NOT NULL,
    "Version" INTEGER,
    "MaxServingDistanceMeters" BIGINT,
    "EffectiveFrom" TIMESTAMPTZ,
    "EffectiveTo" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    "Note" TEXT,
    "CreatedByUserId" UUID,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_transit_table" PRIMARY KEY ("Id")
);

CREATE TABLE public."TRANSIT_TABLE_BAND" (
    "Id" UUID NOT NULL,
    "TransitTableId" UUID,
    "MinDistanceMeters" BIGINT,
    "MaxDistanceMeters" BIGINT,
    "HandlingMinutes" BIGINT,
    "TransitMinutes" BIGINT,
    "EstimatedCostAmount" NUMERIC(18,2),
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_transit_table_band" PRIMARY KEY ("Id")
);

CREATE TABLE public."TRANSIT_TIME_RULE" (
    "Id" UUID NOT NULL,
    "WarehouseId" UUID,
    "MinDistanceMeters" BIGINT,
    "MaxDistanceMeters" BIGINT,
    "HandlingMinutes" BIGINT,
    "TransitMinutes" BIGINT,
    "MaxServingDistanceMeters" BIGINT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "EffectiveFrom" TIMESTAMPTZ,
    "EffectiveTo" TIMESTAMPTZ,
    "Version" INTEGER,
    "EstimatedTransportCost" NUMERIC(18,2),
    CONSTRAINT "pk_transit_time_rule" PRIMARY KEY ("Id")
);

CREATE TABLE public."USER_ACCOUNT" (
    "Id" UUID NOT NULL,
    "GoogleSubject" TEXT,
    "Email" TEXT,
    "FullName" TEXT,
    "Role" TEXT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "IdentityProvider" TEXT,
    "Phone" VARCHAR(64),
    CONSTRAINT "pk_user_account" PRIMARY KEY ("Id")
);

CREATE TABLE public."USER_CREDENTIAL" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "PasswordHash" TEXT,
    "FailedLoginCount" INTEGER,
    "LockoutEndAt" TIMESTAMPTZ,
    "MustChangePassword" BOOLEAN,
    "PasswordChangedAt" TIMESTAMPTZ,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_user_credential" PRIMARY KEY ("Id")
);

CREATE TABLE public."USER_REGION_ASSIGNMENT" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "RegionId" UUID,
    "AssignedAt" TIMESTAMPTZ,
    "UnassignedAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    CONSTRAINT "pk_user_region_assignment" PRIMARY KEY ("Id")
);

CREATE TABLE public."USER_WAREHOUSE_ASSIGNMENT" (
    "Id" UUID NOT NULL,
    "UserAccountId" UUID,
    "WarehouseId" UUID,
    "AssignedAt" TIMESTAMPTZ,
    "IsActive" BOOLEAN,
    CONSTRAINT "pk_user_warehouse_assignment" PRIMARY KEY ("Id")
);

CREATE TABLE public."VEHICLE" (
    "Id" UUID NOT NULL,
    "PlateNumber" VARCHAR(64),
    "VehicleType" TEXT,
    "Capacity" BIGINT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "WarehouseId" UUID,
    CONSTRAINT "pk_vehicle" PRIMARY KEY ("Id")
);

CREATE TABLE public."WAREHOUSE" (
    "Id" UUID NOT NULL,
    "Code" TEXT,
    "Name" TEXT,
    "Address" TEXT,
    "IsActive" BOOLEAN,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    "MinimumStockThresholdCartons" BIGINT,
    "RegionId" UUID,
    CONSTRAINT "pk_warehouse" PRIMARY KEY ("Id")
);

CREATE TABLE public."WRITE_OFF" (
    "Id" UUID NOT NULL,
    "WriteOffCode" TEXT,
    "WarehouseId" UUID,
    "CreatedByUserId" UUID,
    "Status" TEXT,
    "Reason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    "UpdatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_write_off" PRIMARY KEY ("Id")
);

CREATE TABLE public."WRITE_OFF_ATTACHMENT" (
    "Id" UUID NOT NULL,
    "WriteOffId" UUID,
    "UploadedByUserId" UUID,
    "FileName" TEXT,
    "ContentType" TEXT,
    "BlobUrl" TEXT,
    "UploadedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_write_off_attachment" PRIMARY KEY ("Id")
);

CREATE TABLE public."WRITE_OFF_ITEM" (
    "Id" UUID NOT NULL,
    "WriteOffId" UUID,
    "BatchId" UUID,
    "Quantity" BIGINT,
    "Reason" TEXT,
    "CreatedAt" TIMESTAMPTZ,
    CONSTRAINT "pk_write_off_item" PRIMARY KEY ("Id")
);

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" VARCHAR(150) NOT NULL,
    "ProductVersion" VARCHAR(32),
    CONSTRAINT "pk___efmigrationshistory" PRIMARY KEY ("MigrationId")
);

-- ============================================================
-- PHASE 2: Add all 195 relationships exported by GraphML
-- Default NO ACTION is assumed; real ON DELETE is not available in GraphML.
-- ============================================================
ALTER TABLE public."ACCOUNT_TOKEN" ADD CONSTRAINT "fk_account_token_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."COMPLAINT_EVIDENCE" ADD CONSTRAINT "fk_complaint_evidence_receipt_discrepancy_id" FOREIGN KEY ("ReceiptDiscrepancyId") REFERENCES public."RECEIPT_DISCREPANCY" ("Id");
ALTER TABLE public."COMPLAINT_EVIDENCE" ADD CONSTRAINT "fk_complaint_evidence_uploaded_by_user_id" FOREIGN KEY ("UploadedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."LOYALTY_PROGRAM_RETAILER" ADD CONSTRAINT "fk_loyalty_program_retailer_loyalty_program_id" FOREIGN KEY ("LoyaltyProgramId") REFERENCES public."LOYALTY_PROGRAM" ("Id");
ALTER TABLE public."LOYALTY_PROGRAM_RETAILER" ADD CONSTRAINT "fk_loyalty_program_retailer_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."PAYMENT_RECEIPT" ADD CONSTRAINT "fk_payment_receipt_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."PAYMENT_RECEIPT" ADD CONSTRAINT "fk_payment_receipt_confirmed_by_user_id" FOREIGN KEY ("ConfirmedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PAYMENT_RECEIPT" ADD CONSTRAINT "fk_payment_receipt_reversed_by_user_id" FOREIGN KEY ("ReversedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PAYMENT_RECEIPT_ALLOCATION" ADD CONSTRAINT "fk_payment_receipt_allocation_payment_id" FOREIGN KEY ("PaymentId") REFERENCES public."PAYMENT" ("Id");
ALTER TABLE public."PAYMENT_RECEIPT_ALLOCATION" ADD CONSTRAINT "fk_payment_receipt_allocation_payment_receipt_id" FOREIGN KEY ("PaymentReceiptId") REFERENCES public."PAYMENT_RECEIPT" ("Id");
ALTER TABLE public."REPLACEMENT_CASE" ADD CONSTRAINT "fk_replacement_case_receipt_discrepancy_id" FOREIGN KEY ("ReceiptDiscrepancyId") REFERENCES public."RECEIPT_DISCREPANCY" ("Id");
ALTER TABLE public."REPLACEMENT_CASE" ADD CONSTRAINT "fk_replacement_case_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."RETAILER_ACTIVATION_CHALLENGE" ADD CONSTRAINT "fk_retailer_activation_challenge_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER_DECLARATION_CONTACT" ADD CONSTRAINT "fk_retailer_declaration_contact_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."ALLOCATION" ADD CONSTRAINT "fk_allocation_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."ALLOCATION" ADD CONSTRAINT "fk_allocation_promotion_id" FOREIGN KEY ("PromotionId") REFERENCES public."PROMOTION" ("Id");
ALTER TABLE public."ALLOCATION" ADD CONSTRAINT "fk_allocation_sales_order_line_id" FOREIGN KEY ("SalesOrderLineId") REFERENCES public."SALES_ORDER_LINE" ("Id");
ALTER TABLE public."ALLOCATION" ADD CONSTRAINT "fk_allocation_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."ALLOCATION_LINE_TRACE" ADD CONSTRAINT "fk_allocation_line_trace_allocation_run_id" FOREIGN KEY ("AllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_LINE_TRACE" ADD CONSTRAINT "fk_allocation_line_trace_allocation_run_line_id" FOREIGN KEY ("AllocationRunLineId") REFERENCES public."ALLOCATION_RUN_LINE" ("Id");
ALTER TABLE public."ALLOCATION_PLAN_PRICE" ADD CONSTRAINT "fk_allocation_plan_price_allocation_run_id" FOREIGN KEY ("AllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_PLAN_PRICE" ADD CONSTRAINT "fk_allocation_plan_price_allocation_run_line_id" FOREIGN KEY ("AllocationRunLineId") REFERENCES public."ALLOCATION_RUN_LINE" ("Id");
ALTER TABLE public."ALLOCATION_RUN" ADD CONSTRAINT "fk_allocation_run_retry_of_allocation_run_id" FOREIGN KEY ("RetryOfAllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_RUN" ADD CONSTRAINT "fk_allocation_run_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."ALLOCATION_RUN_ALLOCATION" ADD CONSTRAINT "fk_allocation_run_allocation_allocation_run_id" FOREIGN KEY ("AllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_RUN_ALLOCATION" ADD CONSTRAINT "fk_allocation_run_allocation_allocation_run_line_id" FOREIGN KEY ("AllocationRunLineId") REFERENCES public."ALLOCATION_RUN_LINE" ("Id");
ALTER TABLE public."ALLOCATION_RUN_ALLOCATION" ADD CONSTRAINT "fk_allocation_run_allocation_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."ALLOCATION_RUN_LINE" ADD CONSTRAINT "fk_allocation_run_line_allocation_run_order_id" FOREIGN KEY ("AllocationRunOrderId") REFERENCES public."ALLOCATION_RUN_ORDER" ("Id");
ALTER TABLE public."ALLOCATION_RUN_LINE" ADD CONSTRAINT "fk_allocation_run_line_sales_order_line_id" FOREIGN KEY ("SalesOrderLineId") REFERENCES public."SALES_ORDER_LINE" ("Id");
ALTER TABLE public."ALLOCATION_RUN_ORDER" ADD CONSTRAINT "fk_allocation_run_order_allocation_run_id" FOREIGN KEY ("AllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_RUN_ORDER" ADD CONSTRAINT "fk_allocation_run_order_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."ALLOCATION_RUN_STOCK" ADD CONSTRAINT "fk_allocation_run_stock_allocation_run_id" FOREIGN KEY ("AllocationRunId") REFERENCES public."ALLOCATION_RUN" ("Id");
ALTER TABLE public."ALLOCATION_RUN_STOCK" ADD CONSTRAINT "fk_allocation_run_stock_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."ALLOCATION_TRACE_CANDIDATE" ADD CONSTRAINT "fk_allocation_trace_candidate_allocation_line_trace_id" FOREIGN KEY ("AllocationLineTraceId") REFERENCES public."ALLOCATION_LINE_TRACE" ("Id");
ALTER TABLE public."ALLOCATION_TRACE_SCORE" ADD CONSTRAINT "fk_allocation_trace_score_allocation_line_trace_id" FOREIGN KEY ("AllocationLineTraceId") REFERENCES public."ALLOCATION_LINE_TRACE" ("Id");
ALTER TABLE public."AUDIT_LOG" ADD CONSTRAINT "fk_audit_log_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."BATCH" ADD CONSTRAINT "fk_batch_parent_batch_id" FOREIGN KEY ("ParentBatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."BATCH" ADD CONSTRAINT "fk_batch_root_batch_id" FOREIGN KEY ("RootBatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."BATCH" ADD CONSTRAINT "fk_batch_goods_receipt_line_id" FOREIGN KEY ("GoodsReceiptLineId") REFERENCES public."GOODS_RECEIPT_LINE" ("Id");
ALTER TABLE public."BATCH" ADD CONSTRAINT "fk_batch_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."BATCH" ADD CONSTRAINT "fk_batch_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."BATCH_QR_LABEL" ADD CONSTRAINT "fk_batch_qr_label_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."BATCH_QR_LABEL" ADD CONSTRAINT "fk_batch_qr_label_parent_label_id" FOREIGN KEY ("ParentLabelId") REFERENCES public."BATCH_QR_LABEL" ("Id");
ALTER TABLE public."BATCH_QR_LABEL" ADD CONSTRAINT "fk_batch_qr_label_root_label_id" FOREIGN KEY ("RootLabelId") REFERENCES public."BATCH_QR_LABEL" ("Id");
ALTER TABLE public."BATCH_QR_LABEL" ADD CONSTRAINT "fk_batch_qr_label_goods_receipt_id" FOREIGN KEY ("GoodsReceiptId") REFERENCES public."GOODS_RECEIPT" ("Id");
ALTER TABLE public."BATCH_QR_LABEL" ADD CONSTRAINT "fk_batch_qr_label_current_warehouse_id" FOREIGN KEY ("CurrentWarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."DELIVERY" ADD CONSTRAINT "fk_delivery_driver_id" FOREIGN KEY ("DriverId") REFERENCES public."DRIVER" ("Id");
ALTER TABLE public."DELIVERY" ADD CONSTRAINT "fk_delivery_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."DELIVERY" ADD CONSTRAINT "fk_delivery_vehicle_id" FOREIGN KEY ("VehicleId") REFERENCES public."VEHICLE" ("Id");
ALTER TABLE public."DRIVER" ADD CONSTRAINT "fk_driver_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."GOODS_RECEIPT" ADD CONSTRAINT "fk_goods_receipt_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."GOODS_RECEIPT" ADD CONSTRAINT "fk_goods_receipt_approved_by_user_id" FOREIGN KEY ("ApprovedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."GOODS_RECEIPT" ADD CONSTRAINT "fk_goods_receipt_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."GOODS_RECEIPT_LINE" ADD CONSTRAINT "fk_goods_receipt_line_goods_receipt_id" FOREIGN KEY ("GoodsReceiptId") REFERENCES public."GOODS_RECEIPT" ("Id");
ALTER TABLE public."GOODS_RECEIPT_LINE" ADD CONSTRAINT "fk_goods_receipt_line_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."IDEMPOTENCY_KEY" ADD CONSTRAINT "fk_idempotency_key_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."IDEMPOTENCY_KEY" ADD CONSTRAINT "fk_idempotency_key_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."INVENTORY_BALANCE" ADD CONSTRAINT "fk_inventory_balance_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."INVENTORY_LOCK" ADD CONSTRAINT "fk_inventory_lock_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."INVENTORY_LOCK" ADD CONSTRAINT "fk_inventory_lock_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."INVENTORY_LOCK" ADD CONSTRAINT "fk_inventory_lock_locked_by_user_id" FOREIGN KEY ("LockedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."INVENTORY_LOCK" ADD CONSTRAINT "fk_inventory_lock_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_goods_receipt_id" FOREIGN KEY ("GoodsReceiptId") REFERENCES public."GOODS_RECEIPT" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_goods_receipt_line_id" FOREIGN KEY ("GoodsReceiptLineId") REFERENCES public."GOODS_RECEIPT_LINE" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."INVENTORY_TRANSACTION" ADD CONSTRAINT "fk_inventory_transaction_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."LOYALTY_PROGRAM" ADD CONSTRAINT "fk_loyalty_program_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."LOYALTY_REWARD" ADD CONSTRAINT "fk_loyalty_reward_loyalty_program_id" FOREIGN KEY ("LoyaltyProgramId") REFERENCES public."LOYALTY_PROGRAM" ("Id");
ALTER TABLE public."LOYALTY_TRANSACTION" ADD CONSTRAINT "fk_loyalty_transaction_loyalty_program_id" FOREIGN KEY ("LoyaltyProgramId") REFERENCES public."LOYALTY_PROGRAM" ("Id");
ALTER TABLE public."LOYALTY_TRANSACTION" ADD CONSTRAINT "fk_loyalty_transaction_retailer_loyalty_id" FOREIGN KEY ("RetailerLoyaltyId") REFERENCES public."RETAILER_LOYALTY" ("Id");
ALTER TABLE public."LOYALTY_TRANSACTION" ADD CONSTRAINT "fk_loyalty_transaction_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."LOYALTY_TRANSACTION" ADD CONSTRAINT "fk_loyalty_transaction_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_payment_id" FOREIGN KEY ("PaymentId") REFERENCES public."PAYMENT" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_receipt_discrepancy_id" FOREIGN KEY ("ReceiptDiscrepancyId") REFERENCES public."RECEIPT_DISCREPANCY" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_submitted_by_user_id" FOREIGN KEY ("SubmittedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_verified_by_user_id" FOREIGN KEY ("VerifiedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."MANUAL_REFUND" ADD CONSTRAINT "fk_manual_refund_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."MAP_DISTANCE_CACHE" ADD CONSTRAINT "fk_map_distance_cache_origin_location_id" FOREIGN KEY ("OriginLocationId") REFERENCES public."MAP_LOCATION" ("Id");
ALTER TABLE public."MAP_DISTANCE_CACHE" ADD CONSTRAINT "fk_map_distance_cache_destination_location_id" FOREIGN KEY ("DestinationLocationId") REFERENCES public."MAP_LOCATION" ("Id");
ALTER TABLE public."MAP_DISTANCE_CACHE" ADD CONSTRAINT "fk_map_distance_cache_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."MAP_DISTANCE_CACHE" ADD CONSTRAINT "fk_map_distance_cache_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."MAP_LOCATION" ADD CONSTRAINT "fk_map_location_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."MAP_LOCATION" ADD CONSTRAINT "fk_map_location_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."NOTIFICATION" ADD CONSTRAINT "fk_notification_outbox_message_id" FOREIGN KEY ("OutboxMessageId") REFERENCES public."OUTBOX_MESSAGE" ("Id");
ALTER TABLE public."NOTIFICATION" ADD CONSTRAINT "fk_notification_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."NOTIFICATION" ADD CONSTRAINT "fk_notification_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."ORDER_PROMOTION" ADD CONSTRAINT "fk_order_promotion_promotion_id" FOREIGN KEY ("PromotionId") REFERENCES public."PROMOTION" ("Id");
ALTER TABLE public."ORDER_PROMOTION" ADD CONSTRAINT "fk_order_promotion_sales_order_line_id" FOREIGN KEY ("SalesOrderLineId") REFERENCES public."SALES_ORDER_LINE" ("Id");
ALTER TABLE public."ORDER_STATUS_HISTORY" ADD CONSTRAINT "fk_order_status_history_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."ORDER_STATUS_HISTORY" ADD CONSTRAINT "fk_order_status_history_changed_by_user_id" FOREIGN KEY ("ChangedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PAYMENT" ADD CONSTRAINT "fk_payment_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."PAYMENT" ADD CONSTRAINT "fk_payment_confirmed_by_user_id" FOREIGN KEY ("ConfirmedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PICKING_ITEM" ADD CONSTRAINT "fk_picking_item_allocation_id" FOREIGN KEY ("AllocationId") REFERENCES public."ALLOCATION" ("Id");
ALTER TABLE public."PICKING_ITEM" ADD CONSTRAINT "fk_picking_item_source_batch_id" FOREIGN KEY ("SourceBatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."PICKING_ITEM" ADD CONSTRAINT "fk_picking_item_stock_out_batch_id" FOREIGN KEY ("StockOutBatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."PICKING_ITEM" ADD CONSTRAINT "fk_picking_item_picking_list_id" FOREIGN KEY ("PickingListId") REFERENCES public."PICKING_LIST" ("Id");
ALTER TABLE public."PICKING_LIST" ADD CONSTRAINT "fk_picking_list_purchase_order_id" FOREIGN KEY ("PurchaseOrderId") REFERENCES public."PURCHASE_ORDER" ("Id");
ALTER TABLE public."PICKING_LIST" ADD CONSTRAINT "fk_picking_list_assigned_to_user_id" FOREIGN KEY ("AssignedToUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PICKING_LIST" ADD CONSTRAINT "fk_picking_list_confirmed_by_user_id" FOREIGN KEY ("ConfirmedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PICKING_LIST" ADD CONSTRAINT "fk_picking_list_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."PRODUCT" ADD CONSTRAINT "fk_product_product_category_id" FOREIGN KEY ("ProductCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."PRODUCT" ADD CONSTRAINT "fk_product_replaces_product_id" FOREIGN KEY ("ReplacesProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."PRODUCT_CATEGORY" ADD CONSTRAINT "fk_product_category_parent_category_id" FOREIGN KEY ("ParentCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."PRODUCT_PRICE" ADD CONSTRAINT "fk_product_price_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."PROMOTION" ADD CONSTRAINT "fk_promotion_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."PROMOTION_CATEGORY" ADD CONSTRAINT "fk_promotion_category_product_category_id" FOREIGN KEY ("ProductCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."PROMOTION_CATEGORY" ADD CONSTRAINT "fk_promotion_category_promotion_id" FOREIGN KEY ("PromotionId") REFERENCES public."PROMOTION" ("Id");
ALTER TABLE public."PROMOTION_PRODUCT" ADD CONSTRAINT "fk_promotion_product_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."PROMOTION_PRODUCT" ADD CONSTRAINT "fk_promotion_product_promotion_id" FOREIGN KEY ("PromotionId") REFERENCES public."PROMOTION" ("Id");
ALTER TABLE public."PROMOTION_RETAILER" ADD CONSTRAINT "fk_promotion_retailer_promotion_id" FOREIGN KEY ("PromotionId") REFERENCES public."PROMOTION" ("Id");
ALTER TABLE public."PROMOTION_RETAILER" ADD CONSTRAINT "fk_promotion_retailer_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."QR_LABEL_EVENT" ADD CONSTRAINT "fk_qr_label_event_batch_qr_label_id" FOREIGN KEY ("BatchQrLabelId") REFERENCES public."BATCH_QR_LABEL" ("Id");
ALTER TABLE public."QR_LABEL_EVENT" ADD CONSTRAINT "fk_qr_label_event_performed_by_user_id" FOREIGN KEY ("PerformedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."QR_LABEL_EVENT" ADD CONSTRAINT "fk_qr_label_event_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION" ADD CONSTRAINT "fk_receipt_confirmation_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION" ADD CONSTRAINT "fk_receipt_confirmation_shipment_id" FOREIGN KEY ("ShipmentId") REFERENCES public."SHIPMENT" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION" ADD CONSTRAINT "fk_receipt_confirmation_confirmed_by_retailer_user_id" FOREIGN KEY ("ConfirmedByRetailerUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_ITEM" ADD CONSTRAINT "fk_receipt_confirmation_item_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_ITEM" ADD CONSTRAINT "fk_receipt_confirmation_item_batch_qr_label_id" FOREIGN KEY ("BatchQrLabelId") REFERENCES public."BATCH_QR_LABEL" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_ITEM" ADD CONSTRAINT "fk_receipt_confirmation_item_receipt_confirmation_id" FOREIGN KEY ("ReceiptConfirmationId") REFERENCES public."RECEIPT_CONFIRMATION" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_ITEM" ADD CONSTRAINT "fk_receipt_confirmation_item_sales_order_line_id" FOREIGN KEY ("SalesOrderLineId") REFERENCES public."SALES_ORDER_LINE" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_QR_LABEL" ADD CONSTRAINT "fk_receipt_confirmation_qr_label_batch_qr_label_id" FOREIGN KEY ("BatchQrLabelId") REFERENCES public."BATCH_QR_LABEL" ("Id");
ALTER TABLE public."RECEIPT_CONFIRMATION_QR_LABEL" ADD CONSTRAINT "fk_receipt_confirmation_qr_label_receipt_confirmation_id" FOREIGN KEY ("ReceiptConfirmationId") REFERENCES public."RECEIPT_CONFIRMATION" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY" ADD CONSTRAINT "fk_receipt_discrepancy_receipt_confirmation_id" FOREIGN KEY ("ReceiptConfirmationId") REFERENCES public."RECEIPT_CONFIRMATION" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY" ADD CONSTRAINT "fk_receipt_discrepancy_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY" ADD CONSTRAINT "fk_receipt_discrepancy_reported_by_retailer_user_id" FOREIGN KEY ("ReportedByRetailerUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY" ADD CONSTRAINT "fk_receipt_discrepancy_reviewed_by_user_id" FOREIGN KEY ("ReviewedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY_ITEM" ADD CONSTRAINT "fk_receipt_discrepancy_item_allocation_id" FOREIGN KEY ("AllocationId") REFERENCES public."ALLOCATION" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY_ITEM" ADD CONSTRAINT "fk_receipt_discrepancy_item_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."RECEIPT_DISCREPANCY_ITEM" ADD CONSTRAINT "fk_receipt_discrepancy_item_receipt_discrepancy_id" FOREIGN KEY ("ReceiptDiscrepancyId") REFERENCES public."RECEIPT_DISCREPANCY" ("Id");
ALTER TABLE public."REFRESH_TOKEN" ADD CONSTRAINT "fk_refresh_token_replaced_by_token_id" FOREIGN KEY ("ReplacedByTokenId") REFERENCES public."REFRESH_TOKEN" ("Id");
ALTER TABLE public."REFRESH_TOKEN" ADD CONSTRAINT "fk_refresh_token_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RESERVATION" ADD CONSTRAINT "fk_reservation_allocation_id" FOREIGN KEY ("AllocationId") REFERENCES public."ALLOCATION" ("Id");
ALTER TABLE public."RESERVATION" ADD CONSTRAINT "fk_reservation_allocation_run_allocation_id" FOREIGN KEY ("AllocationRunAllocationId") REFERENCES public."ALLOCATION_RUN_ALLOCATION" ("Id");
ALTER TABLE public."RESERVATION" ADD CONSTRAINT "fk_reservation_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."RETAILER" ADD CONSTRAINT "fk_retailer_region_id" FOREIGN KEY ("RegionId") REFERENCES public."REGION" ("Id");
ALTER TABLE public."RETAILER" ADD CONSTRAINT "fk_retailer_declared_by_user_id" FOREIGN KEY ("DeclaredByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER" ADD CONSTRAINT "fk_retailer_reviewed_by_user_id" FOREIGN KEY ("ReviewedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER" ADD CONSTRAINT "fk_retailer_assessed_by_user_id" FOREIGN KEY ("AssessedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER" ADD CONSTRAINT "fk_retailer_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER_LOYALTY" ADD CONSTRAINT "fk_retailer_loyalty_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."RETAILER_PRODUCT_MLOR" ADD CONSTRAINT "fk_retailer_product_mlor_product_category_id" FOREIGN KEY ("ProductCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."RETAILER_PRODUCT_MLOR" ADD CONSTRAINT "fk_retailer_product_mlor_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."RETAILER_PRODUCT_MLOR" ADD CONSTRAINT "fk_retailer_product_mlor_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."RETAILER_PRODUCT_MLOR" ADD CONSTRAINT "fk_retailer_product_mlor_updated_by_user_id" FOREIGN KEY ("UpdatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."RETAILER_SALES_ASSIGNMENT" ADD CONSTRAINT "fk_retailer_sales_assignment_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."RETAILER_SALES_ASSIGNMENT" ADD CONSTRAINT "fk_retailer_sales_assignment_sales_group_id" FOREIGN KEY ("SalesGroupId") REFERENCES public."SALES_GROUP" ("Id");
ALTER TABLE public."REWARD_REDEMPTION" ADD CONSTRAINT "fk_reward_redemption_loyalty_reward_id" FOREIGN KEY ("LoyaltyRewardId") REFERENCES public."LOYALTY_REWARD" ("Id");
ALTER TABLE public."REWARD_REDEMPTION" ADD CONSTRAINT "fk_reward_redemption_loyalty_transaction_id" FOREIGN KEY ("LoyaltyTransactionId") REFERENCES public."LOYALTY_TRANSACTION" ("Id");
ALTER TABLE public."REWARD_REDEMPTION" ADD CONSTRAINT "fk_reward_redemption_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."REWARD_REDEMPTION" ADD CONSTRAINT "fk_reward_redemption_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."REWARD_REDEMPTION" ADD CONSTRAINT "fk_reward_redemption_redeemed_by_user_id" FOREIGN KEY ("RedeemedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SALES_GROUP" ADD CONSTRAINT "fk_sales_group_region_id" FOREIGN KEY ("RegionId") REFERENCES public."REGION" ("Id");
ALTER TABLE public."SALES_GROUP_MEMBER" ADD CONSTRAINT "fk_sales_group_member_sales_group_id" FOREIGN KEY ("SalesGroupId") REFERENCES public."SALES_GROUP" ("Id");
ALTER TABLE public."SALES_GROUP_MEMBER" ADD CONSTRAINT "fk_sales_group_member_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SALES_ORDER" ADD CONSTRAINT "fk_sales_order_retailer_id" FOREIGN KEY ("RetailerId") REFERENCES public."RETAILER" ("Id");
ALTER TABLE public."SALES_ORDER" ADD CONSTRAINT "fk_sales_order_sales_group_id" FOREIGN KEY ("SalesGroupId") REFERENCES public."SALES_GROUP" ("Id");
ALTER TABLE public."SALES_ORDER" ADD CONSTRAINT "fk_sales_order_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SALES_ORDER" ADD CONSTRAINT "fk_sales_order_reviewed_by_user_id" FOREIGN KEY ("ReviewedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SALES_ORDER_ATTACHMENT" ADD CONSTRAINT "fk_sales_order_attachment_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."SALES_ORDER_ATTACHMENT" ADD CONSTRAINT "fk_sales_order_attachment_uploaded_by_user_id" FOREIGN KEY ("UploadedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SALES_ORDER_LINE" ADD CONSTRAINT "fk_sales_order_line_mlor_product_category_id" FOREIGN KEY ("MlorProductCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."SALES_ORDER_LINE" ADD CONSTRAINT "fk_sales_order_line_product_price_id" FOREIGN KEY ("ProductPriceId") REFERENCES public."PRODUCT_PRICE" ("Id");
ALTER TABLE public."SALES_ORDER_LINE" ADD CONSTRAINT "fk_sales_order_line_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."SALES_ORDER_LINE" ADD CONSTRAINT "fk_sales_order_line_mlor_source_rule_id" FOREIGN KEY ("MlorSourceRuleId") REFERENCES public."RETAILER_PRODUCT_MLOR" ("Id");
ALTER TABLE public."SALES_ORDER_LINE" ADD CONSTRAINT "fk_sales_order_line_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."SHELF_LIFE_DISCOUNT_TABLE" ADD CONSTRAINT "fk_shelf_life_discount_table_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."SHELF_LIFE_DISCOUNT_TIER" ADD CONSTRAINT "fk_shelf_life_discount_tier_product_category_id" FOREIGN KEY ("ProductCategoryId") REFERENCES public."PRODUCT_CATEGORY" ("Id");
ALTER TABLE public."SHELF_LIFE_DISCOUNT_TIER" ADD CONSTRAINT "fk_shelf_life_discount_tier_product_id" FOREIGN KEY ("ProductId") REFERENCES public."PRODUCT" ("Id");
ALTER TABLE public."SHELF_LIFE_DISCOUNT_TIER" ADD CONSTRAINT "fk_shelf_life_discount_tier_shelf_life_discount_table_id" FOREIGN KEY ("ShelfLifeDiscountTableId") REFERENCES public."SHELF_LIFE_DISCOUNT_TABLE" ("Id");
ALTER TABLE public."SHIPMENT" ADD CONSTRAINT "fk_shipment_driver_id" FOREIGN KEY ("DriverId") REFERENCES public."DRIVER" ("Id");
ALTER TABLE public."SHIPMENT" ADD CONSTRAINT "fk_shipment_picking_list_id" FOREIGN KEY ("PickingListId") REFERENCES public."PICKING_LIST" ("Id");
ALTER TABLE public."SHIPMENT" ADD CONSTRAINT "fk_shipment_sales_order_id" FOREIGN KEY ("SalesOrderId") REFERENCES public."SALES_ORDER" ("Id");
ALTER TABLE public."SHIPMENT" ADD CONSTRAINT "fk_shipment_vehicle_id" FOREIGN KEY ("VehicleId") REFERENCES public."VEHICLE" ("Id");
ALTER TABLE public."SHIPMENT" ADD CONSTRAINT "fk_shipment_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."SYSTEM_CONFIGURATION" ADD CONSTRAINT "fk_system_configuration_updated_by_user_id" FOREIGN KEY ("UpdatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."TRANSIT_TABLE" ADD CONSTRAINT "fk_transit_table_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."TRANSIT_TABLE_BAND" ADD CONSTRAINT "fk_transit_table_band_transit_table_id" FOREIGN KEY ("TransitTableId") REFERENCES public."TRANSIT_TABLE" ("Id");
ALTER TABLE public."TRANSIT_TIME_RULE" ADD CONSTRAINT "fk_transit_time_rule_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."USER_CREDENTIAL" ADD CONSTRAINT "fk_user_credential_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."USER_REGION_ASSIGNMENT" ADD CONSTRAINT "fk_user_region_assignment_region_id" FOREIGN KEY ("RegionId") REFERENCES public."REGION" ("Id");
ALTER TABLE public."USER_REGION_ASSIGNMENT" ADD CONSTRAINT "fk_user_region_assignment_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."USER_WAREHOUSE_ASSIGNMENT" ADD CONSTRAINT "fk_user_warehouse_assignment_user_account_id" FOREIGN KEY ("UserAccountId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."USER_WAREHOUSE_ASSIGNMENT" ADD CONSTRAINT "fk_user_warehouse_assignment_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."VEHICLE" ADD CONSTRAINT "fk_vehicle_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."WAREHOUSE" ADD CONSTRAINT "fk_warehouse_region_id" FOREIGN KEY ("RegionId") REFERENCES public."REGION" ("Id");
ALTER TABLE public."WRITE_OFF" ADD CONSTRAINT "fk_write_off_created_by_user_id" FOREIGN KEY ("CreatedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."WRITE_OFF" ADD CONSTRAINT "fk_write_off_warehouse_id" FOREIGN KEY ("WarehouseId") REFERENCES public."WAREHOUSE" ("Id");
ALTER TABLE public."WRITE_OFF_ATTACHMENT" ADD CONSTRAINT "fk_write_off_attachment_uploaded_by_user_id" FOREIGN KEY ("UploadedByUserId") REFERENCES public."USER_ACCOUNT" ("Id");
ALTER TABLE public."WRITE_OFF_ATTACHMENT" ADD CONSTRAINT "fk_write_off_attachment_write_off_id" FOREIGN KEY ("WriteOffId") REFERENCES public."WRITE_OFF" ("Id");
ALTER TABLE public."WRITE_OFF_ITEM" ADD CONSTRAINT "fk_write_off_item_batch_id" FOREIGN KEY ("BatchId") REFERENCES public."BATCH" ("Id");
ALTER TABLE public."WRITE_OFF_ITEM" ADD CONSTRAINT "fk_write_off_item_write_off_id" FOREIGN KEY ("WriteOffId") REFERENCES public."WRITE_OFF" ("Id");



-- ============================================================================
-- PHASE 3: Suggested foreign-key indexes (not taken from actual index metadata)
-- ============================================================================
CREATE INDEX IF NOT EXISTS "ix_account_token_user_account_id" ON public."ACCOUNT_TOKEN" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_complaint_evidence_receipt_discrepancy_id" ON public."COMPLAINT_EVIDENCE" ("ReceiptDiscrepancyId");
CREATE INDEX IF NOT EXISTS "ix_complaint_evidence_uploaded_by_user_id" ON public."COMPLAINT_EVIDENCE" ("UploadedByUserId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_program_retailer_loyalty_program_id" ON public."LOYALTY_PROGRAM_RETAILER" ("LoyaltyProgramId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_program_retailer_retailer_id" ON public."LOYALTY_PROGRAM_RETAILER" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_payment_receipt_retailer_id" ON public."PAYMENT_RECEIPT" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_payment_receipt_confirmed_by_user_id" ON public."PAYMENT_RECEIPT" ("ConfirmedByUserId");
CREATE INDEX IF NOT EXISTS "ix_payment_receipt_reversed_by_user_id" ON public."PAYMENT_RECEIPT" ("ReversedByUserId");
CREATE INDEX IF NOT EXISTS "ix_payment_receipt_allocation_payment_id" ON public."PAYMENT_RECEIPT_ALLOCATION" ("PaymentId");
CREATE INDEX IF NOT EXISTS "ix_payment_receipt_allocation_payment_receipt_id" ON public."PAYMENT_RECEIPT_ALLOCATION" ("PaymentReceiptId");
CREATE INDEX IF NOT EXISTS "ix_replacement_case_receipt_discrepancy_id" ON public."REPLACEMENT_CASE" ("ReceiptDiscrepancyId");
CREATE INDEX IF NOT EXISTS "ix_replacement_case_warehouse_id" ON public."REPLACEMENT_CASE" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_retailer_activation_challenge_user_account_id" ON public."RETAILER_ACTIVATION_CHALLENGE" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_retailer_declaration_contact_retailer_id" ON public."RETAILER_DECLARATION_CONTACT" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_allocation_batch_id" ON public."ALLOCATION" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_allocation_promotion_id" ON public."ALLOCATION" ("PromotionId");
CREATE INDEX IF NOT EXISTS "ix_allocation_sales_order_line_id" ON public."ALLOCATION" ("SalesOrderLineId");
CREATE INDEX IF NOT EXISTS "ix_allocation_warehouse_id" ON public."ALLOCATION" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_allocation_line_trace_allocation_run_id" ON public."ALLOCATION_LINE_TRACE" ("AllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_line_trace_allocation_run_line_id" ON public."ALLOCATION_LINE_TRACE" ("AllocationRunLineId");
CREATE INDEX IF NOT EXISTS "ix_allocation_plan_price_allocation_run_id" ON public."ALLOCATION_PLAN_PRICE" ("AllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_plan_price_allocation_run_line_id" ON public."ALLOCATION_PLAN_PRICE" ("AllocationRunLineId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_retry_of_allocation_run_id" ON public."ALLOCATION_RUN" ("RetryOfAllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_sales_order_id" ON public."ALLOCATION_RUN" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_allocation_allocation_run_id" ON public."ALLOCATION_RUN_ALLOCATION" ("AllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_allocation_allocation_run_line_id" ON public."ALLOCATION_RUN_ALLOCATION" ("AllocationRunLineId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_allocation_batch_id" ON public."ALLOCATION_RUN_ALLOCATION" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_line_allocation_run_order_id" ON public."ALLOCATION_RUN_LINE" ("AllocationRunOrderId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_line_sales_order_line_id" ON public."ALLOCATION_RUN_LINE" ("SalesOrderLineId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_order_allocation_run_id" ON public."ALLOCATION_RUN_ORDER" ("AllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_order_sales_order_id" ON public."ALLOCATION_RUN_ORDER" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_stock_allocation_run_id" ON public."ALLOCATION_RUN_STOCK" ("AllocationRunId");
CREATE INDEX IF NOT EXISTS "ix_allocation_run_stock_batch_id" ON public."ALLOCATION_RUN_STOCK" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_allocation_trace_candidate_allocation_line_trace_id" ON public."ALLOCATION_TRACE_CANDIDATE" ("AllocationLineTraceId");
CREATE INDEX IF NOT EXISTS "ix_allocation_trace_score_allocation_line_trace_id" ON public."ALLOCATION_TRACE_SCORE" ("AllocationLineTraceId");
CREATE INDEX IF NOT EXISTS "ix_audit_log_user_account_id" ON public."AUDIT_LOG" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_batch_parent_batch_id" ON public."BATCH" ("ParentBatchId");
CREATE INDEX IF NOT EXISTS "ix_batch_root_batch_id" ON public."BATCH" ("RootBatchId");
CREATE INDEX IF NOT EXISTS "ix_batch_goods_receipt_line_id" ON public."BATCH" ("GoodsReceiptLineId");
CREATE INDEX IF NOT EXISTS "ix_batch_product_id" ON public."BATCH" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_batch_warehouse_id" ON public."BATCH" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_batch_qr_label_batch_id" ON public."BATCH_QR_LABEL" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_batch_qr_label_parent_label_id" ON public."BATCH_QR_LABEL" ("ParentLabelId");
CREATE INDEX IF NOT EXISTS "ix_batch_qr_label_root_label_id" ON public."BATCH_QR_LABEL" ("RootLabelId");
CREATE INDEX IF NOT EXISTS "ix_batch_qr_label_goods_receipt_id" ON public."BATCH_QR_LABEL" ("GoodsReceiptId");
CREATE INDEX IF NOT EXISTS "ix_batch_qr_label_current_warehouse_id" ON public."BATCH_QR_LABEL" ("CurrentWarehouseId");
CREATE INDEX IF NOT EXISTS "ix_delivery_driver_id" ON public."DELIVERY" ("DriverId");
CREATE INDEX IF NOT EXISTS "ix_delivery_sales_order_id" ON public."DELIVERY" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_delivery_vehicle_id" ON public."DELIVERY" ("VehicleId");
CREATE INDEX IF NOT EXISTS "ix_driver_warehouse_id" ON public."DRIVER" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_goods_receipt_created_by_user_id" ON public."GOODS_RECEIPT" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_goods_receipt_approved_by_user_id" ON public."GOODS_RECEIPT" ("ApprovedByUserId");
CREATE INDEX IF NOT EXISTS "ix_goods_receipt_warehouse_id" ON public."GOODS_RECEIPT" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_goods_receipt_line_goods_receipt_id" ON public."GOODS_RECEIPT_LINE" ("GoodsReceiptId");
CREATE INDEX IF NOT EXISTS "ix_goods_receipt_line_product_id" ON public."GOODS_RECEIPT_LINE" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_idempotency_key_sales_order_id" ON public."IDEMPOTENCY_KEY" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_idempotency_key_user_account_id" ON public."IDEMPOTENCY_KEY" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_inventory_balance_batch_id" ON public."INVENTORY_BALANCE" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_inventory_lock_batch_id" ON public."INVENTORY_LOCK" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_inventory_lock_product_id" ON public."INVENTORY_LOCK" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_inventory_lock_locked_by_user_id" ON public."INVENTORY_LOCK" ("LockedByUserId");
CREATE INDEX IF NOT EXISTS "ix_inventory_lock_warehouse_id" ON public."INVENTORY_LOCK" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_batch_id" ON public."INVENTORY_TRANSACTION" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_goods_receipt_id" ON public."INVENTORY_TRANSACTION" ("GoodsReceiptId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_goods_receipt_line_id" ON public."INVENTORY_TRANSACTION" ("GoodsReceiptLineId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_product_id" ON public."INVENTORY_TRANSACTION" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_created_by_user_id" ON public."INVENTORY_TRANSACTION" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_inventory_transaction_warehouse_id" ON public."INVENTORY_TRANSACTION" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_program_created_by_user_id" ON public."LOYALTY_PROGRAM" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_reward_loyalty_program_id" ON public."LOYALTY_REWARD" ("LoyaltyProgramId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_transaction_loyalty_program_id" ON public."LOYALTY_TRANSACTION" ("LoyaltyProgramId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_transaction_retailer_loyalty_id" ON public."LOYALTY_TRANSACTION" ("RetailerLoyaltyId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_transaction_sales_order_id" ON public."LOYALTY_TRANSACTION" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_loyalty_transaction_created_by_user_id" ON public."LOYALTY_TRANSACTION" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_payment_id" ON public."MANUAL_REFUND" ("PaymentId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_receipt_discrepancy_id" ON public."MANUAL_REFUND" ("ReceiptDiscrepancyId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_sales_order_id" ON public."MANUAL_REFUND" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_submitted_by_user_id" ON public."MANUAL_REFUND" ("SubmittedByUserId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_verified_by_user_id" ON public."MANUAL_REFUND" ("VerifiedByUserId");
CREATE INDEX IF NOT EXISTS "ix_manual_refund_created_by_user_id" ON public."MANUAL_REFUND" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_map_distance_cache_origin_location_id" ON public."MAP_DISTANCE_CACHE" ("OriginLocationId");
CREATE INDEX IF NOT EXISTS "ix_map_distance_cache_destination_location_id" ON public."MAP_DISTANCE_CACHE" ("DestinationLocationId");
CREATE INDEX IF NOT EXISTS "ix_map_distance_cache_retailer_id" ON public."MAP_DISTANCE_CACHE" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_map_distance_cache_warehouse_id" ON public."MAP_DISTANCE_CACHE" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_map_location_retailer_id" ON public."MAP_LOCATION" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_map_location_warehouse_id" ON public."MAP_LOCATION" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_notification_outbox_message_id" ON public."NOTIFICATION" ("OutboxMessageId");
CREATE INDEX IF NOT EXISTS "ix_notification_sales_order_id" ON public."NOTIFICATION" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_notification_user_account_id" ON public."NOTIFICATION" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_order_promotion_promotion_id" ON public."ORDER_PROMOTION" ("PromotionId");
CREATE INDEX IF NOT EXISTS "ix_order_promotion_sales_order_line_id" ON public."ORDER_PROMOTION" ("SalesOrderLineId");
CREATE INDEX IF NOT EXISTS "ix_order_status_history_sales_order_id" ON public."ORDER_STATUS_HISTORY" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_order_status_history_changed_by_user_id" ON public."ORDER_STATUS_HISTORY" ("ChangedByUserId");
CREATE INDEX IF NOT EXISTS "ix_payment_sales_order_id" ON public."PAYMENT" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_payment_confirmed_by_user_id" ON public."PAYMENT" ("ConfirmedByUserId");
CREATE INDEX IF NOT EXISTS "ix_picking_item_allocation_id" ON public."PICKING_ITEM" ("AllocationId");
CREATE INDEX IF NOT EXISTS "ix_picking_item_source_batch_id" ON public."PICKING_ITEM" ("SourceBatchId");
CREATE INDEX IF NOT EXISTS "ix_picking_item_stock_out_batch_id" ON public."PICKING_ITEM" ("StockOutBatchId");
CREATE INDEX IF NOT EXISTS "ix_picking_item_picking_list_id" ON public."PICKING_ITEM" ("PickingListId");
CREATE INDEX IF NOT EXISTS "ix_picking_list_purchase_order_id" ON public."PICKING_LIST" ("PurchaseOrderId");
CREATE INDEX IF NOT EXISTS "ix_picking_list_assigned_to_user_id" ON public."PICKING_LIST" ("AssignedToUserId");
CREATE INDEX IF NOT EXISTS "ix_picking_list_confirmed_by_user_id" ON public."PICKING_LIST" ("ConfirmedByUserId");
CREATE INDEX IF NOT EXISTS "ix_picking_list_warehouse_id" ON public."PICKING_LIST" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_product_product_category_id" ON public."PRODUCT" ("ProductCategoryId");
CREATE INDEX IF NOT EXISTS "ix_product_replaces_product_id" ON public."PRODUCT" ("ReplacesProductId");
CREATE INDEX IF NOT EXISTS "ix_product_category_parent_category_id" ON public."PRODUCT_CATEGORY" ("ParentCategoryId");
CREATE INDEX IF NOT EXISTS "ix_product_price_product_id" ON public."PRODUCT_PRICE" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_promotion_created_by_user_id" ON public."PROMOTION" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_promotion_category_product_category_id" ON public."PROMOTION_CATEGORY" ("ProductCategoryId");
CREATE INDEX IF NOT EXISTS "ix_promotion_category_promotion_id" ON public."PROMOTION_CATEGORY" ("PromotionId");
CREATE INDEX IF NOT EXISTS "ix_promotion_product_product_id" ON public."PROMOTION_PRODUCT" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_promotion_product_promotion_id" ON public."PROMOTION_PRODUCT" ("PromotionId");
CREATE INDEX IF NOT EXISTS "ix_promotion_retailer_promotion_id" ON public."PROMOTION_RETAILER" ("PromotionId");
CREATE INDEX IF NOT EXISTS "ix_promotion_retailer_retailer_id" ON public."PROMOTION_RETAILER" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_qr_label_event_batch_qr_label_id" ON public."QR_LABEL_EVENT" ("BatchQrLabelId");
CREATE INDEX IF NOT EXISTS "ix_qr_label_event_performed_by_user_id" ON public."QR_LABEL_EVENT" ("PerformedByUserId");
CREATE INDEX IF NOT EXISTS "ix_qr_label_event_warehouse_id" ON public."QR_LABEL_EVENT" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_sales_order_id" ON public."RECEIPT_CONFIRMATION" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_shipment_id" ON public."RECEIPT_CONFIRMATION" ("ShipmentId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_confirmed_by_retailer_user_id" ON public."RECEIPT_CONFIRMATION" ("ConfirmedByRetailerUserId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_item_batch_id" ON public."RECEIPT_CONFIRMATION_ITEM" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_item_batch_qr_label_id" ON public."RECEIPT_CONFIRMATION_ITEM" ("BatchQrLabelId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_item_receipt_confirmation_id" ON public."RECEIPT_CONFIRMATION_ITEM" ("ReceiptConfirmationId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_item_sales_order_line_id" ON public."RECEIPT_CONFIRMATION_ITEM" ("SalesOrderLineId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_qr_label_batch_qr_label_id" ON public."RECEIPT_CONFIRMATION_QR_LABEL" ("BatchQrLabelId");
CREATE INDEX IF NOT EXISTS "ix_receipt_confirmation_qr_label_receipt_confirmation_id" ON public."RECEIPT_CONFIRMATION_QR_LABEL" ("ReceiptConfirmationId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_receipt_confirmation_id" ON public."RECEIPT_DISCREPANCY" ("ReceiptConfirmationId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_sales_order_id" ON public."RECEIPT_DISCREPANCY" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_reported_by_retailer_user_id" ON public."RECEIPT_DISCREPANCY" ("ReportedByRetailerUserId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_reviewed_by_user_id" ON public."RECEIPT_DISCREPANCY" ("ReviewedByUserId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_item_allocation_id" ON public."RECEIPT_DISCREPANCY_ITEM" ("AllocationId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_item_batch_id" ON public."RECEIPT_DISCREPANCY_ITEM" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_receipt_discrepancy_item_receipt_discrepancy_id" ON public."RECEIPT_DISCREPANCY_ITEM" ("ReceiptDiscrepancyId");
CREATE INDEX IF NOT EXISTS "ix_refresh_token_replaced_by_token_id" ON public."REFRESH_TOKEN" ("ReplacedByTokenId");
CREATE INDEX IF NOT EXISTS "ix_refresh_token_user_account_id" ON public."REFRESH_TOKEN" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_reservation_allocation_id" ON public."RESERVATION" ("AllocationId");
CREATE INDEX IF NOT EXISTS "ix_reservation_allocation_run_allocation_id" ON public."RESERVATION" ("AllocationRunAllocationId");
CREATE INDEX IF NOT EXISTS "ix_reservation_batch_id" ON public."RESERVATION" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_retailer_region_id" ON public."RETAILER" ("RegionId");
CREATE INDEX IF NOT EXISTS "ix_retailer_declared_by_user_id" ON public."RETAILER" ("DeclaredByUserId");
CREATE INDEX IF NOT EXISTS "ix_retailer_reviewed_by_user_id" ON public."RETAILER" ("ReviewedByUserId");
CREATE INDEX IF NOT EXISTS "ix_retailer_assessed_by_user_id" ON public."RETAILER" ("AssessedByUserId");
CREATE INDEX IF NOT EXISTS "ix_retailer_user_account_id" ON public."RETAILER" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_retailer_loyalty_retailer_id" ON public."RETAILER_LOYALTY" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_retailer_product_mlor_product_category_id" ON public."RETAILER_PRODUCT_MLOR" ("ProductCategoryId");
CREATE INDEX IF NOT EXISTS "ix_retailer_product_mlor_product_id" ON public."RETAILER_PRODUCT_MLOR" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_retailer_product_mlor_retailer_id" ON public."RETAILER_PRODUCT_MLOR" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_retailer_product_mlor_updated_by_user_id" ON public."RETAILER_PRODUCT_MLOR" ("UpdatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_retailer_sales_assignment_retailer_id" ON public."RETAILER_SALES_ASSIGNMENT" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_retailer_sales_assignment_sales_group_id" ON public."RETAILER_SALES_ASSIGNMENT" ("SalesGroupId");
CREATE INDEX IF NOT EXISTS "ix_reward_redemption_loyalty_reward_id" ON public."REWARD_REDEMPTION" ("LoyaltyRewardId");
CREATE INDEX IF NOT EXISTS "ix_reward_redemption_loyalty_transaction_id" ON public."REWARD_REDEMPTION" ("LoyaltyTransactionId");
CREATE INDEX IF NOT EXISTS "ix_reward_redemption_retailer_id" ON public."REWARD_REDEMPTION" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_reward_redemption_sales_order_id" ON public."REWARD_REDEMPTION" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_reward_redemption_redeemed_by_user_id" ON public."REWARD_REDEMPTION" ("RedeemedByUserId");
CREATE INDEX IF NOT EXISTS "ix_sales_group_region_id" ON public."SALES_GROUP" ("RegionId");
CREATE INDEX IF NOT EXISTS "ix_sales_group_member_sales_group_id" ON public."SALES_GROUP_MEMBER" ("SalesGroupId");
CREATE INDEX IF NOT EXISTS "ix_sales_group_member_user_account_id" ON public."SALES_GROUP_MEMBER" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_retailer_id" ON public."SALES_ORDER" ("RetailerId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_sales_group_id" ON public."SALES_ORDER" ("SalesGroupId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_created_by_user_id" ON public."SALES_ORDER" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_reviewed_by_user_id" ON public."SALES_ORDER" ("ReviewedByUserId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_attachment_sales_order_id" ON public."SALES_ORDER_ATTACHMENT" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_attachment_uploaded_by_user_id" ON public."SALES_ORDER_ATTACHMENT" ("UploadedByUserId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_line_mlor_product_category_id" ON public."SALES_ORDER_LINE" ("MlorProductCategoryId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_line_product_price_id" ON public."SALES_ORDER_LINE" ("ProductPriceId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_line_product_id" ON public."SALES_ORDER_LINE" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_line_mlor_source_rule_id" ON public."SALES_ORDER_LINE" ("MlorSourceRuleId");
CREATE INDEX IF NOT EXISTS "ix_sales_order_line_sales_order_id" ON public."SALES_ORDER_LINE" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_shelf_life_discount_table_created_by_user_id" ON public."SHELF_LIFE_DISCOUNT_TABLE" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_shelf_life_discount_tier_product_category_id" ON public."SHELF_LIFE_DISCOUNT_TIER" ("ProductCategoryId");
CREATE INDEX IF NOT EXISTS "ix_shelf_life_discount_tier_product_id" ON public."SHELF_LIFE_DISCOUNT_TIER" ("ProductId");
CREATE INDEX IF NOT EXISTS "ix_shelf_life_discount_tier_shelf_life_discount_table_id" ON public."SHELF_LIFE_DISCOUNT_TIER" ("ShelfLifeDiscountTableId");
CREATE INDEX IF NOT EXISTS "ix_shipment_driver_id" ON public."SHIPMENT" ("DriverId");
CREATE INDEX IF NOT EXISTS "ix_shipment_picking_list_id" ON public."SHIPMENT" ("PickingListId");
CREATE INDEX IF NOT EXISTS "ix_shipment_sales_order_id" ON public."SHIPMENT" ("SalesOrderId");
CREATE INDEX IF NOT EXISTS "ix_shipment_vehicle_id" ON public."SHIPMENT" ("VehicleId");
CREATE INDEX IF NOT EXISTS "ix_shipment_warehouse_id" ON public."SHIPMENT" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_system_configuration_updated_by_user_id" ON public."SYSTEM_CONFIGURATION" ("UpdatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_transit_table_created_by_user_id" ON public."TRANSIT_TABLE" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_transit_table_band_transit_table_id" ON public."TRANSIT_TABLE_BAND" ("TransitTableId");
CREATE INDEX IF NOT EXISTS "ix_transit_time_rule_warehouse_id" ON public."TRANSIT_TIME_RULE" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_user_credential_user_account_id" ON public."USER_CREDENTIAL" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_user_region_assignment_region_id" ON public."USER_REGION_ASSIGNMENT" ("RegionId");
CREATE INDEX IF NOT EXISTS "ix_user_region_assignment_user_account_id" ON public."USER_REGION_ASSIGNMENT" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_user_warehouse_assignment_user_account_id" ON public."USER_WAREHOUSE_ASSIGNMENT" ("UserAccountId");
CREATE INDEX IF NOT EXISTS "ix_user_warehouse_assignment_warehouse_id" ON public."USER_WAREHOUSE_ASSIGNMENT" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_vehicle_warehouse_id" ON public."VEHICLE" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_warehouse_region_id" ON public."WAREHOUSE" ("RegionId");
CREATE INDEX IF NOT EXISTS "ix_write_off_created_by_user_id" ON public."WRITE_OFF" ("CreatedByUserId");
CREATE INDEX IF NOT EXISTS "ix_write_off_warehouse_id" ON public."WRITE_OFF" ("WarehouseId");
CREATE INDEX IF NOT EXISTS "ix_write_off_attachment_uploaded_by_user_id" ON public."WRITE_OFF_ATTACHMENT" ("UploadedByUserId");
CREATE INDEX IF NOT EXISTS "ix_write_off_attachment_write_off_id" ON public."WRITE_OFF_ATTACHMENT" ("WriteOffId");
CREATE INDEX IF NOT EXISTS "ix_write_off_item_batch_id" ON public."WRITE_OFF_ITEM" ("BatchId");
CREATE INDEX IF NOT EXISTS "ix_write_off_item_write_off_id" ON public."WRITE_OFF_ITEM" ("WriteOffId");

COMMIT;

-- Count objects generated by the reconstruction. The values should be
-- 89 tables and 195 FK constraints on a new, otherwise empty public schema.
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

SELECT COUNT(*) AS total_foreign_keys
FROM pg_constraint AS c
JOIN pg_namespace AS n ON n.oid = c.connamespace
WHERE n.nspname = 'public' AND c.contype = 'f';

SELECT COUNT(*) AS total_public_indexes
FROM pg_indexes
WHERE schemaname = 'public';
-- Note: index count includes PK indexes as well as the suggested FK indexes.
