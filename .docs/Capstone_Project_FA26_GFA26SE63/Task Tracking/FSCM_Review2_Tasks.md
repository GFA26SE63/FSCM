# FSCM (FA26SE083) — Review 2 Task Checklist

**Nguồn:** `SWP490_R2_Huong-dan-chuan-bi-Review-2_1.pdf`  
**Quy ước:** `[X]` \= đã có bằng chứng hoàn thành trong các file được cung cấp; `[ ]` \= còn cần thực hiện hoặc chưa thể xác minh. Việc có file không đồng nghĩa toàn bộ nội dung đã hoàn thiện.

**Record of Changes:** Các bảng đầu Report 1–5 được công nhận là Record of Changes (không cần file riêng). BM03 của Registration vẫn là yêu cầu riêng theo hướng dẫn.

## 1\. Hồ sơ nộp Review 2

### 1.1. Registration — Phiếu đăng ký chốt phạm vi

- [x] Chuẩn bị phiếu đăng ký đề tài phiên bản đề xuất chốt theo mẫu môn học.  
- [x] Cập nhật thông tin đề tài, nhóm, bối cảnh, phạm vi, FR, NFR và công nghệ dự kiến.  
- [ ] Lập BM03 — Record of Changes; ghi rõ thay đổi hoặc `No changes`. **(Hoàng)**  
- [x] Đánh phiên bản phiếu đăng ký và giải trình các thay đổi phạm vi.  
- [ ] Đối chiếu phạm vi Registration với Report 1, SRS, SDD và Design Brief. **(Sau khi hoàn thiện tất cả tài liệu liên quan)**  
- [ ] Xuất `SWP490_FA26SE083_R2_Registration.pdf`. **(Sau khi hoàn thiện tài liệu)**

### 1.2. Report 1–5 và Project Tracking

- [x] Chuẩn bị Report 1 — Project Introduction.  
- [x] Chuẩn bị Report 2 — Project Management Plan.  
- [x] Chuẩn bị Report 3 — Software Requirement Specification (SRS).  
- [x] Chuẩn bị Report 4 — Software Design Document (SDD).  
- [x] Chuẩn bị Report 5 — Software Test Documentation.  
- [x] Chuẩn bị Project Schedule.  
- [ ] Cập nhật Project Tracking theo tiến độ Iteration 1 và phạm vi chốt. **(Nhân)**  
- [ ] Xuất Report 1–5 và Project Tracking thành PDF theo tên quy định. **(FINAL)**  
- [ ] Gắn tag `review-2` cho repository chứa mã nguồn Iteration 1, database scripts, tests và cấu hình CI. **(Hải)**

### 1.3. BM02 — SRS/SDD Self-Review **(Hải)**

- [ ] Chuẩn bị BM02 — Self-Review Report.  
- [ ] Chạy nguyên văn prompt chuẩn bằng coding agent có quyền đọc repository tại tag `review-2`.  
- [ ] Đối chiếu Registration, SRS, SDD, sơ đồ, source code và database scripts.  
- [ ] Ghi công cụ AI, model, ngày chạy và phiên bản Registration dùng làm căn cứ.  
- [ ] Lưu nguyên vẹn bảng kết quả AI: `ID | Category | Location | Finding | Severity | Evidence`.  
- [ ] Ghi lại năm finding quan trọng nhất.  
- [ ] Điền Team response cho từng finding: `Fixed` \+ commit, `Kept` \+ lý do, hoặc `Planned` \+ owner/deadline.  
- [ ] Liên kết finding mức High được giữ lại hoặc lên kế hoạch với mục Known Gaps trong Design Brief.  
- [ ] Xuất `SWP490_FA26SE083_R2_SelfReview.pdf`.

### 1.4. BM01 — Design Brief **(Nhân)**

- [ ] Chuẩn bị Design Brief bằng tiếng Anh theo BM01, mục 0–8 và Phụ lục A.  
- [ ] Kiểm tra giới hạn 4 trang A4 cho mục 0–8 (không tính Phụ lục A), font 11, lề 2 cm.  
- [ ] Xuất `SWP490_FA26SE083_R2_DesignBrief.pdf`.

## 2\. Nội dung và tính nhất quán của Report 1–5

### 2.1. Report 1 — Project Introduction **(Khiết)**

- [x] Cập nhật Project Information và Project Team.  
- [x] Trình bày Product Background, Existing Systems và Business Opportunity.  
- [x] Trình bày Software Product Vision.  
- [x] Liệt kê Major Features, Scope, Limitations và Exclusions.  
- [x] Cập nhật System Context Diagram theo phạm vi và công nghệ hiện hành. **(Hoàng)**  
- [x] Đối chiếu các FR ở Report 1 với Registration và SRS.  
- [x] Cập nhật Record of Changes.

### 2.2. Report 2 — Project Management Plan / Project Schedule **(Hoàng)**

- [x] Cập nhật Scope & Estimation, Objectives, Risks và Effort Allocation.  
- [x] Cập nhật Management Approach, Quality Management và Training Plan.  
- [x] Cập nhật Project Deliverables, Responsibility Assignments và Communications.  
- [x] Cập nhật Configuration Management, Source Code Management và Tools & Infrastructure.  
- [ ] Đồng bộ Project Schedule với các mốc Iteration 1, Review 2 và Defense 1.1.  
- [ ] Xác định đầu ra, người phụ trách và deadline cho các mốc quan trọng.  
- [ ] Đối chiếu phân công ở Report 2 với Ownership Map.  
- [ ] Đồng bộ lịch kiểm thử giữa Report 2 và Report 5\.  
- [ ] Cập nhật Project Tracking cho các nhiệm vụ trong kế hoạch.

### 2.3. Report 3 — SRS **(Sơn)**

- [x] Hoàn thiện Product Overview và System Context.  
- [x] Đặc tả Actors và Use Cases.  
- [x] Đặc tả Functional Requirements cho các nhóm chức năng.  
- [ ] Gắn actor và acceptance criteria có thể kiểm thử cho từng FR.  
- [ ] Đặc tả NFR với metric, threshold và measurement method.  
- [x] Cập nhật Business Rules, Common Requirements và Application Messages.  
- [ ] Đồng bộ Use Cases, FR và Business Rules cho allocation, approval, reservation, payment, refund và loyalty.  
- [ ] Đối chiếu phạm vi chức năng giữa Registration và SRS.  
- [ ] Đối chiếu các yêu cầu với SDD và code theo kết quả Self-Review.

### 2.4. Report 4 — SDD

#### System & architecture design **(Khiết)**

- [x] Hoàn thiện System Overview/Architecture Diagram: components, external services và luồng dữ liệu chính. (Bổ sung dịch vụ còn thiếu: Google Maps)  
- [x] Cập nhật System Overview/Architecture Diagram vào report 4  
- [x] Vẽ Package Diagrams và mô tả packages/namespaces.&nbsp;  
- [x] Thêm Package diagram vào report 4 (Đã có trong Drive)

#### Database design **(Hoàng)**

- [ ] Xây dựng Logical ERD đầy đủ cho phạm vi chốt.  
- [ ] Lập table descriptions, PK, FK và các ràng buộc dữ liệu.  
- [ ] Tạo database scripts/migrations theo Logical ERD.  
- [ ] Đối chiếu entity/attribute/table giữa SRS, ERD và database scripts.

#### State machine diagrams **(Khiết)**

- [x] Vẽ state machine cho toàn bộ các entity có state/lifecycle trong hệ thống  
- [x] Đối chiếu state, transition, trigger FR và implementation.  
- [ ] Bổ sung các state machine diagram vào report 4

#### Activity diagrams / business flows **(Sơn)**

- [ ] Vẽ Activity Diagram F1 – Quản lý nguồn hàng, nhập kho và kiểm soát tồn kho theo Batch/Lot.  
- [ ] Vẽ Activity Diagram F2 – Đăng ký Retailer, thiết lập MLOR, khuyến mãi, tạo Sales Order và đồng bộ offline.  
- [ ] Vẽ Activity Diagram F3 – Phân bổ FEFO–MLOR hàng ngày, phê duyệt kết quả và Reservation.  
- [ ] Vẽ Activity Diagram F4 – Xử lý đơn hàng, Picking, xuất kho, giao hàng và xác nhận nhận hàng.  
- [ ] Vẽ Activity Diagram F5 – Đối soát thanh toán, hoàn tất đơn, Loyalty, đổi quà, khiếu nại và hoàn tiền.  
- [ ] Kiểm tra tính nhất quán và liên kết giữa 5 luồng nghiệp vụ F1–F5.  
- [ ] Liên kết 5 Activity Diagrams với Phụ lục A, SRS, SDD và các State Machine tương ứng.  
- [ ] Chuẩn hóa UML, lưu mã nguồn Mermaid/PlantUML và bổ sung sơ đồ vào Report 4\.

#### Detailed design

- [x] Vẽ Class Diagrams cho các functional groups. **(Hải)**  
- [ ] Vẽ Sequence Diagrams cho các luồng nghiệp vụ khác biệt. **(Sơn)**  
- [ ] Thiết kế transaction boundaries, idempotency, concurrency và exception handling. **(Sau khi hoàn thiện report 1, 2, 3 cùng tất cả các diagram)**

#### Technology & DevOps declaration **(Khiết)**

- [ ] Liệt kê third-party services, mục đích và dữ liệu gửi đi. (Đã có tên dịch vụ và một phần mục đích trong Report 1; cần bổ sung dữ liệu gửi đi và đưa vào Report 4.)&nbsp;  
- [ ] Khai báo Front-end, Back-end, Mobile, Database và phiên bản. (Đã có tên công nghệ trong Report 1; cần bổ sung phiên bản và đưa vào Report 4.)&nbsp;  
- [ ] Mô tả repository platform, CI/CD và branching rules.  
      - [x] Khai báo GitHub Organization để quản lý source code.  
      - [x] Sử dụng Git quản lý lịch sử thay đổi.  
      - [x] Phát triển trên các branch riêng.  
      - [x] Sử dụng Pull Request để review trước khi merge.  
      - [x] Quy định `main` là nhánh chứa mã nguồn ổn định.  
      - [x] Quy định commit message và quyền truy cập repository.  
      - [x] Chưa mô tả CI/CD pipeline, các bước build, test và deploy.  
      - [x] Chưa khai báo cụ thể GitHub Actions workflow.  
- [ ] Mô tả dev/staging/production, deployment procedure và rollback.&nbsp;  
      - [x] Xác định nền tảng triển khai Web Frontend.  
      - [x] Xác định nền tảng cloud cho Backend và Worker.  
      - [x] Chưa mô tả riêng ba môi trường Development, Staging và Production.  
      - [ ] Thiếu chi tiết môi trường staging  
      - [x] Chưa xác định cấu hình và nơi triển khai cụ thể của từng môi trường.  
      - [x] Chưa có deployment procedure.  
      - [x] Chưa có application rollback procedure.  
- [ ] Khai báo AI tools, models và các giai đoạn sử dụng.  
      - [x] Report 2 mục 6.3 có liệt kê Kiro trong nhóm IDEs/Editors.  
      - [x] Chưa có bảng khai báo đầy đủ AI tools sử dụng.  
      - [ ] Chưa ghi tên AI models.  
      - [x] Chưa mô tả công cụ/model nào được sử dụng trong requirements, design, coding, testing hoặc review.  
- [ ] Lưu source Mermaid/PlantUML cho các sơ đồ trong repository.  
      - [x] Report 2 mục 6.3 khai báo Mermaid.js là công cụ vẽ sơ đồ.  
      - [ ] Chưa xác minh source Mermaid/PlantUML của các sơ đồ được lưu trong repository.  
      - [ ] Chưa xác minh các sơ đồ trong Report 3 và Report 4 có source tương ứng.  
      - [ ] Chưa xác minh source diagram thuộc phiên bản Git tag `review-2`.  
- [ ] Chuẩn hóa ngày, phiên bản, chú thích hình và nội dung template trong SDD.  
      - [x] Có tên báo cáo Software Design Document.  
      - [x] Có bảng Record of Changes.  
      - [x] Có chú thích `Figure 1. FSCM High-Level System Architecture diagram`.  
      - [x] Bìa vẫn ghi Hanoi, August 2019\.  
      - [x] Record of Changes ghi năm 2016, không khớp phiên bản 2026\.  
      - [ ] Package Diagram và Package Descriptions còn nội dung template.  
      - [ ] Database Design còn sơ đồ ví dụ và bảng mẫu.  
      - [ ] Nhiều Class Diagram và Sequence Diagram vẫn có placeholder `[Insert Figure ...]`.  
      - [ ] Delivery Operations Class Diagram vẫn ghi `PENDING`.  
      - [ ] Chưa thể kiểm tra tính nhất quán của toàn bộ chú thích hình khi các sơ đồ chưa được bổ sung.

### 2.5. Report 5 — Software Test Documentation **(Hải)**

- [ ] Cập nhật Scope of Testing theo phạm vi Registration.  
- [x] Xây dựng Test Strategy: testing types, test levels và supporting tools.  
- [x] Lập Test Plan: human resources, test environment và test milestones.  
- [ ] Ghi Start Date/End Date cho các test milestones.  
- [ ] Thiết kế test cases cho từng mandatory feature và acceptance criterion.  
- [ ] Thiết kế end-to-end test cases cho từng main workflow.  
- [ ] Thiết kế positive, negative, boundary và exception tests.  
- [ ] Thiết kế tests cho các state transitions.  
- [ ] Thiết kế NFR tests theo metric, threshold và measurement method.  
- [ ] Thiết kế tests cho allocation, pricing, full-order fulfillment, QR receipt, payment, refund và loyalty.  
- [ ] Chuẩn hóa test case fields: ID, precondition, steps, test data, expected/actual result và status.  
- [ ] Lập test execution reports, Pass/Fail statistics, defect log và evidence.  
- [ ] Tích hợp automated tests với CI và lưu kết quả chạy.  
- [ ] Đồng bộ mục tiêu và ngưỡng kiểm thử với Phụ lục A.

## 3\. BM01 — Design Brief mục 0–8 **(Nhân)**

- [ ] **0\. Header:** Project code/name, group, supervisor, repo/tag, version và date.  
- [ ] **1\. Scope:** Scope changes, exclusions và rationale.  
- [ ] **2\. System at a Glance:** Problem, target users và architecture reference (tối đa 150 từ).  
- [ ] **3\. Key Design Decisions:** Đúng 5 quyết định; alternatives, chosen solution, rationale và owner.  
- [ ] **4\. Top Risks:** Đúng 3 rủi ro; impact và validation/mitigation.  
- [ ] **5\. Known Gaps:** Registration–SRS–SDD–code mismatches và resolution plan.  
- [ ] **6\. Mandatory Features:** Features, measurable acceptance criteria và associated tests.  
- [ ] **7\. NFRs:** Metrics, thresholds và measurement methods (tối đa 6 dòng).  
- [ ] **8\. Ownership Map:** 2–3 phần/người, ít nhất một main workflow/người, tất cả phần quan trọng có owner.

## 4\. Phụ lục A — Defense 1.1 Targets **(Nhân)**

### 4.1. Main Workflows

- [ ] Xác định danh sách main workflows (ít nhất 5 workflow cho nhóm 5 người).  
- [ ] Kiểm tra điều kiện của mỗi workflow: ít nhất 2 actors **hoặc** ít nhất 3 mandatory features.  
- [ ] Kiểm tra mỗi workflow có state change của ít nhất một thực thể chính.  
- [ ] Ghi Workflow ID, Actors, Business Outcome, Features, Entity State Transitions và Owner.  
- [ ] Chỉ định đúng một owner cho mỗi workflow.  
- [ ] Liên kết workflow với activity diagram trong SDD.

### 4.2. Demo Scenarios

- [ ] Xây dựng ít nhất một main scenario cho mỗi workflow.  
- [ ] Xây dựng ít nhất một exception scenario cho mỗi workflow.  
- [ ] Ghi Scenario ID, workflow, type, preconditions, test data, steps và expected result.  
- [ ] Chuẩn bị môi trường staging cho demo.  
- [ ] Chuẩn bị demo seed scripts và dữ liệu đầu vào thay đổi được.  
- [ ] Kiểm tra khả năng chạy lại các demo scenarios.

### 4.3. Functional Test Case Commitment

- [ ] Xác định `F`: số mandatory features.  
- [ ] Xác định `W`: số main workflows.  
- [ ] Xác định `S`: số state transitions cần kiểm thử.  
- [ ] Xác định `N`: số NFR đã chốt.  
- [ ] Tính số test case tối thiểu theo `N_min = 3F + W + S + N`.  
- [ ] Ghi số test case cam kết vào Phụ lục A.  
- [ ] Phân bổ test cases cho features, workflows, state transitions và NFRs.

### 4.4. Viva Readiness Thresholds

- [ ] Xác lập ngưỡng 100% main workflows chạy end-to-end.  
- [ ] Xác lập ngưỡng 100% main demo scenarios đạt.  
- [ ] Xác lập ngưỡng ít nhất 80% exception demo scenarios đạt.  
- [ ] Xác lập số lượng test cases không thấp hơn cam kết.  
- [ ] Xác lập ngưỡng ít nhất 90% tổng test cases đạt.  
- [ ] Xác lập ngưỡng 100% test luồng chính của mandatory features đạt.  
- [ ] Xác lập ngưỡng ít nhất 50% test cases tự động hóa và chạy trong CI.  
- [ ] Xác lập yêu cầu không có Critical/High defects đang mở.  
- [ ] Xác lập yêu cầu mỗi thành viên demo và bảo vệ workflow mình sở hữu.

## 5\. Repository, Iteration 1, Database và CI/CD **(Hải)**

- [ ] Cung cấp repository URL và tag `review-2`.  
- [ ] Chuẩn bị mã nguồn Iteration 1 và hướng dẫn chạy.  
- [ ] Chuẩn bị database scripts/migrations và hướng dẫn khởi tạo database.  
- [ ] Đồng bộ scripts với Logical ERD.  
- [ ] Lưu Mermaid/PlantUML diagram sources trong repository.  
- [ ] Chuẩn bị automated unit tests và integration tests.  
- [ ] Cấu hình CI pipeline cho build và test.  
- [ ] Chuẩn bị demo data, seed scripts và bước reset dữ liệu.  
- [ ] Chuẩn bị staging deployment, cấu hình môi trường và hướng dẫn demo.  
- [ ] Kiểm chứng cùng một phiên bản repository được dùng cho Self-Review và buổi Review 2\.

## 6\. Chuẩn bị tham gia buổi Review 2 **(Cả nhóm)**

### 6.1. Scope & registration discussion

- [ ] Chuẩn bị nội dung trình bày Record of Changes và Scope section.  
- [ ] Chuẩn bị lý do và tác động của từng scope change.

### 6.2. Design defense

- [ ] Chuẩn bị giải thích 5 key design decisions.  
- [ ] Chuẩn bị giải thích 3 top design risks.  
- [ ] Chuẩn bị giải thích Known Gaps và các findings Kept/Planned.

### 6.3. Change scenarios

- [ ] Luyện phân tích tác động khi thêm user role.  
- [ ] Luyện phân tích tác động khi thêm entity state.  
- [ ] Luyện phân tích phương án khi third-party service gián đoạn.  
- [ ] Luyện phân tích tác động khi tải tăng 10 lần.  
- [ ] Liên kết mỗi kịch bản thay đổi với entity, API, diagram, code và tests liên quan.

### 6.4. Defense 1.1 agreement

- [ ] Chuẩn bị Mandatory Features và acceptance criteria để chốt tại Review 2\.  
- [ ] Chuẩn bị NFR metrics, thresholds và measurement methods.  
- [ ] Chuẩn bị main workflows, demo scenarios, test case commitment và Viva thresholds.

### 6.5. Member ownership verification

- [ ] Phân công 2–3 phần và ít nhất một main workflow cho mỗi thành viên.  
- [ ] Chuẩn bị khả năng mở, chạy và giải thích code thuộc phần sở hữu.  
- [ ] Luyện trả lời câu hỏi thay đổi thiết kế và xử lý ngoại lệ.  
- [ ] Xác nhận sự tham gia của toàn bộ thành viên.

## 7\. BM04 — Review 2 Commitment (sau buổi Review 2\) **(PENDING \- SAU REVIEW 2\)**

- [ ] Hoàn thiện BM04 trong vòng 3 ngày làm việc sau Review 2\.  
- [ ] Ghi Registration được chốt và các thay đổi được giảng viên xác nhận.  
- [ ] Ghi Mandatory Features, NFRs, out-of-scope và Defense 1.1 targets được thống nhất.  
- [ ] Ghi cam kết của từng workflow và từng thành viên.  
- [ ] Ghi các điểm cần sửa, owner, deadline và kết quả Review 2\.  
- [ ] Hoàn tất xác nhận/chữ ký theo biểu mẫu môn học.  
- [ ] Xuất `SWP490_FA26SE083_R2_Commitment.pdf`.

## 8\. Sử dụng AI và tính minh bạch **(Khiết)**

- [ ] Khai báo AI tools, models và mục đích/giai đoạn sử dụng. (Nhân: Anti-gravity \+ Chatgpt \+ Claude; Sơn: antigravity, android studio; Hải: vs-code \+ codex; Hoàng: vs-code \+ code; Khiết: Kiro \+ Chatgpt)  
- [ ] Thiết lập review/test cho kết quả do AI hỗ trợ trước khi tích hợp.  
- [ ] Sử dụng dữ liệu thử nghiệm phù hợp khi tương tác với công cụ AI.  
- [ ] Lưu nguyên trạng kết quả coding-agent Self-Review.  
- [ ] Chuẩn bị giải thích trách nhiệm cá nhân đối với nội dung dùng AI hỗ trợ.

## 9\. Quy cách nộp và hành chính **(Cả nhóm)**

- [x] Kiểm tra ngôn ngữ tiếng Anh của các hồ sơ.  
- [ ] Kiểm tra định dạng PDF và naming convention `SWP490_<Mã đề tài>_R2_<Tên hồ sơ>.pdf`.  
- [ ] Áp dụng biểu mẫu của môn học: BM01, BM02, BM03 và BM04 theo đúng giai đoạn.  
- [ ] Xóa nội dung hướng dẫn màu xám và dữ liệu ví dụ khỏi biểu mẫu.  
- [ ] Xác nhận hạn nộp, lịch review và phân công giảng viên phản biện.  
- [ ] Chuẩn bị toàn bộ tài liệu, repo và thiết bị trước giờ review.

## 10\. Đối chiếu và chuẩn hóa liên tài liệu **(Cả nhóm)**

- [ ] Đồng bộ phạm vi Registration, Project Detail, Report 1, SRS và SDD.  
- [ ] Đồng bộ allocation, pricing, approval-before-reservation và full-order fulfillment giữa requirements và design.  
- [ ] Đồng bộ payment, complaints, manual refund, loyalty và state transitions.  
- [ ] Chuẩn hóa thuật ngữ, ngày tháng, phiên bản và captions.  
- [ ] Loại bỏ template placeholders và sơ đồ ví dụ khỏi hồ sơ chính thức.  
- [ ] Đồng bộ Ownership Map với Responsibility Assignments và Project Tracking.  
- [ ] Đồng bộ test objectives, test plan, case count và Viva thresholds.  
- [ ] Liên kết mỗi mandatory feature với acceptance criteria, test case, code và evidence.