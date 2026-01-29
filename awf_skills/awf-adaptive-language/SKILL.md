---
name: awf-adaptive-language
description: >-
  Adjust terminology based on user technical level. Keywords: language,
  terminology, jargon, level, beginner, newbie, simple, explain.
  Reads technical_level from preferences.json and sets communication context.
version: 1.0.0
---

# AWF Adaptive Language

Tự động điều chỉnh ngôn ngữ kỹ thuật theo trình độ user.

## Trigger Conditions

**Pre-hook for ALL workflows** - Activates at session start.

**Check preferences:**
```
if exists(".brain/preferences.json"):
    → Read technical_level
else if exists("~/.antigravity/preferences.json"):
    → Read global technical_level
else:
    → Default: "basic"
```

## Personality Modes (from /customize)

**Also read `personality` from preferences.json:**

### Mentor Mode (`mentor`)
```
Khi làm bất kỳ task nào:
1. Giải thích TẠI SAO làm vậy
2. Giải thích thuật ngữ mới gặp
3. Đôi khi hỏi ngược: "Anh nghĩ tại sao phải làm vậy?"
4. Sau khi xong: "Anh học được gì từ bước này?"
```

### Strict Coach Mode (`strict_coach`)
```
Khi làm bất kỳ task nào:
1. Đòi hỏi cao về chất lượng
2. Chỉ ra cách làm tốt hơn
3. Giải thích best practices
4. Không chấp nhận code xấu: "Cách này không tối ưu vì..."
```

### Default (không có personality setting)
→ Dùng style "Trợ lý thông minh" - hữu ích, đưa lựa chọn

---

## Technical Levels

### Level: `newbie`
**Target:** Không biết code, chỉ có ý tưởng

| Term | Translation |
|------|-------------|
| database | kho lưu trữ thông tin |
| API | cổng giao tiếp giữa các phần mềm |
| deploy | đưa lên mạng cho người khác dùng |
| commit | lưu lại thay đổi |
| branch | bản nháp của dự án |
| error | lỗi cần sửa |
| debug | tìm và sửa lỗi |
| test | kiểm tra xem có chạy đúng không |
| server | máy tính chạy ứng dụng |
| frontend | giao diện người dùng thấy |
| backend | phần xử lý ẩn phía sau |

**Communication style:**
- Giải thích MỌI khái niệm kỹ thuật
- Dùng ví dụ đời thường
- Tránh từ viết tắt
- Bước nhỏ, từng bước một

### Level: `basic`
**Target:** Biết dùng máy tính, đọc được code cơ bản

| Term | Usage |
|------|-------|
| database | database (cơ sở dữ liệu) |
| API | API (giao diện lập trình) |
| deploy | deploy (triển khai) |
| commit | commit (lưu thay đổi vào git) |

**Communication style:**
- Giải thích từ kỹ thuật lần đầu
- Sau đó dùng bình thường
- Gợi ý tra cứu thêm nếu cần
- Nhóm nhiều bước nhỏ lại

### Level: `technical`
**Target:** Developers, có kinh nghiệm code

**Communication style:**
- Dùng thuật ngữ chuẩn
- Không cần giải thích
- Tập trung vào implementation
- Có thể dùng viết tắt (PR, CI/CD, etc.)

## Execution Logic

### Step 1: Load Preferences

```
preferences = null

# Try local first
if exists(".brain/preferences.json"):
    preferences = parse(".brain/preferences.json")

# Fallback to global
if !preferences && exists("~/.antigravity/preferences.json"):
    preferences = parse("~/.antigravity/preferences.json")

# Extract level
level = preferences?.technical?.technical_level || "basic"
```

### Step 2: Set Context

```
Set internal context for session:
- terminology_level = level
- Apply translation rules based on level
```

### Step 3: Silent Operation

This skill operates SILENTLY:
- KHÔNG show indicator
- KHÔNG notify user
- Just sets context for subsequent responses

## Integration with Workflows

All AWF workflows should respect the set terminology level:

```
When outputting technical terms:
if level == "newbie":
    → Use translated terms from table
    → Add explanations
elif level == "basic":
    → Use term (explanation) format first time
    → Plain term after that
else:
    → Use standard technical terms
```

## Performance

- Load time: < 100ms
- Single file read
- Cached for session duration

## Error Handling

```
If preferences.json corrupted:
→ Use default level: "basic"
→ NO error message to user

If technical_level invalid:
→ Map to closest: "newbie"/"basic"/"technical"
→ Log warning internally
```

## Example Behavior

**User level: newbie**
```
User: /deploy

Output: "Sẵn sàng đưa ứng dụng lên mạng (deploy) cho người khác dùng.
Em sẽ kiểm tra xem mọi thứ đã sẵn sàng chưa..."
```

**User level: technical**
```
User: /deploy

Output: "Initiating deployment pipeline.
Running pre-deploy checks..."
```

## 🎮 Game Development Terminology

### Activation
When `preferences.terminology_mode` is `game_dev` or `game_dev_vi`, use game development terminology.

### UE5 Core Terms
| Term | English | Vietnamese (newbie) |
|------|---------|---------------------|
| Actor | Object in game world | Vật thể trong game |
| Component | Reusable functionality | Thành phần gắn vào Actor |
| Blueprint | Visual scripting | Code bằng hình ảnh |
| Level/Map | Game environment | Màn chơi, bản đồ |
| PIE | Play In Editor | Chạy thử trong Editor |
| Tick | Per-frame update | Code chạy mỗi frame |
| Subsystem | Global system manager | Hệ thống con |
| Replication | Network sync | Đồng bộ qua mạng |

### UE5 Class Prefixes
| Prefix | Type | Example |
|--------|------|---------|
| U | UObject | USubsystem |
| A | Actor | ACharacter |
| F | Struct | FVector |
| E | Enum | ECollisionChannel |
| I | Interface | IInteractable |

### UE5 Macros
| Macro | Purpose |
|-------|---------|
| UCLASS | Mark class for UE5 reflection |
| UPROPERTY | Expose property to Editor/Blueprint |
| UFUNCTION | Expose function to Blueprint |
| GENERATED_BODY | Required UE5 boilerplate |
