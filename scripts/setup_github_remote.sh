#!/usr/bin/env bash
# Creates GitHub repo and pushes main branch.
# Usage: ./scripts/setup_github_remote.sh [public|private]

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

VISIBILITY="${1:-public}"
REPO_NAME="bankx"

if ! command -v gh &>/dev/null; then
  echo "GitHub CLI (gh) is required." >&2
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Run: gh auth login" >&2
  exit 1
fi

ACCOUNT=$(gh api user -q .login)
REMOTE="git@github.com:${ACCOUNT}/${REPO_NAME}.git"

echo "==> Account: $ACCOUNT"
echo "==> Repo: $REPO_NAME ($VISIBILITY)"

if git remote get-url origin &>/dev/null; then
  echo "Remote origin already set: $(git remote get-url origin)"
else
  if gh repo view "${ACCOUNT}/${REPO_NAME}" &>/dev/null; then
    echo "Repository exists — adding remote origin"
    git remote add origin "$REMOTE"
  else
    gh repo create "$REPO_NAME" \
      --"$VISIBILITY" \
      --source=. \
      --remote=origin \
      --description "BankX — Premium Digital Banking App (Flutter)"
  fi
fi

git push -u origin main
echo ""
echo "Done: https://github.com/${ACCOUNT}/${REPO_NAME}"
