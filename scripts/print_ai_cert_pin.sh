#!/usr/bin/env bash
# Print SHA-256 certificate pin for AI API host (for BANKX_AI_CERT_PINS).
# Usage: ./scripts/print_ai_cert_pin.sh api.openai.com
set -euo pipefail

HOST="${1:-}"
if [[ -z "$HOST" ]]; then
  echo "Usage: $0 <hostname>" >&2
  echo "Example: $0 your-proxy.run.app" >&2
  exit 1
fi

PIN=$(openssl s_client -connect "${HOST}:443" -servername "$HOST" </dev/null 2>/dev/null \
  | openssl x509 -outform DER 2>/dev/null \
  | openssl dgst -sha256 -hex \
  | awk '{print $2}')

if [[ -z "$PIN" ]]; then
  echo "Failed to read certificate for $HOST" >&2
  exit 1
fi

echo "Host: $HOST"
echo "SHA-256 pin: $PIN"
echo ""
echo "Set in production:"
echo "  BANKX_AI_CERT_PIN_ENABLED=true"
echo "  BANKX_AI_CERT_PINS=$PIN"
