# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x.x   | ✅ Active |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

If you discover a security issue in BankX:

1. Email **security@bankx.dev** (replace with your contact) with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

2. We will acknowledge within **48 hours** and provide an initial assessment within **7 days**.

3. Please allow time for a fix before public disclosure. We follow coordinated disclosure.

## Scope

In scope:

- Authentication and session management flaws
- Insecure data storage (tokens, PINs, PII)
- Network interception or certificate pinning bypass
- Injection vulnerabilities in API handling
- Secrets committed to the repository

Out of scope:

- Social engineering attacks
- Denial of service against demo backends
- Issues in third-party dependencies (report upstream; we track via Dependabot)
- Missing features that are documented as portfolio/demo limitations

## Security Practices in BankX

| Area | Implementation |
|------|----------------|
| Token storage | `flutter_secure_storage` (Keychain / EncryptedSharedPreferences) |
| Session | Auto-logout, JWT expiry tracking, silent refresh |
| Network | HTTPS only, typed error mapping, retry with backoff |
| Device | Root/jailbreak detection, screenshot protection on sensitive screens |
| Secrets | GitHub Secrets in CI, `check_secrets.sh` in pipeline |
| Dependencies | `dart pub audit` in PR workflow, Dependabot weekly |

## Responsible Disclosure

We appreciate responsible disclosure and will credit researchers in release notes (with permission).

## Disclaimer

BankX is a portfolio showcase. It is not a licensed financial product. Do not deploy for real banking without independent security audits and regulatory compliance.
