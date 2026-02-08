#!/usr/bin/env bash
set -euo pipefail

# Audit consistency between oss/ reports and supplementary documents
# Checks that every project appears in TABLE.md and ROADMAP.md
# Reports projects missing from COMPARISONS.md and PATTERNS.md

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

TABLE="$ROOT_DIR/docs/TABLE.md"
ROADMAP="$ROOT_DIR/docs/ROADMAP.md"
COMPARISONS="$ROOT_DIR/docs/COMPARISONS.md"
PATTERNS="$ROOT_DIR/docs/PATTERNS.md"

errors=0
warnings=0

echo "=== OSS Documentation Audit ==="
echo ""

# Collect all project directories (excluding template)
projects=()
for dir in "$ROOT_DIR"/oss/*/; do
  name="$(basename "$dir")"
  if [ "$name" = "_template" ]; then
    continue
  fi
  projects+=("$name")
done

total=${#projects[@]}
echo "Total projects in oss/: $total"
echo ""

# --- TABLE.md check (required) ---
echo "--- TABLE.md ---"
table_missing=()
for p in "${projects[@]}"; do
  if ! grep -q "oss/${p}/README.md" "$TABLE" 2>/dev/null; then
    table_missing+=("$p")
  fi
done

if [ ${#table_missing[@]} -eq 0 ]; then
  echo "OK: All $total projects found in TABLE.md"
else
  echo "ERROR: ${#table_missing[@]} projects missing from TABLE.md:"
  for p in "${table_missing[@]}"; do
    echo "  - $p"
  done
  errors=$((errors + ${#table_missing[@]}))
fi
echo ""

# --- ROADMAP.md check (required) ---
echo "--- ROADMAP.md ---"
roadmap_missing=()
for p in "${projects[@]}"; do
  if ! grep -q "oss/${p}/README.md" "$ROADMAP" 2>/dev/null; then
    roadmap_missing+=("$p")
  fi
done

if [ ${#roadmap_missing[@]} -eq 0 ]; then
  echo "OK: All $total projects found in ROADMAP.md"
else
  echo "WARN: ${#roadmap_missing[@]} projects not in ROADMAP.md:"
  for p in "${roadmap_missing[@]}"; do
    echo "  - $p"
  done
  warnings=$((warnings + ${#roadmap_missing[@]}))
fi
echo ""

# --- COMPARISONS.md check (informational) ---
echo "--- COMPARISONS.md ---"
comp_count=0
for p in "${projects[@]}"; do
  if grep -q "oss/${p}/README.md" "$COMPARISONS" 2>/dev/null; then
    comp_count=$((comp_count + 1))
  fi
done
echo "Coverage: $comp_count / $total projects referenced"
echo ""

# --- PATTERNS.md check (informational) ---
echo "--- PATTERNS.md ---"
pat_count=0
for p in "${projects[@]}"; do
  if grep -q "oss/${p}/README.md" "$PATTERNS" 2>/dev/null; then
    pat_count=$((pat_count + 1))
  fi
done
echo "Coverage: $pat_count / $total projects referenced"
echo ""

# --- Summary ---
echo "=== Summary ==="
echo "Errors: $errors"
echo "Warnings: $warnings"

if [ $errors -gt 0 ]; then
  echo ""
  echo "FAIL: Fix errors above. Run 'bash scripts/generate-table.sh' to update TABLE.md."
  exit 1
fi

if [ $warnings -gt 0 ]; then
  echo ""
  echo "WARN: Some projects are not in ROADMAP.md. Consider adding them."
  exit 0
fi

echo ""
echo "All checks passed."
