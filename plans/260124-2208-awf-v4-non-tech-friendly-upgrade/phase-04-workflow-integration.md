# Phase 04: Workflow Integration

## Context Links
- [Main Plan](./plan.md)
- [Phase 03](./phase-03-safety-onboarding-skills.md)
- [All Workflows](../../workflows/)
- [Code Workflow](../../workflows/code.md)

## Overview
| Priority | P1 - Integration |
|----------|-----------------|
| Status | Pending |
| Effort | 2h |

Update all 17 workflows with skill call indicators. Add pre-hooks/post-hooks documentation. Test backward compatibility.

## Key Insights
- Workflows don't call skills directly - agent discovers them
- Manual indicators show which skill is active
- Hooks are documentation triggers, not actual function calls
- Backward compatible: no changes to slash command behavior

## Requirements

### Functional
- [ ] All workflows document which skills apply
- [ ] Manual indicators added at workflow start
- [ ] Post-hook suggestions at workflow end

### Non-Functional
- Zero breaking changes to command behavior
- Indicators optional (can be disabled in preferences)
- Hook documentation consistent across workflows

## Architecture

**Skill Integration Pattern:**
```markdown
## Pre-Hooks (Auto-Activate)
- awf-session-restore: Restores context if available
- awf-adaptive-language: Adjusts terminology

## Post-Hooks (Auto-Activate)
- awf-smart-suggest: Recommends next steps
```

**Indicator Format:**
```
"Restoring session..." → workflow content → "Analyzing next steps..."
```

## Related Code Files

### Modify (All 17 Workflows)
- `workflows/audit.md`
- `workflows/brainstorm.md`
- `workflows/code.md`
- `workflows/customize.md`
- `workflows/debug.md`
- `workflows/deploy.md`
- `workflows/init.md`
- `workflows/next.md`
- `workflows/plan.md`
- `workflows/recap.md`
- `workflows/refactor.md`
- `workflows/rollback.md`
- `workflows/run.md`
- `workflows/save_brain.md`
- `workflows/test.md`
- `workflows/visualize.md`
- `workflows/awf-update.md`

## Implementation Steps

### 1. Define Hook Patterns
- [ ] Create standard hook documentation block:
  ```markdown
  ## AWF Skills (v4.0)
  **Pre-hooks:** awf-session-restore, awf-adaptive-language
  **Post-hooks:** awf-smart-suggest
  **Indicators:** Show "Skill: [name]" when active
  ```

### 2. Update Core Workflows
- [ ] `/code` - Add error-translator hook, progress-tracker
- [ ] `/debug` - Add error-translator hook
- [ ] `/test` - Add error-translator hook
- [ ] `/deploy` - Add rollback-guard pre-hook
- [ ] `/rollback` - Add rollback-guard pre-hook
- [ ] `/init` - Add onboarding pre-hook (first-run only)
- [ ] `/help` - Route to awf-context-help
- [ ] `/next` - Add progress-tracker hook
- [ ] `/recap` - Add progress-tracker hook

### 3. Update Support Workflows
- [ ] `/plan`, `/brainstorm`, `/visualize` - Standard hooks only
- [ ] `/audit`, `/refactor`, `/run` - Standard hooks only
- [ ] `/save_brain`, `/customize` - Standard hooks only
- [ ] `/awf-update` - No hooks (system command)

### 4. Add Indicator Blocks
- [ ] Each workflow start:
  ```markdown
  > Skill indicators (v4.0):
  > Pre: "Restoring session..." | "Adjusting language..."
  > Post: "Analyzing next steps..."
  ```

### 5. Test Backward Compatibility
- [ ] All slash commands work without changes
- [ ] Users without skills/ folder see no errors
- [ ] Existing .brain/ files work unchanged

## Success Criteria
- [ ] All 17 workflows updated with hook documentation
- [ ] Indicators documented consistently
- [ ] No existing functionality broken
- [ ] Skills optional (graceful degradation)

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Breaking existing workflows | High | Changes are documentation only |
| Indicator fatigue | Medium | Keep indicators brief |
| Inconsistent hook usage | Low | Use copy-paste template |

## Security Considerations
- No new permissions required
- Hooks are passive documentation

## Next Steps
- After completion → [Phase 05: Installer & Docs](./phase-05-installer-docs.md)
