#!/usr/bin/env bash
set -euo pipefail

# Generate OSS project table in root README.md
# Scans oss/*/README.md for metadata and builds a markdown table
# sorted by Category then Project name

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
OSS_DIR="$ROOT_DIR/oss"
README="$ROOT_DIR/README.md"

# Temporary files
TMPFILE=$(mktemp)
TABLEFILE=$(mktemp)
trap 'rm -f "$TMPFILE" "$TABLEFILE"' EXIT

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

  # Extract Repository URL from metadata table
  repo=$(grep "^| Repository |" "$readme" | sed 's/^| Repository | //' | sed 's/ |$//')

  # Build table row: sort key (category + name) | actual row
  printf '%s\t%s\t| [%s](oss/%s/README.md) | %s | %s | %s |\n' \
    "$category" "$name" "$name" "$dir" "$description" "$language" "$category" >> "$TMPFILE"
done

# Sort by category (col 1) then name (col 2)
sort -t$'\t' -k1,1 -k2,2 "$TMPFILE" > "${TMPFILE}.sorted"

# Build the full table into a file
{
  echo "| Project | Description | Language | Category |"
  echo "|---|---|---|---|"
  while IFS=$'\t' read -r _ _ row; do
    echo "$row"
  done < "${TMPFILE}.sorted"
} > "$TABLEFILE"

# Count rows (subtract header lines)
ROW_COUNT=$(( $(wc -l < "$TABLEFILE") - 2 ))
echo "Generated table with $ROW_COUNT projects"

# Replace content between markers in README.md
if ! grep -q "<!-- TABLE_START -->" "$README"; then
  echo "ERROR: <!-- TABLE_START --> marker not found in README.md"
  exit 1
fi

if ! grep -q "<!-- TABLE_END -->" "$README"; then
  echo "ERROR: <!-- TABLE_END --> marker not found in README.md"
  exit 1
fi

# Use awk to replace content between markers, reading table from file
awk '
  /<!-- TABLE_START -->/ {
    print
    print ""
    while ((getline line < "'"$TABLEFILE"'") > 0) print line
    print ""
    skip=1
    next
  }
  /<!-- TABLE_END -->/ { skip=0 }
  skip { next }
  { print }
' "$README" > "${README}.tmp"

mv "${README}.tmp" "$README"
rm -f "${TMPFILE}.sorted"

echo "README.md updated successfully"
