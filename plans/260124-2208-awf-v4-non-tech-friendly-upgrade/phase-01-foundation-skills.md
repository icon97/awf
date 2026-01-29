# Phase 01: Foundation Skills

## Context Links
- [Main Plan](./plan.md)
- [Brainstorm Report](../reports/brainstorm-260124-2143-awf-v4-non-tech-friendly-upgrade.md)
- [Preferences Schema](../../schemas/preferences.schema.json)

## Overview
| Priority | P1 - Critical Path |
|----------|-------------------|
| Status | Done (2026-01-24 22:25) |
| Effort | 2h |

Create foundation infrastructure: skills directory, session-restore skill, adaptive-language skill, and update preferences schema.

## Key Insights
- Skills discovered by matching task descriptions to SKILL.md
- Pre-hooks run BEFORE workflow execution
- Session restore must be < 5 seconds
- Adaptive language reads `technical_level` from preferences

## Requirements

### Functional
- [x] Create skills/ directory structure
- [x] awf-session-restore: auto-loads context at workflow start
- [x] awf-adaptive-language: adjusts terminology per user level
- [x] Update preferences.schema.json with `technical_level` field

### Non-Functional
- [x] Skills load time < 500ms
- [x] No breaking changes to existing workflows
- [x] SKILL.md follows Antigravity standard format

## Architecture

```
~/.gemini/antigravity/skills/
├── awf-session-restore/
│   └── SKILL.md
└── awf-adaptive-language/
    └── SKILL.md
```

**Pre-hook Pattern:**
```
User runs /code → awf-session-restore activates → shows "Restoring context..." → workflow executes
```

## Related Code Files

### Create
- `skills/awf-session-restore/SKILL.md`
- `skills/awf-adaptive-language/SKILL.md`

### Modify
- `schemas/preferences.schema.json` - add technical_level enum

## Implementation Steps

### 1. Create Directory Structure
- [x] Create `skills/` folder in repo
- [x] Create `skills/awf-session-restore/` folder
- [x] Create `skills/awf-adaptive-language/` folder

### 2. Create awf-session-restore Skill
- [x] Write SKILL.md with:
  - name: awf-session-restore
  - description: Keywords "context, memory, session, restore, recap, remember"
  - Trigger: Pre-hook for ALL workflows
  - Logic: Read .brain/session.json → show brief summary → continue
  - Show indicator: "Restoring session..."

### 3. Create awf-adaptive-language Skill
- [x] Write SKILL.md with:
  - name: awf-adaptive-language
  - description: Keywords "language, terminology, jargon, level, beginner"
  - Trigger: Pre-hook for ALL workflows
  - Logic: Read preferences.json technical_level → set terminology context
  - Levels: newbie (no jargon), basic (some jargon), technical (full jargon)

### 4. Update preferences.schema.json
- [x] Add `technical_level` field under `technical` object
- [x] Enum: ["newbie", "basic", "technical"]
- [x] Default: "basic"
- [x] Bump version to 2.0.0

## Success Criteria
- [x] Both skills have valid SKILL.md
- [x] preferences.schema.json validates with new field
- [x] Skills can be discovered by Antigravity agent
- [x] No existing workflows break

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Skill discovery fails | High | Test with actual Antigravity agent |
| Performance overhead | Medium | Keep SKILL.md minimal |

## Security Considerations
- Skills read-only access to .brain/ files
- No sensitive data exposure in indicators

## Next Steps
- After completion → [Phase 02: Core UX Skills](./phase-02-core-ux-skills.md)
