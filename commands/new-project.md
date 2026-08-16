---
description: Scaffold a new project with context files and control plane wiring, or retroactively onboard an existing project
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

# New Project Scaffold

Scaffold a project with full control plane integration. The project name comes from
`$ARGUMENTS`. If no name is provided, ask for one.

## Step 0: Gather configuration

Ask the user these questions one at a time. Do NOT assume defaults.

1. **One-line description** — what is this project?
2. **Language** — and framework, if any?
3. **Public or private repo?**
4. **Deployable?** If yes: deploy target and whether it auto-deploys from main.

Present a summary and wait for explicit approval before proceeding.

## Step 1: GitHub repo

Create the repo with `gh repo create <owner>/<name> --{public|private}`.
**If the repo already exists** (or the user says it's an existing project), switch to
**Retroactive mode** (bottom of this file).

## Step 2: Clone and initialise

Clone into `~/Projects/<name>` and initialise for the chosen framework (e.g.
`npm create vite@latest`, FastAPI skeleton, etc.). For TypeScript ensure
`"strict": true` and a `typecheck` script (`tsc --noEmit`); for Python set up type
checking with mypy or pyright.

## Step 3: Create the context shard

Create `~/Projects/project-context/<name>/` containing:

- **CLAUDE.md** — from the `project-CLAUDE.md` template. Read 1-2 existing project
  CLAUDE.md files first and follow the same structure. Omit sections that don't apply.
- **PROJECT_CONTEXT.md** — from the `PROJECT_CONTEXT.md` template, populated with the
  actual post-scaffold file tree, not placeholders.

## Step 4: Symlink CLAUDE.md into the repo

```bash
ln -s ~/Projects/project-context/<name>/CLAUDE.md ~/Projects/<name>/CLAUDE.md
```

For **public** repos, add to the project's `.gitignore`:

```
# Claude Code config (stored in private context repo)
CLAUDE.md
```

## Step 5: Configure hooks (optional)

If a hook profile exists for the language in `~/Projects/project-context/hooks/`:

```bash
mkdir -p ~/Projects/<name>/.claude
ln -s ~/Projects/project-context/hooks/<language>-settings.json ~/Projects/<name>/.claude/settings.json
```

Gitignore `.claude/settings.json` and `.claude/commands/`.

## Step 6: Deploy command (if deployable)

Create `~/Projects/project-context/commands/deploy-<name>.md` documenting the exact
deploy procedure (version bump → changelog → build → test → deploy → verify), then
symlink it:

```bash
mkdir -p ~/Projects/<name>/.claude/commands
ln -s ~/Projects/project-context/commands/deploy-<name>.md ~/Projects/<name>/.claude/commands/deploy.md
```

If it auto-deploys from main, skip this and note that fact prominently in CLAUDE.md.

## Step 7: Update the manifest and global CLAUDE.md

- Add a row to the Projects table in `~/Projects/project-context/manifest.md`
  (alphabetical order).
- Add the project to the Project Structure table in `~/.claude/CLAUDE.md`.

## Step 8: Commit and push

Commit the project repo (initial scaffold) and the context repo (new shard + manifest)
separately, then push both.

## Step 9: Report

Summarise: repo URL, local directory, context files created, hooks wired, deploy
command (or N/A), manifest updated.

---

## Retroactive mode (existing project)

1. Skip repo creation; clone if not already local.
2. **Read the existing codebase** to infer language, framework, structure, and version.
3. **Confirm inferences with the user** — present what was detected, ask for
   corrections, and still ask for description, visibility, and deploy model.
4. Create the context shard reflecting the **real current state** of the project, not a
   blank scaffold.
5. Continue from Step 4 (symlinks, hooks, deploy command, manifest). Only commit the
   context repo changes.
