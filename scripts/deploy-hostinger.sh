#!/bin/bash
set -e

# Load environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: .env file not found!"
    echo "Please copy .env.example to .env and configure your credentials"
    exit 1
fi

source "$ENV_FILE"

echo "🚀 Deploying to Hostinger..."

# Build production site
echo "📦 Building production site..."
JEKYLL_ENV=production bundle exec jekyll build

# Sync to Hostinger (dry run first)
echo ""
echo "📋 Dry run - checking what will be deployed..."
rsync -avz --delete --dry-run \
  _site/ \
  $HOSTINGER_SSH_ALIAS:$HOSTINGER_PATH

# Confirm before actual deploy
echo ""
read -p "🤔 Proceed with deployment? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "📤 Deploying..."
  rsync -avz --delete \
    _site/ \
    $HOSTINGER_SSH_ALIAS:$HOSTINGER_PATH

  echo ""
  echo "✅ Deployment complete!"
  echo "🌐 Visit: $SITE_URL"
else
  echo "❌ Deployment cancelled"
  exit 1
fi
