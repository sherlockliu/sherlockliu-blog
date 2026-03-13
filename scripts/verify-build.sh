#!/bin/bash
set -e

echo "🏗️  Testing Jekyll build..."
JEKYLL_ENV=production bundle exec jekyll build

echo "🔍 Verifying critical files..."
test -f _site/index.html || (echo "❌ Missing index.html" && exit 1)
test -f _site/feed.xml || (echo "❌ Missing feed.xml" && exit 1)
test -f _site/sitemap.xml || (echo "❌ Missing sitemap.xml" && exit 1)
test -f _site/robots.txt || (echo "❌ Missing robots.txt" && exit 1)
test -d _site/blog || (echo "❌ Missing /blog/ directory" && exit 1)
test -f _site/blog/index.html || (echo "❌ Missing /blog/index.html" && exit 1)

echo "📊 Counting blog posts..."
# Count HTML files in date-based directory structure (e.g., /engineering/2026/03/07/*.html)
POST_COUNT=$(find _site -type f -regex ".*/[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]/.*\.html" 2>/dev/null | wc -l | xargs)
echo "Found $POST_COUNT blog post pages"

if [ "$POST_COUNT" -lt 1 ]; then
  echo "⚠️  Warning: No blog posts found"
fi

echo "📁 Build size:"
du -sh _site

echo "✅ Build verification passed!"
