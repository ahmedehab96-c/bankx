# BankX Branching Strategy

GitFlow-inspired workflow for enterprise banking releases.

## Branches

```
main          ← production-ready, tagged releases
develop       ← integration branch for next release
feature/*     ← new features
release/*     ← release stabilization
hotfix/*      ← urgent production fixes
```

## Branch rules

| Branch | Merges from | Merges to | CI |
|--------|-------------|-----------|-----|
| `main` | `release/*`, `hotfix/*` | — | Release + deploy |
| `develop` | `feature/*` | `release/*` | PR checks |
| `feature/*` | — | `develop` | PR checks |
| `release/*` | `develop` | `main`, `develop` | PR + manual QA |
| `hotfix/*` | `main` | `main`, `develop` | PR + expedited release |

## Naming conventions

```
feature/BANKX-123-biometric-login
feature/BANKX-456-transfer-receipt-pdf
release/1.2.0
hotfix/BANKX-789-session-timeout
```

Format: `{type}/BANKX-{ticket}-{short-description}`

## Feature workflow

```bash
git checkout develop
git pull
git checkout -b feature/BANKX-101-qr-receipt
# ... commits with conventional commits ...
git push -u origin feature/BANKX-101-qr-receipt
# Open PR → develop
```

## Release workflow

```bash
git checkout develop
git checkout -b release/1.3.0
# Version bump, changelog, QA fixes only
git push -u origin release/1.3.0
# PR → main (triggers release build)
# PR → develop (back-merge)
git tag v1.3.0
```

## Hotfix workflow

```bash
git checkout main
git checkout -b hotfix/BANKX-200-auth-crash
# Minimal fix only
git push -u origin hotfix/BANKX-200-auth-crash
# PR → main (expedited release)
# PR → develop
```

## Commit message format

```
feat: add biometric auto-login on splash
fix: resolve session timeout on background
chore: bump dio to 5.8.0
docs: update deployment guide
ci: add Firebase distribution workflow
```

## Protected branches

Configure in GitHub → Settings → Branches:

- **main**: require PR, require status checks (`quality`, `test`, `integration`), no direct push
- **develop**: require PR, require status checks

## Version tags

Releases are tagged automatically: `v{major}.{minor}.{patch}+{build}`

Example: `v1.2.3+142`
