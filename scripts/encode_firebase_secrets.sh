#!/usr/bin/env bash
# Prints base64 payloads for GitHub Secrets (run locally, never commit output).
# Usage: ./scripts/encode_firebase_secrets.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANDROID="${ROOT}/android/app/google-services.json"
IOS="${ROOT}/ios/Runner/GoogleService-Info.plist"

echo "==> BankX Firebase secrets for GitHub"
echo ""

if [[ ! -f "$ANDROID" ]]; then
  echo "Missing: $ANDROID" >&2
  exit 1
fi
if [[ ! -f "$IOS" ]]; then
  echo "Missing: $IOS" >&2
  exit 1
fi

echo "Add these GitHub repository secrets (Settings → Secrets → Actions):"
echo ""
echo "GOOGLE_SERVICES_JSON_BASE64"
base64 < "$ANDROID" | tr -d '\n'
echo ""
echo ""
echo "GOOGLE_SERVICE_INFO_PLIST_BASE64"
base64 < "$IOS" | tr -d '\n'
echo ""
echo ""
echo "FIREBASE_APP_ID_ANDROID=1:184700813147:android:8e939a394a823118e1e47e"
echo "FIREBASE_APP_ID_IOS=1:184700813147:ios:55955d89bec707b5e1e47e"
echo "FIREBASE_TOKEN=<run: firebase login:ci>"
