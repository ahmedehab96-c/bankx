# BankX Developer Guide

Complete guide for setting up, running, building, and troubleshooting BankX locally.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Setup](#project-setup)
- [Environment Configuration](#environment-configuration)
- [Running Locally](#running-locally)
- [Code Generation](#code-generation)
- [Building](#building)
- [Releasing](#releasing)
- [Testing](#testing)
- [Common Troubleshooting](#common-troubleshooting)

---

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Flutter SDK | 3.x stable | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart | 3.10+ | Bundled with Flutter |
| Xcode | 15+ | Mac App Store (iOS builds) |
| CocoaPods | Latest | `sudo gem install cocoapods` |
| Android Studio | Latest | [developer.android.com](https://developer.android.com/studio) |
| JDK | 17 | Required for Android Gradle |

Verify installation:

```bash
flutter doctor -v
```

All checks should pass for your target platform.

---

## Project Setup

```bash
# Clone
git clone https://github.com/ahmedehabmohammed/bankx.git
cd bankx

# Dependencies
flutter pub get

# Code generation (Freezed, JSON serializable, mocks)
dart run build_runner build --delete-conflicting-outputs

# Verify analyzer
flutter analyze --fatal-infos --fatal-warnings
```

### IDE setup

**VS Code / Cursor extensions:**
- Dart
- Flutter
- Bloc (optional)

**Analysis:** Project uses strict `analysis_options.yaml`. Enable format-on-save.

---

## Environment Configuration

BankX uses compile-time configuration via `--dart-define-from-file`.

| Environment | Config file | API URL |
|-------------|-------------|---------|
| Development | `config/env/development.json` | `https://api-dev.bankx.com/v1` |
| Staging | `config/env/staging.json` | `https://api-staging.bankx.com/v1` |
| Production | `config/env/production.json` | `https://api.bankx.com/v1` |

### Load environment

```bash
# Prints dart-define flags
./scripts/load_env.sh development

# Use with flutter run
flutter run $(./scripts/load_env.sh development)
```

### Local secret overrides

Copy `config/env/.env.example` → `config/env/.env.local` (gitignored).

Full reference: [ENVIRONMENT.md](ENVIRONMENT.md)

### Firebase (optional)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Set `FIREBASE_CONFIGURED=true` in staging/production JSON. Platform files are gitignored:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

---

## Running Locally

### Development mode

```bash
flutter run $(./scripts/load_env.sh development)
```

### Hot reload

Press `r` in terminal for hot reload, `R` for hot restart.

### Run on specific device

```bash
flutter devices
flutter run -d <device_id> $(./scripts/load_env.sh development)
```

### Run with verbose logging

```bash
flutter run $(./scripts/load_env.sh development) --verbose
```

HTTP logging is enabled in debug builds via `LoggerInterceptor`.

---

## Code Generation

After modifying Freezed models or JSON serializable classes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch mode during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from analyzer.

---

## Building

### Android

```bash
# Debug APK
flutter build apk --debug $(./scripts/load_env.sh development)

# Release APK
./scripts/ci_build.sh android-apk staging

# Play Store App Bundle
./scripts/ci_build.sh android-aab production
```

**Release signing:** Copy `android/key.properties.example` → `android/key.properties` and place keystore at `android/app/upload-keystore.jks`.

### iOS

```bash
# Simulator
flutter run $(./scripts/load_env.sh development)

# Release IPA
./scripts/ci_build.sh ios production
```

Requires Apple Developer account, distribution certificate, and provisioning profile. See `ios/ExportOptions.plist`.

### Build outputs

| Target | Output path |
|--------|-------------|
| APK | `build/app/outputs/flutter-apk/app-release.apk` |
| AAB | `build/app/outputs/bundle/release/app-release.aab` |
| IPA | `build/ios/ipa/*.ipa` |

---

## Releasing

### Automated (CI)

Push to `main` triggers the Release workflow:
1. Version bump (`scripts/bump_version.sh`)
2. Changelog generation
3. Android APK + AAB + iOS IPA
4. GitHub Release with artifacts

### Manual beta (Firebase App Distribution)

GitHub Actions → **Firebase App Distribution** → select environment and platform.

### Store submission

See [DEPLOYMENT.md](DEPLOYMENT.md) and [RELEASE_CHECKLIST.md](RELEASE_CHECKLIST.md).

---

## Testing

```bash
# All unit, bloc, widget, performance tests
flutter test --coverage test/

# Coverage threshold (90% on lib/)
bash scripts/check_coverage.sh 90 lib/

# Integration tests
flutter test integration_test/

# Single test file
flutter test test/bloc/auth_bloc_test.dart
```

Full strategy: [TESTING.md](TESTING.md)

---

## Common Troubleshooting

### `flutter pub get` fails

```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### Build runner conflicts

```bash
dart run build_runner build --delete-conflicting-outputs
```

### iOS pod install fails

```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
```

### Android Gradle errors

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

Ensure JDK 17 is active: `java -version`

### Analyzer errors after pull

```bash
dart run build_runner build --delete-conflicting-outputs
dart format lib test integration_test
flutter analyze
```

### Firebase not initializing

- Verify `FIREBASE_CONFIGURED=true` in environment JSON
- Confirm `google-services.json` and `GoogleService-Info.plist` exist locally
- Run `flutterfire configure` again

### Token refresh loop / 401 errors

- Clear secure storage: uninstall app or clear app data
- Verify backend `/auth/refresh` endpoint is reachable
- Check `BANKX_API_BASE_URL` points to correct environment

### Offline transfers not syncing

- Confirm `BANKX_ENABLE_OFFLINE_SYNC=true`
- Check connectivity with `ConnectivityService`
- Inspect Hive transfer queue box via debug logs

### Coverage check fails in CI

```bash
flutter test --coverage test/
bash scripts/check_coverage.sh 90 lib/
# Open coverage/lcov.info to find uncovered lines
```

### Secret scan fails

```bash
./scripts/check_secrets.sh
# Remove or gitignore any matched files
```

---

## Related Documentation

| Document | Topic |
|----------|-------|
| [ARCHITECTURE.md](ARCHITECTURE.md) | System design |
| [API.md](API.md) | REST endpoints |
| [ENVIRONMENT.md](ENVIRONMENT.md) | dart-define variables |
| [CICD.md](CICD.md) | GitHub Actions |
| [DEPLOYMENT.md](DEPLOYMENT.md) | Store deployment |
| [BRANCHING.md](BRANCHING.md) | Git workflow |
