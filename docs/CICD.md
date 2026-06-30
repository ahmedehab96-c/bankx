# BankX CI/CD Pipeline

Enterprise-grade continuous integration and delivery for the BankX digital banking application.

## Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| [`pr.yml`](../.github/workflows/pr.yml) | Pull Request → `main` / `develop` | Quality gates, tests, coverage |
| [`release.yml`](../.github/workflows/release.yml) | Push to `main`, manual | APK, AAB, IPA, GitHub Release |
| [`firebase-distribution.yml`](../.github/workflows/firebase-distribution.yml) | Manual | Beta builds to Firebase App Distribution |

## Pull Request pipeline

Every PR runs:

1. **Secret scan** — `scripts/check_secrets.sh`
2. **Format check** — `dart format --set-exit-if-changed`
3. **Analyze** — `flutter analyze --fatal-infos --fatal-warnings`
4. **DCM** — optional `dcm analyze` (see `metrics.yaml`)
5. **Tests** — unit, bloc, widget, performance
6. **Coverage** — 90% threshold on `lib/`
7. **Integration tests** — `integration_test/`

PR fails if any step fails.

## Release pipeline

On push to `main`:

1. Auto version bump (`scripts/bump_version.sh`) using `GITHUB_RUN_NUMBER`
2. Changelog generation (`scripts/generate_changelog.sh`)
3. Android APK + AAB (signed when secrets present)
4. iOS IPA (macOS runner)
5. GitHub Release with artifacts

## Caching strategy

| Cache | Key |
|-------|-----|
| Flutter SDK | `subosito/flutter-action` with `cache: true` |
| Pub packages | `~/.pub-cache` + `.dart_tool` hashed by `pubspec.lock` |
| Gradle | `~/.gradle` hashed by gradle files |

## Environment builds

```bash
# Development
flutter run $(./scripts/load_env.sh development)

# Staging release APK
./scripts/ci_build.sh android-apk staging

# Production App Bundle
./scripts/ci_build.sh android-aab production
```

Configuration files: `config/env/{development,staging,production}.json`

## Code quality

- **flutter_lints** via strict `analysis_options.yaml`
- **dart_code_metrics** via `metrics.yaml` + DCM CLI (optional in CI)
- CI enforces zero warnings and zero infos

```bash
dart format .
flutter analyze --fatal-infos --fatal-warnings
dcm analyze lib   # requires DCM CLI
```

## Required GitHub Secrets

| Secret | Purpose |
|--------|---------|
| `ANDROID_KEYSTORE_BASE64` | Release keystore (base64) |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_ALIAS` | Key alias |
| `ANDROID_KEY_PASSWORD` | Key password |
| `IOS_P12_BASE64` | Distribution certificate |
| `IOS_P12_PASSWORD` | Certificate password |
| `GOOGLE_SERVICES_JSON_BASE64` | `google-services.json` (base64) for CI builds |
| `GOOGLE_SERVICE_INFO_PLIST_BASE64` | `GoogleService-Info.plist` (base64) for CI builds |
| `FIREBASE_TOKEN` | Firebase CI token |
| `FIREBASE_APP_ID_ANDROID` | Firebase Android app ID |
| `FIREBASE_APP_ID_IOS` | Firebase iOS app ID |
| `CODECOV_TOKEN` | Coverage upload (optional) |

## Repository variables

| Variable | Purpose |
|----------|---------|
| `FIREBASE_TESTER_GROUPS` | Comma-separated tester groups (default: `qa-testers`) |

## Dependabot

Weekly updates for pub, GitHub Actions, and Gradle — see `.github/dependabot.yml`.
