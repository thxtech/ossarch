#!/usr/bin/env bash
set -euo pipefail

# Generate OSS project table in TABLE.md
# Scans oss/*/README.md for metadata and builds a markdown table
# sorted by Category then Project name

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
OSS_DIR="$ROOT_DIR/oss"
OUTPUT="$ROOT_DIR/TABLE.md"

# Temporary files
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE" "${TMPFILE}.sorted"' EXIT

for readme in "$OSS_DIR"/*/README.md; do
  dir="$(basename "$(dirname "$readme")")"

  # Skip template
  if [ "$dir" = "_template" ]; then
    continue
  fi

  # Extract project name from "# {name}" line
  name=$(head -1 "$readme" | sed 's/^# //')

  # Extract description from "> {description}" line
  description=$(sed -n '3p' "$readme" | sed 's/^> //')

  # Extract Primary Language from metadata table
  language=$(grep "^| Primary Language |" "$readme" | sed 's/^| Primary Language | //' | sed 's/ |$//')

  # Extract Category from metadata table
  category=$(grep "^| Category |" "$readme" | sed 's/^| Category | //' | sed 's/ |$//')

  # Build table row: sort key (category + name) | actual row
  printf '%s\t%s\t| [%s](oss/%s/README.md) | %s | %s | %s |\n' \
    "$category" "$name" "$name" "$dir" "$description" "$language" "$category" >> "$TMPFILE"
done

# Sort by category (col 1) then name (col 2)
sort -t$'\t' -k1,1 -k2,2 "$TMPFILE" > "${TMPFILE}.sorted"

# Build TABLE.md
{
  echo "# OSS Architecture Reports"
  echo ""
  echo "| Project | Description | Language | Category |"
  echo "|---|---|---|---|"
  while IFS=$'\t' read -r _ _ row; do
    echo "$row"
  done < "${TMPFILE}.sorted"
} > "$OUTPUT"

# Count rows (total lines minus header/separator/title/blank = -4)
ROW_COUNT=$(( $(wc -l < "$OUTPUT") - 4 ))
echo "Generated TABLE.md with $ROW_COUNT projects"
