# BankX — Portfolio Presentation

Professional content for portfolio websites, LinkedIn, resumes, and client demonstrations.

---

## Project Overview

**BankX** is a production-grade digital banking application built with Flutter, demonstrating enterprise mobile engineering practices suitable for regulated fintech environments. It implements Clean Architecture with feature-first modules, comprehensive security controls, offline-capable transfers, and full CI/CD automation.

**Role:** Lead / Senior Flutter Engineer  
**Duration:** [Your timeline]  
**Platform:** iOS & Android  
**Status:** Production-ready showcase

---

## Problem Statement

Mobile banking applications must balance three competing demands:

1. **Security** — JWT sessions, biometric auth, device integrity, and data protection for financial PII
2. **Reliability** — Offline access, graceful degradation, and queued operations when connectivity is lost
3. **Maintainability** — Large codebases that multiple engineers can work on without merge conflicts or architectural drift

Most portfolio Flutter projects demonstrate UI only. BankX addresses all three demands with patterns used in real enterprise teams.

---

## Solution

BankX implements a **feature-first Clean Architecture** where each banking capability (auth, transfers, cards, payments) is an isolated module with its own data, domain, and presentation layers. Cross-cutting infrastructure (networking, security, caching, Firebase) lives in a shared `core/` layer injected via GetIt.

Key engineering decisions:

- **BLoC + Either** for predictable state and typed error handling
- **NetworkBoundResource** for cache-first reads with remote refresh
- **Offline transfer queue** with automatic sync on reconnect
- **JWT silent refresh** via dedicated AuthRefreshClient
- **90% test coverage** target with unit, bloc, widget, and integration tests
- **GitHub Actions CI/CD** with release signing, Firebase distribution, and store-ready builds

---

## Technologies Used

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.x, Dart 3.10+ |
| Architecture | Clean Architecture, Feature-first modules |
| State Management | flutter_bloc, equatable |
| DI | GetIt |
| Networking | Dio, connectivity_plus |
| Storage | Hive, flutter_secure_storage |
| Auth | JWT, local_auth (biometrics) |
| Navigation | GoRouter, StatefulShellRoute |
| Serialization | Freezed, json_serializable |
| Functional | dartz (Either) |
| Firebase | Analytics, Crashlytics, FCM |
| QR | mobile_scanner, qr_flutter |
| PDF | pdf, printing, share_plus |
| Charts | fl_chart |
| Testing | bloc_test, mocktail, integration_test |
| CI/CD | GitHub Actions, Firebase App Distribution |
| Localization | EN / AR with RTL |

---

## Architecture

```
Presentation (BLoC + Pages)
        ↓
Domain (Use Cases + Repository Interfaces)
        ↓
Data (Repository Impl + Remote/Local DataSources)
        ↓
Core (ApiClient, Hive, Security, Firebase)
```

Each of 11 feature modules follows this pattern independently. Shared REST client (`BankingApiService`) serves all features through typed DTOs.

**Diagram:** See [ARCHITECTURE.md](ARCHITECTURE.md) for Mermaid diagrams.

---

## Key Features

| Feature | Engineering highlight |
|---------|----------------------|
| JWT Authentication | Silent refresh, secure token storage, session timeout |
| Money Transfers | Offline queue, beneficiary management, receipt PDF |
| QR Payments | Custom codec, scanner integration, receive flow |
| Card Management | Freeze/unfreeze with optimistic UI updates |
| Bill Payments | Typed API with validation error mapping |
| Dashboard Analytics | fl_chart integration with cached data |
| Push Notifications | FCM + local notifications + deep link routing |
| Biometric Security | local_auth with PIN fallback |
| Device Protection | Root detection, screenshot block, privacy overlay |
| PDF Statements | Server-quality PDF generation client-side |
| Localization | Full Arabic RTL with gen-l10n |
| Accessibility | Text scaling, high contrast, semantics |

---

## Challenges

### 1. Token refresh without interceptor recursion

**Problem:** Dio interceptors that call the refresh endpoint on the same client cause infinite loops.

**Solution:** Separate `AuthRefreshClient` with its own Dio instance, no interceptors attached.

### 2. Offline transfers with data consistency

**Problem:** Users expect to initiate transfers without connectivity, but server must eventually confirm.

**Solution:** Hive-persisted transfer queue processed by `OfflineSyncService` on connectivity restore, with UI feedback for queued vs completed states.

### 3. Testable architecture at scale

**Problem:** 11 feature modules with shared DI makes unit testing fragile.

**Solution:** `resetDependencies()` for test isolation, mocktail mocks per layer, `bloc_test` for state machine verification, 90% coverage gate in CI.

### 4. Performance on startup

**Problem:** Eager initialization of settings, offline sync, and session on cold start caused jank.

**Solution:** `StartupScheduler` defers non-critical init; lazy tab loading in shell; `BlocSelector` to minimize rebuilds.

---

## Performance Optimizations

| Optimization | Impact |
|-------------|--------|
| Deferred startup (StartupScheduler) | Faster time-to-interactive |
| Lazy shell tab loading | Reduced initial widget tree |
| BlocSelector + BlocBuildWhen | Fewer unnecessary rebuilds |
| CachedNetworkImage with memCache | Lower memory for avatars |
| Hive TTL cache | Fewer API calls, instant offline reads |
| Debug-only Dio logger | Zero logging overhead in release |
| ProGuard/R8 (Android) | Smaller APK, obfuscated release builds |

Details: [PERFORMANCE.md](PERFORMANCE.md)

---

## Testing

| Layer | Count | Tools |
|-------|-------|-------|
| Unit (repositories, use cases, services) | ~47 | mocktail |
| BLoC | ~23 | bloc_test |
| Widget | ~12 | flutter_test |
| Performance | 4 | flutter_test |
| Integration | 8 | integration_test |
| **Total** | **~94** | |

CI enforces 90% line coverage on `lib/` via `scripts/check_coverage.sh`.

Details: [TESTING.md](TESTING.md)

---

## Future Improvements

| Area | Enhancement |
|------|-------------|
| Backend | Open-source mock server or OpenAPI spec for self-hosted demo |
| Security | Certificate pinning, hardware security module integration |
| Testing | Golden tests for UI regression, patrol E2E |
| Features | Scheduled transfers, multi-currency wallets, spending budgets |
| Architecture | Extract features into melos monorepo packages |
| Observability | OpenTelemetry tracing, Sentry integration |
| Accessibility | WCAG 2.1 AA audit, voice navigation |
| Store | Published demo on TestFlight and Play Store internal track |

---

## Links

| Resource | URL |
|----------|-----|
| GitHub | `https://github.com/ahmedehab96-c/bankx` |
| Live Demo | [Add TestFlight / APK link] |
| Architecture | [ARCHITECTURE.md](ARCHITECTURE.md) |
| API Docs | [API.md](API.md) |

---

## Elevator Pitch (30 seconds)

> "I built BankX, a production-grade Flutter banking app with Clean Architecture, offline transfers, JWT auth with silent refresh, QR payments, and 90% test coverage. It has full CI/CD with signed Android and iOS releases, Firebase distribution, and enterprise security — biometric login, session timeout, and device integrity checks. It's designed to show how a senior Flutter team would structure a regulated fintech product."

## Elevator Pitch (60 seconds)

> "BankX demonstrates enterprise Flutter engineering for digital banking. I used feature-first Clean Architecture with BLoC state management across 11 modules — auth, transfers, cards, QR payments, and more. The networking layer handles JWT silent refresh without interceptor recursion, and transfers work offline via a Hive queue that syncs automatically. Security includes biometrics, PIN lock, root detection, and screenshot protection. I wrote 94 tests with a 90% coverage gate in CI, and set up GitHub Actions for PR quality checks, release builds, and Firebase beta distribution. The app supports English and Arabic with Material 3 theming. It's portfolio-ready and structured for technical interviews."
