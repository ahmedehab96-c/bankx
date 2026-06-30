#!/usr/bin/env bash
# Unified CI build script for BankX Android/iOS artifacts.
# Usage: ./scripts/ci_build.sh android-apk staging

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TARGET="${1:-android-apk}"
ENV="${2:-staging}"
DEFINES="$(bash scripts/load_env.sh "$ENV")"

echo "Building $TARGET for environment: $ENV"

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs 2>/dev/null || true

case "$TARGET" in
  android-apk)
    flutter build apk --release $DEFINES
    ;;
  android-aab)
    flutter build appbundle --release $DEFINES
    ;;
  ios)
    flutter build ipa --release $DEFINES \
      --export-options-plist=ios/ExportOptions.plist
    ;;
  *)
    echo "Unknown target: $TARGET (android-apk|android-aab|ios)" >&2
    exit 1
    ;;
esac

echo "Build complete: $TARGET ($ENV)"
