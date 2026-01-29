# AWF v4.0 Test Plan

## Quick Test Checklist

### Prerequisites
```bash
# 1. Install AWF v4.0
# Windows:
powershell -ExecutionPolicy Bypass -File install.ps1
# Mac/Linux:
./install.sh

# 2. Verify installation
ls ~/.gemini/antigravity/skills/
# Should show: awf-session-restore, awf-adaptive-language, awf-error-translator, awf-onboarding, awf-context-help
```

---

## Test 1: Adaptive Language (awf-adaptive-language)

### Setup
```bash
# Create preferences file in your project
mkdir -p .brain
echo '{"technical":{"technical_level":"newbie"}}' > .brain/preferences.json
```

### Test Steps
1. Open Gemini in your project
2. Run `/code` command
3. **Expected:** AI uses simple language, no technical jargon
4. Change to `"technical_level":"technical"` and test again
5. **Expected:** AI uses technical terms freely

### Pass Criteria
- [ ] Newbie mode: No stack traces, emoji explanations
- [ ] Technical mode: Full technical details

---

## Test 2: Error Translator (awf-error-translator)

### Test Steps
1. Set `technical_level: "newbie"` in preferences.json
2. Run `/debug` with an error like:
   ```
   /debug
   Error: ECONNREFUSED 127.0.0.1:5432
   ```
3. **Expected:** AI explains "Database chưa bật → Mở app database lên"

### Pass Criteria
- [ ] Error translated to simple Vietnamese
- [ ] Action suggested (what to do next)
- [ ] No raw stack trace shown

---

## Test 3: Session Restore (awf-session-restore)

### Setup
```bash
# Create session file
cat > .brain/session.json << 'EOF'
{
  "updated_at": "2026-01-24T10:00:00Z",
  "working_on": {
    "feature": "User Authentication",
    "task": "Create login form",
    "status": "coding"
  },
  "pending_tasks": [
    {"task": "Add validation", "priority": "high"}
  ]
}
EOF
```

### Test Steps
1. Open Gemini in your project
2. Run `/recap`
3. **Expected:** AI summarizes "Lần trước bạn đang làm: User Authentication..."

### Pass Criteria
- [ ] Context restored automatically
- [ ] Summary in user-friendly format
- [ ] Pending tasks mentioned

---

## Test 4: Context Help (awf-context-help)

### Test Steps
1. Run `/debug` (pretend you're debugging)
2. Then run `/help`
3. **Expected:** AI suggests debugging-related commands

### Pass Criteria
- [ ] Help is context-aware
- [ ] Suggests relevant next commands

---

## Test 5: Workflow Non-Tech Mode

### Test Workflows
Test each workflow with `technical_level: "newbie"`:

| Workflow | Test Command | Expected |
|----------|--------------|----------|
| `/debug` | Report an error | Simple explanation, no stack trace |
| `/init` | Start new project | Progress bar, no tech details |
| `/test` | Run tests | "X/Y tests passed" format |
| `/recap` | Restore context | Human-readable summary |
| `/brainstorm` | Discuss idea | No technical jargon |
| `/deploy` | Deploy app | Step-by-step with simple terms |
| `/code` | Write code | Quality level explained simply |
| `/audit` | Security check | Threats explained plainly |
| `/refactor` | Clean code | Code smells in simple terms |
| `/visualize` | Design UI | Design terms explained |
| `/save_brain` | Save progress | Benefits-focused messaging |

### Pass Criteria
- [ ] All 11 workflows adapt to newbie level
- [ ] Technical terms have explanations
- [ ] Progress shown with emojis

---

## Test 6: Backward Compatibility

### Test Steps
1. Remove preferences.json (use defaults)
2. Run any workflow (`/plan`, `/code`, `/debug`)
3. **Expected:** Works exactly like v3.4

### Pass Criteria
- [ ] All v3.4 commands work
- [ ] No errors without preferences.json
- [ ] Default behavior unchanged

---

## Test Summary

| Test | Status |
|------|--------|
| Adaptive Language | ⬜ |
| Error Translator | ⬜ |
| Session Restore | ⬜ |
| Context Help | ⬜ |
| Workflow Non-Tech | ⬜ |
| Backward Compat | ⬜ |

**Legend:** ✅ Pass | ❌ Fail | ⬜ Not tested

---

## Automated Test Script (Optional)

```bash
#!/bin/bash
# test-awf-v4.sh

echo "🧪 AWF v4.0 Test Suite"
echo "======================"

# Check skills installed
echo -n "Skills installed: "
if [ -d ~/.gemini/antigravity/skills/awf-error-translator ]; then
  echo "✅"
else
  echo "❌"
  exit 1
fi

# Check workflows enhanced
echo -n "Workflows enhanced: "
if grep -q "Non-Tech Mode" ~/.gemini/antigravity/global_workflows/debug.md; then
  echo "✅"
else
  echo "❌"
fi

# Check version
echo -n "Version 4.0.0: "
if grep -q "4.0.0" ~/.gemini/awf_version; then
  echo "✅"
else
  echo "❌"
fi

echo ""
echo "Manual tests required for full validation."
echo "See test-awf-v4.md for details."
```

---

## Report Issues

If tests fail, report at: https://github.com/icon97/awf/issues

Include:
- AWF version (`cat ~/.gemini/awf_version`)
- OS (Windows/Mac/Linux)
- Error message
- Steps to reproduce
