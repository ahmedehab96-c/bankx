# BankX Release Checklist

Use before every production release and public GitHub launch.

## Code quality gate

- [ ] `flutter analyze --fatal-infos --fatal-warnings` — zero issues
- [ ] `dart format --set-exit-if-changed lib test integration_test` — passes
- [ ] `flutter test` — all tests pass (currently 83/87 — fix 4 failures)
- [ ] `bash scripts/check_coverage.sh 90 lib/` — coverage threshold met
- [ ] `dart pub audit` — no unresolved vulnerabilities
- [ ] `./scripts/check_secrets.sh` — no secrets in repository
- [ ] No `debugPrint` / `print()` in production code paths (Firebase bootstrap excepted)
- [ ] No `TODO` / `FIXME` / `HACK` comments in `lib/`
- [ ] No unused imports or dead code in active feature modules
- [ ] Legacy orphan directories removed or documented

## Pre-release

- [ ] All PR checks green on `release/*` branch
- [ ] QA sign-off on staging build (Firebase App Distribution)
- [ ] Security review completed (banking compliance)
- [ ] `CHANGELOG.md` updated
- [ ] Version bumped in `pubspec.yaml`
- [ ] `config/env/production.json` API URL verified
- [ ] Firebase Crashlytics enabled for production
- [ ] No secrets in repository (`./scripts/check_secrets.sh`)

## Open source & portfolio readiness

- [ ] `README.md` — badges, features, screenshots, install guide complete
- [ ] `LICENSE` — MIT with banking disclaimer
- [ ] `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` present
- [ ] GitHub issue and PR templates configured
- [ ] Screenshots captured per [SCREENSHOTS.md](SCREENSHOTS.md) (min. 6 for README)
- [ ] Demo GIF recorded per [DEMO_VIDEO_STORYBOARD.md](DEMO_VIDEO_STORYBOARD.md)
- [ ] `docs/assets/logo.png` added
- [x] Placeholder `your-username` replaced with `ahmedehabmohammed`
- [ ] Portfolio content reviewed ([PORTFOLIO.md](PORTFOLIO.md))

## Assets & signing

- [ ] App icon and splash assets optimized (no oversized PNGs)
- [ ] `flutter build apk --analyze-size` — review APK breakdown
- [ ] Android release keystore configured (`key.properties` + `.jks`)
- [ ] iOS distribution certificate and provisioning profile valid
- [ ] `ios/ExportOptions.plist` profile name matches Apple Developer portal
- [ ] ProGuard/R8 rules verified (`android/app/proguard-rules.pro`)

## Build verification

- [ ] Android APK installs and launches
- [ ] Android AAB uploaded to Play Console internal track
- [ ] iOS IPA installs via TestFlight
- [ ] App size within acceptable limits (`flutter build apk --analyze-size`)

## Functional smoke test

- [ ] Login / logout / session timeout
- [ ] Dashboard loads with real API
- [ ] Money transfer end-to-end
- [ ] Bill payment
- [ ] QR payment scan & receive
- [ ] Card freeze / unfreeze
- [ ] Push notification received
- [ ] Offline mode → sync on reconnect
- [ ] PDF statement generation
- [ ] Biometric login
- [ ] Arabic / English localization
- [ ] Dark / light theme

## Store submission

- [ ] Play Store: privacy policy URL, data safety form
- [ ] App Store: export compliance, banking category
- [ ] Screenshots and descriptions updated
- [ ] Release notes published

## Post-release

- [ ] Monitor Crashlytics for 24 hours
- [ ] Monitor API error rates
- [ ] Confirm analytics events firing
- [ ] Tag release in GitHub (`v*`)
- [ ] Back-merge `main` → `develop` if hotfix
- [ ] Notify stakeholders

## Rollback criteria

Initiate rollback if any of:

- Crash rate > 1% in first hour
- Authentication failure rate spike
- Payment / transfer failures
- Regulatory or security incident

## Emergency contacts

| Role | Action |
|------|--------|
| Release engineer | Trigger rollback in Play Console / App Store |
| Backend team | API circuit breaker / feature flags |
| Security | Incident response per bank policy |
