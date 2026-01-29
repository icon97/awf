---
id: build-ue
title: /build-ue - UE5 Build Workflow
version: 1.0.0
category: game-dev
triggers:
  - /build-ue
  - /build
  - /compile
---

# /build-ue - UE5 Build Workflow

## Overview

### Purpose
Manage UE5 project builds - compile C++ code, cook content, and package games for distribution.

### When to Use
- Before testing changes in standalone mode
- Before packaging for distribution
- After making C++ code changes
- After modifying Build.cs or Target.cs files
- When switching build configurations

---

## Build Targets

### Development Targets
| Target | Platform | Use Case |
|--------|----------|----------|
| Win64 Development | Windows | Daily development, debugging |
| Win64 DebugGame | Windows | Deep debugging with symbols |
| Win64 Shipping | Windows | Final release build |

### Console Targets (if applicable)
| Target | Platform | Notes |
|--------|----------|-------|
| PS5 Development | PlayStation 5 | Requires SDK |
| XSX Development | Xbox Series X | Requires GDK |
| Switch Development | Nintendo Switch | Requires SDK |

### Platform Targets
| Platform | Command Flag | Notes |
|----------|--------------|-------|
| Win64 | `-platform=Win64` | Default for Windows |
| Linux | `-platform=Linux` | Server builds |
| Android | `-platform=Android` | Mobile |
| iOS | `-platform=iOS` | Requires Mac |

---

## Build Configurations

### Editor vs Standalone
| Config | Command | Use Case |
|--------|---------|----------|
| Editor | Build [Project]Editor Win64 Development | For PIE testing |
| Game | Build [Project] Win64 Development | Standalone game |
| Server | Build [Project]Server Win64 Development | Dedicated server |
| Client | Build [Project]Client Win64 Development | Network client |

### Configuration Types
| Config | Description | Performance | Debug |
|--------|-------------|-------------|-------|
| `Debug` | Full debug info | Slow | Full |
| `DebugGame` | Debug game, optimized engine | Medium | Game only |
| `Development` | Balanced | Good | Limited |
| `Shipping` | Release build | Best | None |
| `Test` | Like Shipping + testing | Good | Test only |

---

## Pre-Build Checks

### Before Building:
1. **Save All** - Ensure all assets saved
2. **Check Errors** - Review Message Log for warnings
3. **Verify Dependencies** - Check plugin status
4. **Clean Intermediates** (if needed) - Delete Intermediate/ folder

### Checklist:
```
□ Source control clean (no uncommitted changes)?
□ All .uasset files saved?
□ No Blueprint compile errors?
□ DefaultEngine.ini configured correctly?
□ Build.cs dependencies up to date?
```

### Quick Check Commands:
```bash
# Check for unsaved assets
/audit --unsaved

# Check for Blueprint errors
/blueprint --validate

# Check C++ syntax
/code --check
```

---

## Build Execution

### From Editor:
1. File → Package Project → Build Configuration
2. Or: Platforms → [Platform] → Build

### From Command Line:
```bash
# Development build
RunUAT.bat BuildCookRun -project="[Project].uproject" -platform=Win64 -configuration=Development -build

# Shipping build
RunUAT.bat BuildCookRun -project="[Project].uproject" -platform=Win64 -configuration=Shipping -build -cook -stage -pak

# Server build
RunUAT.bat BuildCookRun -project="[Project].uproject" -platform=Win64 -configuration=Development -server -build
```

### Build Options:
| Option | Purpose |
|--------|---------|
| -build | Compile code |
| -cook | Cook content |
| -stage | Stage for packaging |
| -pak | Create .pak files |
| -clean | Clean before build |
| -iterate | Incremental cook |

### Quick Build (Editor)
```powershell
# Windows
UnrealBuildTool.exe [ProjectName]Editor Win64 Development

# Or via Editor
# Build → Build [ProjectName]
```

### Full Rebuild
```powershell
# Clean + Build
UnrealBuildTool.exe [ProjectName] Win64 Development -clean
UnrealBuildTool.exe [ProjectName] Win64 Development
```

---

## Build Modes

### /build-ue compile
Compile C++ code only:
```
Input: /build-ue compile
Output:
- Compile all modules
- Report errors/warnings
- Update session.json with build status
```

### /build-ue cook
Cook content for target platform:
```
Input: /build-ue cook [platform]
Output:
- Cook all content
- Report missing assets
- Estimate package size
```

### /build-ue package
Full package for distribution:
```
Input: /build-ue package [platform] [config]
Output:
- Build + Cook + Stage + Package
- Generate build report
- Update session.json
```

### /build-ue clean
Clean build artifacts:
```
Input: /build-ue clean
Output:
- Remove Intermediate/
- Remove Saved/StagedBuilds/
- Keep Binaries/ (optional)
```

---

## Error Handling

### Common Build Errors
| Error | Cause | Fix |
|-------|-------|-----|
| `C2065` | Undeclared identifier | Add #include |
| `LNK2019` | Unresolved external | Implement function |
| `Cook failed` | Missing asset reference | Fix redirectors |
| `Package failed` | Invalid config | Check DefaultGame.ini |

### Build Failed Workflow:
```
1. Check Output Log for first error
2. Use /debug to analyze error
3. Fix issue
4. Run /build-ue compile to verify
5. Continue with full build
```

---

## Post-Build Summary

### On Success:
```
✅ Build Complete

📊 Build Summary:
- Target: [target]
- Platform: [platform]
- Configuration: [config]
- Duration: [time]
- Output: [path]

📋 Next Steps:
- /run to test build
- /deploy to package
- /test to run automation
```

### On Failure:
```
❌ Build Failed

🔴 Errors: [count]
🟡 Warnings: [count]

📋 Common Fixes:
- /debug to analyze errors
- /code --fix to auto-fix issues
- Clean Intermediate/ and rebuild
```

---

## Session Update

After build, update session.json:
```json
{
  "game_context": {
    "last_build": {
      "timestamp": "[ISO date]",
      "target": "[target]",
      "platform": "[platform]",
      "configuration": "[config]",
      "status": "success|failed",
      "duration_seconds": [number],
      "errors": [count],
      "warnings": [count]
    }
  }
}
```

---

## Terminology cho newbie

| Term | Giải thích |
|------|-----------|
| Build Target | Nền tảng đích (Win64, PS5, etc.) |
| Configuration | Chế độ build (Development, Shipping) |
| Cook | Chuyển đổi assets sang format runtime |
| UAT | Unreal Automation Tool - công cụ build |
| Pak | File đóng gói assets (.pak) |
| Intermediate | Folder chứa file tạm khi build |

---

## Related Workflows
- `/run` - Test build
- `/deploy` - Distribute build
- `/debug` - Fix build errors
- `/test` - Run automation tests

