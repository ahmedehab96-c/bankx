#!/usr/bin/env bash
# Resolves dart-define flags for a BankX environment.
# Usage: source scripts/load_env.sh staging
#        flutter run $(bankx_dart_defines staging)

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bankx_dart_defines() {
  local env="${1:-development}"
  local file="${ROOT}/config/env/${env}.json"

  if [[ ! -f "$file" ]]; then
    echo "Unknown environment: $env (expected ${file})" >&2
    return 1
  fi

  echo "--dart-define-from-file=${file}"
}

# Export for CI: eval "$(scripts/load_env.sh development)"
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  bankx_dart_defines "${1:-development}"
fi
