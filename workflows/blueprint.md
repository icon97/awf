---
id: blueprint
title: /blueprint - Blueprint Management Workflow
version: 1.0.0
description: Blueprint Management - Create, debug, convert, and document Blueprints
triggers:
  - /blueprint
  - /bp
category: game-dev
---

# /blueprint - Blueprint Management

## Overview

**Purpose:** Manage UE5 Blueprints - create, debug, convert, document

**Modes:**
- `create` - Create new Blueprints with proper structure
- `debug` - Debug Blueprint issues with breakpoints and watches
- `convert` - Convert Blueprint to C++ code
- `document` - Generate documentation for Blueprints

## Khi nào dùng
- Khi cần tạo Blueprint mới
- Khi Blueprint có lỗi runtime
- Khi cần convert Blueprint sang C++
- Khi cần document Blueprint logic

---

## /blueprint create

### Create New Blueprint:
```
/blueprint create [type] [name]
```

### Blueprint Types:
| Type | Base Class | Use Case |
|------|------------|----------|
| actor | AActor | Placeable objects |
| character | ACharacter | Player/NPC characters |
| pawn | APawn | Controllable entities |
| component | UActorComponent | Reusable functionality |
| widget | UUserWidget | UI elements |
| gamemode | AGameModeBase | Game rules |
| interface | UInterface | Contracts between classes |

### Naming Convention:
| Type | Prefix | Example |
|------|--------|---------|
| Blueprint | BP_ | BP_RacingCar |
| Widget | WBP_ | WBP_MainMenu |
| Interface | BPI_ | BPI_Interactable |
| Component | BPC_ | BPC_Health |
| Enum | E_ | E_VehicleType |
| Struct | S_ | S_VehicleData |

### Create Output:
```
🎨 Blueprint Created: [Name]

📁 Location: Content/Blueprints/[Type]/[Name]
📋 Type: [BlueprintType]
🔗 Parent: [BaseClass]

✅ Created with:
- Default components for [type]
- Standard event setup (BeginPlay, Tick disabled)
- Naming convention applied

📝 Next steps:
1. Open in Editor
2. Add custom logic
3. Test in PIE
```

---

## /blueprint debug

### Debug Tools:
1. **Breakpoints** - F9 to toggle
2. **Watch Variables** - Add to watch window
3. **Call Stack** - View execution path
4. **Print String** - Quick debug output

### Debug Shortcuts:
| Key | Action |
|-----|--------|
| F9 | Toggle breakpoint |
| F10 | Step over |
| F11 | Step into |
| Shift+F11 | Step out |
| F5 | Continue |

### Common Issues:
| Issue | Cause | Fix |
|-------|-------|-----|
| Accessed None | Null reference | Add IsValid check |
| Infinite Loop | No exit condition | Add break/return |
| Cast Failed | Wrong type | Verify class type |
| Array Out of Bounds | Invalid index | Check array length |

### Debug Output:
```
🔍 Blueprint Debug: [BlueprintName]

📍 Breakpoint Hit: [NodeName]
📊 Variables:
- [VarName]: [Value]
- [VarName]: [Value]

📋 Call Stack:
1. [Function] → [Node]
2. [Function] → [Node]

⚠️ Issues Found:
- [Issue description]
- [Suggested fix]
```

### Debug Workflow:
```
1. Reproduce error
2. Add breakpoint before error
3. Step through execution
4. Watch variable values
5. Identify root cause
6. Fix and test
```

---

## /blueprint convert

### Convert Blueprint to C++:
```
/blueprint convert [BlueprintPath] --output [CppPath]
```

### Conversion Guidelines:
| Blueprint | C++ Equivalent |
|-----------|----------------|
| Variable | UPROPERTY() |
| Function | UFUNCTION() |
| Event | BlueprintImplementableEvent |
| Interface | UINTERFACE + IInterface |
| Macro | Inline function |

### When to Convert:
| Scenario | Recommendation |
|----------|----------------|
| Performance critical | ✅ Convert |
| Complex math | ✅ Convert |
| Network replication | ✅ Convert |
| Simple UI logic | ❌ Keep BP |
| Rapid prototyping | ❌ Keep BP |

### Conversion Template:
```cpp
// Generated from BP_[Name]
UCLASS(BlueprintType)
class GAME_API U[Name] : public [BaseClass]
{
    GENERATED_BODY()

public:
    // From Blueprint variables
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
    [Type] [VarName];

    // From Blueprint functions
    UFUNCTION(BlueprintCallable)
    void [FunctionName]();
};
```

### Convert Output:
```
🔄 Blueprint Convert: [BlueprintName]

📁 Output Files:
- [CppPath]/[Name].h
- [CppPath]/[Name].cpp

📊 Conversion Summary:
- Variables: [count] → UPROPERTY
- Functions: [count] → UFUNCTION
- Events: [count] → BlueprintImplementableEvent

⚠️ Manual Review Required:
- [Item needing manual adjustment]

📝 Migration Checklist:
□ Update references to use C++ class
□ Reparent child Blueprints
□ Test all functionality
□ Remove old Blueprint (after verification)
```

---

## /blueprint document

### Generate Documentation:
```
/blueprint document [BlueprintPath] --output [DocPath]
```

### Documentation Output:
```markdown
# BP_[Name] Documentation

## Overview
- **Type**: [BlueprintType]
- **Parent**: [ParentClass]
- **Location**: [ContentPath]

## Variables
| Name | Type | Default | Description |
|------|------|---------|-------------|
| [Var] | [Type] | [Default] | [Desc] |

## Functions
| Name | Inputs | Outputs | Description |
|------|--------|---------|-------------|
| [Func] | [Params] | [Return] | [Desc] |

## Events
| Name | Trigger | Description |
|------|---------|-------------|
| [Event] | [When] | [Desc] |

## Dependencies
- [OtherBlueprint]
- [Interface]
```

---

## Common Patterns

### Event-Driven Pattern
```
Event BeginPlay
  → Initialize variables
  → Bind delegates
  → Start timers

Event Tick (avoid if possible)
  → Use Timers instead
  → Or Event-driven updates

Custom Events
  → Modular logic
  → Reusable functions
```

### Component Pattern
```
BP_Vehicle
├── StaticMeshComponent (body)
├── SkeletalMeshComponent (wheels)
├── BPC_Movement (custom)
├── BPC_Health (custom)
└── BPC_Input (custom)
```

### Interface Pattern
```
BPI_Interactable
├── Interact(Actor Caller)
├── GetInteractionText() → Text
└── CanInteract(Actor Caller) → Bool

Implementers:
- BP_Door implements BPI_Interactable
- BP_Pickup implements BPI_Interactable
- BP_NPC implements BPI_Interactable
```

---

## Performance

### Performance Guidelines
| Practice | Good | Bad |
|----------|------|-----|
| Tick | Disabled | Always enabled |
| Updates | Event-driven | Polling |
| Casts | Cached | In loops |
| Arrays | For Each | Get All Actors |
| Timers | Timer by Event | Tick + counter |

### Optimization Checklist
```
□ Disable Tick if not needed
□ Use Timers instead of Tick
□ Cache Cast results
□ Avoid Get All Actors of Class
□ Use Event Dispatchers
□ Minimize string operations
□ Use Async nodes for heavy ops
```

---

## Blueprint vs C++

### When to use Blueprint
- Rapid prototyping
- Designer-friendly logic
- Simple game logic
- UI/UX implementation
- Quick iterations

### When to use C++
- Performance-critical code
- Complex algorithms
- Engine modifications
- Networking/replication
- Large-scale systems

### Hybrid Approach
```
C++ Base Class
├── Core logic
├── Performance-critical
└── UFUNCTION(BlueprintCallable)

Blueprint Child
├── Designer tweaks
├── Visual polish
└── Quick iterations
```

---

## Integration

### With /visualize:
```
/blueprint document BP_RacingCar | /visualize --format mermaid
```

### With /code:
```
/blueprint convert BP_RacingCar | /code --review
```

### With /audit:
```
/blueprint --validate | /audit --report
```

---

## Terminology cho newbie

| Term | Giải thích |
|------|-----------|
| Blueprint | Code bằng hình ảnh (kéo thả nodes) |
| Node | Một khối lệnh trong Blueprint |
| Pin | Điểm kết nối giữa các nodes |
| Event Graph | Nơi xử lý events (BeginPlay, Tick) |
| Construction Script | Code chạy khi spawn Actor |
| Macro | Nhóm nodes tái sử dụng |
| Function | Hàm trong Blueprint |
| Variable | Biến lưu trữ dữ liệu |
| Cast | Chuyển đổi kiểu object |
| Interface | Hợp đồng giữa các Blueprint |

---

## Related Workflows
- `/code` - C++ development
- `/visualize` - Diagram generation
- `/debug` - Error analysis
- `/refactor` - Code improvement
- `/audit` - Performance and quality audit
