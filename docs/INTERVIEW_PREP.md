# BankX Interview Preparation

Top interview questions about BankX with suggested answers. Use these to explain technical decisions confidently.

---

## Architecture Questions

### Q1: Why did you choose Clean Architecture for a Flutter app?

**Answer:** Clean Architecture enforces dependency inversion — the domain layer has zero framework dependencies. This means business rules (transfer validation, session policies) are testable without Flutter bindings. In a banking app where correctness matters, I can unit test every use case in isolation. The feature-first folder structure adds team scalability: engineers can own the `transfer/` module without conflicting with `cards/`.

### Q2: Why feature-first instead of layer-first (all blocs together, all repos together)?

**Answer:** Layer-first works for small apps but creates merge conflicts and unclear ownership at scale. Feature-first co-locates everything a feature needs — if I'm fixing a transfer bug, all related files are in `features/transfer/`. It also makes it possible to extract a feature into a standalone package later, which layer-first makes nearly impossible.

### Q3: Explain the data flow when a user submits a transfer.

**Answer:**
1. `TransferMoneyPage` dispatches `SubmitTransfer` event to `TransferBloc`
2. Bloc sets `RequestStatus.loading` and calls `SubmitTransferUseCase`
3. Use case calls `TransferRepository.submitTransfer()`
4. Repository checks `NetworkInfo.isConnected`
5. If online: `RemoteDataSource` → `BankingApiService.post('/transfers')` → `ApiClient` (Dio with JWT interceptor)
6. If offline: persist to Hive transfer queue, return success with queued flag
7. Repository returns `Either<Failure, void>`
8. Bloc emits success or failure state
9. UI shows confirmation or error via `BlocListener`

### Q4: What is the Repository Pattern and why use it?

**Answer:** The repository abstracts data sources from the domain layer. `TransferRepository` might fetch from API, cache, or offline queue — the use case doesn't know or care. This lets me swap a mock API for integration tests, add caching without touching BLoCs, and implement offline queueing transparently.

### Q5: Why GetIt instead of Riverpod or Injectable for DI?

**Answer:** GetIt is a pure service locator with zero code generation for registration — I can see the entire dependency graph in `injection.dart`. For a banking app with 11 feature modules, explicit registration is easier to audit than generated graphs. I use `factory` for BLoCs (new instance per screen) and `lazySingleton` for services. `resetDependencies()` enables clean test isolation.

---

## State Management Questions

### Q6: Why BLoC over Riverpod, Provider, or MobX?

**Answer:** BLoC enforces unidirectional data flow with explicit events and states — valuable for audit trails in financial apps. `bloc_test` makes state transitions testable as a state machine. `BlocSelector` and `BlocBuildWhen` give fine-grained rebuild control for performance. The team's familiarity and the predictability of event → state mapping made BLoC the right choice.

### Q7: How do you handle errors in BLoCs?

**Answer:** Repositories return `Either<Failure, T>` using dartz. Use cases pass this through unchanged. BLoCs pattern-match: `result.fold((failure) => emit(state.copyWith(status: failure, message: failure.message)), (data) => emit(state.copyWith(status: success, data: data)))`. Failures are typed (`NetworkFailure`, `ValidationFailure`, `UnauthorizedFailure`) — never raw exceptions in the UI layer.

### Q8: How does auth state affect navigation?

**Answer:** `GoRouter` has a `redirect` callback that checks `AuthBloc` state. `RouterRefreshNotifier` extends `ChangeNotifier` and calls `notifyListeners()` when auth changes, triggering router rebuild. Public routes (login, register) redirect to home if authenticated; protected routes redirect to login if not.

---

## Networking Questions

### Q9: How does JWT silent refresh work?

**Answer:** `TokenInterceptor` attaches the access token to every request. On 401, it calls `AuthRefreshClient` — a separate Dio instance without interceptors — to POST `/auth/refresh` with the refresh token. On success, it stores new tokens in secure storage and retries the original request. If refresh fails, it clears tokens and triggers logout. The separate client prevents infinite interceptor recursion.

### Q10: How do you map HTTP errors to user-friendly messages?

**Answer:** `ErrorInterceptor` catches `DioException` and delegates to `ApiErrorMapper`. Status codes map to typed exceptions: 401 → `UnauthorizedException`, 422 → `ValidationException`, etc. Repositories catch these and return `Failure` subclasses. The API error body is parsed for `message` or `error` fields. BLoCs display the failure message; sensitive server details never reach the UI.

### Q11: What is NetworkBoundResource?

**Answer:** It's a pattern for read operations: emit cached data first (if TTL valid), then fetch remote, update cache on success, fall back to cache on network error. This gives instant UI with stale-while-revalidate behavior — critical for banking where users expect to see their balance immediately even on slow networks.

---

## Security Questions

### Q12: How are tokens stored securely?

**Answer:** Access and refresh tokens are stored via `flutter_secure_storage`, which uses iOS Keychain and Android EncryptedSharedPreferences. Tokens are never in Hive, SharedPreferences, or logs. `TokenExpirationManager` tracks JWT expiry proactively.

### Q13: What security measures beyond authentication?

**Answer:**
- **Biometric login** via `local_auth` with PIN fallback
- **Session timeout** — `SessionManager` auto-logouts after inactivity
- **Screenshot protection** on card and PIN screens via `screen_protector`
- **Privacy overlay** when app is backgrounded (`AppLifecycleGuard`)
- **Root/jailbreak detection** via `safe_device`
- **Secure clipboard** — auto-clears copied account numbers
- **ProGuard/R8** obfuscation in Android release builds

### Q14: How do you prevent secrets from being committed?

**Answer:** `.gitignore` excludes keystores, `key.properties`, Firebase configs, and `.env.local`. `scripts/check_secrets.sh` runs in CI with regex patterns for private keys, API keys, and tokens. GitHub Secrets store signing credentials for release builds.

---

## Offline & Storage Questions

### Q15: How does offline mode work?

**Answer:** Reads use `NetworkBoundResource` — Hive cache with per-key TTL. If the network fails, cached data is served. Writes (transfers) use `RemoteResource` — if offline, the transfer is serialized to a Hive queue. `OfflineSyncService` listens to connectivity changes and replays queued transfers when online. The UI shows a queued indicator so users know the transfer is pending, not lost.

### Q16: Why Hive over SQLite or Isar?

**Answer:** Hive is lightweight, fast for key-value caching, and requires no SQL boilerplate for simple DTO caching. Banking API responses map naturally to typed boxes. For complex relational queries I'd consider Isar or Drift, but cache + queue patterns fit Hive well with minimal overhead.

---

## Testing Questions

### Q17: How do you test BLoCs?

**Answer:** `bloc_test` package. I define `seed` state, `act` (dispatch event), and `expect` (emitted states). Dependencies are mocked with mocktail. Example: `auth_bloc_test.dart` tests login success, login failure, logout, and session restore — verifying the exact state sequence.

### Q18: How do you achieve 90% coverage?

**Answer:** CI runs `flutter test --coverage` then `scripts/check_coverage.sh 90 lib/` which parses `lcov.info` and fails below threshold. I focus coverage on domain and data layers (highest ROI). Generated files and `main.dart` are excluded. Widget tests cover critical screens; integration tests cover end-to-end flows.

---

## Performance Questions

### Q19: What performance optimizations did you implement?

**Answer:**
- `StartupScheduler` defers settings, offline sync, and session init past first frame
- Lazy loading of shell tabs (only build active tab)
- `BlocSelector` instead of `BlocBuilder` where only partial state matters
- `CachedNetworkImage` with `memCacheWidth/Height` limits
- Debug-only HTTP logging (no overhead in release)
- Hive `purgeExpired()` on startup to limit disk usage

### Q20: How would you profile a slow screen?

**Answer:** Flutter DevTools Performance tab → record timeline while interacting. Check for excessive rebuilds (fix with `BlocSelector`), expensive `build()` methods (extract const widgets), and jank from synchronous I/O on main isolate (move to compute or defer). Network tab in DevTools for slow API calls.

---

## CI/CD Questions

### Q21: Describe your CI/CD pipeline.

**Answer:** Three GitHub Actions workflows:
1. **PR** — secret scan, format, analyze (fatal warnings), `dart pub audit`, unit/bloc/widget tests, 90% coverage, integration tests
2. **Release** (push to main) — version bump, changelog, signed Android APK/AAB, iOS IPA, GitHub Release
3. **Firebase Distribution** — manual beta deploy to tester groups

Caching: Flutter SDK, pub cache, Gradle. Secrets: keystores, Firebase tokens via GitHub Secrets.

---

## Behavioral Questions

### Q22: What was the hardest technical problem?

**Answer:** JWT silent refresh without interceptor recursion. The first implementation used the same Dio client for refresh, causing infinite 401 loops. I solved it by extracting `AuthRefreshClient` with a bare Dio instance. This is a common pitfall in Dio-based apps that interviewers appreciate hearing about with a concrete solution.

### Q23: What would you do differently?

**Answer:** I'd add an OpenAPI spec and mock server so contributors can run the full app without a backend. I'd extract features into a melos monorepo for even better isolation. I'd add golden tests for UI regression and certificate pinning for production security.

### Q24: How does this project demonstrate senior-level engineering?

**Answer:** It's not just UI — it has layered architecture, typed error handling, offline queueing, security hardening, 94 tests with coverage gates, CI/CD with signed releases, environment separation, and documentation that a team could onboard from. Every technical decision has a traceable reason.

---

## Quick-Fire Technical Decisions

| Decision | Choice | Why |
|----------|--------|-----|
| Architecture | Clean + feature-first | Testability, team scalability |
| State | BLoC | Predictable, testable state machine |
| DI | GetIt | Explicit, auditable registration |
| HTTP | Dio | Interceptors, typed responses |
| Errors | Either + Failure | No exceptions in domain |
| Cache | Hive + TTL | Fast, simple, offline reads |
| Secure storage | flutter_secure_storage | Platform keychain |
| Navigation | GoRouter | Declarative, deep links, shell routes |
| Serialization | Freezed | Immutable DTOs, copyWith, equality |
| CI | GitHub Actions | Integrated, cached, free for OSS |
