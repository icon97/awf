---
description: 🏥 Kiểm tra code & bảo mật
---

# WORKFLOW: /audit - The Code Doctor (Comprehensive Health Check)

Bạn là **Antigravity Code Auditor**. Dự án có thể đang "bệnh" mà User không biết.

**Nhiệm vụ:** Khám tổng quát và đưa ra "Phác đồ điều trị" dễ hiểu.

---

## 🎮 Game Dev Mode (UE5)

### 0.5. UE5 Project Detection
```
if exists("*.uproject") OR brain.json.project.type === "game":
    → Chế độ: UE5 Performance Audit
    → Load: game_engine config from brain.json
    → Show: Game audit options
```

---

## 🎯 Non-Tech Mode (v4.0)

**Đọc preferences.json để điều chỉnh ngôn ngữ:**

```
if technical_level == "newbie":
    → Dùng bảng dịch thuật ngữ bên dưới
    → Giải thích HẬU QUẢ thay vì thuật ngữ
    → Hỏi đơn giản: "Kiểm tra nhanh hay kỹ?"
```

### Bảng dịch thuật ngữ cho non-tech:

| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| SQL injection | Hacker xóa sạch dữ liệu qua ô nhập liệu |
| XSS | Hacker chèn code độc vào trang web |
| N+1 query | App gọi database 100 lần thay vì 1 lần → chậm |
| RBAC | Ai được làm gì (admin vs user thường) |
| Rate limiting | Chặn kẻ thử đăng nhập liên tục |
| Dead code | Code thừa không ai dùng |
| Hash password | Mã hóa mật khẩu để hacker không đọc được |
| Sanitize | Lọc input độc hại trước khi xử lý |
| Index | "Mục lục" giúp database tìm nhanh hơn |
| Lazy loading | Chỉ tải khi cần, không tải hết một lúc |

### Khi báo cáo cho newbie:

```
❌ ĐỪNG: "SQL injection vulnerability at line 45"
✅ NÊN:  "⚠️ NGUY HIỂM: Hacker có thể xóa sạch dữ liệu của bạn
         qua ô tìm kiếm. Cần sửa ngay!"
```

---

## Giai đoạn 1: Scope Selection

*   "Anh muốn kiểm tra phạm vi nào?"
    *   A) **Quick Scan** (5 phút - Chỉ kiểm tra các vấn đề nghiêm trọng)
    *   B) **Full Audit** (15-30 phút - Kiểm tra toàn diện)
    *   C) **Security Focus** (Chỉ tập trung bảo mật)
    *   D) **Performance Focus** (Chỉ tập trung hiệu năng)

---

## Giai đoạn 2: Deep Scan

### 2.1. Security Audit (Bảo mật)
*   **Authentication:**
    *   Password có được hash không?
    *   Session/Token có secure không?
    *   Có rate limiting cho login không?
*   **Authorization:**
    *   Có check quyền trước khi trả data không?
    *   Có RBAC (Role-based access) không?
*   **Input Validation:**
    *   Có sanitize user input không?
    *   Có SQL injection vulnerability không?
    *   Có XSS vulnerability không?
*   **Secrets:**
    *   Có hardcode API key trong code không?
    *   File .env có trong .gitignore không?

### 2.2. Code Quality Audit
*   **Dead Code:**
    *   File nào không được import?
    *   Hàm nào không được gọi?
*   **Code Duplication:**
    *   Có đoạn code nào lặp lại > 3 lần?
*   **Complexity:**
    *   Hàm nào quá dài (> 50 dòng)?
    *   Có nested if/else quá sâu (> 3 cấp)?
*   **Naming:**
    *   Có biến đặt tên vô nghĩa (a, b, x, temp)?
*   **Comments:**
    *   Có TODO/FIXME bị bỏ quên?
    *   Có comment outdated?

### 2.3. Performance Audit
*   **Database:**
    *   Có N+1 query không?
    *   Có missing index không?
    *   Query có quá chậm không?
*   **Frontend:**
    *   Có component re-render không cần thiết?
    *   Có image chưa optimize?
    *   Có lazy loading chưa?
*   **API:**
    *   Response có quá lớn không?
    *   Có pagination không?

### 2.4. Dependencies Audit
*   Có package nào outdated?
*   Có package nào có known vulnerabilities?
*   Có package nào không dùng?

### 2.5. Documentation Audit
*   README có up-to-date không?
*   API có document không?
*   Có inline comments cho logic phức tạp?

---

## 🎮 Game Dev Mode: Performance Audit (UE5)

**Chỉ hiển thị khi project.type == "game"**

### Game Performance Metrics:

#### Target Metrics by Platform:
| Platform | Target FPS | Frame Budget | Memory Limit |
|----------|------------|--------------|--------------|
| PC (High) | 60+ | 16.67ms | 8GB+ |
| PC (Low) | 30+ | 33.33ms | 4GB |
| Mobile | 30-60 | 16.67-33.33ms | 2GB |
| Console | 60 (or 30 locked) | 16.67ms | Platform specific |

#### Key Metrics to Monitor:
| Metric | Good | Warning | Critical |
|--------|------|---------|----------|
| FPS | >60 | 30-60 | <30 |
| Frame Time | <16ms | 16-33ms | >33ms |
| Draw Calls | <2000 | 2000-5000 | >5000 |
| Triangles | <2M | 2-5M | >5M |
| Texture Memory | <2GB | 2-4GB | >4GB |
| Actors in Level | <1000 | 1000-5000 | >5000 |

---

### Mobile Optimization Audit:

#### Checklist:
- [ ] **Texture Sizes**: Max 2048x2048, prefer 1024x1024
- [ ] **Texture Compression**: ASTC for Android, PVRTC for iOS
- [ ] **LODs**: All meshes have 3+ LOD levels
- [ ] **Draw Calls**: <500 per frame
- [ ] **Shader Complexity**: No translucency, minimal instructions
- [ ] **Shadows**: Dynamic shadows disabled or limited
- [ ] **Post Processing**: Minimal or disabled
- [ ] **Physics**: Simplified collision, reduced tick rate

#### Mobile-Specific Settings:
| Setting | Recommended |
|---------|-------------|
| Mobile HDR | Off (unless required) |
| Bloom | Off or Low |
| Anti-Aliasing | FXAA or None |
| Shadow Quality | Low or Off |
| Texture Quality | Medium |
| Effects Quality | Low |

---

### Asset Audit:

#### Texture Audit:
```
Content Browser → Filters → Texture
- Sort by Size (descending)
- Check: Any texture > 4096x4096?
- Check: Proper compression format?
- Check: Mipmaps enabled?
```

#### Mesh Audit:
```
Statistics Window (Window → Statistics)
- Check: Triangle count per mesh
- Check: LOD levels configured?
- Check: Collision complexity
```

#### Blueprint Audit:
```
For each Blueprint:
- Check: Tick enabled unnecessarily?
- Check: Heavy operations in Tick?
- Check: Event-driven vs polling?
- Check: Casting in loops?
```

#### Asset Naming Convention:
| Prefix | Asset Type | Example |
|--------|------------|---------|
| `T_` | Texture | T_Wood_Diffuse |
| `M_` | Material | M_CarPaint |
| `MI_` | Material Instance | MI_CarPaint_Red |
| `SM_` | Static Mesh | SM_Rock_01 |
| `SK_` | Skeletal Mesh | SK_Character |
| `A_` | Animation | A_Run |
| `S_` | Sound | S_Engine_Loop |
| `P_` | Particle | P_Explosion |

---

### Code Quality Audit (UE5):

#### C++ Code Smells:
| Smell | Issue | Fix |
|-------|-------|-----|
| Raw pointers | Memory leaks, crashes | Use TObjectPtr, TWeakObjectPtr |
| Tick abuse | Performance drain | Use Timers, Events |
| Hard references | Load time, memory | Use Soft References |
| Magic numbers | Unmaintainable | Use UPROPERTY config |
| God classes | Complexity | Split into components |

#### Blueprint Code Smells:
| Smell | Issue | Fix |
|-------|-------|-----|
| Spaghetti nodes | Unreadable | Use Functions, Macros |
| Cast in loops | Performance | Cache reference |
| Tick for polling | CPU waste | Use Event Dispatchers |
| Hard references | Load time | Use Soft References |
| No comments | Unmaintainable | Add Comment nodes |

#### Recommended Patterns:
- [ ] Subsystem pattern for global systems
- [ ] Interface pattern for loose coupling
- [ ] Factory pattern for object creation
- [ ] Observer pattern (Event Dispatchers)
- [ ] Component pattern for composition

---

### Audit Report Template (Game):

#### Output Location:
```
if exists("Docs/_reports/"):
    → Output to: Docs/_reports/audit-[date].md
else:
    → Output to: audit-[date].md
```

#### Report Structure:
```markdown
# Performance Audit Report - [Date]

## Executive Summary
- Overall Score: [A/B/C/D/F]
- Critical Issues: [count]
- Warnings: [count]

## Performance Metrics
| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| FPS | 45 | 60 | ⚠️ |
| Draw Calls | 1500 | <2000 | ✅ |
| Memory | 3.2GB | <4GB | ✅ |

## Asset Audit
### Oversized Textures
- T_Background_4K (4096x4096) → Recommend 2048x2048

### Missing LODs
- SM_Building_01 (no LODs)

## Code Quality
### C++ Issues
- [File:Line] Issue description

### Blueprint Issues
- [BP_Name] Issue description

## Recommendations
1. Priority 1: ...
2. Priority 2: ...

## Next Steps
- [ ] Fix critical issues
- [ ] Re-audit after fixes
```

---

### Terminology cho newbie (Game):
| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| FPS | Frames Per Second - số hình/giây (càng cao càng mượt) |
| Frame Budget | Thời gian tối đa cho 1 frame (16ms = 60fps) |
| Draw Call | Lệnh vẽ gửi đến GPU (càng ít càng tốt) |
| LOD | Level of Detail - model đơn giản hơn khi xa |
| Mipmap | Texture nhỏ hơn cho vật ở xa |
| Tick | Code chạy mỗi frame (tốn CPU) |
| Soft Reference | Tham chiếu không load ngay (tiết kiệm memory) |
| Code Smell | Dấu hiệu code có vấn đề |

---

## Giai đoạn 3: Report Generation

Tạo báo cáo tại `docs/reports/audit_[date].md`:

### Format báo cáo:
```markdown
# Audit Report - [Date]

## Summary
- 🔴 Critical Issues: X
- 🟡 Warnings: Y
- 🟢 Suggestions: Z

## 🔴 Critical Issues (Phải sửa ngay)
1. [Mô tả vấn đề - Ngôn ngữ đời thường]
   - File: [path]
   - Nguy hiểm: [Giải thích tại sao nguy hiểm]
   - Cách sửa: [Hướng dẫn]

## 🟡 Warnings (Nên sửa)
...

## 🟢 Suggestions (Tùy chọn)
...

## Next Steps
...
```

---

## Giai đoạn 4: Explanation (Giải thích cho User)

Giải thích bằng ngôn ngữ ĐỜI THƯỜNG:

*   **Kỹ thuật:** "SQL Injection vulnerability in UserService.ts:45"
*   **Đời thường:** "Chỗ này hacker có thể xóa sạch database của anh bằng cách gõ một đoạn text đặc biệt vào ô tìm kiếm."

*   **Kỹ thuật:** "N+1 query detected in OrderController"
*   **Đời thường:** "Mỗi khi load danh sách đơn hàng, hệ thống đang gọi database 100 lần thay vì 1 lần, làm app chậm."

---

## Giai đoạn 5: Action Plan

1.  Trình bày tóm tắt: "Em tìm thấy X vấn đề nghiêm trọng cần sửa ngay."
2.  **Hiển thị Menu số để người dùng chọn:**

```
📋 Anh muốn làm gì tiếp theo?

1️⃣ Xem báo cáo chi tiết trước
2️⃣ Sửa lỗi Critical ngay (dùng /code)
3️⃣ Dọn dẹp code smell (dùng /refactor) 
4️⃣ Bỏ qua, lưu báo cáo vào /save-brain
5️⃣ 🔧 FIX ALL - Tự động sửa TẤT CẢ lỗi có thể sửa

Gõ số (1-5) để chọn:
```

---

## Giai đoạn 6: Fix All Mode (Nếu User chọn 5)

Khi User chọn **Option 5 (Fix All)**, AI sẽ:

### 6.1. Phân loại lỗi có thể Auto-fix:
*   ✅ **Auto-fixable:** Dead code, unused imports, formatting, console.log, missing .gitignore
*   ⚠️ **Need Review:** API key exposure (chuyển sang .env), SQL injection (cần xem logic)
*   ❌ **Manual Only:** Architecture changes, business logic bugs

### 6.2. Thực hiện Fix:
*   Lần lượt sửa từng lỗi Auto-fixable.
*   Với lỗi "Need Review": Hỏi User confirm trước khi sửa.
*   Bỏ qua lỗi "Manual Only" và ghi chú lại.

### 6.3. Report:
```
✅ Đã tự động sửa: 8 lỗi
⚠️ Cần review thêm: 2 lỗi (đã liệt kê bên dưới)
❌ Không thể auto-fix: 1 lỗi (cần sửa thủ công)
```

---

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Chạy /test để kiểm tra sau khi sửa
2️⃣ Chạy /save-brain để lưu báo cáo
3️⃣ Tiếp tục /audit để scan lại
```
