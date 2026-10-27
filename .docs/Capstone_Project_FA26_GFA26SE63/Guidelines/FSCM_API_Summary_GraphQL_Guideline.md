# Tổng quan API hiện có trong FSCM-Backend

Tại thời điểm rà soát ngày 13/10/2026, backend có:

- **84 REST endpoint nghiệp vụ**, nằm trong 16 controller.
- `GET /health` để health check.
- `/graphql`, hiện chỉ có query `status` trả về `"FSCM API is running"`.
- Swagger/OpenAPI trong môi trường Development.
- 6 role: `Admin`, `Operator`, `SalesManager`, `Sales`, `WarehouseKeeper`, `Retailer`.
- Kết quả kiểm thử: **43 unit test + 8 integration test đều pass**.

Nguồn đối chiếu:

- [FSCM_Business_Baseline_Before_Coding.md]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/temp/FSCM_Business_Baseline_Before_Coding.md)
- [Controllers]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers)
- [Application Features]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.Application/Features)

Quy ước quyền:

- **Công khai**: không cần access token.
- **Đã đăng nhập**: mọi role có JWT hợp lệ.
- Các API ghi dữ liệu thường giới hạn theo role và một số nghiệp vụ còn kiểm tra warehouse/sales-group scope trong service.

---

## 1. Xác thực và quản lý người dùng — 15 API

Nguồn: [AuthController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/AuthController.cs), [UsersController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/UsersController.cs)

### Xác thực — 7 API

| API                                        | Quyền        | Công dụng                                                                                                                                |
| ------------------------------------------ | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `POST /api/v1/auth/login`                  | Công khai    | Đăng nhập bằng email/password, trả access token, refresh token, thông tin user và scope. Khóa tài khoản 15 phút sau 5 lần sai liên tiếp. |
| `POST /api/v1/auth/refresh`                | Công khai    | Đổi refresh token cũ lấy bộ token mới; token cũ bị thu hồi.                                                                              |
| `POST /api/v1/auth/activate`               | Công khai    | Kích hoạt tài khoản bằng activation token và thiết lập mật khẩu.                                                                         |
| `POST /api/v1/auth/password-reset/request` | Công khai    | Tạo token đặt lại mật khẩu. Chỉ trả token trực tiếp trong Development; chưa thấy tích hợp gửi email thực tế.                             |
| `POST /api/v1/auth/password-reset/confirm` | Công khai    | Đặt mật khẩu mới bằng reset token và thu hồi các refresh token đang hoạt động.                                                           |
| `POST /api/v1/auth/logout`                 | Công khai    | Thu hồi refresh token được gửi lên; gọi lặp lại không gây lỗi.                                                                           |
| `GET /api/v1/auth/me`                      | Đã đăng nhập | Lấy hồ sơ user hiện tại, role, `MustChangePassword` và các warehouse/sales-group/retailer scope.                                         |

Mật khẩu kích hoạt/reset phải tối thiểu 12 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.

### Quản trị user — 8 API, chỉ Admin

| API                                                               | Công dụng                                                                                |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `POST /api/v1/users`                                              | Tạo user chưa kích hoạt và phát activation token. Không cho tạo tài khoản Admin qua API. |
| `GET /api/v1/users/{userId}/scope`                                | Xem user cùng warehouse, sales-group và retailer scope.                                  |
| `PATCH /api/v1/users/{userId}/role`                               | Đổi role; không cho gán role Admin qua API.                                              |
| `PATCH /api/v1/users/{userId}/status`                             | Active/inactive user; inactive sẽ thu hồi refresh token.                                 |
| `PUT /api/v1/users/{userId}/scope/warehouses/{warehouseId}`       | Gán user vào kho.                                                                        |
| `DELETE /api/v1/users/{userId}/scope/warehouses/{warehouseId}`    | Bỏ quyền truy cập kho.                                                                   |
| `PUT /api/v1/users/{userId}/scope/sales-groups/{salesGroupId}`    | Gán Sales/SalesManager vào nhóm Sales; đóng membership cũ để giữ lịch sử.                |
| `DELETE /api/v1/users/{userId}/scope/sales-groups/{salesGroupId}` | Kết thúc membership của user trong nhóm Sales.                                           |

Lưu ý: hiện **chưa có `GET /users` để tìm kiếm hoặc liệt kê user**. Admin account cũng không thể bị sửa qua các API quản trị trên.

Phục vụ baseline:

- Sáu actor/role.
- Role-based authorization.
- Warehouse scope và Sales-group scope.
- Nguyên tắc Admin account không được tạo từ UI thông thường.
- Inactive thay cho xóa user.

---

## 2. Danh mục ngành hàng và sản phẩm — 16 API

Nguồn: [CategoriesController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/CategoriesController.cs), [ProductsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/ProductsController.cs)

### Category — 5 API

| API                                            | Quyền        | Công dụng                                             |
| ---------------------------------------------- | ------------ | ----------------------------------------------------- |
| `GET /api/v1/categories?includeInactive=`      | Đã đăng nhập | Danh sách category, tùy chọn gồm cả inactive.         |
| `GET /api/v1/categories/{categoryId}`          | Đã đăng nhập | Chi tiết category.                                    |
| `POST /api/v1/categories`                      | Admin        | Tạo category với mã `CAT-xx`, hỗ trợ parent category. |
| `PUT /api/v1/categories/{categoryId}`          | Admin        | Sửa tên, mô tả và quan hệ cha-con.                    |
| `PATCH /api/v1/categories/{categoryId}/status` | Admin        | Active/inactive category.                             |

Các kiểm soát chính:

- Không cho tạo chu trình cha-con.
- Không cho inactive category đang có category con active.
- Không cho inactive category có sản phẩm `Draft` hoặc `Published`.
- Không hard-delete category, phù hợp baseline.

### Product/SKU — 11 API

| API                                                 | Quyền        | Công dụng                                                                      |
| --------------------------------------------------- | ------------ | ------------------------------------------------------------------------------ |
| `GET /api/v1/products`                              | Đã đăng nhập | Tìm kiếm/phân trang theo `search`, `categoryId`, `status`, `page`, `pageSize`. |
| `GET /api/v1/products/{productId}`                  | Đã đăng nhập | Chi tiết SKU, category, shelf life, trạng thái và giá hiện hành.               |
| `POST /api/v1/products`                             | Admin        | Tạo SKU ở trạng thái `Draft`, mã dạng `SKUxxx`, kèm giá ban đầu nếu có.        |
| `PUT /api/v1/products/{productId}`                  | Admin        | Sửa Draft product. Không cho sửa sản phẩm đã publish.                          |
| `DELETE /api/v1/products/{productId}`               | Admin        | Xóa Draft product và giá liên quan.                                            |
| `POST /api/v1/products/{productId}/publish`         | Admin        | Publish SKU; bắt buộc phải có giá active.                                      |
| `POST /api/v1/products/{productId}/inactivate`      | Admin        | Chuyển `Published → Inactive`.                                                 |
| `POST /api/v1/products/{productId}/replacement`     | Admin        | Tạo SKU thay thế ở trạng thái Draft, kế thừa category và có thể kế thừa giá.   |
| `GET /api/v1/products/{productId}/prices`           | Đã đăng nhập | Xem toàn bộ lịch sử giá.                                                       |
| `GET /api/v1/products/{productId}/price-suggestion` | Đã đăng nhập | Gợi ý giá từ lịch sử giá của SKU hoặc SKU tiền nhiệm.                          |
| `POST /api/v1/products/{productId}/prices`          | Admin        | Thiết lập giá mới; đóng giá hiện hành để giữ lịch sử.                          |

Khi publish SKU thay thế, SKU tiền nhiệm đang Published được tự động chuyển sang Inactive.

Phục vụ baseline:

- Đúng lifecycle `Draft → Published → Inactive`.
- Chỉ Draft được sửa/xóa.
- Published bị khóa master data.
- Thay đổi lớn được thực hiện bằng replacement SKU.
- Lưu lịch sử giá thay vì ghi đè, giúp giữ snapshot và truy vết giá sau này.

---

## 3. Kho, ETA, MLOR và cấu hình — 12 API

Nguồn: [WarehousesController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/WarehousesController.cs), [MlorConfigurationsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/MlorConfigurationsController.cs), [BusinessConfigurationsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/BusinessConfigurationsController.cs)

### Warehouse — 7 API

| API                                                       | Quyền        | Công dụng                                                             |
| --------------------------------------------------------- | ------------ | --------------------------------------------------------------------- |
| `GET /api/v1/warehouses?includeInactive=`                 | Đã đăng nhập | Danh sách kho.                                                        |
| `GET /api/v1/warehouses/{warehouseId}`                    | Đã đăng nhập | Chi tiết kho, loại kho, địa chỉ và tọa độ.                            |
| `POST /api/v1/warehouses`                                 | Admin        | Tạo kho `Central` hoặc `Regional`, mã bắt đầu bằng `WH-`.             |
| `PUT /api/v1/warehouses/{warehouseId}`                    | Admin        | Sửa tên, loại kho, địa chỉ, tọa độ; không đổi business code.          |
| `PATCH /api/v1/warehouses/{warehouseId}/status`           | Admin        | Active/inactive kho.                                                  |
| `GET /api/v1/warehouses/{warehouseId}/transit-time-rules` | Đã đăng nhập | Lấy các khoảng cách, handling time, transit time và bán kính phục vụ. |
| `PUT /api/v1/warehouses/{warehouseId}/transit-time-rules` | Admin        | Thay toàn bộ bộ quy tắc ETA; bộ cũ được inactive để giữ lịch sử.      |

### MLOR — 2 API

| API                                | Quyền        | Công dụng                                                                                               |
| ---------------------------------- | ------------ | ------------------------------------------------------------------------------------------------------- |
| `GET /api/v1/mlor-configurations`  | Đã đăng nhập | Tra cứu MLOR theo `retailerId`, `productId`, có thể gồm lịch sử inactive.                               |
| `POST /api/v1/mlor-configurations` | Admin        | Thiết lập MLOR cho cặp Retailer–Product bằng tỷ lệ và/hoặc số giờ tối thiểu. Bản cũ được đóng hiệu lực. |

Kiểm soát:

- `MinimumLifeRatio` phải lớn hơn 0 và không quá 1.
- `MinimumLifeHours` không được vượt tổng shelf life của sản phẩm.

### Business configuration — 3 API

| API                                        | Quyền        | Công dụng                                                             |
| ------------------------------------------ | ------------ | --------------------------------------------------------------------- |
| `GET /api/v1/configurations`               | Đã đăng nhập | Xem các cấu hình hiện hành.                                           |
| `GET /api/v1/configurations/{key}/history` | Đã đăng nhập | Xem toàn bộ version của một cấu hình.                                 |
| `PUT /api/v1/configurations/{key}`         | Admin        | Tạo version cấu hình mới, giữ version trước để phục vụ lịch sử/audit. |

Hiện chỉ hỗ trợ 4 key:

- `allocation.weights`: trọng số expiry/distance/coverage, tổng phải bằng 1.
- `allocation.service_radius_meters`: mặc định 20 km.
- `replenishment.regional_minimum_stock_cartons`: mặc định 35 thùng.
- `mlor.default_ratio`: MLOR mặc định.

Phục vụ baseline:

- Mô hình Central/Regional warehouse.
- Dữ liệu khoảng cách và ETA cho hard filter.
- MLOR theo Retailer–SKU.
- Các tham số nền của thuật toán allocation và replenishment.
- Version hóa cấu hình để thay đổi chỉ ảnh hưởng nghiệp vụ về sau.

Điểm còn thiếu: baseline còn yêu cầu cấu hình discount tier, credit term, loyalty rate và ranking threshold nhưng các key này chưa có.

---

## 4. Lãnh thổ và nhóm Sales — 15 API

Nguồn: [RegionsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/RegionsController.cs), [SalesGroupsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/SalesGroupsController.cs), [TerritoryAssignmentsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/TerritoryAssignmentsController.cs), [TerritoryAccessController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/TerritoryAccessController.cs)

### Region — 5 API

| API                                       | Quyền        | Công dụng                                                       |
| ----------------------------------------- | ------------ | --------------------------------------------------------------- |
| `GET /api/v1/regions`                     | Đã đăng nhập | Danh sách region, mặc định bỏ inactive.                         |
| `GET /api/v1/regions/{regionId}`          | Đã đăng nhập | Chi tiết region.                                                |
| `POST /api/v1/regions`                    | Admin        | Tạo region, mã gồm 2–4 ký tự in hoa/chữ số.                     |
| `PUT /api/v1/regions/{regionId}`          | Admin        | Sửa tên và mô tả.                                               |
| `PATCH /api/v1/regions/{regionId}/status` | Admin        | Active/inactive; không cho inactive khi còn Sales group active. |

### Sales group — 5 API

| API                                                | Quyền        | Công dụng                                                                          |
| -------------------------------------------------- | ------------ | ---------------------------------------------------------------------------------- |
| `GET /api/v1/sales-groups`                         | Đã đăng nhập | Danh sách, lọc theo region và trạng thái.                                          |
| `GET /api/v1/sales-groups/{salesGroupId}`          | Đã đăng nhập | Chi tiết nhóm Sales.                                                               |
| `POST /api/v1/sales-groups`                        | Admin        | Tạo nhóm với mã dạng `{Region}-A`.                                                 |
| `PUT /api/v1/sales-groups/{salesGroupId}`          | Admin        | Đổi tên nhóm.                                                                      |
| `PATCH /api/v1/sales-groups/{salesGroupId}/status` | Admin        | Active/inactive; không cho inactive nếu còn Sales hoặc Retailer assignment active. |

### Assignment — 4 API, Admin hoặc SalesManager

| API                                                        | Công dụng                                                             |
| ---------------------------------------------------------- | --------------------------------------------------------------------- |
| `GET /api/v1/territory-assignments/sales`                  | Xem lịch sử/current membership của Sales theo nhóm hoặc user.         |
| `PUT /api/v1/territory-assignments/sales/{userId}`         | Chuyển Sales sang nhóm mới; đóng assignment cũ và tạo assignment mới. |
| `GET /api/v1/territory-assignments/retailers`              | Xem assignment Retailer–Sales group.                                  |
| `PUT /api/v1/territory-assignments/retailers/{retailerId}` | Chuyển Retailer sang nhóm mới trong cùng region.                      |

SalesManager chỉ được quản lý assignment thuộc nhóm mà họ đang là thành viên active. Admin có quyền toàn cục.

### Kiểm tra quyền đặt hàng — 1 API, chỉ Sales

`GET /api/v1/territory-access/retailers/{retailerId}/order-eligibility`

API kiểm tra:

- User phải là Sales active.
- Retailer phải được duyệt và active.
- Sales và Retailer phải có assignment chung trong lãnh thổ.
- Trả `CanCreateOrder`, Sales group hiện hành và lý do bị từ chối.

Phục vụ trực tiếp quy tắc baseline: **Sales chỉ được tạo đơn cho Retailer thuộc territory được phân công**.

---

## 5. Quản lý Retailer — 7 API

Nguồn: [RetailersController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/RetailersController.cs)

| API                                                    | Quyền                                | Công dụng                                                                                  |
| ------------------------------------------------------ | ------------------------------------ | ------------------------------------------------------------------------------------------ |
| `GET /api/v1/retailers?status=`                        | Admin, Operator, SalesManager, Sales | Danh sách Retailer theo scope và trạng thái.                                               |
| `GET /api/v1/retailers/{retailerId}`                   | Các role trên                        | Xem chi tiết Retailer nếu nằm trong phạm vi được nhìn thấy.                                |
| `POST /api/v1/retailers`                               | Sales                                | Khai báo Retailer mới trong territory của Sales.                                           |
| `PUT /api/v1/retailers/{retailerId}/declaration`       | Sales khai báo                       | Sửa bản khai đang Pending/Rejected rồi gửi lại PendingApproval.                            |
| `POST /api/v1/retailers/{retailerId}/review`           | Admin                                | Approve/reject khai báo; reject bắt buộc có lý do.                                         |
| `PATCH /api/v1/retailers/{retailerId}/status`          | Admin                                | Chuyển `Active ↔ Inactive`.                                                                |
| `GET /api/v1/retailers/{retailerId}/order-eligibility` | Sales                                | Kiểm tra eligibility trước khi tạo đơn. Có chức năng gần tương đương Territory Access API. |

Luồng:

```
Sales khai báo
→ mã KB-xxxx
→ PendingApproval
→ Admin approve
→ mã Retailer 8 chữ số
→ Active
```

Dữ liệu và quy tắc đã triển khai:

- Loại Retailer: grocery, mini supermarket, convenience store, market stall.
- Doanh thu dự báo.
- Diện tích cửa hàng.
- Sức mua dự kiến.
- Tần suất mua.
- Credit term: `0/7/14/30`.
- Tự phân hạng tiềm năng A/B/C đúng ngưỡng trong baseline.
- Store size category S/M/L.
- Chỉ Sales khai báo mới được sửa declaration.
- Không hard-delete Retailer.

---

## 6. Nhập kho và tồn kho theo batch — 6 API

Nguồn: [GoodsReceiptsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/GoodsReceiptsController.cs), [InventoryController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/InventoryController.cs)

### Goods receipt — 3 API

| API                                       | Quyền                            | Công dụng                                                           |
| ----------------------------------------- | -------------------------------- | ------------------------------------------------------------------- |
| `GET /api/v1/goods-receipts?warehouseId=` | Admin, Operator, WarehouseKeeper | Danh sách phiếu nhập theo scope kho.                                |
| `GET /api/v1/goods-receipts/{receiptId}`  | Các role trên                    | Chi tiết phiếu nhập và từng dòng batch.                             |
| `POST /api/v1/goods-receipts`             | WarehouseKeeper                  | Nhập hàng vào kho được phân công. Yêu cầu header `Idempotency-Key`. |

Khi nhận hàng:

- Chỉ nhận sản phẩm `Published`.
- Số lượng phải là số nguyên dương theo đơn vị carton.
- Không nhận hàng đã hết hạn hoặc hết hạn trong ngày.
- Cùng `Warehouse + SKU + ExpiryDate` được gộp vào một batch.
- Batch code theo `{WarehouseCode}-{SKU}-{ddMMyyyy}`.
- Tăng `Physical/OnHand` và tính lại `Available`.
- Ghi inventory transaction/history.
- Idempotency ngăn tạo phiếu nhập trùng khi client retry.

### Inventory — 3 API

| API                                       | Quyền                            | Công dụng                                                            |
| ----------------------------------------- | -------------------------------- | -------------------------------------------------------------------- |
| `GET /api/v1/inventory`                   | Admin, Operator, WarehouseKeeper | Danh sách tồn kho, lọc `warehouseId`, `productId`, `includeExpired`. |
| `GET /api/v1/inventory/batches/{batchId}` | Các role trên                    | Chi tiết một batch.                                                  |
| `GET /api/v1/inventory/history`           | Các role trên                    | Lịch sử biến động theo warehouse hoặc batch.                         |

Kết quả tồn kho trả:

- `OnHandQuantity`/physical.
- `HeldQuantity`.
- `ReservedQuantity`.
- `AvailableQuantity`.
- Trạng thái `Valid`, `NearExpiry`, `Expired`.
- Version phục vụ optimistic concurrency.

Công thức đã sử dụng:

```
Available = Physical/On Hand - Held - Reserved
```

Tuy nhiên, hiện chưa có API order/allocation nên chưa có luồng thực tế chuyển `Available → Held → Reserved`.

---

## 7. QR label và truy xuất nguồn gốc — 5 API

Nguồn: [QrLabelsController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/QrLabelsController.cs)

| API                                     | Quyền                            | Công dụng                                                        |
| --------------------------------------- | -------------------------------- | ---------------------------------------------------------------- |
| `GET /api/v1/qr-labels`                 | Admin, Operator, WarehouseKeeper | Danh sách tem theo warehouse hoặc batch.                         |
| `GET /api/v1/qr-labels/{qrCode}`        | Các role trên                    | Chi tiết tem, toàn bộ lineage cha-con và lịch sử event.          |
| `POST /api/v1/qr-labels`                | WarehouseKeeper                  | Sinh tem cho một lượng hàng trong batch.                         |
| `POST /api/v1/qr-labels/{qrCode}/split` | WarehouseKeeper                  | Tách một phần số lượng thành child tag; parent giữ phần còn lại. |
| `POST /api/v1/qr-labels/{qrCode}/scans` | WarehouseKeeper                  | Scan với action `Inspect`, `Issue` hoặc `Receive`.               |

Đặc điểm:

- QR payload chỉ chứa QR code.
- Mã tem được quản lý dạng `TEM-xxxxxx`.
- Theo dõi batch, warehouse, số lượng, trạng thái và parent/root lineage.
- Trạng thái tem: `Available`, `InTransit`, `Invalidated`.
- `ExpectedVersion` chống cập nhật đồng thời.
- `Idempotency-Key` chống xử lý trùng.
- WarehouseKeeper chỉ thao tác trên kho được phân công.
- Khi nhận sang kho mới, destination batch phải cùng product và thuộc kho nhận.

Chưa có API cho Retailer scan/confirm nhận hàng; QR hiện chỉ phục vụ vận hành kho và điều chuyển nội bộ.

---

## 8. Điều chuyển Central → Regional — 8 API

Nguồn: [InternalTransfersController.cs]\(D:/FPT_UNIVERSITY/Semester9/GraduationThesis/CODE/FSCM/FSCM-Backend/src/FSCM.API/Controllers/InternalTransfersController.cs)

| API                                             | Quyền                            | Công dụng                                                                           |
| ----------------------------------------------- | -------------------------------- | ----------------------------------------------------------------------------------- |
| `GET /api/v1/internal-transfers/suggestions`    | Admin, Operator                  | Gợi ý bổ sung kho Regional khi tồn available dưới ngưỡng.                           |
| `GET /api/v1/internal-transfers`                | Admin, Operator, WarehouseKeeper | Danh sách phiếu, lọc theo warehouse/status; WarehouseKeeper bị giới hạn theo scope. |
| `GET /api/v1/internal-transfers/{id}`           | Các role trên                    | Chi tiết phiếu, item, QR label và event history.                                    |
| `POST /api/v1/internal-transfers`               | Admin, Operator                  | Tạo yêu cầu điều chuyển Central → Regional.                                         |
| `POST /api/v1/internal-transfers/{id}/approve`  | Admin, Operator                  | Phê duyệt phiếu đang Requested.                                                     |
| `POST /api/v1/internal-transfers/{id}/reject`   | Admin, Operator                  | Từ chối phiếu, bắt buộc có lý do.                                                   |
| `POST /api/v1/internal-transfers/{id}/dispatch` | WarehouseKeeper kho nguồn        | Scan toàn bộ tem và xuất hàng khỏi Central warehouse.                               |
| `POST /api/v1/internal-transfers/{id}/receive`  | WarehouseKeeper kho đích         | Scan toàn bộ tem, nhập vào Regional warehouse.                                      |

Luồng:

```
Requested
→ Approved hoặc Rejected
→ InTransit
→ Received
```

Nghiệp vụ đã có:

- Chỉ cho phép kho nguồn active `Central` và kho đích active `Regional`.
- Gợi ý khi tồn kho Regional thấp hơn `regional_minimum_stock_cartons`.
- Chọn batch Central theo FEFO.
- Khi tạo phiếu cũng kiểm tra người dùng đã chọn đúng thứ tự FEFO.
- Không cho chuyển batch hết hạn.
- Không cho số lượng vượt `Available`.
- Dispatch phải scan đủ toàn bộ item và đúng tổng số lượng.
- Khi dispatch, giảm physical/on-hand ở kho nguồn.
- Khi receive, tạo hoặc gộp batch tại kho đích theo SKU + expiry.
- QR code được giữ nguyên để bảo toàn traceability.
- Có optimistic concurrency bằng `ExpectedVersion`.
- Mọi command dùng `Idempotency-Key`.
- Có event history cho Created, Approved, Rejected, Dispatched, Received.

Đây là luồng **Central → Regional đã được baseline phê duyệt**. Backend không cho tạo Regional → Regional nên chưa vô tình triển khai proposal đang chờ GVHD.

---

# Mức độ đáp ứng FSCM_Business_Baseline

## Đã triển khai khá đầy đủ

| Phạm vi baseline                       | API hiện có                                              |
| -------------------------------------- | -------------------------------------------------------- |
| Actor, JWT, role và scope              | Auth + Users                                             |
| Product/category master data           | Categories + Products                                    |
| Product lifecycle                      | Draft/Published/Inactive/Replacement                     |
| Lịch sử giá                            | Product Prices                                           |
| Central/Regional warehouse             | Warehouses                                               |
| Khoảng cách và ETA rule                | Transit Time Rules                                       |
| MLOR Retailer–Product                  | MLOR Configurations                                      |
| Business configuration có version      | Configurations                                           |
| Region/Sales group                     | Regions + Sales Groups                                   |
| Territory assignment và kiểm tra quyền | Territory Assignments/Access                             |
| Khai báo, đánh giá Retailer            | Retailers                                                |
| Batch và nhập kho                      | Goods Receipts                                           |
| On Hand/Held/Reserved/Available model  | Inventory                                                |
| QR và split child tag                  | QR Labels                                                |
| Central → Regional replenishment       | Internal Transfers                                       |
| FEFO trong replenishment               | Suggestions + transfer validation                        |
| Idempotency cho thao tác kho           | Goods receipt, QR, transfer                              |
| Không hard-delete master data          | Chủ yếu dùng inactive; riêng Draft product được phép xóa |

## Mới triển khai một phần

| Phạm vi                   | Hiện trạng                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------ |
| Inventory Hold → Reserved | Có field và công thức nhưng chưa có order/allocation API để tạo hold/reservation.                |
| MLOR hard filter          | Có dữ liệu MLOR nhưng chưa có allocation engine sử dụng MLOR theo ETA.                           |
| Allocation weights/Dmax   | Đã cấu hình được nhưng chưa có API chạy weighted scoring/greedy allocation.                      |
| Audit                     | Có price/config/assignment/inventory/QR/transfer history, nhưng chưa có API audit log tập trung. |
| Shelf-life handling       | Có trạng thái NearExpiry và threshold theo product, chưa có discount program.                    |
| Credit/debt               | Retailer có credit term `0/7/14/30`, chưa có order payment/due date/overdue flow.                |
| Order eligibility         | Kiểm tra được Sales–Retailer nhưng chưa thể tạo order.                                           |
| Business configuration    | Mới có 4 key, chưa bao phủ toàn bộ cấu hình baseline.                                            |

## Chưa có API

Mặc dù một số entity/database model đã được tạo, chưa thấy controller hoặc application service công khai cho các nhóm sau:

1. **Sales Order**
   - Tạo đơn bởi Sales.
   - Offline order sync.
   - Idempotency theo temporary order ID.
   - Order snapshot.
   - PendingApproval/Approved/Issued/Delivering/Delivered.
   - Reject/cancel order.
2. **Order Allocation**
   - Hard filter theo expired, available, Dmax, ETA, MLOR.
   - Weighted score `wE/wD/wQ`.
   - Greedy multi-batch/multi-warehouse.
   - Toàn bộ đơn hoặc từ chối, không partial fulfillment.
   - Held → Reserved → release/issue.
3. **Promotion và batch shelf-life discount**
   - Discount suggestion 5%/10%/15%.
   - Admin áp dụng discount 1%–50%.
   - Promotion áp dụng theo product/category/retailer.
   - Price snapshot sau promotion/discount.
4. **Picking và fulfillment**
   - Tạo picking list.
   - Xác nhận pick/issue cho sales order.
   - Giảm On Hand khi Warehouse Keeper xác nhận xuất đơn.
5. **Delivery**
   - Vehicle master data.
   - Delivery-person master data.
   - Operator chọn vehicle/driver.
   - Delivery status và delivery snapshot.
6. **Payment và debt**
   - Prepaid/COD/Credit.
   - Ghi nhận full payment.
   - Due date.
   - Unpaid/Paid/Overdue.
   - Sales thu tiền mặt, Operator ghi nhận chuyển khoản.
7. **Sales KPI và ranking**
   - Revenue after promotion.
   - Successful orders.
   - Retailers served/new retailers.
   - Promotion/revenue ratio.
   - Top products và ranking.
8. **Loyalty**
   - Loyalty program.
   - Point ledger.
   - Pending Earn/Earn.
   - Gift master data và redemption approval.
   - Point expiry/refund.
9. **Complaint**
   - Retailer tạo complaint.
   - Operator xử lý complaint.
   - Chưa có luồng khiếu nại độc lập.
10. **Retailer receipt confirmation**
    - Retailer scan đầy đủ tag.
    - Xác nhận nhận hàng.
    - Kích hoạt loyalty earning.

---

# Đánh giá tổng thể

Backend hiện tại đã xây dựng tốt phần **master data và nền tảng kho**:

```
Identity
→ Catalog
→ Warehouse/MLOR/configuration
→ Territory
→ Retailer
→ Goods receipt
→ Batch inventory
→ QR traceability
→ Central-to-Regional replenishment
```

Nhưng core flow quan trọng nhất trong baseline vẫn đang dừng trước bước tạo đơn:

```
Sales chọn Retailer hợp lệ       ✅
Retailer và product master       ✅
Tồn kho/batch/MLOR/ETA           ✅
Create Sales Order               ❌
Weighted allocation + Hold       ❌
Approve + Reserved               ❌
Picking/Issue                    ❌
Delivery                         ❌
Payment/Debt                     ❌
Loyalty                          ❌
```

Vì vậy có thể kết luận: **84 REST endpoint hiện tại hoàn thành phần nền tảng và warehouse replenishment, nhưng chưa hoàn thành end-to-end business flow từ Sales Order đến Delivery/Payment/Loyalty được mô tả trong FSCM Business Baseline.**
---

# 9. Quy ước tích hợp cho Frontend và Mobile: ưu tiên GraphQL cho đọc dữ liệu

> **Mục đích:** tránh để Frontend/Mobile phụ thuộc quá nhiều vào nhiều REST `GET` endpoint riêng lẻ. Với các màn hình cần đọc dữ liệu, team nên ưu tiên GraphQL Query. REST tiếp tục dùng cho các thao tác thay đổi trạng thái hoặc ghi dữ liệu.

## 9.1. Quy ước chung

Backend FSCM nên áp dụng hướng sau:

```text
READ / QUERY          -> GraphQL
WRITE / COMMAND       -> REST

GET                   -> ưu tiên GraphQL Query
POST                  -> REST
PUT                   -> REST
PATCH                 -> REST
DELETE                -> REST
```

Ngoại lệ nên giữ REST:

- `GET /health`: health check / infrastructure endpoint.
- Các endpoint kỹ thuật đặc thù nếu sau này có yêu cầu tích hợp ngoài hệ thống và REST phù hợp hơn.

GraphQL không có nghĩa là toàn bộ REST hiện tại phải bị xóa ngay. Trong giai đoạn chuyển đổi, REST GET có thể tiếp tục tồn tại để tránh làm hỏng client cũ, nhưng Frontend/Mobile mới nên ưu tiên GraphQL.

---

## 9.2. Frontend/Mobile không nên suy nghĩ theo kiểu "mỗi màn hình = nhiều GET endpoint"

Ví dụ màn Product Detail có thể cần:

- thông tin Product/SKU;
- Category;
- giá hiện hành;
- lịch sử giá;
- tồn kho theo warehouse;
- batch và expiry date.

Nếu dùng REST thuần, client có thể phải gọi nhiều API:

```text
GET /api/v1/products/{productId}
GET /api/v1/products/{productId}/prices
GET /api/v1/inventory?productId={productId}
GET /api/v1/warehouses/...
```

Với GraphQL, client nên yêu cầu đúng dữ liệu màn hình cần trong một query, ví dụ:

```graphql
query ProductDetail($id: UUID!) {
  product(id: $id) {
    id
    sku
    name
    status
    shelfLifeDays

    category {
      id
      name
    }

    currentPrice {
      amount
    }

    prices {
      amount
      effectiveFrom
      effectiveTo
    }

    inventory {
      warehouse {
        id
        code
        name
      }

      onHandQuantity
      heldQuantity
      reservedQuantity
      availableQuantity

      batches {
        id
        expiryDate
        availableQuantity
      }
    }
  }
}
```

Client chỉ lấy những field thực sự cần render.

---

## 9.3. Các nhóm GET hiện tại phù hợp để chuyển sang GraphQL Query

### Auth / Current user

REST hiện có:

```text
GET /api/v1/auth/me
```

GraphQL dự kiến:

```graphql
query {
  me {
    id
    fullName
    email
    role
    mustChangePassword
    warehouseScopes
    salesGroupScopes
    retailerScopes
  }
}
```

### User / Scope

REST hiện có:

```text
GET /api/v1/users/{userId}/scope
```

GraphQL dự kiến:

```graphql
query UserScope($userId: UUID!) {
  userScope(userId: $userId) {
    warehouses { id code name }
    salesGroups { id code name }
    retailers { id code name }
  }
}
```

> Lưu ý: backend hiện chưa có `GET /users` để tìm kiếm/liệt kê user. Nếu UI Admin cần danh sách user thì nên thiết kế GraphQL query `users(...)` thay vì tạo thêm REST GET mới, trừ khi có lý do tích hợp cụ thể.

### Category

REST hiện có:

```text
GET /api/v1/categories
GET /api/v1/categories/{categoryId}
```

GraphQL dự kiến:

```graphql
type Query {
  categories(includeInactive: Boolean): [Category!]!
  category(id: UUID!): Category
}
```

### Product / SKU

REST hiện có:

```text
GET /api/v1/products
GET /api/v1/products/{productId}
GET /api/v1/products/{productId}/prices
GET /api/v1/products/{productId}/price-suggestion
```

GraphQL dự kiến:

```graphql
type Query {
  products(
    search: String
    categoryId: UUID
    status: ProductStatus
    page: Int
    pageSize: Int
  ): ProductPage!

  product(id: UUID!): Product
}
```

Các quan hệ như `prices`, `currentPrice`, `priceSuggestion`, `category`, `inventory` nên được expose thông qua field của Product khi hợp lý.

### Warehouse / ETA rules

REST hiện có:

```text
GET /api/v1/warehouses
GET /api/v1/warehouses/{warehouseId}
GET /api/v1/warehouses/{warehouseId}/transit-time-rules
```

GraphQL dự kiến:

```graphql
type Query {
  warehouses(includeInactive: Boolean): [Warehouse!]!
  warehouse(id: UUID!): Warehouse
}
```

Ví dụ:

```graphql
query WarehouseDetail($id: UUID!) {
  warehouse(id: $id) {
    id
    code
    name
    type
    address
    latitude
    longitude

    transitTimeRules {
      minDistanceMeters
      maxDistanceMeters
      handlingMinutes
      transitMinutes
      serviceRadiusMeters
    }
  }
}
```

### MLOR

REST hiện có:

```text
GET /api/v1/mlor-configurations
```

GraphQL dự kiến:

```graphql
query MlorConfigurations($retailerId: UUID, $productId: UUID) {
  mlorConfigurations(retailerId: $retailerId, productId: $productId) {
    id
    retailerId
    productId
    minimumLifeRatio
    minimumLifeHours
    isActive
  }
}
```

### Business configuration

REST hiện có:

```text
GET /api/v1/configurations
GET /api/v1/configurations/{key}/history
```

GraphQL dự kiến:

```graphql
type Query {
  configurations: [BusinessConfiguration!]!
  configurationHistory(key: String!): [BusinessConfigurationVersion!]!
}
```

### Region / Sales Group / Territory

REST hiện có:

```text
GET /api/v1/regions
GET /api/v1/regions/{regionId}
GET /api/v1/sales-groups
GET /api/v1/sales-groups/{salesGroupId}
GET /api/v1/territory-assignments/sales
GET /api/v1/territory-assignments/retailers
GET /api/v1/territory-access/retailers/{retailerId}/order-eligibility
```

GraphQL dự kiến:

```graphql
type Query {
  regions: [Region!]!
  region(id: UUID!): Region

  salesGroups(regionId: UUID, includeInactive: Boolean): [SalesGroup!]!
  salesGroup(id: UUID!): SalesGroup

  salesAssignments(salesGroupId: UUID, userId: UUID): [SalesAssignment!]!
  retailerAssignments(salesGroupId: UUID, retailerId: UUID): [RetailerAssignment!]!

  retailerOrderEligibility(retailerId: UUID!): OrderEligibility!
}
```

### Retailer

REST hiện có:

```text
GET /api/v1/retailers
GET /api/v1/retailers/{retailerId}
GET /api/v1/retailers/{retailerId}/order-eligibility
```

GraphQL dự kiến:

```graphql
type Query {
  retailers(
    status: RetailerStatus
    search: String
    regionId: UUID
    salesGroupId: UUID
    page: Int
    pageSize: Int
  ): RetailerPage!

  retailer(id: UUID!): Retailer
}
```

Các field liên quan như `orderEligibility`, territory, assigned sales group có thể được expose khi cần.

### Goods Receipt

REST hiện có:

```text
GET /api/v1/goods-receipts
GET /api/v1/goods-receipts/{receiptId}
```

GraphQL dự kiến:

```graphql
type Query {
  goodsReceipts(warehouseId: UUID, page: Int, pageSize: Int): GoodsReceiptPage!
  goodsReceipt(id: UUID!): GoodsReceipt
}
```

### Inventory

REST hiện có:

```text
GET /api/v1/inventory
GET /api/v1/inventory/batches/{batchId}
GET /api/v1/inventory/history
```

GraphQL dự kiến:

```graphql
type Query {
  inventory(
    warehouseId: UUID
    productId: UUID
    includeExpired: Boolean
    page: Int
    pageSize: Int
  ): InventoryPage!

  inventoryBatch(id: UUID!): InventoryBatch

  inventoryHistory(
    warehouseId: UUID
    batchId: UUID
    page: Int
    pageSize: Int
  ): InventoryHistoryPage!
}
```

Inventory là một trong các nhóm nên ưu tiên GraphQL vì UI thường cần Product + Warehouse + Batch + quantity cùng lúc.

### QR Label

REST hiện có:

```text
GET /api/v1/qr-labels
GET /api/v1/qr-labels/{qrCode}
```

GraphQL dự kiến:

```graphql
type Query {
  qrLabels(warehouseId: UUID, batchId: UUID): [QrLabel!]!
  qrLabel(code: String!): QrLabel
}
```

Chi tiết QR có thể bao gồm lineage và event history.

### Internal Transfer

REST hiện có:

```text
GET /api/v1/internal-transfers/suggestions
GET /api/v1/internal-transfers
GET /api/v1/internal-transfers/{id}
```

GraphQL dự kiến:

```graphql
type Query {
  internalTransferSuggestions(
    warehouseId: UUID
    productId: UUID
  ): [InternalTransferSuggestion!]!

  internalTransfers(
    warehouseId: UUID
    status: InternalTransferStatus
    page: Int
    pageSize: Int
  ): InternalTransferPage!

  internalTransfer(id: UUID!): InternalTransfer
}
```

---

## 9.4. Các API ghi dữ liệu tiếp tục dùng REST

Frontend/Mobile không nên cố chuyển các command sang GraphQL chỉ để "dùng GraphQL cho tất cả".

Các thao tác sau vẫn gọi REST:

```text
POST
PUT
PATCH
DELETE
```

Ví dụ:

```text
POST  /api/v1/auth/login
POST  /api/v1/auth/refresh
POST  /api/v1/auth/logout

POST  /api/v1/products
PUT   /api/v1/products/{id}
DELETE /api/v1/products/{id}
POST  /api/v1/products/{id}/publish
POST  /api/v1/products/{id}/inactivate

POST  /api/v1/goods-receipts
POST  /api/v1/qr-labels
POST  /api/v1/qr-labels/{qrCode}/split
POST  /api/v1/qr-labels/{qrCode}/scans

POST  /api/v1/internal-transfers
POST  /api/v1/internal-transfers/{id}/approve
POST  /api/v1/internal-transfers/{id}/reject
POST  /api/v1/internal-transfers/{id}/dispatch
POST  /api/v1/internal-transfers/{id}/receive
```

Sau này các module Sales Order, Allocation, Picking, Delivery, Payment, Loyalty, Complaint... cũng nên giữ nguyên nguyên tắc:

```text
Query/read        -> GraphQL
Command/write     -> REST
```

---

## 9.5. Lưu ý quan trọng cho Frontend/Mobile

### Không hard-code tư duy theo REST endpoint

Frontend/Mobile nên tổ chức data-access theo business feature thay vì theo từng URL REST.

Ví dụ nên có:

```text
productService
inventoryService
retailerService
warehouseService
internalTransferService
```

Trong mỗi service có thể sử dụng cả GraphQL và REST:

```text
productService
├── getProducts()          -> GraphQL
├── getProductDetail()     -> GraphQL
├── createProduct()        -> REST POST
├── updateProduct()        -> REST PUT
├── publishProduct()       -> REST POST
└── inactivateProduct()    -> REST POST
```

Nhờ vậy UI không phụ thuộc trực tiếp vào việc backend expose REST hay GraphQL.

### Không gọi REST GET chỉ vì endpoint đang tồn tại

Các REST GET hiện có chủ yếu là implementation hiện tại của backend. Chúng không nên được xem là contract bắt buộc cho client mới nếu cùng dữ liệu đã được expose qua GraphQL.

Khi backend bổ sung GraphQL Query tương ứng:

```text
Frontend Web  -> ưu tiên GraphQL
Sales Mobile  -> ưu tiên GraphQL
Retailer App  -> ưu tiên GraphQL
```

REST GET chỉ nên được dùng tạm thời khi GraphQL query tương ứng chưa được triển khai.

### Client chỉ query field thực sự cần

Không nên tạo một query cực lớn cho mọi màn hình.

Ví dụ màn danh sách Product chỉ cần:

```graphql
query Products($search: String, $page: Int, $pageSize: Int) {
  products(search: $search, page: $page, pageSize: $pageSize) {
    items {
      id
      sku
      name
      status
      currentPrice {
        amount
      }
    }
    totalCount
  }
}
```

Không cần lấy batch, inventory history, QR lineage nếu màn hình không sử dụng chúng.

### Pagination/filter vẫn phải thực hiện ở backend

GraphQL không có nghĩa là tải toàn bộ dữ liệu về client rồi tự filter.

Các danh sách lớn như:

- Product;
- Retailer;
- Inventory;
- Goods Receipt;
- Internal Transfer;
- tương lai là Order/Delivery/Payment;

vẫn phải hỗ trợ:

```text
search
filter
sort
page/pageSize hoặc cursor pagination
```

ở server.

### GraphQL vẫn phải tuân thủ role và scope

Việc chuyển từ REST GET sang GraphQL không được bỏ qua authorization.

Ví dụ:

- WarehouseKeeper chỉ xem kho được phân công.
- Sales chỉ xem Retailer thuộc territory/scope được phép.
- SalesManager chỉ xem dữ liệu trong sales group được quản lý.
- Retailer chỉ xem dữ liệu của chính Retailer đó nếu module Retailer App được expose.

GraphQL resolver phải gọi Application/Business layer đang có thay vì bypass trực tiếp xuống database.

Luồng chuẩn:

```text
Frontend / Mobile
       |
       v
GraphQL Query
       |
       v
Application / Business Service
       |
       v
Repository
       |
       v
EF Core / SQL Server
```

Không nên để resolver tự chứa business rule hoặc expose trực tiếp `DbContext` cho client query tùy ý.

---

## 9.6. Khuyến nghị cho Backend khi triển khai GraphQL

Hiện `/graphql` mới có query `status`. Vì vậy backend cần bổ sung business queries dần theo feature thay vì chuyển toàn bộ cùng lúc.

Thứ tự ưu tiên hợp lý:

```text
Phase 1
- Categories
- Products
- Warehouses
- Retailers
- Inventory

Phase 2
- Regions
- Sales Groups
- Territory assignments
- MLOR
- Configurations

Phase 3
- Goods Receipts
- QR Labels
- Internal Transfers

Phase 4
- Sales Orders
- Allocation
- Picking
- Delivery
- Payment
- KPI/Ranking
- Loyalty
- Complaint
```

Trong giai đoạn migration:

```text
REST GET cũ      -> giữ để client cũ không lỗi
GraphQL Query    -> client mới ưu tiên dùng
```

Sau khi Web/Mobile không còn sử dụng REST GET cũ:

```text
REST GET
   -> đánh dấu deprecated
   -> kiểm tra usage
   -> remove nếu không còn consumer
```

---

## 9.7. Quy ước ngắn gọn cho team Frontend/Mobile

> ### FSCM Client API Rule
>
> 1. **Đọc dữ liệu:** ưu tiên GraphQL Query.
> 2. **Tạo/cập nhật/xóa/thay đổi trạng thái:** dùng REST API.
> 3. Không gọi nhiều REST GET nếu một GraphQL query có thể trả đúng data graph cho màn hình.
> 4. Chỉ query các field màn hình thực sự cần.
> 5. Search/filter/sort/pagination phải được truyền xuống backend, không tải toàn bộ về client.
> 6. REST GET hiện tại có thể dùng tạm khi GraphQL query tương ứng chưa tồn tại.
> 7. Authorization và scope vẫn do backend enforce; client không được tự giả định quyền dựa vào UI.
> 8. Frontend/Mobile nên bọc toàn bộ API access trong service/repository layer của client để không phụ thuộc trực tiếp vào transport REST hay GraphQL.

---

# 10. Kiến trúc tích hợp mục tiêu

```text
                  FSCM Clients
          +-------------------------+
          | Web Portal              |
          | Sales Mobile App        |
          | Retailer Mobile App     |
          +------------+------------+
                       |
          +------------+-------------+
          |                          |
          v                          v
   GraphQL /graphql             REST /api/v1/...
      READ / QUERY             WRITE / COMMAND
          |                          |
          +------------+-------------+
                       |
                       v
            Application / Business
                       |
                       v
                  Repository
                       |
                       v
                EF Core / SQL Server
```

Mục tiêu cuối cùng không phải là loại bỏ REST hoàn toàn mà là **dùng đúng công cụ cho đúng loại tác vụ**:

- GraphQL giúp Web/Mobile đọc đúng cấu trúc dữ liệu cần cho từng màn hình và giảm phụ thuộc vào nhiều endpoint GET nhỏ.
- REST giữ command rõ ràng, dễ audit, dễ áp dụng idempotency, authorization và business workflow.
- Business rule vẫn nằm ở Application/Business layer, không nằm trong GraphQL resolver hoặc UI.

---

# 11. Ghi chú trạng thái hiện tại cho team

Tính đến tài liệu rà soát ngày 13/10/2026:

- Backend có **84 REST endpoint nghiệp vụ**.
- `/graphql` đã tồn tại nhưng mới có query `status`.
- Vì vậy Frontend/Mobile **chưa thể lập tức thay tất cả REST GET bằng GraphQL** cho đến khi backend expose các Query tương ứng.
- Trong thời gian đó, client được phép dùng REST GET hiện tại để phát triển.
- Với feature/query mới, backend nên ưu tiên bổ sung GraphQL Query thay vì tiếp tục tạo thêm nhiều GET endpoint nếu dữ liệu đó phục vụ UI đọc dữ liệu.
- Các REST command hiện có tiếp tục là contract chính cho thao tác thay đổi dữ liệu.

Quy ước này nên được xem là hướng tích hợp chung của FSCM để Backend, Frontend Web và Mobile phát triển nhất quán về sau.
