#!/usr/bin/env bash
# Checks lcov coverage for lib/ against a minimum percentage.
# Usage: ./scripts/check_coverage.sh 90 lib/

set -euo pipefail

THRESHOLD="${1:-90}"
SCOPE="${2:-lib/}"

if [[ ! -f coverage/lcov.info ]]; then
  echo "coverage/lcov.info not found. Run: flutter test --coverage"
  exit 1
fi

# Extract line coverage for scoped files only.
LCOV_FILE=$(mktemp)
grep -E "^(SF:|DA:|end_of_record)" coverage/lcov.info > "$LCOV_FILE"

TOTAL=0
HIT=0
CURRENT=""

while IFS= read -r line; do
  case "$line" in
    SF:*)
      CURRENT="${line#SF:}"
      ;;
    DA:*)
      if [[ "$CURRENT" == "$SCOPE"* ]] || [[ "$CURRENT" == *"/$SCOPE"* ]]; then
        COUNT="${line#DA:}"
        HITS="${COUNT#*,}"
        TOTAL=$((TOTAL + 1))
        if [[ "$HITS" != "0" ]]; then
          HIT=$((HIT + 1))
        fi
      fi
      ;;
  esac
done < "$LCOV_FILE"

rm -f "$LCOV_FILE"

if [[ "$TOTAL" -eq 0 ]]; then
  echo "No coverage data for scope: $SCOPE"
  exit 1
fi

PCT=$((HIT * 100 / TOTAL))
echo "Coverage for $SCOPE: ${PCT}% (${HIT}/${TOTAL} lines)"

if [[ "$PCT" -lt "$THRESHOLD" ]]; then
  echo "Coverage ${PCT}% is below threshold ${THRESHOLD}%"
  exit 1
fi

echo "Coverage threshold met."
