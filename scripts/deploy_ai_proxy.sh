#!/usr/bin/env bash
# Deploy BankX AI proxy to Google Cloud Run.
# Prerequisites: gcloud CLI, OPENAI_API_KEY, PROXY_API_KEY
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROXY_DIR="$ROOT/tools/ai-proxy"

PROJECT_ID="${GCP_PROJECT_ID:-}"
REGION="${GCP_REGION:-me-central1}"
SERVICE_NAME="${AI_PROXY_SERVICE:-bankx-ai-proxy}"
IMAGE="gcr.io/${PROJECT_ID}/${SERVICE_NAME}"

if [[ -z "$PROJECT_ID" ]]; then
  echo "Set GCP_PROJECT_ID (Firebase project: bankx-app-c0958)" >&2
  exit 1
fi
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "Set OPENAI_API_KEY" >&2
  exit 1
fi

echo "Building image $IMAGE..."
gcloud builds submit "$PROXY_DIR" --tag "$IMAGE" --project "$PROJECT_ID"

echo "Deploying to Cloud Run..."
gcloud run deploy "$SERVICE_NAME" \
  --image "$IMAGE" \
  --platform managed \
  --region "$REGION" \
  --project "$PROJECT_ID" \
  --allow-unauthenticated \
  --set-env-vars "OPENAI_API_KEY=${OPENAI_API_KEY},PROXY_API_KEY=${PROXY_API_KEY:-},OPENAI_MODEL=${OPENAI_MODEL:-gpt-4o-mini}" \
  --port 8080 \
  --memory 256Mi \
  --min-instances 0 \
  --max-instances 3

URL=$(gcloud run services describe "$SERVICE_NAME" \
  --platform managed \
  --region "$REGION" \
  --project "$PROJECT_ID" \
  --format 'value(status.url)')

echo ""
echo "Deployed: ${URL}/health"
echo "Set in BankX:"
echo "  BANKX_AI_API_URL=${URL}/v1"
echo "  BANKX_AI_API_KEY=<PROXY_API_KEY>"
echo "  BANKX_AI_PROVIDER=http"
