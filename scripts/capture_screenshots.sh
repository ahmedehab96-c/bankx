#!/usr/bin/env bash
# Helper to capture BankX screenshots for README / portfolio.
# Requires a running iOS Simulator or Android emulator.
#
# Usage:
#   ./scripts/capture_screenshots.sh ios
#   ./scripts/capture_screenshots.sh android

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${ROOT}/docs/assets/screenshots"
PLATFORM="${1:-ios}"

mkdir -p "$OUT"

echo "==> BankX screenshot capture"
echo "    Output: $OUT"
echo "    Platform: $PLATFORM"
echo ""
echo "Manual steps (recommended for banking UI quality):"
echo "  1. flutter run \$(./scripts/load_env.sh development)"
echo "  2. Navigate to each screen and capture:"
echo "     - Splash, Login, Dashboard, Transfer, QR Payment, Dark mode"
echo "  3. Save as:"
echo "     01_splash.png, 02_login.png, 03_dashboard.png,"
echo "     04_transfer.png, 05_qr_payment.png, 06_dark_mode.png"
echo ""

case "$PLATFORM" in
  ios)
    if command -v xcrun &>/dev/null; then
      DEVICE="$(xcrun simctl list devices booted | grep -m1 Booted | sed 's/ *(.*//' | xargs)"
      if [[ -n "$DEVICE" ]]; then
        echo "Booted simulator: $DEVICE"
        echo "After navigating to a screen, run:"
        echo "  xcrun simctl io booted screenshot \"$OUT/03_dashboard.png\""
      else
        echo "Start a simulator: open -a Simulator"
      fi
    fi
    ;;
  android)
    if command -v adb &>/dev/null && adb devices | grep -q device; then
      echo "After navigating to a screen, run:"
      echo "  adb exec-out screencap -p > \"$OUT/03_dashboard.png\""
    else
      echo "Start an Android emulator and ensure adb sees a device."
    fi
    ;;
  *)
    echo "Usage: $0 [ios|android]" >&2
    exit 1
    ;;
esac

echo ""
echo "See docs/SCREENSHOTS.md for naming and README integration."
