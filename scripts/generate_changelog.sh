#!/usr/bin/env bash
# Generates CHANGELOG entry from conventional commits since last tag.
# Usage: ./scripts/generate_changelog.sh [version]

set -euo pipefail

VERSION="${1:-$(grep '^version:' pubspec.yaml | awk '{print $2}' | cut -d+ -f1)}"
DATE="$(date -u +%Y-%m-%d)"
OUTPUT="CHANGELOG.md"

last_tag="$(git describe --tags --abbrev=0 2>/dev/null || echo "")"
range="${last_tag:+${last_tag}..HEAD}"

commits="$(git log ${range} --pretty=format:'%s' --no-merges 2>/dev/null || true)"

features=""
fixes=""
other=""

while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  case "$line" in
    feat:*|feature:*) features+="- ${line#*: }"$'\n' ;;
    fix:*|bugfix:*) fixes+="- ${line#*: }"$'\n' ;;
    *) other+="- $line"$'\n' ;;
  esac
done <<< "$commits"

{
  echo "## [$VERSION] - $DATE"
  echo
  if [[ -n "$features" ]]; then
    echo "### Added"
    echo "$features"
  fi
  if [[ -n "$fixes" ]]; then
    echo "### Fixed"
    echo "$fixes"
  fi
  if [[ -n "$other" ]]; then
    echo "### Other"
    echo "$other"
  fi
  echo
} > /tmp/bankx_changelog_entry.md

if [[ -f "$OUTPUT" ]]; then
  { cat /tmp/bankx_changelog_entry.md; echo; cat "$OUTPUT"; } > "${OUTPUT}.new"
  mv "${OUTPUT}.new" "$OUTPUT"
else
  mv /tmp/bankx_changelog_entry.md "$OUTPUT"
fi

echo "Updated $OUTPUT for version $VERSION"
