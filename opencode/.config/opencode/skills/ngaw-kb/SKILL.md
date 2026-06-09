---
name: ngaw-kb
description: >
  Reference guide for Laravel 12 API-only application development from the NGAW Knowledge Base. Load this skill when working on ANY Laravel project — building API endpoints,
  writing Eloquent models, setting up authentication, creating tests with Pest, structuring services/events/jobs, or following code quality conventions.
  Even if the user just says "create a new endpoint" or "write a test for this controller" in a Laravel project, this skill provides the exact patterns,
  conventions, and code examples to follow. Covers: architecture, API response format, controllers, form requests, resources, middleware, policies,
  Sanctum auth, Spatie permissions, Pest testing, service layer, event/listener/job patterns, migrations, factories, and PHP coding standards.
---

# NGAW Knowledge Base Reference

This skill provides best practices documentation by reading from the NGAW Knowledge Base wiki. Use it whenever you need authoritative patterns for API development, testing, auth, models, or code quality.

## How to Use This Skill

The knowledge base follows a three-layer architecture: `raw/` (source documents) → `wiki/` (distilled content) → query against wiki. Always start with the wiki.

### Step 1: Start with the Wiki Index

Read `/Users/amolw/personal/ngaw-knowledge-base/wiki/index.md` to discover what's available.

### Step 2: Read Wiki Pages

The wiki contains summaries, syntheses, and cross-referenced content:

| Wiki Page | When to Read It |
|-----------|-----------------|
| `wiki/syntheses/laravel-best-practices.md` | Comprehensive Laravel best practices overview — architecture, API development, models, services, events, auth, testing, code quality |
| `wiki/sources/laravel-project-skeleton.md` | Source analysis — key points, entities, concepts extracted from the Laravel project skeleton |

### Step 3: Deep Dive into Raw Docs

When the wiki summary isn't enough and you need full code examples, detailed explanations, or setup instructions, read the raw reference files:

| Raw File | When to Read It |
|----------|-----------------|
| `raw/Laravel/01-best-practices-overview.md` | Starting a new Laravel project, onboarding, or need a general overview of conventions |
| `raw/Laravel/02-architecture-structure.md` | Setting up project structure, organizing controllers, routes, or understanding Laravel 12's streamlined layout |
| `raw/Laravel/03-api-development.md` | Building API endpoints, CRUD controllers, form requests, API resources, response format, exception handling, or filtering/sorting |
| `raw/Laravel/04-models-database.md` | Creating Eloquent models, relationships, migrations, factories, seeders, or namespaced models |
| `raw/Laravel/05-testing.md` | Writing Pest tests, organizing test files, factory usage, notification faking, assertions |
| `raw/Laravel/06-auth-authorization.md` | Setting up Sanctum auth, 2FA, verification codes, policies, Spatie permissions, role-based access |
| `raw/Laravel/07-services-events-jobs.md` | Creating service classes, events, listeners, queued jobs, notifications, mailables |
| `raw/Laravel/08-code-quality-php.md` | PHP coding standards, Pint formatting, Rector, configuration rules, naming conventions |

All paths are relative to `/Users/amolw/personal/ngaw-knowledge-base/`.

### Quick Reference: Common Patterns

**API response format** — All responses use `{success, message, data, code}`:
```json
{"success": true, "message": "Created successfully", "data": {...}, "code": 201}
```

**Controller middleware** — Per-controller via `HasMiddleware` interface:
```php
public static function middleware(): array
{
    return [
        new Middleware('auth:sanctum', except: ['index']),
        new Middleware(CheckUserRolesAndPermissions::class . ':' . Plan::class, except: ['index']),
    ];
}
```

**Form requests** — Always use dedicated request classes, never inline validation.

**API resources** — Always transform models through resource classes with explicit type casts.

**Testing** — Pest, not PHPUnit. Use `describe` blocks. Test happy, failure, and edge cases.

**Services** — Extract complex logic with DB transactions to `app/Services/`.

**Permission naming** — `{resource}.{action}` pattern: `teams.view_any`, `teams.create`, `teams.edit`.

### When to Read the Full Docs

The quick reference above covers the most common patterns. Read the full documentation files when you need:
- Complete code examples (full controller, full test, full migration)
- Detailed explanations of *why* patterns exist
- Edge cases and gotchas
- Package-specific configuration (Spatie Query Builder, Cashier, etc.)
- Setup instructions (DDEV, queue workers, API docs generation)
