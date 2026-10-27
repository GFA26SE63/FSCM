# FSCM Sequence Diagrams

Các script trong thư mục này được viết bằng Mermaid `sequenceDiagram` để có thể dán trực tiếp vào draw.io: **Arrange → Insert → Advanced → Mermaid**.

## Visual Paradigm notation

Script đã được chuẩn hóa theo quy ước UML sequence diagram thường dùng trong Visual Paradigm:

- Actor dùng `actor "Role" as Alias`.
- Boundary dùng nhãn `Interface: UI`.
- Control dùng nhãn `mainController: Controller` hoặc `...Service: Service`.
- Entity/database dùng nhãn `...: Entity` và `PostgreSQL: Database`.
- Message gọi dùng mũi tên nét liền `->>`; các operation có response tương ứng mở activation bar bằng `->>+`.
- Message trả về dùng mũi tên nét đứt `-->>`; activation được đóng bằng `-->>-` khi có cặp response tương ứng.
- `alt`, `else`, `opt`, `loop` biểu diễn combined fragments UML.

Mermaid không tái tạo hoàn toàn màu sắc của Visual Paradigm, nhưng cấu trúc lifeline, stereotype, activation và return message đã được giữ theo cùng convention.

## Quy ước đã dùng

- `UI` là Portal/Mobile/Warehouse/Retailer client; `API` là ASP.NET API; `App` là application service; `DB` là PostgreSQL.
- Sơ đồ bám backend ở `FSCM-Backend` và các quyết định Scope V10 trong `temp/`.
- Retailer không tự đăng ký và không tự đặt hàng; Sales là người tạo đơn.
- MLOR được khai báo cùng retailer theo Category/SKU; thứ tự resolve là Retailer-SKU → Category → default.
- Allocation chọn batch thỏa MLOR trước, sau đó mới tính HSD discount theo rule versioned SKU → Category.
- Không dùng `Held`; `Available = OnHand - Reserved`. Tentative allocation chỉ nằm trong allocation run.
- Offline order chỉ được Sales gửi thủ công qua `/api/v1/orders/sync` (alias `/offline`), có idempotency; không có background sync.
- Allocation job đọc `allocation_run` từ schedule đã publish; fallback trong code là `00:00` Asia/Ho_Chi_Minh.
- PayOS chỉ xác nhận thanh toán bằng verified webhook; return URL chỉ phục vụ UX.
- Google sign-in chưa có route trong backend hiện tại; sơ đồ Authentication ghi rõ nhánh bị từ chối.

Các script được đánh tên theo chuẩn SDD mục 3.1–3.9 và mã Figure tương ứng, ví dụ:

`3.1.2-user-authentication-system-google-account.mmd`

`3.6.2-allocate-inventory-across-warehouses-including-receipt-time-estimation.mmd`

## Folder structure

Các file đã được phân bổ theo cùng tên module với Class Diagram:

- `Authentication & User Account Sequence Diagram`
- `Retailer Registration & Assessment Sequence Diagram`
- `Product & Category Management Sequence Diagram`
- `Promotion & Batch Discount Management Sequence Diagram`
- `Purchase Order & Offline Synchronization Sequence Diagram`
- `FEFO–MLOR Allocation & Availability Sequence Diagram`
- `Warehouse Receiving & Batch Inventory Sequence Diagram`
- `Picking & Retailer Receipt Confirmation Sequence Diagram`
- `Payment & Loyalty Management Sequence Diagram`
- `Sales Groups & Operational Reporting Sequence Diagram`
- `System Configuration & Notifications Sequence Diagram`
- `Delivery Operations Sequence Diagram`
- `Daily Allocation Run, Approval & Reservation Sequence Diagram`
- `Batch Pricing & Price Traceability Sequence Diagram`
- `Inventory Expiry Monitoring & Stock Blocking Sequence Diagram`
- `Shipment Readiness, Dispatch & Exception Handling Sequence Diagram`
- `Accounts Receivable & Debt Collection Sequence Diagram`
- `Complaint, Financial Adjustment & Manual Refund Sequence Diagram`

Các nhóm bổ sung tương ứng với SDD mục 3.10–3.18; tổng cộng hiện có 52 sequence-diagram script.
