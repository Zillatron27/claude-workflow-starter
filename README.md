# Claude Code Workflow Starter

A clone-and-fill starter kit for running Claude Code the "control plane" way: a private
context repo that sits beside your projects and holds behavioural policy, per-project
state, and reusable runbooks — so every session starts with the same rules and the same
knowledge, instead of starting from zero.

---

## Why

Claude Code is stateless. Every session starts fresh with no memory of previous work, no
knowledge of your systems and no awareness of what phase a project is in. Left unmanaged
it's a fast worker that guesses at context and makes confident mistakes and often makes the
*same* mistakes repeatedly because corrections don't persist between sessions.

These are infrastructure problems that can be helped (but not entirely solved) with infrastructure, not memory: policy files that load automatically, state files that survive between sessions, runbooks for repeatable procedures and hooks that enforce checks mechanically. That layer between you and the executor is the control plane.

## System Pattern

- A **global CLAUDE.md** encodes how you want Claude to behave everywhere
(policy)
- A per-project **PROJECT_CONTEXT.md** records where each project actually is
(state)
- A per-project **CLAUDE.md** records how to work in that repo (local policy),
- **slash commands** capture repeatable procedures like deploys and context updates
(runbooks)
- **hooks** enforce checks automatically (validation). 

All of it lives in one private git repo — `project-context/` — beside your project directories, so it's
versioned, backed up and portable.

## Directory Layout You're Building

```
~/Projects/
├── project-context/          # Private repo — the control plane
│   ├── global-claude.md      # Master copy of your global policy
│   ├── manifest.md           # Index of all projects
│   ├── <project>/            # One shard per project:
│   │   ├── CLAUDE.md         #   how Claude works in that repo
│   │   ├── PROJECT_CONTEXT.md#   current state of the project
│   │   └── specs/            #   planning docs (optional)
│   ├── commands/             # Slash commands (symlinked into projects)
│   └── hooks/                # Hook scripts + settings profiles
├── my-first-project/         # Your actual code repos
└── another-project/
```

## Setup

0. Install Claude Code and download these files, put them where Claude Code can read them. Ask Claude to read the content and set everything up for you.

Or...

1. **Create your private context repo.** Copy this kit's contents into
   `~/Projects/project-context/`, `git init`, create a **private** GitHub repo, push.
   Everything in here is your working notes — it should never be public.

2. **Install the global policy.** Fill in `templates/global-CLAUDE.md` (sections marked
   `<!-- FILL IN -->`), save it as `project-context/global-claude.md`, then copy or
   symlink it to `~/.claude/CLAUDE.md`. Claude Code reads that file at the start of
   every session, in every directory.

3. **Install the commands.** Symlink the commands so they're available everywhere:
   ```bash
   mkdir -p ~/.claude/commands
   ln -s ~/Projects/project-context/commands/*.md ~/.claude/commands/
   ```
   You now have `/new-project` and `/update-context` in any session.

4. **Onboard each project** — new or existing — by running `/new-project <name>` in a
   Claude Code session. It interviews you, creates the context shard, wires up symlinks
   and hooks, and updates the manifest. For an existing repo it reads the codebase and
   drafts the context files from what's actually there.

5. **Close every work session** with `/update-context`. This is the habit that makes the
   whole system work: the context files only stay useful if they're updated when reality
   changes. State drift is the failure mode.

   **NOTE:** I define a 'session' as a single task/issue/job to be done. Despite the large context windows and increasingly clever models, 'updating context' and starting a new session per job to be done helps keeps the project context accurate and subsequent sessions spend less tokens reading mountains of code to get orientated with the project state.

## The Public-Repo Trick

CLAUDE.md files often contain things you don't want public (infrastructure details,
candid notes, unreleased plans). For **public** repos: keep the real file in
`project-context/<project>/CLAUDE.md`, symlink it into the repo, and gitignore the
symlink. Claude Code follows the symlink; GitHub never sees the content. For private
repos you can commit CLAUDE.md directly or still use the symlink for consistency.

## Rules of the Road

- **Context files track current state, not history.** Git log is the changelog. If a
  section describes what happened rather than what is, delete it.
- **Encode lessons as policy.** When Claude makes a mistake you had to correct, add a
  rule to the relevant CLAUDE.md so it never recurs. One correction, permanent fix.
- **Specs before implementation.** Plan in whatever tool you think best in (Claude web,
  a whiteboard, a doc), land the result as a spec in the project's shard, then point
  Claude Code at the spec. "Implement the spec" beats re-explaining every session.
- **Surgical updates only.** `/update-context` touches only sections the session
  changed. Rewriting whole files churns git history and invites drift.

## What's in This Kit

| Path | What it is |
|------|-----------|
| `templates/global-CLAUDE.md` | Global behavioural policy — fill in and install to `~/.claude/CLAUDE.md` |
| `templates/project-CLAUDE.md` | Per-project CLAUDE.md skeleton |
| `templates/PROJECT_CONTEXT.md` | Per-project state file skeleton |
| `templates/manifest.md` | Project index skeleton |
| `commands/new-project.md` | `/new-project` — scaffold or retro-onboard a project |
| `commands/update-context.md` | `/update-context` — end-of-session state sync |
| `hooks/` | Example PostToolUse typecheck hook (TypeScript) + settings profile |

Everything is a starting point. Delete what doesn't fit and adjust as needed. 
Have a lot of fun :)
