#!/usr/bin/env bash
# Decodes Firebase platform config from CI secrets into gitignored paths.
# Usage: GOOGLE_SERVICES_JSON_BASE64=... GOOGLE_SERVICE_INFO_PLIST_BASE64=... ./scripts/load_firebase_config.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANDROID_OUT="${ROOT}/android/app/google-services.json"
IOS_OUT="${ROOT}/ios/Runner/GoogleService-Info.plist"

if [[ -n "${GOOGLE_SERVICES_JSON_BASE64:-}" ]]; then
  echo "Writing android/app/google-services.json from secret..."
  echo "$GOOGLE_SERVICES_JSON_BASE64" | base64 -d > "$ANDROID_OUT"
elif [[ -f "${ROOT}/android/app/google-services.json.example" ]] && [[ ! -f "$ANDROID_OUT" ]]; then
  echo "No GOOGLE_SERVICES_JSON_BASE64 — Android Firebase native config skipped."
fi

if [[ -n "${GOOGLE_SERVICE_INFO_PLIST_BASE64:-}" ]]; then
  echo "Writing ios/Runner/GoogleService-Info.plist from secret..."
  echo "$GOOGLE_SERVICE_INFO_PLIST_BASE64" | base64 -d > "$IOS_OUT"
elif [[ -f "${ROOT}/ios/Runner/GoogleService-Info.plist.example" ]] && [[ ! -f "$IOS_OUT" ]]; then
  echo "No GOOGLE_SERVICE_INFO_PLIST_BASE64 — iOS Firebase native config skipped."
fi

if [[ -f "$ANDROID_OUT" ]]; then
  echo "Android Firebase config: OK"
fi
if [[ -f "$IOS_OUT" ]]; then
  echo "iOS Firebase config: OK"
fi
