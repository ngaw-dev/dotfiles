---
name: ngaw-testing-workflow
description: >
  TDD testing workflow for Tour Planner (Laravel+Pest+React) projects. Use when the user asks to implement
  features, add tests, write tests, fix bugs, modify code, or verify changes. Covers: writing tests first (TDD),
  covering happy paths / edge cases / error handling / integration, choosing the right test type (Pest unit,
  Pest feature/integration, Playwright E2E), running filtered tests before the full suite, incremental atomic
  commits with conventional format, and a verification checklist. Always use this skill when the user mentions
  "test", "TDD", "implement", "add feature", "fix", "modify", "bug", "change", "verify", "ship", or writes
  any PHP code — in the tour-planner-v2 project or any Laravel+React project using Pest and Playwright.
---

# Testing Workflow

## How to Use This Skill

This skill provides a structured testing workflow for the Tour Planner project. Use it whenever you're implementing, modifying, or fixing code.

**Three ways to activate:**

1. **Auto-triggered** — The skill loads automatically when the conversation context matches its description (e.g., you mention "test", "TDD", "implement", "fix", "verify"). No action needed.
2. **Manual load** — Explicitly load it: `skill(name="testing-workflow")`
3. **Task delegation** — Pass it to task agents: `task(category="quick", load_skills=["testing-workflow"], prompt="...")`

When implementing new features, pair this with the `reference-patterns` skill (load both via `load_skills=["reference-patterns", "testing-workflow"]`) — use the reference patterns skill first to scaffold the feature, then this skill to add tests.

When implementing or modifying features in the Tour Planner project, follow this testing workflow.

## Why This Workflow Matters

Adding tests **first** (or alongside code) catches design issues early, documents expected behavior, and prevents
regressions. Running filtered tests before the full suite keeps iteration fast — you get feedback in seconds, not
minutes. Incremental commits with clear messages make it possible to revert or cherry-pick individual changes
without collateral damage — and make review easier for teammates.

---

## 1. Test Requirements

### 1.1 Add Tests First (TDD approach when applicable)

Write test cases covering:

| Scenario | What to Test |
|----------|-------------|
| **Happy path** | The primary successful scenario — "given valid input, the feature works" |
| **Edge cases** | Boundary conditions, empty states, unusual inputs — empty strings, max-length values, null values, duplicate entries, pagination limits |
| **Error handling** | Validation failures, authorization denials, not-found scenarios, server errors — every way the feature can fail |
| **Integration** | Interactions across components/services — a controller calling a service that triggers an event, or a React hook calling an API that queries the database |

### 1.2 Test Types to Include

| Type | Tool | What to Cover |
|------|------|---------------|
| **Unit tests** | Pest | Individual functions, methods, service classes — pure logic with no external dependencies. Fastest feedback loop. |
| **Feature/Integration** | Pest with `$this->get()` / `->post()` / etc. | API endpoints, request validation, database interactions — the full request→response flow for an endpoint or feature |
| **E2E** | Playwright | User-facing UI interactions — page navigation, form submissions, visual verification in a real browser |

---

## 2. Running Tests

### 2.1 Run Filtered Tests First

Always start by running only the tests for the specific feature you're modifying. This gives you feedback in
seconds rather than waiting for the full suite.

```bash
# Run a single test class/file
ddev exec php artisan test tests/Feature/HotelTest.php

# Run a specific test method by name
ddev exec php artisan test --filter test_hotel_create

# Run tests for a service or module
ddev exec php artisan test tests/Unit/Services/HotelServiceTest.php

# Run the full suite (only after confirmation)
ddev exec php artisan test
```

### 2.2 Validate New Tests Pass

Before moving on, confirm every test you added or modified passes. Look for output like:

```
PASS  tests\Feature\HotelTest
✓ hotel create
✓ hotel create with invalid data
...
Tests:    5 passed
```

If any test fails, fix the issue immediately — do not accumulate broken tests.

### 2.3 Ask Before Full Suite

Once filtered tests pass, **ask the user**:

> "Should I run the full test suite to ensure no regressions?"

Only run the full suite (`ddev exec php artisan test`) upon explicit confirmation.
This respects the user's time — the full suite may take minutes.

---

## 3. Commit Strategy

### 3.1 Incremental Commits

Make one commit per logical step. Never batch unrelated changes — this makes reverts and code review easier.

Commit after each:
- Test is written and passes
- Feature is implemented
- Refactor is completed
- Bug is fixed

### 3.2 Conventional Commit Format

```
type(scope): description
```

| Type | When |
|------|------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `test` | Adding or modifying tests |
| `refactor` | Code restructuring with no functional change |
| `chore` | Config, dependencies, tooling |

Examples:
```
feat(hotel): add create endpoint with validation
fix(auth): handle expired token refresh
test(hotel): add edge case tests for create validation
refactor(hotel): extract filtering to dedicated service
```

### 3.3 Plain Text Only

Do **not** include ANSI color codes, emoji, formatted separators, backticks, or markdown formatting
in commit messages. Plain text only — commit messages are consumed by CLI tools, CI systems, and
generated changelogs that expect clean text.

---

## 4. Verification Checklist

Before marking work as complete, verify each item:

- [ ] Tests added for new/modified functionality
- [ ] All new/modified tests passing (filtered)
- [ ] Full suite passing (if user confirmed)
- [ ] Code follows project coding standards
- [ ] No console errors or warnings (frontend)
- [ ] Feature works as expected in browser (UI changes)
- [ ] Incremental commits made at each logical step
- [ ] Commit messages use conventional format (plain text only)

---

## 5. Project Commands Quick Reference

```bash
# PHP / Pest tests (primary)
ddev exec php artisan test                          # Full suite
ddev exec php artisan test --filter=HotelTest       # Single filter
ddev exec php artisan test tests/Feature/HotelTest.php  # By file

# Frontend tests (if available)
pnpm test                     # Vitest unit tests
pnpm test:e2e                 # Playwright E2E
```

## References

- [Project AGENTS.md](file:///Users/amolw/clients/tour-planner-v2/AGENTS.md) — additional conventions
- [ngaw-kb skill](file:///Users/amolw/.agents/skills/ngaw-kb/SKILL.md) — Laravel/Pest best practices
