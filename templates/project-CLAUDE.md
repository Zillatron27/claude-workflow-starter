# {ProjectName}

<!-- Lives at project-context/{project}/CLAUDE.md. For public repos, symlink into the
     repo root and gitignore the symlink; for private repos, commit or symlink as you
     prefer. Omit any section that doesn't apply. -->

{One-line description.}

**Live at:** {URL, or omit if not deployed}

## What This Is NOT

<!-- 2-3 lines preventing scope creep. The most valuable section for keeping sessions
     on-mission. e.g. "Not a game client — no auth, no player data." -->

## Core Concept

{A paragraph on what the project does and the shape of the solution.}

## Tech Stack

- **Language:** {language + strictness settings}
- **Framework:** {framework}
- **Hosting/Deploy:** {target and mechanism — note if it auto-deploys from main}

## Commands

```bash
npm run dev          # dev server
npm run typecheck    # must pass before commit
npm run build        # production build
```

## Critical Rules

<!-- Project-specific policy: styling constraints, API rules, data invariants, things
     Claude got wrong once and must never get wrong again. -->

## Related Projects

<!-- Sibling projects, shared APIs, reference repos. -->
- Context docs: `~/Projects/project-context/{project}/PROJECT_CONTEXT.md`

## Deployment

<!-- How a release happens, step by step, or "auto-deploys from main — do not deploy
     manually." -->

## Repo Info

- **GitHub:** {owner}/{repo} ({public|private})
- **CLAUDE.md:** {symlinked from project-context and gitignored | committed}
