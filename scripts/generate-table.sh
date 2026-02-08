#!/usr/bin/env bash
set -euo pipefail

# Generate OSS project table in TABLE.md
# Scans oss/*/README.md for metadata and builds a markdown table
# grouped by Category with section headings and a table of contents

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
OSS_DIR="$ROOT_DIR/oss"
OUTPUT="$ROOT_DIR/TABLE.md"

# Temporary files
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE" "${TMPFILE}.sorted" "${TMPFILE}.categories"' EXIT

PROJECT_COUNT=0

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

  # Build table row: category\tname\trow (without Category column)
  printf '%s\t%s\t| [%s](oss/%s/README.md) | %s | %s |\n' \
    "$category" "$name" "$name" "$dir" "$description" "$language" >> "$TMPFILE"

  PROJECT_COUNT=$((PROJECT_COUNT + 1))
done

# Sort by category (col 1) then name (col 2)
sort -t$'\t' -k1,1 -k2,2 "$TMPFILE" > "${TMPFILE}.sorted"

# Extract unique categories in sorted order
cut -f1 "${TMPFILE}.sorted" | uniq > "${TMPFILE}.categories"

# Build TABLE.md
{
  echo "# OSS Architecture Reports"
  echo ""
  echo "## Table of Contents"
  echo ""

  # Generate table of contents with anchor links
  while IFS= read -r cat; do
    # Create GitHub-compatible anchor: lowercase, remove non-alphanumeric except spaces/hyphens, spaces to hyphens
    anchor=$(echo "$cat" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 -]//g' | sed 's/ /-/g')
    echo "- [${cat}](#${anchor})"
  done < "${TMPFILE}.categories"

  echo ""

  # Generate category sections
  current_category=""
  while IFS=$'\t' read -r category _ row; do
    if [ "$category" != "$current_category" ]; then
      # New category section
      if [ -n "$current_category" ]; then
        echo ""
      fi
      echo "## ${category}"
      echo ""
      echo "| Project | Description | Language |"
      echo "|---|---|---|"
      current_category="$category"
    fi
    echo "$row"
  done < "${TMPFILE}.sorted"
} > "$OUTPUT"

echo "Generated TABLE.md with $PROJECT_COUNT projects"
