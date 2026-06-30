/**
 * BankX AI Proxy — keeps OpenAI API keys off mobile devices.
 *
 * Env:
 *   OPENAI_API_KEY  — required
 *   PORT            — default 8787
 *   PROXY_API_KEY   — optional client auth (Bearer token)
 *   OPENAI_MODEL    — default gpt-4o-mini
 */

const express = require('express');

const app = express();
app.use(express.json({ limit: '1mb' }));

const PORT = Number(process.env.PORT || 8787);
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;
const PROXY_API_KEY = process.env.PROXY_API_KEY;
const DEFAULT_MODEL = process.env.OPENAI_MODEL || 'gpt-4o-mini';

if (!OPENAI_API_KEY) {
  console.error('Missing OPENAI_API_KEY');
  process.exit(1);
}

function auth(req, res, next) {
  if (!PROXY_API_KEY) return next();
  const header = req.headers.authorization || '';
  const token = header.startsWith('Bearer ') ? header.slice(7) : '';
  if (token !== PROXY_API_KEY) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  next();
}

app.get('/health', (_req, res) => {
  res.json({ status: 'ok', service: 'bankx-ai-proxy' });
});

app.post('/v1/chat/completions', auth, async (req, res) => {
  try {
    const body = {
      model: req.body.model || DEFAULT_MODEL,
      messages: req.body.messages || [],
      max_tokens: req.body.max_tokens,
      stream: Boolean(req.body.stream),
    };

    const upstream = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify(body),
    });

    if (body.stream) {
      res.status(upstream.status);
      res.setHeader('Content-Type', 'text/event-stream');
      res.setHeader('Cache-Control', 'no-cache');
      res.setHeader('Connection', 'keep-alive');
      const reader = upstream.body.getReader();
      const decoder = new TextDecoder();
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;
        res.write(decoder.decode(value));
      }
      return res.end();
    }

    const json = await upstream.json();
    res.status(upstream.status).json(json);
  } catch (err) {
    res.status(502).json({ error: err.message || 'Upstream error' });
  }
});

app.listen(PORT, () => {
  console.log(`BankX AI proxy listening on http://localhost:${PORT}`);
});
