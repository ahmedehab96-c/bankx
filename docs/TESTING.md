# BankX Testing Guide

Production-grade test infrastructure for the BankX digital banking app.

## Structure

```
test/
├── helpers/           # Fixtures, mocks, pump utilities
├── unit/
│   ├── repositories/  # Repository impl tests (mocked data sources)
│   ├── usecases/      # Use case delegation tests
│   └── services/      # Core utilities, codecs, network resources
├── bloc/              # Bloc state-machine tests (all features)
├── widget/            # Screen rendering, forms, localization
└── performance/       # Latency and memory smoke benchmarks

integration_test/      # End-to-end banking flows (mocked use cases)
```

## Running Tests

```bash
# All unit, bloc, widget, and performance tests
flutter test

# With coverage report
flutter test --coverage

# Integration flows
flutter test integration_test/

# Performance benchmarks only
flutter test test/performance/
```

## Coverage Goals

| Layer        | Target | Config                          |
|--------------|--------|---------------------------------|
| Unit (lib/)  | 90%+   | `scripts/check_coverage.sh 90`  |
| Widget       | 80%+   | `test/widget/` screen tests     |

CI runs coverage checks on every push/PR via `.github/workflows/ci.yml`.

## Test Categories

### Unit Tests — Repositories

Each repository test mocks `RemoteDataSource`, `LocalDataSource`, and `NetworkInfo`:

- **Why**: Validates cache-first / offline-fallback logic without HTTP.
- **Files**: `test/unit/repositories/repositories_test.dart`

### Unit Tests — Use Cases

Thin delegation tests ensure use cases forward params to repositories:

- **Why**: Catches signature drift between domain and data layers.
- **Files**: `test/unit/usecases/usecases_test.dart`

### Bloc Tests

Every bloc is tested for initial, loading, success, failure, network, timeout, unauthorized, and validation scenarios.

**Files**: `test/bloc/auth_bloc_test.dart`, `test/bloc/banking_blocs_test.dart`, `test/bloc/security_bloc_test.dart`

### Widget Tests

Screens tested with mocked blocs: Login, Register, Dashboard, Transfer, Cards, QR Payment, Notifications, Profile, Settings.

**File**: `test/widget/screens_widget_test.dart`

### Integration Tests

Critical journeys: login/logout, transfer, bill pay, QR, card freeze, change password, notifications, offline mode.

**File**: `integration_test/app_flow_test.dart`

### Performance Tests

**File**: `test/performance/performance_test.dart`

## Mock Services

| Helper | Purpose |
|--------|---------|
| `mock_definitions.dart` | Repository & data source mocks |
| `bloc_mocks.dart` | Use case mocks + failure fixtures |
| `test_fixtures.dart` | Canonical domain entities |
| `fake_api_responses.dart` | DTO payloads |
| `FakeCacheStorage` | In-memory offline transfer queue |
| `MemorySecureStorage` | In-memory secure storage |

## DI Reset

`resetDependencies()` in `lib/core/di/injection.dart` resets GetIt between integration runs.
