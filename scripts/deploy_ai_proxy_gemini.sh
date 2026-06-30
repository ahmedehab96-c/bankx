#!/usr/bin/env bash
# Deploy BankX AI proxy to Cloud Run (Gemini via OpenAI-compatible API).
# Uses mezo-food-app-a0710 (billing enabled). Secrets stay in GCP Secret Manager.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROXY_DIR="$ROOT/tools/ai-proxy"

PROJECT_ID="${GCP_PROJECT_ID:-mezo-food-app-a0710}"
GEMINI_PROJECT_ID="${GEMINI_PROJECT_ID:-gen-lang-client-0323117991}"
GEMINI_KEY_ID="${GEMINI_KEY_ID:-177ea471-01d1-44bc-ac92-0453d1997529}"
REGION="${GCP_REGION:-us-central1}"
SERVICE_NAME="${AI_PROXY_SERVICE:-bankx-ai-proxy}"
IMAGE="gcr.io/${PROJECT_ID}/${SERVICE_NAME}"
GEMINI_SECRET="bankx-gemini-api-key"
PROXY_SECRET="bankx-proxy-api-key"

echo "Enabling APIs on ${PROJECT_ID}..."
gcloud services enable run.googleapis.com cloudbuild.googleapis.com secretmanager.googleapis.com \
  --project "$PROJECT_ID" --quiet

if ! gcloud secrets describe "$GEMINI_SECRET" --project "$PROJECT_ID" &>/dev/null; then
  echo "Creating Gemini API secret..."
  gcloud services api-keys get-key-string "$GEMINI_KEY_ID" \
    --project "$GEMINI_PROJECT_ID" \
    --format='value(keyString)' \
    | gcloud secrets create "$GEMINI_SECRET" --data-file=- --project "$PROJECT_ID" --quiet
else
  echo "Gemini secret already exists."
fi

if ! gcloud secrets describe "$PROXY_SECRET" --project "$PROJECT_ID" &>/dev/null; then
  echo "Creating proxy auth secret..."
  openssl rand -hex 32 | gcloud secrets create "$PROXY_SECRET" --data-file=- --project "$PROJECT_ID" --quiet
else
  echo "Proxy auth secret already exists."
fi

PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format='value(projectNumber)')
RUN_SA="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"

for SECRET in "$GEMINI_SECRET" "$PROXY_SECRET"; do
  gcloud secrets add-iam-policy-binding "$SECRET" \
    --project "$PROJECT_ID" \
    --member="serviceAccount:${RUN_SA}" \
    --role="roles/secretmanager.secretAccessor" \
    --quiet >/dev/null
done

echo "Building image ${IMAGE}..."
gcloud builds submit "$PROXY_DIR" --tag "$IMAGE" --project "$PROJECT_ID" --quiet

echo "Deploying Cloud Run service ${SERVICE_NAME}..."
gcloud run deploy "$SERVICE_NAME" \
  --image "$IMAGE" \
  --platform managed \
  --region "$REGION" \
  --project "$PROJECT_ID" \
  --allow-unauthenticated \
  --set-secrets "GEMINI_API_KEY=${GEMINI_SECRET}:latest,PROXY_API_KEY=${PROXY_SECRET}:latest" \
  --set-env-vars "AI_PROVIDER=gemini,OPENAI_MODEL=gemini-2.0-flash" \
  --port 8080 \
  --memory 256Mi \
  --min-instances 0 \
  --max-instances 3 \
  --quiet

URL=$(gcloud run services describe "$SERVICE_NAME" \
  --platform managed \
  --region "$REGION" \
  --project "$PROJECT_ID" \
  --format 'value(status.url)')

echo ""
echo "Deployed: ${URL}/health"
echo ""
echo "BankX config (set BANKX_AI_API_KEY from Secret Manager, do not commit):"
echo "  gcloud secrets versions access latest --secret=${PROXY_SECRET} --project=${PROJECT_ID}"
echo ""
echo "  BANKX_AI_PROVIDER=http"
echo "  BANKX_AI_API_URL=${URL}/v1"
echo "  BANKX_AI_MODEL=gemini-2.0-flash"
