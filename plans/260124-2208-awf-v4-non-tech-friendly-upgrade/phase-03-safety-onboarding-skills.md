# Phase 03: Safety & Onboarding Skills

## Context Links
- [Main Plan](./plan.md)
- [Phase 02](./phase-02-core-ux-skills.md)
- [Deploy Workflow](../../workflows/deploy.md)
- [Rollback Workflow](../../workflows/rollback.md)

## Overview
| Priority | P1 - Safety Critical |
|----------|---------------------|
| Status | Pending |
| Effort | 3h |

Create 3 skills: onboarding wizard (first-run experience), rollback guard (destructive action protection), progress tracker (visual progress).

## Key Insights
- Onboarding must complete in 3 steps max (research finding)
- Destructive actions need explicit confirmation
- Progress visualization increases user confidence
- First-run detection via missing .brain/ folder

## Requirements

### Functional
- [ ] awf-onboarding: 3-step wizard for first-time users
- [ ] awf-rollback-guard: Confirm before destructive actions
- [ ] awf-progress-tracker: Visual progress bars/indicators

### Non-Functional
- Onboarding skippable
- Guard cannot be bypassed accidentally
- Progress updates real-time

## Architecture

**Onboarding Flow:**
```
User runs /init (no .brain/) → awf-onboarding activates
→ Step 1: "What's your tech level?" [Newbie/Basic/Technical]
→ Step 2: "What are you building?" [description]
→ Step 3: "How do you want AI to communicate?" [friendly/professional]
→ Creates preferences.json + shows "Ready to go!"
```

**Rollback Guard Flow:**
```
User runs /rollback → awf-rollback-guard activates
→ Shows: "WARNING: This will undo changes. Type 'yes' to confirm"
→ Requires explicit confirmation before proceeding
```

## Related Code Files

### Create
- `skills/awf-onboarding/SKILL.md`
- `skills/awf-rollback-guard/SKILL.md`
- `skills/awf-progress-tracker/SKILL.md`

## Implementation Steps

### 1. Create awf-onboarding Skill
- [ ] SKILL.md with:
  - name: awf-onboarding
  - description: Keywords "first time, new, start, beginner, setup, welcome"
  - Trigger: /init when .brain/ folder doesn't exist
  - 3-step wizard:
    1. Tech level selection (newbie/basic/technical)
    2. Project description (free text)
    3. Communication style (friendly/professional/casual)
  - Creates: .brain/preferences.json with user choices
  - Show indicator: "Setting up AWF..."
  - Skip option: "Skip setup (use defaults)"

### 2. Create awf-rollback-guard Skill
- [ ] SKILL.md with:
  - name: awf-rollback-guard
  - description: Keywords "rollback, undo, revert, dangerous, destructive, confirm"
  - Trigger: Pre-hook for /deploy, /rollback
  - Logic:
    - /rollback: Show warning, require "yes" confirmation
    - /deploy: Check skipped_tests, warn if > 0
  - Guard levels:
    - Yellow: "This will deploy to production. Confirm?"
    - Red: "DANGER: This will delete data. Type 'DELETE' to confirm"
  - Show indicator: "Safety check..."

### 3. Create awf-progress-tracker Skill
- [ ] SKILL.md with:
  - name: awf-progress-tracker
  - description: Keywords "progress, status, how far, percentage, done"
  - Trigger: /code, /next, /recap
  - Visual formats:
    ```
    Phase Progress: [====----] 4/8 (50%)
    Current: phase-04-api-endpoints

    Task Progress: [==------] 2/8 (25%)
    Current: Implement GET /orders
    ```
  - Reads: plan.md phase list, session.json current_phase
  - Show indicator: "Calculating progress..."

## Success Criteria
- [ ] Onboarding creates valid preferences.json
- [ ] Rollback guard prevents accidental destructive actions
- [ ] Progress tracker shows accurate completion %
- [ ] All indicators visible

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Onboarding too long | High | Strict 3-step limit, skip option |
| Guard too annoying | Medium | Only on truly destructive actions |
| Progress calculation wrong | Low | Validate against plan.md structure |

## Security Considerations
- Guard cannot be programmatically bypassed
- Onboarding doesn't ask for sensitive info
- Progress doesn't expose internal paths

## Next Steps
- After completion → [Phase 04: Workflow Integration](./phase-04-workflow-integration.md)
