---
name: ngaw-gittree
description: >
  Git worktree workflow for Tour Planner using git-gtr (Git Worktree Runner). Use when the user mentions
  "worktree", "gtr", "git gtr", "branch isolation", "parallel development", or asks to create/switch/remove
  worktrees. Covers: creating worktrees from branches, navigating between worktrees, opening in editor or AI
  tool, running commands in worktrees, cleaning up stale worktrees, and the project-specific worktree layout.
  Always load when working on multiple features simultaneously or when the user references the worktrees folder.
---
# Git Worktree Workflow (git-gtr)

This skill documents the project's git worktree workflow using `git gtr` (Git Worktree Runner by CodeRabbit).

## Project Worktree Layout

The project root is at `/Users/amolw/clients/tour-planner-v2/` with two key directories:

| Directory | Purpose |
|-----------|---------|
| `tour-planner-v2-main-ddev/` | **Main repo** — the primary working directory |
| `tour-planner-v2-main-ddev-worktrees/` | **Worktrees directory** — contains all linked worktree folders |

Worktree folders inside `-worktrees/` are named after the branch they track (e.g., `feature-calendar/`, `playwright-dev-1/`).

## How to Use This Skill

Use `git gtr` commands (run from the main repo at `/Users/amolw/clients/tour-planner-v2/tour-planner-v2-main-ddev`) for all worktree operations.

### Key Commands

| Action | Command |
|--------|---------|
| **Create a worktree** | `git gtr new <branch-name>` |
| **Create from current branch** (variant) | `git gtr new <branch> --from-current` |
| **List all worktrees** | `git gtr list` (or `ls`) |
| **Open directory** | `gtr cd <branch>` (with shell integration) or `cd "$(git gtr go <branch>)"` |
| **Open in editor** (Cursor/VS Code) | `git gtr editor <branch>` |
| **Open in AI tool** (opencode) | `git gtr ai <branch>` |
| **Run command in worktree** | `git gtr run <branch> <command>` |
| **Run tests in worktree** | `git gtr run <branch> ddev exec php artisan test --env=testing` |
| **Remove a worktree** | `git gtr rm <branch>` |
| **Remove and delete branch** | `git gtr rm <branch> --delete-branch` |
| **Copy files to worktree** | `git gtr copy <branch>` |
| **Rename worktree + branch** | `git gtr mv <old> <new>` |

The special ID `1` refers to the main repo (e.g., `git gtr go 1`, `git gtr editor 1`).

### Interactive Worktree Selection (fzf)

If `fzf` is installed, `gtr cd` with no arguments opens an interactive picker showing all worktrees with preview, and options to open in editor, AI tool, or delete.

### Configuration (Already Set)

```bash
git gtr config set gtr.editor.default code    # Editor = VS Code/Cursor
git gtr config set gtr.ai.default opencode    # AI tool = opencode
```

### Common Patterns

**Starting new feature work:**
```bash
git gtr new features/awesome-thing
git gtr editor features/awesome-thing
git gtr ai features/awesome-thing
```

**Creating a variant (parallel work from same base):**
```bash
git checkout feature/user-auth
git gtr new variant-1 --from-current
```

**Running tests in a specific worktree:**
```bash
git gtr run my-feature ddev exec php artisan test --env=testing
```

**Cleaning up stale worktrees:**
```bash
git gtr clean                # Remove stale/prunable worktrees
git gtr clean --merged       # Also remove worktrees with merged PRs
git gtr clean --dry-run      # Preview without removing
```

**Removing a completed feature:**
```bash
git gtr rm my-feature --delete-branch
```

## Worktree vs Main Repo

- The **main repo** is where global tooling config lives (git-hooks, CI setup, etc.)
- **Worktrees** are isolated working copies for feature branches — changes in one don't affect others
- Use `git gtr copy <branch>` to sync config files like `.env*` from the main repo into worktrees

## More Info

- [git-gtr on GitHub](https://github.com/coderabbitai/git-worktree-runner)
- Run `git gtr help <command>` for detailed help on any command
