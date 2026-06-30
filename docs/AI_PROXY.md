# BankX AI Proxy

Production-safe way to call OpenAI from BankX **without embedding API keys in the mobile app**.

## Why

- OpenAI keys in APK/IPA can be extracted
- Proxy adds auth, rate limits, logging, and model control server-side
- BankX `HttpAiProvider` already speaks OpenAI-compatible `/v1/chat/completions`

## Quick start (local)

```bash
cd tools/ai-proxy
npm install
export OPENAI_API_KEY=sk-...
export PROXY_API_KEY=bankx-dev-proxy-key   # optional
npm start
```

Health check:

```bash
curl http://localhost:8787/health
```

## Connect BankX app

Use **staging/production** env with custom HTTP provider (not direct `openai`):

```json
{
  "BANKX_AI_PROVIDER": "http",
  "BANKX_AI_API_URL": "http://localhost:8787/v1",
  "BANKX_AI_API_KEY": "bankx-dev-proxy-key",
  "BANKX_AI_MODEL": "gpt-4o-mini"
}
```

Run:

```bash
flutter run \
  --dart-define-from-file=config/env/staging.json \
  --dart-define=BANKX_AI_API_URL=http://10.0.2.2:8787/v1 \
  --dart-define=BANKX_AI_API_KEY=bankx-dev-proxy-key \
  --dart-define=BANKX_AI_PROVIDER=http
```

> Android emulator: use `10.0.2.2` instead of `localhost`.

## Deploy (Cloud Run)

```bash
chmod +x scripts/deploy_ai_proxy.sh
export GCP_PROJECT_ID=bankx-app-c0958
export OPENAI_API_KEY=sk-...
export PROXY_API_KEY=your-proxy-secret
./scripts/deploy_ai_proxy.sh
```

Uses `tools/ai-proxy/Dockerfile` and deploys to region `me-central1` by default.

## Deploy (Railway)

```bash
cd tools/ai-proxy
railway up
```

Set env vars in Railway dashboard: `OPENAI_API_KEY`, `PROXY_API_KEY`, `OPENAI_MODEL`.

Set env vars in Railway dashboard: `OPENAI_API_KEY`, `PROXY_API_KEY`, `OPENAI_MODEL`.

## Certificate pinning (mobile)

After deploying your proxy, print the TLS pin:

```bash
chmod +x scripts/print_ai_cert_pin.sh
./scripts/print_ai_cert_pin.sh your-service.run.app
```

Enable in production build:

```json
{
  "BANKX_AI_CERT_PIN_ENABLED": "true",
  "BANKX_AI_CERT_PINS": "<sha256-from-script>"
}
```

## Deploy (Cloud Run / Railway / VPS)

1. Set secrets: `OPENAI_API_KEY`, `PROXY_API_KEY`
2. Expose port `8787` (or `PORT` env)
3. Point `BANKX_AI_API_URL` to `https://your-proxy.example.com/v1`
4. Store `BANKX_AI_API_KEY` (= `PROXY_API_KEY`) in GitHub Secrets for CI builds

## Security checklist

- [ ] Enable `PROXY_API_KEY` in production
- [ ] HTTPS only (TLS termination at load balancer)
- [ ] Per-user rate limiting (add middleware)
- [ ] Audit log of prompts (redact PII)
- [ ] Never commit real OpenAI keys to git

## Related

- [AI.md](AI.md) — provider architecture
- [ENVIRONMENT.md](ENVIRONMENT.md) — dart-define config
