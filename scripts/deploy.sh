#!/bin/bash

# SherlockLiu Blog Deployment Script
# Builds the site and pushes _site contents to deploy branch

set -e  # Exit on error

# Load environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: .env file not found!"
    echo "Please copy .env.example to .env and configure your credentials"
    exit 1
fi

source "$ENV_FILE"

echo "🚀 Starting SherlockLiu Blog deployment..."

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "⚠️  Not on main branch. Skipping deployment."
    exit 0
fi

echo "📦 Building Tailwind CSS..."
npm run tw:build

echo "📦 Building Jekyll site..."
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
bundle exec jekyll build

if [ ! -d "_site" ]; then
    echo "❌ Error: _site directory not found!"
    exit 1
fi

echo "🌿 Preparing deploy branch..."

# Save current _site state
echo "Creating temporary copy of _site..."
TEMP_SITE=$(mktemp -d)
cp -R _site/* "$TEMP_SITE/" 2>/dev/null || true

# Create deploy branch if it doesn't exist
if ! git show-ref --verify --quiet refs/heads/deploy; then
    echo "Creating deploy branch (orphan)..."
    git checkout --orphan deploy
    git rm -rf . 2>/dev/null || true
else
    # Switch to deploy branch
    git checkout deploy
fi

# Clean deploy branch
echo "📁 Cleaning deploy branch..."
git rm -rf . 2>/dev/null || true
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name '..' -exec rm -rf {} + 2>/dev/null || true

# Copy _site contents from temp location
echo "📁 Copying site files to deploy branch..."
cp -R "$TEMP_SITE"/* . 2>/dev/null || true

# Clean up temp
rm -rf "$TEMP_SITE"

echo "📝 Committing changes to deploy branch..."
git add -A

if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "✨ No changes to deploy"
else
    COMMIT_MSG="Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MSG"
    
    echo "⬆️  Pushing to deploy branch..."
    git push origin deploy
    
    echo "✅ Deployment successful!"
fi

echo "🔙 Switching back to main branch..."
git checkout main
# Force reset to ensure clean state
git reset --hard HEAD 2>/dev/null || true

echo "🎉 Deployment complete! Deploy branch updated."
echo ""
echo "Next steps:"
echo "1. Configure Hostinger to pull from 'deploy' branch"
echo "2. Or use: make deploy"
