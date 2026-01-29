# Phase 05: Installer & Documentation

## Context Links
- [Main Plan](./plan.md)
- [Phase 04](./phase-04-workflow-integration.md)
- [Install Scripts](../../install.ps1)
- [User Guide](../../docs/USER_GUIDE.md)

## Overview
| Priority | P2 - Distribution |
|----------|------------------|
| Status | Pending |
| Effort | 2h |

Update installers to download skills/, update USER_GUIDE.md with skill documentation, bump VERSION to 4.0.0.

## Key Insights
- Installers must handle skills/ folder alongside workflows/
- Skills are optional upgrade - existing users unaffected
- Version bump signals major UX changes
- User guide needs non-tech friendly skill explanations

## Requirements

### Functional
- [ ] install.ps1 downloads skills/ folder
- [ ] install.sh downloads skills/ folder
- [ ] USER_GUIDE.md documents all 8 skills
- [ ] VERSION updated to 4.0.0

### Non-Functional
- Installer backward compatible (upgrade path)
- Skills download fails gracefully
- Documentation accessible to non-tech users

## Architecture

**New Install Structure:**
```
~/.gemini/antigravity/
├── global_workflows/    # Existing
├── skills/              # NEW in v4.0
│   ├── awf-session-restore/
│   ├── awf-adaptive-language/
│   ├── awf-error-translator/
│   ├── awf-smart-suggest/
│   ├── awf-context-help/
│   ├── awf-onboarding/
│   ├── awf-rollback-guard/
│   └── awf-progress-tracker/
└── schemas/             # Existing (updated)
```

## Related Code Files

### Modify
- `install.ps1` - Add skills download section
- `install.sh` - Add skills download section
- `docs/USER_GUIDE.md` - Add skills chapter
- `VERSION` - Update to 4.0.0

### Create
- `skills/README.md` - Skills overview

## Implementation Steps

### 1. Update install.ps1 (Windows)
- [ ] Add skills download after workflows:
  ```powershell
  # Download skills folder
  $skills = @(
    "awf-session-restore",
    "awf-adaptive-language",
    "awf-error-translator",
    "awf-smart-suggest",
    "awf-context-help",
    "awf-onboarding",
    "awf-rollback-guard",
    "awf-progress-tracker"
  )
  foreach ($skill in $skills) {
    # Download SKILL.md for each
  }
  ```
- [ ] Add error handling for skills download failure
- [ ] Update version display to 4.0.0

### 2. Update install.sh (Mac/Linux)
- [ ] Mirror install.ps1 skills logic in bash
- [ ] Handle curl/wget fallback
- [ ] Add error handling

### 3. Create skills/README.md
- [ ] Overview of skills system
- [ ] List all 8 skills with purpose
- [ ] How skills integrate with workflows
- [ ] Troubleshooting section

### 4. Update docs/USER_GUIDE.md
- [ ] Add "AWF Skills (v4.0)" chapter
- [ ] Non-tech friendly explanations:
  ```markdown
  ## What are Skills?
  Skills are invisible helpers that make AWF easier to use.
  They work automatically - you don't need to do anything!

  ### Session Restore
  Remembers what you were doing last time.

  ### Error Translator
  Turns confusing error messages into plain English.
  ```
- [ ] FAQ section for skills

### 5. Update VERSION
- [ ] Change from 3.4.0 to 4.0.0
- [ ] Update CHANGELOG if exists

## Success Criteria
- [ ] Fresh install gets skills/ folder
- [ ] Upgrade from v3.4 adds skills/ without breaking
- [ ] USER_GUIDE.md readable by non-tech users
- [ ] VERSION shows 4.0.0

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Download failures | Medium | Graceful fallback, warn user |
| Large download size | Low | Skills are small (~2KB each) |
| Breaking upgrades | High | Test upgrade path thoroughly |

## Security Considerations
- Download from official GitHub only
- Verify file integrity if possible
- No credentials in install scripts

## Next Steps
- After completion → Full integration testing
- Release checklist:
  - [ ] Test fresh install (Windows + Mac + Linux)
  - [ ] Test upgrade from v3.4
  - [ ] Update release notes
  - [ ] Tag v4.0.0 release
