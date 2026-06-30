# BankX Environment Setup

## Overview

BankX uses **Flutter dart-define** for compile-time environment configuration — no runtime `.env` package required. This keeps secrets out of the binary when managed correctly and works with CI/CD.

## Configuration files

| File | Purpose |
|------|---------|
| `config/env/development.json` | Dev API, feature flags (committed) |
| `config/env/staging.json` | Staging API, Firebase enabled |
| `config/env/production.json` | Production API, full observability |
| `config/env/.env.development` | Human-readable companion template |
| `config/env/.env.staging` | Staging secrets template (empty values) |
| `config/env/.env.production` | Production secrets template (empty values) |
| `config/env/.env.example` | All secret keys reference |
| `config/env/.env.local` | Local overrides (gitignored) |

## Build commands

```bash
# Run with environment
flutter run $(./scripts/load_env.sh development)

# Release builds
./scripts/ci_build.sh android-apk staging
./scripts/ci_build.sh android-aab production
./scripts/ci_build.sh ios production
```

## Variables

| Key | Description |
|-----|-------------|
| `BANKX_ENV` | Environment name |
| `BANKX_API_BASE_URL` | REST API base URL |
| `FIREBASE_CONFIGURED` | Enable Firebase bootstrap |
| `BANKX_ENABLE_ANALYTICS` | Firebase Analytics |
| `BANKX_ENABLE_CRASHLYTICS` | Crashlytics reporting |
| `BANKX_ENABLE_BIOMETRIC` | Biometric login feature flag |
| `BANKX_ENABLE_OFFLINE_SYNC` | Offline queue sync |

Read in code via `String.fromEnvironment('BANKX_API_BASE_URL')` etc.

## Firebase setup

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Add platform config files (gitignored):
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

Set `FIREBASE_CONFIGURED=true` in staging/production JSON.

## GitHub Secrets

See [CICD.md](CICD.md) for the full secrets table. Never commit:
- Keystores (`.jks`)
- `key.properties`
- Firebase service account keys
- API tokens

Run `./scripts/check_secrets.sh` before every release.
