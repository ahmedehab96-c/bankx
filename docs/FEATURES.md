# BankX Features

## Biometric authentication

- **Fingerprint** and **Face ID** on Android/iOS via `local_auth`.
- Toggle in **Security Settings** (`SecurityBloc`).
- **Auto-login** on splash when a valid session exists and biometrics succeed.

## App security

| Feature | Implementation |
|---------|----------------|
| Session management | `SessionManager` + `SessionActivityDetector` |
| Auto logout | Configurable inactivity timeout (default 5 min) |
| PIN lock | `PinLockService` (hashed in secure storage) |
| Device integrity | `SafeDeviceIntegrityChecker` |
| Root detection | `RootDetectionService` interface |
| Jailbreak detection | `JailbreakDetectionService` interface |
| Screenshot block | `SensitiveScreenWrapper` on QR / card screens |
| Background privacy | `AppLifecycleGuard` overlay |
| Secure clipboard | `SecureClipboardService` |
| Token expiry | `TokenExpirationManager` + `TokenInterceptor` refresh |

## Hive cache

Cached with TTL expiration:

- Accounts, transactions, cards, notifications, profile, settings, dashboard, QR payment data.

## Offline mode

- Read APIs return cached data when offline.
- Transfers are **queued locally** and synced by `OfflineSyncService`.

## Push notifications

- Firebase Cloud Messaging (when configured).
- Foreground, background, and tap-to-open deep links.
- In-memory notification history in `PushNotificationService`.

## PDF

- `BankStatementPdfGenerator` — account statements.
- `TransferReceiptPdfGenerator` — transfer receipts.
- Share via `PdfShareService` (`share_plus`) or print (`printing`).

## QR payments

- **Scanner**: `QrScannerView` + `mobile_scanner`.
- **Generator**: `QrCodeDisplay` + `qr_flutter`.
- **Codec**: `QrPaymentCodec` for BankX payment payloads.

## Analytics & crash reporting

- `AnalyticsService` — login, transfer, payment, card, error events.
- `CrashlyticsService` — global error handlers in `main.dart`.

## Accessibility

- Large fonts via `SettingsState.textScale`.
- High contrast theme variant.
- Screen reader semantics via `AccessibilityWrapper`.

## Multi-language

- English (`en`) and Arabic (`ar`).
- Dynamic switching in Settings without app restart.
