# BankX Screenshot Guide

Use this guide to capture consistent, professional screenshots for GitHub, app stores, and portfolio.

## Asset Locations

```
docs/assets/
├── logo.png                  # App icon / logo (512×512)
├── screenshots/              # Static screenshots
│   ├── 01_splash.png
│   ├── 02_onboarding.png
│   └── ...
└── demo/
    └── bankx-demo.gif        # Animated demo (320–640px wide)
```

## Device Recommendations

| Platform | Device | Resolution |
|----------|--------|------------|
| iOS (App Store) | iPhone 15 Pro Max | 1290 × 2796 |
| iOS (portfolio) | iPhone 15 Pro | 1179 × 2556 |
| Android (Play Store) | Pixel 8 Pro | 1344 × 2992 |
| GitHub README | Any | 1080 × 2340 (scale to ~400px wide) |

Capture on **both light and dark mode** where applicable.

---

## Required Screenshots (18 total)

### Recommended capture order

Capture in user journey order — this matches the demo video storyboard.

| # | Filename | Screen | Mode | Notes |
|---|----------|--------|------|-------|
| 1 | `01_splash.png` | Splash | Dark | Brand logo, loading indicator |
| 2 | `02_onboarding.png` | Onboarding page 1 | Light | Value proposition |
| 3 | `03_login.png` | Login | Light | Clean form, no keyboard |
| 4 | `04_biometric.png` | Biometric prompt | Light | Face ID / fingerprint dialog |
| 5 | `05_dashboard.png` | Home / Dashboard | Light | Balance, chart, recent transactions |
| 6 | `06_analytics.png` | Analytics tab | Light | Spending chart, income/expense |
| 7 | `07_transactions.png` | Transaction history | Light | Mixed credit/debit list |
| 8 | `08_transaction_detail.png` | Transaction details | Light | Reference, status, amount |
| 9 | `09_transfer.png` | Transfer money | Light | Amount entry, beneficiary selected |
| 10 | `10_beneficiaries.png` | Beneficiary list | Light | Saved contacts |
| 11 | `11_qr_payment.png` | QR payment | Light | QR code display or scanner |
| 12 | `12_bill_payment.png` | Bill payment | Light | Bill type selector |
| 13 | `13_cards.png` | My cards | Light | Card carousel |
| 14 | `14_card_freeze.png` | Freeze card | Light | Frozen state indicator |
| 15 | `15_notifications.png` | Notifications | Light | Unread badges |
| 16 | `16_profile.png` | Profile | Light | Avatar, member since |
| 17 | `17_settings.png` | Settings | Light | Theme, language, security |
| 18 | `18_dark_mode.png` | Dashboard | Dark | Full dark theme showcase |

### Bonus shots (recommended)

| Filename | Screen | Purpose |
|----------|--------|---------|
| `19_offline.png` | Transfer (offline banner) | Offline capability |
| `20_pdf_statement.png` | PDF preview | Statement generation |
| `21_arabic.png` | Dashboard | RTL / Arabic localization |
| `22_accessibility.png` | Settings | High contrast / text scale |

---

## Platform-Specific Sets

### Google Play Store (8 screenshots minimum)

**Order for Play Console:**

1. Dashboard (hero shot — first impression)
2. Transfer money
3. QR payment
4. Cards
5. Analytics
6. Dark mode dashboard
7. Notifications
8. Profile / settings

**Tips:**
- Use 16:9 or 9:16 aspect ratio
- No device frames required (but optional with [MockUPhone](https://mockuphone.com))
- First screenshot is most important — use dashboard with balance visible

### Apple App Store (6–10 screenshots)

**Order for App Store Connect:**

1. Dashboard (6.7" display)
2. Transfer
3. QR payment
4. Cards with freeze
5. Analytics
6. Dark mode
7. Biometric login
8. Arabic RTL (if targeting MENA)

**Tips:**
- Required sizes: 6.7", 6.5", 5.5" (or use Xcode automatic sizing)
- Add short caption overlays in App Store Connect (not in image)

### GitHub README (6 screenshots)

Embed in README at ~200px width:

1. Splash
2. Login
3. Dashboard
4. Transfer
5. QR payment
6. Dark mode

### Portfolio Website (10–12 screenshots)

Hero carousel order:

1. Dashboard (hero)
2. Transfer
3. QR payment
4. Cards
5. Analytics
6. Dark mode
7. Offline mode
8. PDF statement
9. Biometric
10. Arabic RTL

Add 2–3 sentence captions per screenshot explaining the engineering behind each feature.

---

## Capture Instructions

### iOS Simulator

```bash
# Boot simulator
open -a Simulator

# Run app
flutter run $(./scripts/load_env.sh development) -d "iPhone 15 Pro"

# Screenshot: Cmd + S (saves to Desktop)
# Move to docs/assets/screenshots/
```

### Android Emulator

```bash
flutter run $(./scripts/load_env.sh development) -d emulator-5554

# Screenshot: emulator toolbar camera icon
# Or: adb exec-out screencap -p > docs/assets/screenshots/05_dashboard.png
```

### Physical device

- iOS: Side button + Volume up
- Android: Power + Volume down

---

## GIF Demo

Record a 2–3 minute screen recording, then convert:

```bash
# Using ffmpeg (install via brew)
ffmpeg -i bankx-demo.mov -vf "fps=12,scale=640:-1" -loop 0 docs/assets/demo/bankx-demo.gif
```

Storyboard: [DEMO_VIDEO_STORYBOARD.md](DEMO_VIDEO_STORYBOARD.md)

---

## Placeholder Notice

Screenshot files referenced in `README.md` are placeholders until captured. Replace `docs/assets/screenshots/*.png` before publishing the repository publicly.
