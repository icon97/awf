# Antigravity Skill System: Best Practices & Integration Patterns

**Report Date:** 2026-01-24
**Scope:** SKILL.md format, directory structure, integration with workflows, error handling
**Sources:** AWF codebase analysis + official Anthropic skills documentation

---

## 1. SKILL.md Format & Frontmatter

### Required Frontmatter (YAML)
```yaml
---
name: skill-name-in-kebab-case
description: Clear description of what skill does and when to use it (written for AI reader)
---
```

**Rules:**
- `name`: Lowercase alphanumeric + hyphen only. Must match directory name.
- `description`: Make-or-break field. Write in third person with strong trigger keywords.
  - ✅ Good: "Generates REST API handlers in FastAPI following security conventions"
  - ❌ Bad: "Help write APIs"

### Optional Frontmatter
```yaml
license: MIT  # or Apache 2.0, etc.
version: 2.0.0
allowed-tools: []  # Pre-approved tools (Claude Code only)
metadata:  # Map of string key-value pairs for custom properties
  domain: "backend"
  complexity: "advanced"
```

### Markdown Body
- No restrictions. Contains instructions, examples, guidelines Claude follows.
- AWF pattern: Include "Communication Style" section referencing coding-level guidelines if injected.
- Include "Your Approach" section listing execution steps.
- Add "Critical Constraints" section outlining what skill does NOT do.

---

## 2. Directory Structure Best Practices

### Minimal Skill
```
my-skill/
  └── SKILL.md
```

### Typical Skill (AWF Pattern)
```
skill-name/
├── SKILL.md              # Entrypoint with YAML + instructions
├── scripts/              # Optional: executable utilities
│   ├── init.sh
│   └── helper.py
├── templates/            # Optional: reusable templates
│   └── template.json
├── examples/             # Optional: usage examples
│   └── example.md
└── docs/                 # Optional: detailed documentation
    └── advanced-usage.md
```

### Scope Levels
- **Global:** `~/.gemini/antigravity/skills/` (macOS/Linux) or `%USERPROFILE%\.gemini\antigravity\skills\` (Windows)
  - Available in all projects
  - Updated by installers
- **Project-Specific:** `./.claude/skills/` or `./.brain/skills/`
  - Loaded only in that project
  - Supports venv Python: `./.claude/skills/.venv/Scripts/python.exe`

### Naming Convention
- Use kebab-case: `my-skill-name` (directory) = `my-skill-name` (name field)
- File names: descriptive, kebab-case, self-documenting for LLM tools
- Skills often group by domain: `backend-development`, `ai-multimodal`, `code-reviewer`

---

## 3. Workflow-to-Skill Integration Patterns

### Discovery & Loading
1. Session start: Agent receives **list of all skills** (name + description only)
2. If task matches skill description → Agent reads full SKILL.md + follows instructions
3. Skills are task-specific, not command-specific

### Integration in Workflows
**Pattern A: Explicit Skill Invocation**
```markdown
# Workflow Section
When brainstorming architecture decisions, use the `brainstorm` skill.

The skill will:
- Ask clarifying questions
- Present trade-off analysis
- Challenge assumptions
- Output markdown report
```

**Pattern B: Conditional Skill Use**
```markdown
If [condition], delegate to [skill-name] agent/skill.
Example from plan.md: "If need authentication, engage `better-auth` skill"
```

**Pattern C: Chained Skill Execution**
AWF workflows chain skills sequentially:
- `/plan` → uses `brainstorm` + `planner` agents
- `/code` → uses `tester` + `code-reviewer` agents
- Skills output feeds into next workflow phase

### Pre/Post Hook Patterns (AWF Convention)
Not formally defined in spec, but AWF implements:

**Pre-Hook (Validation):**
- Skill reads session.json to validate context before execution
- Example: `/code` checks `current_plan_path` before coding

**Post-Hook (State Persistence):**
- Skill updates session.json after completion
- Example: Skill saves `working_on.current_phase` when task done
- Workflow continues from saved state if interrupted

### Context Passing
AWF pattern for context inheritance:
```json
// .brain/session.json
{
  "working_on": {
    "current_plan_path": "plans/260124-1234-feature/",
    "current_phase": "phase-02",
    "task": "Implement database schema"
  },
  "reports_path": "plans/reports/"
}
```

Skills read this to understand:
- What plan they're implementing
- Where to save reports
- What phase context to maintain

---

## 4. Error Handling & Resilience Patterns

### Skill-Level Error Handling
**AWF Pattern (from workflows):**

```markdown
## Error Recovery
- Auto-retry transient errors (network, rate limits) with exponential backoff
- Translate technical errors to simple language for users
- Fallback prompts when operations fail repeatedly (max 3 retries)
- Ask user to manually intervene if auto-fixes exhausted
```

### User-Friendly Error Messages
- **Technical error:** "Connection timeout: ECONNREFUSED on port 5432"
- **User-friendly:** "Can't connect to database. Check if it's running?"

### Critical Constraints Section
AWF skills include "Critical Constraints" to define scope:
```markdown
## Critical Constraints
- You DO NOT implement solutions yourself - you only brainstorm and advise
- You must validate feasibility before endorsing any approach
- You prioritize long-term maintainability over short-term convenience
```

This prevents AI from violating skill boundaries.

---

## 5. AWF-Specific Integration Details

### Skill Collaboration Pattern
From `brainstorm` SKILL.md:
```markdown
## Collaboration Tools
- Consult `planner` agent to research best practices
- Engage `docs-manager` agent to understand project constraints
- Use `WebSearch` tool to find efficient approaches
- Use `docs-seeker` skill for latest documentation
- Leverage `ai-multimodal` skill to analyze visual materials
```

### Output Report Naming
Skills respect project naming conventions:
```
reports/researcher-260124-2209-{slug}.md
reports/planner-260124-2209-{slug}.md
```

Pattern: `{skill-name}-{YYMMDD-HHMM}-{descriptor}.md`

### State Management
Skills reference injected context:
```markdown
## Report Output
Use the naming pattern from the `## Naming` section in injected context.
The pattern includes the full path and computed date.
```

This allows dynamic path resolution across projects.

---

## 6. Key Learnings for AWF v4

✅ **Strengths:**
- Minimal spec (only name + description required)
- Markdown-based (version controllable, editable)
- Supports venv Python with dedicated scripts directory
- Works with state persistence via session.json

⚠️ **Considerations for Non-Tech Users:**
- Skill descriptions are *critical* - bad descriptions = skill won't be used
- Directory naming must match name field (case-sensitive on Linux)
- Python script execution requires proper venv setup
- Error messages must be translated for non-technical users

📋 **Recommended Patterns:**
- Use "Communication Style" section to reference injected coding-level guidelines
- Include "Collaboration Tools" section listing what other skills/tools are used
- Always add "Critical Constraints" to prevent scope creep
- Structure report output to include naming pattern from context

---

## Unresolved Questions

1. Should AWF v4 support trigger syntax beyond skill name matching? (Proposed: keywords, intent patterns)
2. How to document skill dependencies in SKILL.md for non-tech users?
3. Should error handling retries be configurable per skill or global?
4. How deeply should skills reference injected context in markdown?
