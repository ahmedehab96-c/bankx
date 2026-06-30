#!/usr/bin/env bash
# BankX Firebase setup — run once after creating a Firebase project.
# Usage: ./scripts/setup_firebase.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ANDROID_CONFIG="android/app/google-services.json"
IOS_CONFIG="ios/Runner/GoogleService-Info.plist"
PACKAGE="com.bankx.bankx"

echo "==> BankX Firebase setup"
echo "    Package / Bundle ID: $PACKAGE"
echo ""

if ! command -v flutter &>/dev/null; then
  echo "Flutter CLI not found. Install Flutter first." >&2
  exit 1
fi

if ! dart pub global list 2>/dev/null | grep -q flutterfire_cli; then
  echo "==> Installing FlutterFire CLI..."
  dart pub global activate flutterfire_cli
fi

export PATH="$PATH:$HOME/.pub-cache/bin"

if ! command -v flutterfire &>/dev/null; then
  echo "Add to PATH: export PATH=\"\$PATH:\$HOME/.pub-cache/bin\"" >&2
  exit 1
fi

echo "==> Configuring Firebase (interactive)..."
echo "    Select or create project, then add Android ($PACKAGE) and iOS ($PACKAGE)."
flutterfire configure \
  --project=bankx-app \
  --android-package-name="$PACKAGE" \
  --ios-bundle-id="$PACKAGE" \
  --out=lib/core/firebase/firebase_options.dart \
  --yes 2>/dev/null || flutterfire configure \
  --android-package-name="$PACKAGE" \
  --ios-bundle-id="$PACKAGE" \
  --out=lib/core/firebase/firebase_options.dart

if [[ -f "$ANDROID_CONFIG" ]]; then
  echo "==> Android: $ANDROID_CONFIG OK"
else
  echo "WARN: Copy android/app/google-services.json.example and fill values, or re-run flutterfire configure." >&2
fi

if [[ -f "$IOS_CONFIG" ]]; then
  echo "==> iOS: $IOS_CONFIG OK"
else
  echo "WARN: Copy ios/Runner/GoogleService-Info.plist.example and fill values." >&2
fi

echo ""
echo "==> Enable Firebase in staging/production:"
echo "    Set FIREBASE_CONFIGURED=true in config/env/staging.json and production.json"
echo ""
echo "==> Run with Firebase:"
echo "    flutter run \$(./scripts/load_env.sh staging)"
echo ""
echo "==> CI secrets (GitHub):"
echo "    FIREBASE_TOKEN, FIREBASE_APP_ID_ANDROID, FIREBASE_APP_ID_IOS"
echo "    Encode google-services.json / GoogleService-Info.plist as base64 for CI if needed."
echo ""
echo "Done. See docs/FIREBASE_SETUP.md for full checklist."
