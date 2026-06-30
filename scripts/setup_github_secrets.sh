#!/usr/bin/env bash
# Push Firebase + CI secrets to GitHub (run once after cloning).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v gh &>/dev/null; then
  echo "Install GitHub CLI: https://cli.github.com/"
  exit 1
fi

ANDROID_JSON="$ROOT/android/app/google-services.json"
IOS_PLIST="$ROOT/ios/Runner/GoogleService-Info.plist"

if [[ ! -f "$ANDROID_JSON" ]]; then
  echo "Missing $ANDROID_JSON — copy from Firebase Console first."
  exit 1
fi
if [[ ! -f "$IOS_PLIST" ]]; then
  echo "Missing $IOS_PLIST — copy from Firebase Console first."
  exit 1
fi

echo "Setting GitHub secrets for $(gh repo view --json nameWithOwner -q .nameWithOwner)..."

gh secret set GOOGLE_SERVICES_JSON_BASE64 \
  --body "$(base64 -i "$ANDROID_JSON" | tr -d '\n')"
gh secret set GOOGLE_SERVICE_INFO_PLIST_BASE64 \
  --body "$(base64 -i "$IOS_PLIST" | tr -d '\n')"
gh secret set FIREBASE_APP_ID_ANDROID \
  --body "1:184700813147:android:8e939a394a823118e1e47e"
gh secret set FIREBASE_APP_ID_IOS \
  --body "1:184700813147:ios:55955d89bec707b5e1e47e"

gh variable set FIREBASE_TESTER_GROUPS --body "qa-testers"

if [[ -n "${FIREBASE_TOKEN:-}" ]]; then
  gh secret set FIREBASE_TOKEN --body "$FIREBASE_TOKEN"
  echo "FIREBASE_TOKEN set from environment."
else
  echo ""
  echo "FIREBASE_TOKEN not set. Run interactively:"
  echo "  npx firebase-tools login:ci"
  echo "  gh secret set FIREBASE_TOKEN --body \"<paste-token>\""
fi

echo ""
echo "Done. Current secrets:"
gh secret list
gh variable list
