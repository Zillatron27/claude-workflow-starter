# Global Claude Code Configuration

<!-- FILL IN: This file becomes ~/.claude/CLAUDE.md. Claude Code reads it at the start
     of every session in every directory. Keep the master copy in project-context/ and
     copy/symlink it into place. Sections marked FILL IN need your details; the rest is
     a sane default policy — edit anything that doesn't match how you work. -->

## Project Structure

All projects live in `~/Projects/`. Context docs and planning specs are in
`~/Projects/project-context/` (private repo), one subdirectory per project.

<!-- FILL IN: table of your projects. Keep it current — /new-project maintains it. -->

| Directory | Repo | Description |
|-----------|------|-------------|
| `example/` | example (private) | One-line description |

## Who I Am

<!-- FILL IN: your background and skill profile. This is the highest-leverage section —
     it tells Claude what to explain and what to skip. Be honest about gaps. Example:
     "Infrastructure specialist, not a software developer. I understand architecture and
     systems design deeply; I lack language/framework craft knowledge. Bridge that gap —
     don't dumb down the architecture conversation, but make good framework-level
     decisions without asking me to choose between options I don't have opinions on." -->

## How I Work

- ALWAYS read the relevant context files in `project-context/` before starting work on
  a project.
- ALWAYS plan before executing non-trivial changes. Walk me through what and why. I'll
  approve or redirect.
- Before starting work in any repo, check the basics: current branch, working tree
  state, and how the project deploys. Don't assume you're on main. Don't assume the
  deploy model.
- Read the prompt fully before acting. If I state a constraint ("no build step",
  "auto-deploys from main", "keep it minimal"), it's a requirement, not a suggestion.
- When I have opinions, respect them. Push back if I'm wrong, but bring evidence. I
  explicitly want pushback on ideas during design — don't automatically agree.

## Code Quality

- Write code I can read and understand. Clear naming, comments explaining *why* not
  *what*. Simple and obvious over clever — I need to maintain this.
- No dead code, commented-out blocks, or TODO placeholders unless I ask.
- Do not add dependencies without explaining why and what alternatives exist.
- Small, focused commits with clear messages.

<!-- FILL IN: your language standards, e.g. "Type hints in Python. Strict mode in
     TypeScript." -->

## Verification

- After changes, run the relevant test/build/typecheck command and confirm output.
- If tests exist, run them. If they should exist and don't, suggest adding them.
- When something breaks, show the actual error message AND explain what it means before
  fixing. Don't paraphrase errors — I need the real text.
- **Version before deploy:** bump the version number and update the changelog BEFORE
  building and deploying, unless explicitly told to skip it.

## Debugging

- Wait for explicit confirmation before making changes. Explaining a fix and getting
  agreement on the approach is NOT permission to edit.
- **Two-strike rule:** if a fix attempt fails, do not try a similar variation. Stop,
  explain why the approach failed, list at least 3 fundamentally different approaches,
  analyse which is most likely correct and why, then propose the best option.
- If a fix might affect working code paths, call that out and get approval first.

## Things to NOT Do

- Do not refactor working code unless asked or it's blocking a change.
- Do not create abstraction layers "for future flexibility." Build what's needed now.
- Do not silently change behavior of working features while implementing new ones.
- Never `git push --force` without explicit confirmation.
- Do not improvise when a spec already defines the approach. If you think the spec is
  wrong, flag it — don't silently substitute.

## Context File Maintenance

Every project has a `<project>/PROJECT_CONTEXT.md` in `~/Projects/project-context/`.
These track **current state, not history** — change history lives in git. After
completing meaningful work, update the corresponding context file: version, status
tables, file tree, known issues. Surgical updates only; do not rewrite unchanged
sections. If the work changes how Claude Code should interact with the project (new
commands, changed deploy process), update the project's `CLAUDE.md` too.

## External Dependencies

- When external dependencies fail, prefer degraded functionality over complete failure.
  Stale data with a timestamp beats showing nothing.
- Assume rate limits exist on external APIs even if undocumented; cache by default.

<!-- FILL IN (optional): environment specifics — container setup, SSH agent paths,
     anything Claude needs to run git/deploys on your machine. -->
