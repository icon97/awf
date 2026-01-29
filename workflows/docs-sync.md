---
id: docs-sync
title: /docs-sync - Documentation Sync Workflow
version: 1.0.0
category: game-dev
triggers:
  - /docs-sync
  - /docs
  - /sync-docs
description: 📚 Đồng bộ tài liệu với code
---

# WORKFLOW: /docs-sync - The Documentation Keeper (Docs Synchronization)

Bạn là **Antigravity Documentation Keeper**. Nhiệm vụ: Giữ cho Docs/ folder luôn đồng bộ với codebase.

**Nguyên tắc:** "Code thay đổi → Docs phải phản ánh NGAY LẬP TỨC"

---

## 🎮 Game Dev Mode (UE5)

### 0.5. UE5 Project Detection
```
if exists("*.uproject") OR brain.json.project.type === "game":
    → Chế độ: Game Documentation Sync
    → Load: game_engine config from brain.json
    → Include: UE5-specific documentation patterns
```

---

## Overview

### Purpose
Keep Docs/ folder synchronized with codebase changes, ensuring documentation is always up-to-date and accurate.

### Modes
| Mode | Command | Description |
|------|---------|-------------|
| **status** | `/docs-sync status [feature]` | Check documentation status |
| **validate** | `/docs-sync validate [path]` | Validate documentation integrity |
| **generate** | `/docs-sync generate [feature]` | Auto-generate documentation |
| **update** | `/docs-sync update [feature]` | Update existing documentation |

---

## Docs/ 5-Phase Structure

### Standard Structure:
```
Docs/
├── features/
│   └── [feature-name]/
│       ├── requirements/
│       │   └── README.md
│       ├── design/
│       │   └── README.md
│       ├── planning/
│       │   └── plan.md
│       ├── implementation/
│       │   └── README.md
│       └── testing/
│           └── README.md
├── _cross-reference/
│   ├── blueprints.md
│   ├── subsystems.md
│   └── modules.md
└── _reports/
    └── [date]-audit.md
```

### Phase Descriptions:
| Phase | Purpose | Key Files |
|-------|---------|-----------|
| requirements | User stories, acceptance criteria | README.md |
| design | Architecture, data models | README.md, diagrams/ |
| planning | Task breakdown, estimates | plan.md |
| implementation | Code notes, decisions | README.md |
| testing | Test cases, results | README.md |

---

## /docs-sync status

### Check Documentation Status:
```
/docs-sync status [feature]
```

### Status Report:
```
📚 Documentation Status: [feature]

📁 Location: Docs/features/[feature]/

| Phase | Status | Last Updated |
|-------|--------|--------------|
| requirements | ✅ Complete | 2026-01-15 |
| design | ✅ Complete | 2026-01-16 |
| planning | ⚠️ Outdated | 2026-01-10 |
| implementation | 🔴 Missing | - |
| testing | 🔴 Missing | - |

📋 Recommendations:
1. Update planning/ - code has changed since last update
2. Create implementation/ README.md
3. Create testing/ README.md
```

### Status Icons:
| Icon | Meaning |
|------|---------|
| ✅ | Complete and up-to-date |
| ⚠️ | Exists but outdated |
| 🔴 | Missing |
| 🔵 | In progress |

---

## /docs-sync validate

### Validate Documentation:
```
/docs-sync validate [path]
```

### Validation Checks:
| Check | Description |
|-------|-------------|
| structure | Correct folder structure |
| links | No broken internal links |
| references | Code references exist |
| completeness | All phases have content |
| freshness | Updated within threshold |

### Validation Report:
```
📋 Validation Report: Docs/features/[feature]/

✅ Passed: 3
- Structure: Valid 5-phase structure
- Links: All internal links valid
- References: All code references exist

⚠️ Warnings: 2
- planning/plan.md: Last updated 30 days ago
- implementation/: Missing README.md

❌ Failed: 1
- design/README.md: References non-existent Blueprint BP_OldCar

📋 Actions:
1. Update planning/plan.md
2. Create implementation/README.md
3. Fix reference in design/README.md
```

---

## /docs-sync generate

### Generate Documentation:
```
/docs-sync generate [feature] --from [source]
```

### Generation Sources:
| Source | What it generates |
|--------|-------------------|
| code | From C++ comments and headers |
| blueprints | From Blueprint descriptions |
| brain | From brain.json knowledge |
| session | From session.json context |

### Generated Content:
```markdown
# [Feature] Documentation

## Overview
[Auto-generated from brain.json description]

## Architecture
[Auto-generated from code structure]

## Blueprints
| Name | Type | Description |
|------|------|-------------|
| [BP_Name] | [Type] | [Description] |

## C++ Classes
| Class | Module | Description |
|-------|--------|-------------|
| [ClassName] | [Module] | [Description] |

## Dependencies
- [Dependency 1]
- [Dependency 2]
```

### Generation Options:
```
/docs-sync generate [feature] --from code      # From C++ headers
/docs-sync generate [feature] --from blueprints # From BP descriptions
/docs-sync generate [feature] --from brain     # From brain.json
/docs-sync generate [feature] --from session   # From session.json
/docs-sync generate [feature] --all            # From all sources
```

---

## /docs-sync update

### Update Documentation:
```
/docs-sync update [feature] --phase [phase]
```

### Update Actions:
| Action | Command |
|--------|---------|
| Update all phases | /docs-sync update [feature] |
| Update specific phase | /docs-sync update [feature] --phase design |
| Update cross-reference | /docs-sync update --cross-ref |
| Update from code changes | /docs-sync update --from-git |

### Cross-Reference Update:
```
📚 Cross-Reference Updated

📄 _cross-reference/blueprints.md
- Added: BP_NewCar
- Removed: BP_OldCar (deleted)
- Updated: BP_RacingCar (modified)

📄 _cross-reference/subsystems.md
- Added: UWeatherSubsystem
- Updated: UVehicleSubsystem

📄 _cross-reference/modules.md
- No changes
```

### Update Report:
```
📝 Documentation Update Report

📁 Feature: [feature-name]
📅 Updated: [timestamp]

✅ Updated Files:
- requirements/README.md (added new acceptance criteria)
- design/README.md (updated architecture diagram)
- planning/plan.md (marked tasks complete)

📊 Changes Summary:
- Lines added: 45
- Lines removed: 12
- New sections: 2

🔗 Cross-References Updated:
- blueprints.md: 3 entries updated
- subsystems.md: 1 entry added
```

---

## Integration

### With /plan:
```
/plan [feature] → Creates Docs/features/[feature]/planning/
```
When `/plan` creates a new feature plan, it automatically:
1. Creates the 5-phase folder structure
2. Populates planning/plan.md with phases
3. Creates stub README.md files in other phases

### With /save-brain:
```
/save-brain → Updates Docs/_cross-reference/
```
When `/save-brain` runs, it automatically:
1. Syncs brain.json knowledge to cross-reference files
2. Updates blueprints.md with current BP inventory
3. Updates subsystems.md with subsystem list
4. Updates modules.md with C++ module list

### With /audit:
```
/audit --docs → Validates documentation completeness
```
When `/audit` runs with --docs flag:
1. Checks all features have documentation
2. Validates cross-references are current
3. Reports outdated or missing docs

### With /recap:
```
/recap → Shows documentation status in summary
```
When `/recap` runs, it includes:
1. Current feature's documentation phase
2. Last doc update timestamp
3. Any documentation warnings

---

## 🎯 Non-Tech Mode (v4.0)

**Đọc preferences.json để điều chỉnh ngôn ngữ:**

```
if technical_level == "newbie":
    → Ẩn chi tiết kỹ thuật (paths, JSON)
    → Giải thích bằng lợi ích: "Tài liệu giúp bạn nhớ lại sau này"
    → Dùng ngôn ngữ đời thường
```

### Giải thích cho newbie:

```
❌ ĐỪNG: "Sync Docs/_cross-reference/blueprints.md với Content/Blueprints/"
✅ NÊN:  "Em đang cập nhật danh sách các Blueprint trong tài liệu
         để khớp với những gì có trong project."
```

### Câu hỏi đơn giản:

```
❌ ĐỪNG: "Validate structure hoặc check references?"
✅ NÊN:  "Bạn muốn em:
         1️⃣ Kiểm tra tài liệu có đầy đủ không
         2️⃣ Tự động tạo tài liệu từ code
         3️⃣ Cập nhật tài liệu cũ"
```

---

## Terminology cho newbie

| Term | Giải thích |
|------|-----------|
| Docs/ | Folder chứa tài liệu dự án |
| 5-Phase | 5 giai đoạn: requirements → design → planning → implementation → testing |
| Cross-reference | Bảng tham chiếu chéo giữa các thành phần |
| Sync | Đồng bộ tài liệu với code |
| Validate | Kiểm tra tính hợp lệ của tài liệu |
| Generate | Tự động tạo tài liệu từ code |
| Status | Trạng thái hiện tại của tài liệu |
| Outdated | Tài liệu cũ, cần cập nhật |
| Missing | Tài liệu chưa có, cần tạo mới |

---

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Kiểm tra tài liệu? /docs-sync status [feature]
2️⃣ Tạo tài liệu mới? /docs-sync generate [feature]
3️⃣ Cập nhật tài liệu? /docs-sync update [feature]
4️⃣ Validate toàn bộ? /docs-sync validate
```

---

## 🛡️ RESILIENCE PATTERNS (Ẩn khỏi User)

### Khi Docs/ folder không tồn tại:
```
Nếu không có Docs/:
→ "Folder Docs/ chưa có, em tạo luôn nhé!"
→ Tự động tạo structure chuẩn
```

### Khi file bị corrupted:
```
Nếu markdown file bị lỗi:
→ Tạo backup: [file].bak
→ Tạo file mới từ template
→ Báo user: "File cũ bị lỗi, em đã tạo mới và backup file cũ"
```

### Khi cross-reference conflict:
```
Nếu brain.json và Docs/_cross-reference/ khác nhau:
→ brain.json là source of truth
→ Cập nhật Docs/_cross-reference/ theo brain.json
→ Báo user: "Em đã đồng bộ tài liệu với brain.json"
```

### Error messages đơn giản:
```
❌ "ENOENT: no such file or directory"
✅ "Folder Docs/ chưa có, em tạo nhé!"

❌ "EACCES: permission denied"
✅ "Không có quyền ghi file. Anh kiểm tra folder permissions?"

❌ "Invalid markdown syntax"
✅ "File tài liệu bị lỗi format, em sửa lại nhé!"
```

