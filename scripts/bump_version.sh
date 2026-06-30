#!/usr/bin/env bash
# Bumps pubspec version build number using CI run number or timestamp.
# Usage: ./scripts/bump_version.sh [patch|minor|major]

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBSPEC="${ROOT}/pubspec.yaml"
BUMP="${1:-patch}"

current=$(grep '^version:' "$PUBSPEC" | awk '{print $2}')
name="${current%%+*}"
build="${current#*+}"

IFS='.' read -r major minor patch <<< "$name"

case "$BUMP" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  patch) patch=$((patch + 1)) ;;
  build) ;;
  *) echo "Usage: $0 [patch|minor|major|build]" >&2; exit 1 ;;
esac

# CI build number takes priority over local increment.
if [[ -n "${GITHUB_RUN_NUMBER:-}" ]]; then
  build="$GITHUB_RUN_NUMBER"
else
  build=$((build + 1))
fi

new_version="${major}.${minor}.${patch}+${build}"
sed -i.bak "s/^version: .*/version: ${new_version}/" "$PUBSPEC"
rm -f "${PUBSPEC}.bak"

echo "Version bumped to ${new_version}"
echo "BANKX_VERSION=${new_version}" >> "${GITHUB_ENV:-/dev/null}" 2>/dev/null || true
