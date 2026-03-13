#!/bin/bash
set -e

echo "🔍 Running pre-deployment checks..."
echo ""

# 1. Check git status
if [[ -n $(git status -s) ]]; then
  echo "⚠️  Warning: Uncommitted changes detected"
  git status -s
  echo ""
  read -p "Continue anyway? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Pre-deployment checks cancelled"
    exit 1
  fi
fi

# 2. Build production and check
echo ""
echo "📦 Building production site..."
JEKYLL_ENV=production bundle exec jekyll build

# 4. Check for large files
echo ""
echo "📊 Checking for large files (>1MB)..."
LARGE_FILES=$(find _site -type f -size +1M 2>/dev/null || true)
if [ -n "$LARGE_FILES" ]; then
  echo "$LARGE_FILES" | while read file; do
    SIZE=$(du -h "$file" | cut -f1)
    echo "  $file: $SIZE"
  done
else
  echo "  No large files found"
fi

echo ""
echo "✅ Pre-deployment checks passed!"
echo "📁 Ready to deploy from: _site/"
