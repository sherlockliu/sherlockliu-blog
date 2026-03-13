#!/bin/bash
set -e

echo "🧹 Cleaning previous build..."
rm -rf _site

echo "🖼️  Optimizing images..."
if [ -f "scripts/optimize-images.sh" ]; then
    ./scripts/optimize-images.sh || echo "⚠️  Image optimization skipped (ImageMagick not installed?)"
else
    echo "⚠️  Image optimization script not found, skipping..."
fi

echo "🏗️  Building Jekyll site in production mode..."
JEKYLL_ENV=production bundle exec jekyll build

echo "🗑️  Removing development files from _site..."
# Remove source maps
find _site -name "*.css.map" -delete
find _site -name "*.js.map" -delete

# Remove unnecessary root files (if Jekyll copied them)
rm -f _site/Gemfile
rm -f _site/Gemfile.lock
rm -f _site/package.json
rm -f _site/package-lock.json
rm -f _site/tailwind.config.js
rm -f _site/.DS_Store
rm -f Makefile

echo "📊 Build size:"
du -sh _site

echo "✅ Production build complete!"
echo "📁 Output: _site/"
