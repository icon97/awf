---
title: "AWF v4.0 Non-Tech Friendly Upgrade"
description: "Add 5 UX skills + enhance 6 workflows for non-tech users while maintaining backward compatibility"
status: in-progress
priority: P1
effort: 14h
branch: main
tags: [awf, skills, ux, non-tech, v4.0]
created: 2026-01-24
updated: 2026-01-24
---

# AWF v4.0 Non-Tech Friendly Upgrade

## Overview

Add 5 helper skills + enhance 6 workflows for non-tech users. Slash commands unchanged - skills are invisible infrastructure that auto-trigger via pre/post hooks.

**Key Principle:** User dùng AWF giống như cũ (`/plan`, `/code`, `/debug`...) nhưng hiệu quả tăng nhờ skills hoạt động ẩn.

**Architecture:**
```
~/.gemini/antigravity/
├── global_workflows/    # ENHANCED (6 workflows improved)
│   ├── audit.md         # Simplified terminology
│   ├── code.md          # Clearer quality levels
│   ├── deploy.md        # Progressive disclosure
│   ├── visualize.md     # Design terms explained
│   ├── save_brain.md    # Hidden JSON complexity
│   └── refactor.md      # Code smell explanations
│
├── skills/              # NEW (5 skills)
│   ├── awf-session-restore/    # ✅ DONE
│   ├── awf-adaptive-language/  # ✅ DONE
│   ├── awf-error-translator/   # 🔲 TODO
│   ├── awf-onboarding/         # 🔲 TODO
│   └── awf-context-help/       # 🔲 TODO
│
└── schemas/             # UPDATED
    └── preferences.schema.json  # ✅ v2.0.0 with technical_level
```

## Scope Changes (Revised)

### Skills: 8 → 5 (Dropped 3 overlapping)

| Original | Status | Reason |
|----------|--------|--------|
| awf-session-restore | ✅ KEEP | Core pain point |
| awf-adaptive-language | ✅ KEEP | Core non-tech feature |
| awf-error-translator | ✅ KEEP | High impact |
| awf-onboarding | ✅ KEEP | First-run critical |
| awf-context-help | ✅ KEEP | Helps navigation |
| ~~awf-smart-suggest~~ | ❌ DROP | Duplicates `/next` workflow |
| ~~awf-progress-tracker~~ | ❌ DROP | Duplicates `/next` workflow |
| ~~awf-rollback-guard~~ | ❌ DROP | Already in `/deploy` workflow |

### Workflows: 6 need enhancement

| Workflow | Score | Enhancement |
|----------|-------|-------------|
| `/audit` | 2/5 | Simplify security terms, explain consequences |
| `/code` | 3/5 | Clearer quality levels, explain test loop |
| `/deploy` | 3/5 | Progressive disclosure, translate acronyms |
| `/visualize` | 3/5 | Explain design terms, hide tech specs |
| `/save-brain` | 3/5 | Hide JSON structure, focus on benefits |
| `/refactor` | 3/5 | Explain code smells in outcomes |

## Skills Summary

| Skill | Trigger | Purpose |
|-------|---------|---------|
| awf-session-restore | ALL pre-hook | Auto-restore context on session start |
| awf-adaptive-language | ALL pre-hook | Adjust terminology to user level |
| awf-error-translator | /debug,/code,/test | Translate errors to human language |
| awf-onboarding | /init first-run | First-time wizard |
| awf-context-help | /help, ? trigger | Context-aware help |

## Phase Progress

| Phase | Name | Status | Effort |
|-------|------|--------|--------|
| 01 | Foundation Skills | ✅ DONE (2026-01-24) | 2h |
| 02 | Core UX Skills | 🔲 Pending | 3h |
| 03 | Workflow Enhancements | 🔲 Pending | 4h |
| 04 | Installer & Integration | 🔲 Pending | 3h |
| 05 | Testing & Docs | 🔲 Pending | 2h |

## Success Criteria

1. ✅ All 17 workflows backward compatible
2. Skills activate transparently (indicator shown)
3. Non-tech users understand errors 90%+
4. Session restore < 5 seconds
5. First-run onboarding completes in 3 steps
6. 6 enhanced workflows score 4+/5 for non-tech friendliness

## Deliverables Summary

### Phase 01 (DONE)
- [x] `awf_skills/awf-session-restore/SKILL.md`
- [x] `awf_skills/awf-adaptive-language/SKILL.md`
- [x] `schemas/preferences.schema.json` v2.0.0 with `technical_level`

### Phase 02 (Next)
- [ ] `awf_skills/awf-error-translator/SKILL.md`
- [ ] `awf_skills/awf-onboarding/SKILL.md`
- [ ] `awf_skills/awf-context-help/SKILL.md`

### Phase 03 (Workflow Enhancements)
- [ ] Enhanced `workflows/audit.md`
- [ ] Enhanced `workflows/code.md`
- [ ] Enhanced `workflows/deploy.md`
- [ ] Enhanced `workflows/visualize.md`
- [ ] Enhanced `workflows/save_brain.md`
- [ ] Enhanced `workflows/refactor.md`

### Phase 04 (Installer)
- [ ] Updated `install.ps1` with skills download
- [ ] Updated `install.sh` with skills download
- [ ] Updated `GEMINI.md` template

### Phase 05 (Testing & Docs)
- [ ] Integration tests
- [ ] Updated USER_GUIDE.md
- [ ] Migration notes for v3.4 → v4.0

## Related Files

- [Brainstorm Report](../reports/brainstorm-260124-2143-awf-v4-non-tech-friendly-upgrade.md)
- [Non-tech UX Patterns Research](../reports/researcher-02-nontech-ux-patterns-260124.md)
- [Workflow Audit Report](../reports/explore-260124-workflow-nontech-audit.md)
- [Current Schemas](../../schemas/)

## Next Steps

1. ~~Phase 01 Foundation Skills~~ ✅
2. → **Phase 02 Core UX Skills** (awf-error-translator, awf-onboarding, awf-context-help)
3. Phase 03 Workflow Enhancements
4. Phase 04 Installer & Integration
5. Phase 05 Testing & Docs
