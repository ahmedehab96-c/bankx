# BankX Demo Video Storyboard

**Duration:** 2 minutes 30 seconds  
**Format:** Screen recording → GIF for GitHub / MP4 for portfolio  
**Resolution:** 1080 × 2340 (portrait) or 1920 × 1080 (landscape with device frame)  
**Music:** Optional subtle corporate ambient (royalty-free)

---

## Scene Breakdown

### Scene 1 — Splash (0:00 – 0:08)

| Element | Detail |
|---------|--------|
| **Screen** | Splash page |
| **Action** | App launches, logo animates, auto-navigates |
| **Voiceover** | "BankX — enterprise digital banking, built with Flutter." |
| **On-screen text** | Title card: "BankX Digital Banking" |

---

### Scene 2 — Onboarding (0:08 – 0:15)

| Element | Detail |
|---------|--------|
| **Screen** | Onboarding carousel (swipe 2 pages) |
| **Action** | Swipe through value props, tap "Get Started" |
| **Voiceover** | "A complete banking experience — transfers, cards, payments, and more." |

---

### Scene 3 — Login (0:15 – 0:25)

| Element | Detail |
|---------|--------|
| **Screen** | Login page |
| **Action** | Enter demo credentials, tap Login |
| **Credentials** | `demo@bankx.com` / `Demo1234!` (use your demo account) |
| **Voiceover** | "Secure JWT authentication with session management." |

---

### Scene 4 — Biometric Login (0:25 – 0:32)

| Element | Detail |
|---------|--------|
| **Screen** | Biometric prompt (or Security Settings toggle) |
| **Action** | Show Face ID / fingerprint dialog, authenticate |
| **Voiceover** | "Biometric login with PIN fallback and session timeout." |
| **Note** | If simulator lacks biometrics, show Security Settings screen instead |

---

### Scene 5 — Dashboard (0:32 – 0:48)

| Element | Detail |
|---------|--------|
| **Screen** | Home / Dashboard |
| **Action** | Scroll to show balance card, spending chart, recent transactions |
| **Voiceover** | "Real-time dashboard with spending analytics powered by Clean Architecture and BLoC." |
| **Highlight** | Point to balance, chart animation |

---

### Scene 6 — Transfer (0:48 – 1:05)

| Element | Detail |
|---------|--------|
| **Screen** | Transfer money |
| **Action** | Select beneficiary, enter amount, add note, confirm transfer |
| **Voiceover** | "Instant transfers with beneficiary management — and offline queue support." |
| **Highlight** | Success confirmation snackbar |

---

### Scene 7 — QR Payment (1:05 – 1:18)

| Element | Detail |
|---------|--------|
| **Screen** | QR payment (receive tab) |
| **Action** | Show QR code, switch to scan tab briefly |
| **Voiceover** | "QR payments for seamless peer-to-peer transactions." |

---

### Scene 8 — Cards (1:18 – 1:30)

| Element | Detail |
|---------|--------|
| **Screen** | My Cards → Card Details → Freeze |
| **Action** | Swipe cards, open details, toggle freeze |
| **Voiceover** | "Full card management with instant freeze for security." |

---

### Scene 9 — Notifications (1:30 – 1:40)

| Element | Detail |
|---------|--------|
| **Screen** | Notifications list |
| **Action** | Tap notification, mark as read |
| **Voiceover** | "Push notifications via Firebase Cloud Messaging with deep links." |

---

### Scene 10 — Dark Mode (1:40 – 1:50)

| Element | Detail |
|---------|--------|
| **Screen** | Settings → toggle dark theme → Dashboard |
| **Action** | Switch to dark mode, navigate to dashboard |
| **Voiceover** | "Material 3 theming with light, dark, and system modes." |

---

### Scene 11 — Offline Mode (1:50 – 2:02)

| Element | Detail |
|---------|--------|
| **Screen** | Transfer (with airplane mode on) |
| **Action** | Enable airplane mode, submit transfer, show queued state, disable airplane mode, show sync |
| **Voiceover** | "Offline-first architecture — transfers queue locally and sync automatically." |
| **Note** | Most impressive engineering demo — allocate extra time here |

---

### Scene 12 — PDF Statement (2:02 – 2:12)

| Element | Detail |
|---------|--------|
| **Screen** | Transaction details → Generate PDF / Profile → Statement |
| **Action** | Generate PDF, show preview, share sheet |
| **Voiceover** | "PDF statements and receipts with native share and print." |

---

### Scene 13 — Profile & Closing (2:12 – 2:30)

| Element | Detail |
|---------|--------|
| **Screen** | Profile → Settings (Arabic toggle optional) |
| **Action** | Show profile, switch to Arabic briefly, return to English |
| **Voiceover** | "Localized for English and Arabic with full RTL support. BankX — production-grade Flutter engineering." |
| **End card** | GitHub URL, tech stack badges, your name |

---

## Production Checklist

- [ ] Use a clean demo account with realistic data
- [ ] Hide status bar notifications (Do Not Disturb)
- [ ] Full battery and strong signal icons
- [ ] Consistent light mode for scenes 1–9, dark for scene 10
- [ ] Record at 60fps, export at 30fps
- [ ] Add subtle zoom/pan in post-production (optional)
- [ ] Export GIF: max 640px wide, < 10MB for GitHub
- [ ] Export MP4: 1080p for portfolio / LinkedIn

## Tools

| Tool | Purpose |
|------|---------|
| QuickTime / OBS | Screen recording |
| ffmpeg | GIF conversion |
| DaVinci Resolve / iMovie | Editing |
| MockUPhone | Device frame overlay |
| Canva | End card with badges |

## File Outputs

| File | Location | Use |
|------|----------|-----|
| `bankx-demo.gif` | `docs/assets/demo/` | GitHub README |
| `bankx-demo.mp4` | `docs/assets/demo/` | Portfolio, LinkedIn |
| `bankx-demo-youtube.mp4` | External | YouTube (add voiceover) |
