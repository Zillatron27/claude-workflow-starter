---
description: Update project context files after a work session
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

Update the current project's context files in `~/Projects/project-context/` based on
work done this session, then commit and push.

## Steps

### 1. Identify the project

Determine the current project from the working directory path under `~/Projects/`.

### 2. Find context files

Look for `~/Projects/project-context/<project>/PROJECT_CONTEXT.md`. If it doesn't
exist, stop and report: "No context file found for this project. Run /new-project to
onboard it first." Do not create files.

### 3. Review session changes

In the project repo: `git log --oneline -20`, `git diff --stat` against a reasonable
range, current file tree and version numbers. Combine with your knowledge of what was
done this session.

### 4. Update PROJECT_CONTEXT.md

Read the existing file. Only update sections affected by this session's work:

- **Version / Last Updated / Status** header lines
- **▶ Next Session** — what the next session should pick up
- **Implementation Status** tables
- **Project Structure** — file tree if files added/removed/renamed
- **Known Issues / Planned Work** — add, resolve, or update items
- **Design Rationale / Core Concepts** — only if architecture or domain logic changed

Do NOT add changelog entries — git is the changelog. Do NOT rewrite unchanged sections.
Surgical updates only.

### 5. Update CLAUDE.md (only if needed)

Only if the session changed how Claude Code interacts with the project: new commands,
deploy process changes, new dependencies, new conventions. Otherwise skip.

### 6. Commit and push

```bash
cd ~/Projects/project-context
git add <changed_files>
git commit -m "chore: update <project> context - <brief summary>"
git push
```

### 7. Report

State which files were updated, which sections changed, and a brief summary.
