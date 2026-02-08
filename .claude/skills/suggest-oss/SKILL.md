---
name: suggest-oss
description: Suggest OSS projects worth analyzing that are not yet covered. Use when the user asks for new OSS candidates, recommendations, or what to analyze next.
argument-hint: "[category or theme (optional)]"
allowed-tools: Bash(ls:*), Bash(gh:*), Glob, Read, WebSearch
---

# OSS Candidate Suggester

Suggest open source projects whose architecture is worth documenting but not yet covered in this repository.

## Step 1: Check existing reports

List all directories under `oss/` (excluding `_template`) to know what is already covered:

```
ls oss/
```

## Step 2: Determine focus area

If the user provided a category or theme via $ARGUMENTS (e.g., "databases", "security", "web frameworks"), focus suggestions on that area. Otherwise, suggest a diverse mix across categories.

## Step 3: Generate candidates

Suggest 10 OSS projects that meet ALL of these criteria:

- NOT already in `oss/` directory
- Has 5,000+ GitHub stars (well-established)
- Has interesting architecture worth studying (not just a simple library)
- Actively maintained
- Source code is publicly available

For each candidate, use `gh` to fetch real metadata:

```
gh repo view {owner/repo} --json name,description,stargazerCount,primaryLanguage,licenseInfo
```

## Step 4: Output format

Present the candidates as a table with the following columns:

| # | Project | Stars | Language | Why it's architecturally interesting |
|---|---------|-------|----------|--------------------------------------|

Group by category (e.g., Databases, Security, Orchestration, Observability, Build Tools, Web Frameworks, etc.).

After the table, highlight your top 3 picks with a brief explanation of what makes their architecture especially worth documenting.

## Guidelines

- Prioritize diversity in language, domain, and architectural style
- Favor projects known for elegant or novel design (e.g., unique concurrency models, plugin systems, novel data structures)
- Include a mix of well-known (kubernetes, postgres) and lesser-known but architecturally fascinating projects
- If a category is specified, give 10 candidates in that category only
