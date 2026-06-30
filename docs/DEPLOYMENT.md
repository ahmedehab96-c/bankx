# BankX Deployment Guide

## Environments

| Environment | Config file | API | Firebase |
|-------------|-------------|-----|----------|
| Development | `config/env/development.json` | api-dev.bankx.com | Optional |
| Staging | `config/env/staging.json` | api-staging.bankx.com | Enabled |
| Production | `config/env/production.json` | api.bankx.com | Enabled |

Secrets are injected via **GitHub Secrets** in CI — never committed to the repository.

## Local development

```bash
flutter pub get
flutter run $(./scripts/load_env.sh development)
```

Override secrets locally with `config/env/.env.local` (gitignored) — reference `config/env/.env.example`.

## Staging deployment (Firebase App Distribution)

1. Configure GitHub Secrets (see `docs/CICD.md`)
2. GitHub → Actions → **Firebase App Distribution** → Run workflow
3. Select `staging` environment and platform
4. Testers in `qa-testers` group receive notification

## Production deployment

### Google Play Store

1. Run **Release** workflow on `main` (or manual dispatch with `production`)
2. Download `app-release.aab` from GitHub Release artifacts
3. Upload to Play Console → Internal testing → Production rollout
4. Complete store listing, privacy policy, and banking compliance review

### Apple App Store

1. Download IPA from release artifacts
2. Upload via Transporter or `xcrun altool`
3. Submit for App Store review in App Store Connect

## Android signing setup

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
cp android/key.properties.example android/key.properties
# Fill in passwords — never commit key.properties or .jks
```

For CI, base64-encode keystore:
```bash
base64 -i upload-keystore.jks | pbcopy
# Paste into GitHub Secret ANDROID_KEYSTORE_BASE64
```

## iOS signing setup

1. Create Distribution certificate in Apple Developer portal
2. Create App Store provisioning profile for `com.bankx.bankx`
3. Export `.p12` and base64 for `IOS_P12_BASE64` secret
4. Update `ios/ExportOptions.plist` profile name

## Firebase configuration

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Set `FIREBASE_CONFIGURED=true` in environment JSON for staging/production.

Place platform files (gitignored):
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

## Rollback procedure

1. Identify last stable GitHub Release tag (`v*`)
2. Re-run Release workflow from that tag, or
3. Promote previous build in Play Console / App Store Connect
4. Hotfix via `hotfix/*` branch (see `docs/BRANCHING.md`)

## Post-deployment verification

- [ ] Login / logout flow
- [ ] Transfer and bill payment
- [ ] QR payment scan
- [ ] Push notifications
- [ ] Offline mode and sync
- [ ] Crashlytics receiving events
- [ ] API pointing to correct environment
