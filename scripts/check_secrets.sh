#!/usr/bin/env bash
# Scans for accidentally committed secrets.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PATTERNS=(
  'BEGIN (RSA |EC )?PRIVATE KEY'
  'api[_-]?key\s*=\s*["\x27][^"\x27]{8,}'
  'password\s*=\s*["\x27][^"\x27]+'
  'ANDROID_KEYSTORE_PASSWORD'
  'ghp_[A-Za-z0-9]{20,}'
  'firebase.*\.json'
)

FOUND=0
while IFS= read -r -d '' file; do
  for pattern in "${PATTERNS[@]}"; do
    if grep -qiE "$pattern" "$file" 2>/dev/null; then
      echo "Potential secret in: $file (pattern: $pattern)"
      FOUND=1
    fi
  done
done < <(git ls-files -z \
  ':!*.md' \
  ':!scripts/check_secrets.sh' \
  ':!config/env/.env.example' \
  ':!config/env/.env.development' \
  ':!config/env/.env.staging' \
  ':!config/env/.env.production' \
  ':!config/env/*.json')

if [[ "$FOUND" -eq 1 ]]; then
  echo "Secret scan failed."
  exit 1
fi

echo "Secret scan passed."
