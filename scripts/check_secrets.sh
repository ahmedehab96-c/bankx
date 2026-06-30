#!/usr/bin/env bash
# Scans for accidentally committed secrets.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PATTERNS=(
  'BEGIN (RSA |EC )?PRIVATE KEY'
  'api[_-]?key\s*=\s*["\x27][^"\x27]{8,}'
  'password\s*=\s*["\x27][^"\x27]{4,}'
  'ANDROID_KEYSTORE_PASSWORD\s*=\s*["\x27][^"\x27]+'
  'ghp_[A-Za-z0-9]{20,}'
  '"private_key":\s*"-----BEGIN'
  'AIza[0-9A-Za-z_-]{35}'
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
  ':!.github/**' \
  ':!.gitignore' \
  ':!scripts/check_secrets.sh' \
  ':!scripts/setup_firebase.sh' \
  ':!scripts/encode_firebase_secrets.sh' \
  ':!scripts/load_firebase_config.sh' \
  ':!android/app/build.gradle.kts' \
  ':!lib/core/firebase/firebase_options.dart' \
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
