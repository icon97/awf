# Phase 02: Core UX Skills

## Context Links
- [Main Plan](./plan.md)
- [Phase 01](./phase-01-foundation-skills.md)
- [Error Examples](../../workflows/code.md#resilience-patterns)

## Overview
| Priority | P1 - User Experience |
|----------|---------------------|
| Status | Pending |
| Effort | 3h |

Create 3 skills for core UX: error translator (human-friendly errors), context help (smart /help), smart suggest (next step recommendations).

## Key Insights
- Error messages must avoid ALL technical jargon for newbie level
- Context help reads session.json to understand current state
- Smart suggest analyzes workflow completion state
- Each skill needs manual indicator (user requirement)

## Requirements

### Functional
- [ ] awf-error-translator: Map 50+ common errors to human language
- [ ] awf-context-help: Dynamic help based on current workflow state
- [ ] awf-smart-suggest: Recommend 1-3 next actions with reasons

### Non-Functional
- Error translation < 100ms
- Suggestions ranked by relevance
- Help responses actionable, not generic

## Architecture

**Error Translator Flow:**
```
Error occurs → awf-error-translator activates → shows indicator
→ matches error pattern → returns human message + suggested action
```

**Error Mapping Database (in SKILL.md):**
```
ECONNREFUSED → "Database not running. Start PostgreSQL?"
TypeError: Cannot read → "Code error. Running auto-fix..."
npm ERR! → "Package install failed. Retry or skip?"
```

## Related Code Files

### Create
- `skills/awf-error-translator/SKILL.md`
- `skills/awf-context-help/SKILL.md`
- `skills/awf-smart-suggest/SKILL.md`

## Implementation Steps

### 1. Create awf-error-translator Skill
- [ ] SKILL.md with:
  - name: awf-error-translator
  - description: Keywords "error, translate, explain, help, fix, fail"
  - Trigger: When error detected in /debug, /code, /test
  - Include error mapping table (50+ patterns)
  - Output format: emoji + human message + suggested action
  - Show indicator: "Translating error..."

### 2. Build Error Mapping Database
- [ ] Database errors: ECONNREFUSED, ETIMEDOUT, auth failures
- [ ] JS/TS errors: TypeError, ReferenceError, SyntaxError
- [ ] Package errors: npm ERR, yarn error, module not found
- [ ] Network errors: fetch failed, timeout, CORS
- [ ] Test errors: assertion failed, expected vs received
- [ ] Each mapping: pattern → human_message → action

### 3. Create awf-context-help Skill
- [ ] SKILL.md with:
  - name: awf-context-help
  - description: Keywords "help, what, how, confused, stuck, lost"
  - Trigger: /help command or "?" in prompt
  - Logic: Read session.json → detect current workflow → provide relevant help
  - Context-specific examples for each workflow state
  - Show indicator: "Getting context..."

### 4. Create awf-smart-suggest Skill
- [ ] SKILL.md with:
  - name: awf-smart-suggest
  - description: Keywords "next, suggest, recommend, what now, continue"
  - Trigger: Post-hook for ALL workflows
  - Logic: Analyze session.json status → rank suggestions
  - Suggestion rules:
    - Phase complete → suggest /code next-phase or /save-brain
    - Tests failing → suggest /debug or /test
    - skipped_tests > 0 → remind before /deploy
  - Show indicator: "Analyzing next steps..."

## Success Criteria
- [ ] Error translator covers 50+ common patterns
- [ ] Context help differs based on current state
- [ ] Smart suggest provides relevant recommendations
- [ ] All indicators visible to user

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Missing error patterns | Medium | Start with common, add more over time |
| Over-suggestion (annoying) | Medium | Limit to 1-3 suggestions, make dismissible |
| Context detection wrong | Low | Fallback to generic help |

## Security Considerations
- Error messages sanitized (no credentials leaked)
- Help content read-only

## Next Steps
- After completion → [Phase 03: Safety & Onboarding](./phase-03-safety-onboarding-skills.md)
