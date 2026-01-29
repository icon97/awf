---
id: assets
title: /assets - Asset Management Workflow
version: 1.0.0
category: game-dev
triggers:
  - /assets
  - /content
---

# /assets - Asset Management Workflow

## Overview

**Purpose**: Manage UE5 Content folder - import, audit, organize, optimize

**Modes**:
| Mode | Description |
|------|-------------|
| import | Import external assets into project |
| audit | Check assets for issues and violations |
| organize | Structure Content folder properly |
| optimize | Optimize assets for target platform |

---

## /assets import

### Import Assets:
```
/assets import [source] --type [type] --dest [destination]
```

### Supported Types:
| Type | Extensions | Import Settings |
|------|------------|-----------------|
| Texture | .png, .jpg, .tga, .psd | Compression, MipMaps |
| Mesh | .fbx, .obj | LODs, Collision |
| Audio | .wav, .ogg, .mp3 | Quality, Streaming |
| Animation | .fbx | Skeleton, Retarget |
| Material | - | Create from textures |

### Import Checklist:
- [ ] Source files in correct format
- [ ] Naming follows convention
- [ ] Destination folder exists
- [ ] No duplicate names

### Naming Convention:
| Type | Prefix | Example |
|------|--------|---------|
| Texture | T_ | T_Car_Diffuse |
| Material | M_ | M_CarPaint |
| Material Instance | MI_ | MI_CarPaint_Red |
| Static Mesh | SM_ | SM_RacingCar |
| Skeletal Mesh | SK_ | SK_Character |
| Animation | A_ | A_Character_Run |
| Sound | S_ | S_Engine_Loop |
| Particle | P_ | P_Exhaust |

---

## /assets audit

### Audit Content Folder:
```
/assets audit [path] --check [checks]
```

### Audit Checks:
| Check | Description | Severity |
|-------|-------------|----------|
| naming | Naming convention violations | Warning |
| unused | Unused assets | Info |
| missing | Missing references | Error |
| size | Oversized assets | Warning |
| duplicates | Duplicate assets | Warning |

### Audit Report:
```
📊 Asset Audit Report

📁 Scanned: [path]
📄 Total Assets: [count]

🔴 Errors: [count]
- [Asset]: Missing reference to [Other]

🟡 Warnings: [count]
- [Asset]: Name doesn't follow convention (expected: T_*)
- [Asset]: Texture size 4096x4096 exceeds recommended 2048x2048

🔵 Info: [count]
- [Asset]: Unused (no references)

📋 Recommendations:
1. Fix missing references first
2. Rename assets to follow convention
3. Resize oversized textures
```

### Size Guidelines:
| Asset Type | Recommended Max | Notes |
|------------|-----------------|-------|
| Texture (UI) | 1024x1024 | Can be smaller |
| Texture (World) | 2048x2048 | Use streaming |
| Texture (Hero) | 4096x4096 | Sparingly |
| Mesh (LOD0) | 50k triangles | With LODs |
| Audio (SFX) | 1MB | Compressed |
| Audio (Music) | 10MB | Streaming |

---

## /assets organize

### Organize Content Folder:
```
/assets organize [path] --structure [template]
```

### Recommended Structure:
```
Content/
├── _Core/              # Core game assets
│   ├── Blueprints/
│   ├── Materials/
│   └── Textures/
├── Characters/         # Character assets
│   ├── Player/
│   └── NPCs/
├── Vehicles/           # Vehicle assets
│   ├── Cars/
│   └── Parts/
├── Environment/        # World assets
│   ├── Props/
│   ├── Landscape/
│   └── Buildings/
├── UI/                 # User interface
│   ├── Widgets/
│   ├── Icons/
│   └── Fonts/
├── Audio/              # Sound assets
│   ├── SFX/
│   ├── Music/
│   └── Voice/
├── Effects/            # VFX assets
│   ├── Particles/
│   └── Materials/
└── Maps/               # Level maps
    ├── MainMenu/
    └── Gameplay/
```

### Organization Rules:
| Rule | Description |
|------|-------------|
| No root clutter | All assets in subfolders |
| Type separation | Textures, Meshes, etc. separate |
| Feature grouping | Related assets together |
| Shared assets | In _Core/ folder |

---

## /assets optimize

### Optimize Assets:
```
/assets optimize [path] --target [platform]
```

### Optimization Tasks:
| Task | Command | Effect |
|------|---------|--------|
| Generate LODs | --lods | Reduce draw calls |
| Compress Textures | --compress | Reduce memory |
| Create MipMaps | --mipmaps | Better streaming |
| Merge Materials | --merge-mats | Reduce draw calls |
| Remove Unused | --cleanup | Reduce package size |

### Platform-Specific:
| Platform | Texture Format | Max Size |
|----------|----------------|----------|
| Windows | BC7/DXT | 4096 |
| Mobile | ASTC/ETC2 | 2048 |
| Console | BC7 | 4096 |

### Optimization Report:
```
📊 Optimization Report

Before:
- Total Size: [size]
- Textures: [count] ([size])
- Meshes: [count] ([size])

After:
- Total Size: [size] (↓[percent])
- Textures: [count] ([size])
- Meshes: [count] ([size])

Changes:
- [Asset]: Compressed [before] → [after]
- [Asset]: Generated 4 LODs
- [Asset]: Removed (unused)
```

---

## Content Folder Awareness

### Auto-Detection:
```
When in Content/ folder:
1. Detect asset type from extension
2. Suggest appropriate subfolder
3. Validate naming convention
4. Check for duplicates
```

### Quick Commands:
| Command | Action |
|---------|--------|
| /assets here | Audit current folder |
| /assets fix | Auto-fix naming issues |
| /assets move | Move to correct folder |
| /assets refs | Show references |

---

## Terminology cho newbie

| Term | Giải thích |
|------|-----------|
| Asset | File tài nguyên (texture, mesh, sound) |
| Content | Folder chứa tất cả assets |
| LOD | Level of Detail - mesh đơn giản hơn ở xa |
| MipMap | Texture nhỏ hơn cho vật ở xa |
| Reference | Liên kết giữa các assets |
| Streaming | Load asset khi cần, không load hết |
| Pak | File đóng gói assets khi build |
| Cook | Chuyển đổi asset sang format runtime |

---

## Related Workflows
- `/audit` - Performance audit
- `/build-ue` - Build with assets
- `/deploy` - Package assets
- `/refactor` - Reorganize assets

