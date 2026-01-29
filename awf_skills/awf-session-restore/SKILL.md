---
name: awf-session-restore
description: >-
  Auto-restore context on session start. Keywords: context, memory, session,
  restore, recap, remember, resume, continue, comeback, return, game, ue5, unreal.
  Activates as pre-hook for ALL AWF workflows to show brief session summary.
  Supports UE5 game project detection and game context restoration.
version: 1.1.0
---

# AWF Session Restore

Auto-restore context khi user quay lại sau thời gian vắng mặt.
Hỗ trợ phát hiện UE5 project và khôi phục game context.

## Trigger Conditions

**Pre-hook for ALL workflows** - Activates before any AWF command:
- `/plan`, `/code`, `/brainstorm`, `/debug`, `/test`, etc.

**Keywords in user message:**
- "quay lại", "tiếp tục", "đang làm gì", "làm dở"
- "comeback", "continue", "resume", "what was I doing"

## 🎮 Game Project Detection

### Auto-Detection Logic

```
When restoring session, detect game project:

1. Check for .uproject file
   - If found: game_engine = "ue5"
   - Extract engine version from .uproject

2. Check for Source/ folder
   - Scan for *.Build.cs files
   - Extract module names

3. Check for Content/ folder
   - Verify UE5 asset structure
   - Note key Blueprint locations

4. Check for Plugins/
   - List enabled plugins
   - Note custom plugins
```

### Detection Priority

| Check | Weight | Result |
|-------|--------|--------|
| .uproject exists | 100% | Definitely UE5 |
| Source/*.Build.cs | 80% | Likely UE5 |
| Content/*.uasset | 60% | Possibly UE5 |
| Config/DefaultEngine.ini | 40% | Check engine type |

## Execution Logic

### Step 1: Check Session File

```
if exists(".brain/session.json"):
    → Parse JSON
    → Continue to Step 2
else:
    → Show: "Chưa có session. Bắt đầu mới nhé!"
    → Skip to workflow execution
```

### Step 2: Detect Project Type

```
if exists("*.uproject"):
    → project_type = "game"
    → game_engine = "ue5"
    → Continue to Step 3 (Game Context)
else:
    → Continue to Step 4 (Standard Summary)
```

### Step 3: Restore Game Context

```
if session.game_context exists:
    → Extract game-specific fields
    → Show Game Session Summary
else:
    → Auto-populate from project (see below)
    → Show Game Session Summary
```

### Step 4: Generate Brief Summary

Extract from session.json và show indicator:

```
🔄 Restoring session...

📍 **Đang làm:** {working_on.feature}
   └─ Task: {working_on.task}
   └─ Status: {working_on.status}

⏭️ **Pending:** {pending_tasks.length} tasks
   └─ Tiếp theo: {pending_tasks[0].task}

🕐 **Last saved:** {updated_at}
```

### Step 5: Continue to Workflow

After summary display (< 3 seconds):
- Pass context to main workflow
- Workflow executes with restored context

## Game Context Restoration

### Restore from session.json:

```json
{
  "game_context": {
    "current_map": "VN_Hanoi",
    "build_target": "Win64 Development",
    "current_blueprint": "BP_RacingCar",
    "active_subsystem": "UVehicleSubsystem",
    "last_build_status": "success"
  }
}
```

### Context Display:

```
🎮 Game Session Restored

📍 Last Working On:
- Map: [current_map]
- Blueprint: [current_blueprint]
- Subsystem: [active_subsystem]

🔧 Build Status:
- Target: [build_target]
- Status: [last_build_status]

📋 Continue with:
- /code - Continue coding
- /run - Test changes
- /next - See suggestions
```

## UE5-Specific Session Fields

### Fields to Restore

| Field | Source | Purpose |
|-------|--------|---------|
| `current_map` | session.json | Resume map editing |
| `build_target` | session.json | Correct build config |
| `current_blueprint` | session.json | Resume BP editing |
| `active_subsystem` | session.json | Context for /code |
| `last_build_status` | Saved/Logs/ | Show build state |
| `ue5_errors` | session.json | Pending errors |
| `performance_baseline` | session.json | Compare performance |

### Auto-Populate from Project

```
If session.json missing game_context:
1. Scan Saved/Logs/ for last build status
2. Check most recently modified .umap for current_map
3. Check most recently modified Blueprint for current_blueprint
4. Default build_target to "Win64 Development"
```

## Docs/ Context Restoration

### Restore Documentation Context:

```json
{
  "docs_context": {
    "current_feature": "car-customization",
    "current_phase": "implementation",
    "last_doc_updated": "Docs/features/car-customization/implementation/README.md"
  }
}
```

### Display:

```
📚 Documentation Context

📋 Current Feature: [current_feature]
📍 Phase: [current_phase]
📄 Last Doc: [last_doc_updated]

Continue with:
- /plan - Update feature plan
- /code - Continue implementation
```

## Performance Requirements

- Load time: < 500ms
- Summary display: < 3 seconds total
- File read: Single JSON parse
- Project detection: < 200ms additional

## Error Handling

```
If session.json corrupted:
→ "Session file bị lỗi. Bắt đầu fresh nhé!"
→ Skip session restore, continue workflow

If session.json empty:
→ "Chưa có gì trong session. Bắt đầu mới!"
→ Skip session restore, continue workflow

If game_context missing but UE5 detected:
→ Auto-populate from project files
→ Show: "🎮 Game project detected. Auto-populating context..."

If .uproject parse error:
→ Use defaults, log warning
→ Continue with basic game context
```

## Example Output

### Standard Project

```
🔄 Restoring session...

📍 **Đang làm:** User Authentication
   └─ Task: Implement login endpoint
   └─ Status: in_progress

⏭️ **Pending:** 3 tasks
   └─ Tiếp theo: Add password validation

🕐 **Last saved:** 2 hours ago

─────────────────────────────
✅ Context restored. Tiếp tục workflow...
```

### UE5 Game Project

```
🔄 Restoring session...

🎮 Game Session Restored

📍 Last Working On:
- Map: VN_Hanoi
- Blueprint: BP_RacingCar
- Subsystem: UCarDataSubsystem

🔧 Build Status:
- Target: Win64 Development
- Status: ✅ success

📍 **Đang làm:** Car Customization
   └─ Task: Implement paint system UI
   └─ Status: coding

📚 Docs Context:
- Feature: car-customization
- Phase: implementation

⏭️ **Pending:** 2 tasks
   └─ Tiếp theo: Add color picker widget

🕐 **Last saved:** 30 minutes ago

─────────────────────────────
✅ Game context restored. Tiếp tục workflow...

📋 Continue with:
- /code - Continue coding
- /run - Test changes
- /next - See suggestions
```

## Integration

Skill này được gọi tự động bởi tất cả AWF workflows.
User KHÔNG cần gọi trực tiếp.

### Game Project Integration

When UE5 project detected:
- Pass `game_context` to all workflows
- Enable `## 🎮 Game Dev Mode` sections in workflows
- Set `project.type = "game"` in brain.json context
