# Contributing to BankX

Thank you for your interest in contributing to BankX! This guide explains how to get started.

## Before You Start

1. Read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
2. Check existing [issues](https://github.com/ahmedehab96-c/bankx/issues) and [pull requests](https://github.com/ahmedehab96-c/bankx/pulls)
3. For large changes, open an issue first to discuss the approach

## Development Setup

```bash
git clone https://github.com/ahmedehab96-c/bankx.git
cd bankx
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run $(./scripts/load_env.sh development)
```

Full guide: [docs/DEVELOPER_GUIDE.md](docs/DEVELOPER_GUIDE.md)

## Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready releases |
| `develop` | Integration branch |
| `feature/*` | New features |
| `release/*` | Release stabilization |
| `hotfix/*` | Urgent production fixes |

Naming: `feature/BANKX-123-short-description`

Details: [docs/BRANCHING.md](docs/BRANCHING.md)

## Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add biometric auto-login on splash
fix: resolve session timeout on background
test: add transfer bloc edge cases
docs: update API reference
ci: add dependency audit step
refactor: extract network error mapper
```

## Pull Request Process

1. Branch from `develop` (or `main` for hotfixes)
2. Keep PRs focused — one feature or fix per PR
3. Run quality checks locally:

```bash
dart format lib test integration_test
flutter analyze --fatal-infos --fatal-warnings
flutter test --coverage test/
bash scripts/check_coverage.sh 90 lib/
./scripts/check_secrets.sh
```

4. Fill out the PR template completely
5. Ensure CI passes before requesting review
6. Squash or rebase if requested by maintainers

## Code Standards

- Follow existing architecture: `data` / `domain` / `presentation` per feature
- No business logic in widgets — use BLoCs and use cases
- Use `Either<Failure, T>` for repository results
- Add tests for new use cases, repositories, and BLoCs
- Do not commit secrets, keystores, or Firebase config files
- Match existing naming, import order, and formatting

## Testing Requirements

| Change type | Required tests |
|-------------|----------------|
| Use case | Unit test |
| Repository | Unit test with mocked data sources |
| BLoC | `bloc_test` |
| Screen | Widget test for critical flows |
| Bug fix | Regression test |

## Documentation

Update relevant docs when you change:

- Public API endpoints → `docs/API.md`
- Architecture decisions → `docs/ARCHITECTURE.md`
- Setup steps → `docs/DEVELOPER_GUIDE.md`
- New features → `docs/FEATURES.md` and `README.md`

## Questions?

Open a [Discussion](https://github.com/ahmedehab96-c/bankx/discussions) or issue.
