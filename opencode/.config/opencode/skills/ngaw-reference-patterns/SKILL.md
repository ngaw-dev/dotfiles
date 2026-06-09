---
name: ngaw-reference-patterns
description: >
  Reference code pattern matching for implementing features in Tour Planner (Laravel 12 + React/Inertia + shadcn/ui).
  Use when building new features, endpoints, components, CRUD operations, or any feature that follows an existing
  pattern in the codebase. Provides a structured workflow for finding a similar existing implementation and mirroring
  it across the full Laravel+React stack: Eloquent Model → Migration → Factory → Filter → Controller → FormRequest →
  API Resource on the backend, and API client functions → TypeScript types → React Query hooks → Page components on
  the frontend. **Starts by asking the user which existing feature to reference and what new feature to build** —
  never guesses. Always use this skill when the user says "implement", "create", "add", "build", "endpoint", "CRUD",
  "API", "resource", "feature", or mentions a new entity type.
---

# Reference Code Pattern Matching

## How to Use This Skill

This skill provides a reference pattern matching workflow for implementing new features in the Tour Planner project.
Use it whenever you're building a new feature, endpoint, or CRUD operation that follows an existing pattern.

**Three ways to activate:**

1. **Auto-triggered** — The skill loads automatically when the conversation context matches its description (e.g., you mention "implement", "create", "build", "endpoint", "CRUD"). No action needed.
2. **Manual load** — Explicitly load it: `skill(name="reference-patterns")`
3. **Task delegation** — Pass it to task agents: `task(category="quick", load_skills=["reference-patterns"], prompt="...")`

**Important**: This skill starts by **asking you** which existing feature to reference and what new feature to build.
It will not guess or assume — you need to provide both names.

After scaffolding the feature with this skill, follow up with `testing-workflow` to add tests:
`task(category="quick", load_skills=["reference-patterns", "testing-workflow"], prompt="...")`

When implementing new features in the Tour Planner project, don't start from scratch. The codebase has established
patterns — find a similar existing feature and mirror it across the full stack.

## Why Pattern Matching Matters

Building features by pattern matching is faster and more reliable than designing from scratch:

- **Consistency** — all features follow the same conventions, making the codebase predictable for every developer
- **Correctness** — the existing patterns have been tested, reviewed, and debugged already
- **Velocity** — you don't need to re-decide file locations, naming, or structure every time

---

## Workflow

### Step 1: Ask the User for Reference and Target

This skill does **not** guess which feature to build. You must ask the user two questions:

> **1. Which existing feature should I use as a reference?**
> (e.g., "Hotels" — a fully implemented CRUD with models, controllers, frontend pages)

> **2. What is the new feature you're building?**
> (e.g., "Tours" — the feature you want me to create following the same pattern)

Wait for answers before proceeding. You need both the **reference** entity name
(e.g., `Hotel`) and the **target** entity name (e.g., `Tour`) to replicate the pattern.

Once you have both names, locate all reference files:

```bash
# Find backend files for the reference entity
find app -name "*[Reference]*" -type f

# Find frontend files for the reference entity
find resources/js -name "*[reference]*" -type f

# Or use ripgrep for broader search
rg "class [Reference]" --type php
```

Read the reference files to understand the full pattern before writing any code.

### Step 2: Trace the Full Stack

Examine every layer of the reference feature in order — this ensures nothing is missed:

**Backend (PHP/Laravel)** — data flows from database to response:
```
Model (relationships, fillable, casts)
  → Migration (columns, indexes, foreign keys)
  → Factory (test data, model states)
  → Filter (query scopes, filtering logic)
  → Controller (CRUD endpoints, middleware)
  → FormRequest (validation rules, authorize)
  → API Resource (response transformation)
  → Route (api.php registration)
```

**Frontend (TypeScript/React)** — data flows from response to UI:
```
API client function (lib/api-*.ts)
  → TypeScript types (lib/types/*.ts)
  → React Query hook (hooks/use*.ts)
  → Page component (pages/*.jsx)
  → Form/Detail subcomponents
```

### Step 3: Mirror Each Layer

Use the **reference** entity name (from Step 1) and **target** entity name (from Step 1)
to drive every file creation. Read each reference file first, then create the target file
with appropriate substitutions.

For every reference file path, derive the target file path by replacing the reference
name with the target name. The table below uses `[Ref]` / `[ref]` for the reference
entity and `[Tgt]` / `[tgt]` for the target entity — substitute the actual names:

| Reference File | Target File | What Changes |
|----------------|-------------|--------------|
| `app/Models/[Ref].php` | `app/Models/[Tgt].php` | Model name, table, relationships, fillable fields |
| `database/migrations/<stamp>_create_[refs]_table.php` | `database/migrations/<stamp>_create_[tgts]_table.php` | Schema, columns, indexes |
| `database/factories/[Ref]Factory.php` | `database/factories/[Tgt]Factory.php` | Factory states, field generation |
| `app/Filters/[Ref]Filters.php` | `app/Filters/[Tgt]Filters.php` | Filterable fields specific to target |
| `app/Http/Controllers/Api/[Ref]Controller.php` | `app/Http/Controllers/Api/[Tgt]Controller.php` | Model references, validation, resource class |
| `app/Http/Requests/Api/[Ref]Request.php` | `app/Http/Requests/Api/[Tgt]Request.php` | Validation rules for target-specific fields |
| `app/Http/Resources/[Ref]Resource.php` | `app/Http/Resources/[Tgt]Resource.php` | Fields exposed in API response |
| `resources/js/lib/api-[ref].ts` | `resources/js/lib/api-[tgt].ts` | Endpoint URL, request/response types |
| `resources/js/lib/types/[ref].ts` | `resources/js/lib/types/[tgt].ts` | TypeScript interfaces for target entity |
| `resources/js/hooks/use[Ref].ts` | `resources/js/hooks/use[Tgt].ts` | Query/mutation keys, API call functions |
| `resources/js/pages/[Ref].jsx` | `resources/js/pages/[Tgt].jsx` | Component structure, form fields, table columns |

> **Concrete example**: If reference=**Hotel** and target=**Tour**, then `app/Models/Hotel.php`
> becomes `app/Models/Tour.php`, `resources/js/lib/api-hotel.ts` becomes
> `resources/js/lib/api-tour.ts`, and so on for every file in the stack.

### Step 4: Register and Verify Connections

After creating all files, ensure everything is wired together:

**Backend checklist:**
- [ ] Route registered in `routes/api.php` (check route group, prefix, middleware)
- [ ] Permission slug or policy registered (if auth-protected)
- [ ] Factory available for seeding
- [ ] Migration is runnable (check `php artisan migrate --pretend`)

**Frontend checklist:**
- [ ] Page routes registered (check Inertia route definitions)
- [ ] Navigation links added (if the feature is user-facing)
- [ ] API client function exported and usable

---

## File Structure Reference

```
Backend:
├── app/Models/[Model].php                         # Eloquent model, relationships, fillable/casts
├── app/Filters/[Model]Filters.php                 # Query filtering logic
├── app/Http/Controllers/Api/[Model]Controller.php # CRUD endpoints with middleware
├── app/Http/Requests/Api/[Model]Request.php       # Validation rules with authorize()
├── app/Http/Resources/[Model]Resource.php         # JSON transformation with type casts
├── database/factories/[Model]Factory.php          # Test data generation with model states
└── database/migrations/*_create_[table]_table.php # Schema definition with indexes

Frontend:
├── resources/js/lib/api-[model].ts                # Axios API calls (CRUD functions)
├── resources/js/lib/types/[model].ts              # TypeScript interfaces for the entity
├── resources/js/hooks/use[Model].ts               # React Query hooks (useQuery/useMutation)
├── resources/js/pages/[Model].jsx                 # List/detail views
└── resources/js/pages/[model]/                    # CRUD form subcomponents
```

---

## Key Consistency Points

These are the most commonly missed items when mirroring a feature:

- **API DocBlocks** — Update the Swagger/OpenAPI PHPDoc annotations on the controller after changing any function.
  The doc block describes endpoint parameters, responses, and status codes.
- **File Path Comments** — Add the project-relative path as the first line comment in every TS/JSX/PHP file.
  E.g., `// app/Models/Hotel.php` or `// resources/js/lib/api-hotel.ts`. This helps developers orient
  themselves when reading code in split-pane editors or terminal output.
- **No Long Namespaces** — Use `use Illuminate\Support\Facades\Log` not `\Illuminate\Support\Facades\Log`.
  Top-level `use` statements are cleaner and PSR-compliant.
- **Shadcn UI** — Use available shadcn/ui components (`@/Components/ui/...`) over custom HTML elements.
  Check the project's component library before building new UI.
- **Single Quotes** — Use single quotes in JSX/TSX files (matching the project's `.prettierrc.json`).
- **No Null Returns** — Throw exceptions or return dedicated objects instead of `null` from methods.
  Returning `null` forces every caller to add null checks.

---

## Anti-Patterns

| Anti-Pattern | Why It's Harmful | Correct Approach |
|--------------|------------------|------------------|
| Copy-pasting without renaming all references | Leaves stale imports, class names, and route references — causes runtime errors | Search for every occurrence of the old name in the new file and replace deliberately |
| Skipping FormRequest | Inline `$request->validate(...)` in controllers makes validation unreusable and clutters the controller | Always create a dedicated FormRequest class |
| Skipping API Resource | Returning `$model->toArray()` from controllers couples response format to model structure | Always transform through a Resource class |
| Returning `null` from services/controllers | Forces null-checking at every call site, making bugs easy to miss | Throw a dedicated exception or use the Null Object pattern |

---

## Related Skills

- [testing-workflow](file:///Users/amolw/.agents/skills/testing-workflow/SKILL.md) — run this after implementing to add tests for the new feature
- [ngaw-kb](file:///Users/amolw/.agents/skills/ngaw-kb/SKILL.md) — detailed Laravel 12 API conventions (response format, permissions, testing patterns)
