# AWF Adaptive Language - Game Dev Extension

Extension documentation for game development terminology support in awf-adaptive-language skill.

> **Note**: Core skill logic is in `SKILL.md`. This file documents game dev terminology extensions.

---

## 🎮 Game Dev Terminology Mode

### Activation
```
When preferences.terminology_mode === "game_dev" OR "game_dev_vi":
→ Use game development terminology
→ Explain UE5-specific terms
→ Add Vietnamese translations (if game_dev_vi)
```

### Mode Selection:
| Mode | Language | Terms | Example |
|------|----------|-------|---------|
| `web` | English | Web dev | "component", "API", "endpoint" |
| `mobile` | English | Mobile dev | "view", "activity", "intent" |
| `game_dev` | English | Game dev | "Actor", "Component", "Blueprint" |
| `game_dev_vi` | Vietnamese | Game dev | "Actor (vật thể)", "Component (thành phần)" |

---

## UE5 Terminology Mappings

### Core Concepts:
| Term | Explanation (EN) | Giải thích (VI) |
|------|------------------|-----------------|
| Actor | Object that can be placed in a level | Vật thể có thể đặt trong level |
| Component | Reusable functionality attached to Actor | Thành phần gắn vào Actor |
| Blueprint | Visual scripting system | Code bằng hình ảnh (kéo thả) |
| Level/Map | Game world/environment | Màn chơi, bản đồ |
| PIE | Play In Editor | Chạy thử game trong Editor |
| Tick | Per-frame update | Code chạy mỗi frame |

### UE5 Classes:
| Prefix | Meaning | Example |
|--------|---------|---------|
| U | UObject-derived | USubsystem, UWidget |
| A | Actor-derived | ACharacter, AVehicle |
| F | Struct | FVector, FTransform |
| E | Enum | ECollisionChannel |
| I | Interface | IInteractable |
| T | Template | TArray, TMap |

### UE5 Macros:
| Macro | Purpose | Giải thích |
|-------|---------|-----------|
| UCLASS | Mark class for UE5 | Đánh dấu class cho UE5 |
| UPROPERTY | Expose property | Biến hiện trong Editor |
| UFUNCTION | Expose function | Hàm gọi được từ Blueprint |
| GENERATED_BODY | Required boilerplate | Code tự động của UE5 |

---

## Newbie-Friendly Explanations

### Complexity Levels:
| Level | Audience | Style |
|-------|----------|-------|
| `newbie` | Complete beginner | Simple analogies, Vietnamese |
| `basic` | Some experience | Technical + explanation |
| `advanced` | Experienced | Technical only |

### Example Adaptations:

#### Newbie Level:
```
"UPROPERTY là gì?"
→ "UPROPERTY giống như đặt biển tên cho biến. 
   Khi có biển tên, Editor sẽ thấy và cho phép chỉnh sửa.
   Không có biển tên = biến ẩn, chỉ code mới thấy."
```

#### Basic Level:
```
"UPROPERTY là gì?"
→ "UPROPERTY là macro đánh dấu property để UE5 reflection system
   nhận diện. Cho phép serialize, replicate, và hiển thị trong Editor."
```

#### Advanced Level:
```
"UPROPERTY là gì?"
→ "UPROPERTY macro registers the property with UE5's reflection system,
   enabling serialization, GC tracking, replication, and Editor exposure."
```

---

## Context-Aware Term Selection

### Auto-Select Based on Context:
```
When explaining code:
- In Blueprint context → Use Blueprint terms
- In C++ context → Use C++ terms
- In UI context → Use UMG terms

When user asks:
- "Làm sao..." → Vietnamese response
- "How to..." → English response
- Mixed → Follow preferences.language
```

### Term Substitution:
| Generic Term | Web Context | Game Context |
|--------------|-------------|--------------|
| "object" | "component" | "Actor" |
| "function" | "method" | "UFUNCTION" |
| "variable" | "property" | "UPROPERTY" |
| "class" | "component class" | "UCLASS" |
| "event" | "callback" | "Event Dispatcher" |

---

## Integration with SKILL.md

This README extends the core `SKILL.md` with game-specific terminology. The skill should:

1. **Check project type first:**
```
if brain.project.type == "game":
    → Load game terminology mappings
    → Apply UE5-specific translations
else:
    → Use standard web/mobile terminology
```

2. **Combine with technical_level:**
```
terminology = get_terminology_mode()  # game_dev, game_dev_vi, web, mobile
level = get_technical_level()         # newbie, basic, advanced

Apply both filters to output
```

3. **Respect preferences.json:**
```json
{
  "terminology_mode": "game_dev_vi",
  "technical_level": "newbie",
  "game_preferences": {
    "ue5_terminology_level": "newbie"
  }
}
```

---

## Related Files

- `SKILL.md` - Core adaptive language skill logic
- `awf/schemas/preferences.schema.json` - Preferences schema with game_preferences
- `specs/awf-gamedev-integration/requirements.md` - Full requirements (AC-021)

