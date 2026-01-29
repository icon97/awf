# AWF Context Help - UE5/Game Development Extension

Extension documentation for UE5 context-aware help in awf-context-help skill.

> **Note**: Core skill logic is in `SKILL.md`. This file documents UE5 context detection and game dev help extensions.

---

## 🎮 UE5 Context Detection

### Context Sources:
```
Detect current UE5 context from:

1. session.json
   - current_map → Map editing context
   - current_blueprint → Blueprint editing context
   - active_subsystem → Subsystem development context
   - build_target → Build/deploy context

2. Recent file changes
   - .cpp/.h files → C++ development
   - .uasset files → Blueprint/Asset work
   - .umap files → Level design

3. Error state
   - Compile errors → Debug context
   - Runtime errors → Testing context
```

### Context States:
| State | Indicators | Help Focus |
|-------|------------|------------|
| **C++ Development** | Editing .cpp/.h | C++ patterns, macros, compilation |
| **Blueprint Editing** | current_blueprint set | Blueprint nodes, debugging |
| **Level Design** | current_map set | Level streaming, lighting, optimization |
| **UI Development** | Editing WBP_* | UMG widgets, data binding |
| **Multiplayer** | Nakama/replication code | Networking, RPCs, replication |
| **Build/Deploy** | build_target active | Packaging, platform settings |
| **Debugging** | Errors present | Error translation, profiling |

---

## UE5 State-Based Help

### C++ Development Help:
```
When in C++ context, show:

📚 Quick Reference:
- UCLASS specifiers: BlueprintType, Blueprintable, Abstract
- UPROPERTY specifiers: EditAnywhere, BlueprintReadWrite, Replicated
- UFUNCTION specifiers: BlueprintCallable, Server, Client

🔧 Common Tasks:
- Create new class: /code → C++ mode
- Add to Blueprint: UFUNCTION(BlueprintCallable)
- Expose property: UPROPERTY(EditAnywhere)

⚠️ Watch Out:
- Include headers in .cpp, forward declare in .h
- Use TObjectPtr instead of raw pointers
- Avoid heavy Tick() operations
```

### Blueprint Editing Help:
```
When in Blueprint context, show:

📚 Quick Reference:
- F9: Toggle breakpoint
- F10: Step over
- Ctrl+F: Find nodes

🔧 Common Tasks:
- Debug: Add Print String nodes
- Optimize: Replace Tick with Timers
- Organize: Use Functions and Macros

⚠️ Watch Out:
- Avoid casting in loops
- Use Event Dispatchers instead of polling
- Check IsValid before using references
```

### Level Design Help:
```
When in Level context, show:

📚 Quick Reference:
- Level Streaming for large maps
- Lighting: Static vs Dynamic
- Collision: Simple vs Complex

🔧 Common Tasks:
- Optimize: /audit for performance check
- Test: /run to play in editor
- Package: /deploy for final build

⚠️ Watch Out:
- Keep draw calls under 2000
- Use LODs for distant objects
- Bake lighting for static objects
```

---

## Docs/ 5-Phase Guidance

### Phase Detection:
```
Detect current phase from docs_context:

Docs/features/[feature]/
├── requirements/  → Phase 1: Requirements
├── design/        → Phase 2: Design
├── planning/      → Phase 3: Planning
├── implementation/→ Phase 4: Implementation
└── testing/       → Phase 5: Testing
```

### Phase-Specific Help:

#### Phase 1: Requirements
```
📋 You're in Requirements phase

Tasks:
- Define user stories
- List acceptance criteria
- Identify constraints

Commands:
- /plan - Create detailed plan
- /brainstorm - Explore ideas

Output:
- Docs/features/[feature]/requirements/README.md
```

#### Phase 2: Design
```
📐 You're in Design phase

Tasks:
- Define architecture
- Choose patterns
- Plan data models

Commands:
- /visualize - Create diagrams
- /code - Start prototyping

Output:
- Docs/features/[feature]/design/README.md
```

#### Phase 3: Planning
```
📅 You're in Planning phase

Tasks:
- Break down tasks
- Estimate effort
- Identify dependencies

Commands:
- /plan - Detailed task breakdown
- /brainstorm - Risk assessment

Output:
- Docs/features/[feature]/planning/plan.md
```

#### Phase 4: Implementation
```
💻 You're in Implementation phase

Tasks:
- Write code
- Create assets
- Integrate systems

Commands:
- /code - Write C++/Blueprint
- /run - Test changes
- /debug - Fix issues

Output:
- Source code, Blueprints, Assets
```

#### Phase 5: Testing
```
🧪 You're in Testing phase

Tasks:
- Write tests
- Run automation
- Fix bugs

Commands:
- /test - Run test suite
- /audit - Performance check
- /deploy - Package for release

Output:
- Docs/features/[feature]/testing/README.md
```

---

## Contextual Command Suggestions

### Based on Current State:
| Context | Suggested Commands |
|---------|-------------------|
| Just started | `/init`, `/plan` |
| Writing code | `/code`, `/run` |
| Build failed | `/debug` |
| Feature complete | `/test`, `/audit` |
| Ready to ship | `/deploy` |
| End of session | `/save-brain`, `/recap` |
| Lost/confused | `/next`, `/recap` |

### Based on Recent Actions:
```
If just_created_blueprint:
→ Suggest: "/run to test", "/code to add logic"

If just_fixed_error:
→ Suggest: "/run to verify fix", "/test to prevent regression"

If just_completed_feature:
→ Suggest: "/test for validation", "/save-brain to record"

If session_long:
→ Suggest: "/save-brain to preserve context", "/recap to summarize"
```

---

## Game Terminology Quick Reference

### Always Available:
```
Type "?" + term for quick explanation:

?Actor     → Object in game world
?Blueprint → Visual scripting
?PIE       → Play In Editor
?Tick      → Per-frame update
?Subsystem → Global system manager
```

### Context-Sensitive:
```
In C++ context:
?UCLASS, ?UPROPERTY, ?UFUNCTION, ?TArray, ?TMap

In Blueprint context:
?EventDispatcher, ?Interface, ?Cast, ?IsValid

In Multiplayer context:
?Replication, ?RPC, ?NetMulticast, ?Authority
```

---

## Integration with SKILL.md

This README extends the core `SKILL.md` with UE5-specific context detection. The skill should:

1. **Check project type first:**
```
if brain.project.type == "game":
    → Load UE5 context detection
    → Apply game-specific help templates
else:
    → Use standard web/mobile help
```

2. **Combine with existing state detection:**
```
state = detect_standard_state()  # planning, coding, debugging, etc.
game_context = detect_ue5_context()  # cpp, blueprint, level, etc.

if game_context:
    → Show UE5-specific help for state + game_context
else:
    → Show standard help for state
```

3. **Respect session.json game_context:**
```json
{
  "working_on": {
    "game_context": {
      "current_module": "PrototypeRacing",
      "current_blueprint": "BP_PlayerController",
      "editor_mode": "blueprint"
    }
  }
}
```

