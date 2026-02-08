---
name: update-docs
description: Update all supplementary documents (TABLE, ROADMAP, PATTERNS) to reflect the current state of oss/ reports. Use when the user asks to update, refresh, or sync documentation.
allowed-tools: Bash(bash:*), Read, Write, Edit, Glob, Grep
---

# Documentation Updater

Bring all supplementary documents in `docs/` up to date with the current `oss/` reports.

## Step 1: Run the audit

Run `bash scripts/audit-docs.sh` to identify gaps between `oss/` reports and documentation.

Save the output for reference throughout the remaining steps.

## Step 2: Regenerate TABLE.md

Run `bash scripts/generate-table.sh` to rebuild `docs/TABLE.md` from scratch. This is fully automated and always produces the correct result.

## Step 3: Update ROADMAP.md

Read `docs/ROADMAP.md` and identify projects missing from it (listed in the audit output).

For each missing project:
1. Read its `oss/{project}/README.md` to understand its architectural complexity
2. Determine difficulty level:
   - Beginner: focused scope, clean codebase, straightforward architecture, single-purpose
   - Intermediate: multiple subsystems, distributed components, sophisticated data structures
   - Advanced: massive-scale distributed systems, novel algorithms, complex consensus/scheduling
3. Add a row to the appropriate difficulty table: `| [{name}](../oss/{project}/README.md) | {why} |`
4. Check if the project fits any existing Learning Path. If so, add it there too.

Follow the existing writing style. Keep "Why Start Here" / "What You'll Learn" descriptions to one concise sentence.

## Step 4: Update PATTERNS.md

Read `docs/PATTERNS.md` to understand the documented patterns.

For each project NOT yet referenced in PATTERNS.md:
1. Read its `oss/{project}/README.md`, especially Core Components and Key Design Decisions
2. Identify which documented patterns the project uses (Plugin Architecture, Pipeline, Event-Driven, WAL, LSM-Tree, Raft, MVCC, Middleware, Work-Stealing, Declarative Reconciliation, Actor Model, Distributed Snapshots, Content-Addressable Storage)
3. Add a row to each matching pattern table: `| [{name}](../oss/{project}/README.md) | {implementation details} |`
4. If the project uses a pattern not yet documented and at least 3 projects share it, create a new pattern section

Keep implementation details concise (2-3 sentences) and specific to the project. Reference actual module names, interfaces, or techniques.

## Step 5: Verify

Run `bash scripts/audit-docs.sh` again and confirm:
- TABLE.md: 0 errors
- ROADMAP.md: 0 warnings (all projects covered)
- PATTERNS.md: coverage improved

## Rules

- Write entirely in English
- Do NOT use markdown bold syntax (`**`) anywhere
- Follow the existing format and writing style of each document
- Use relative links: `../oss/{project}/README.md`
- Do not add projects that do not exist under `oss/`
- Prioritize accuracy over coverage. If unsure about a project's patterns or difficulty, read its report first
