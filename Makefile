.PHONY: help install build run serve clean build-prod verify deploy optimize-images install-image-tools

# Default target
help:
	@echo "Available commands:"
	@echo "  make install          - Install dependencies"
	@echo "  make build            - Build the site"
	@echo "  make run              - Build and serve locally (alias: serve)"
	@echo "  make serve            - Build and serve locally with auto-reload"
	@echo "  make clean            - Clean build artifacts"
	@echo "  make build-prod       - Build for production"
	@echo "  make verify           - Verify build integrity"
	@echo "  make deploy           - Deploy to Hostinger (production)"
	@echo ""
	@echo "Image optimization:"
	@echo "  make optimize-images                    - Optimize all post images"
	@echo "  make optimize-images PATH=<path>        - Optimize images in specific folder"
	@echo "  make optimize-images FILE=<file.png>    - Optimize a single image"
	@echo "  make install-image-tools                - Install pngquant & optipng"

# Install dependencies
install:
	bundle install

# Build the site
build:
	bundle exec jekyll build

# Build and serve locally
run: serve

# Serve with auto-reload
serve:
	bundle exec jekyll serve --livereload

# Clean build artifacts
clean:
	bundle exec jekyll clean
	rm -rf _site

# Production build
build-prod:
	./scripts/build-production.sh

# Verify build
verify:
	./scripts/verify-build.sh

# Deploy to Hostinger
deploy:
	./scripts/deploy-hostinger.sh

# Install image optimization tools
install-image-tools:
	@echo "Installing image optimization tools..."
	@command -v pngquant >/dev/null 2>&1 || brew install pngquant
	@command -v optipng >/dev/null 2>&1 || brew install optipng
	@echo "✓ Image tools installed"

# Optimize images (compress PNGs)
# Usage: 
#   make optimize-images                          # Optimize all post images
#   make optimize-images PATH=assets/images       # Optimize all images
#   make optimize-images PATH=assets/images/posts/2026-03-10-*  # Specific folder
#   make optimize-images FILE=path/to/image.png   # Single file
optimize-images:
	@if [ -n "$(FILE)" ]; then \
		echo "Optimizing single file: $(FILE)"; \
		mkdir -p assets/images/.originals; \
		cp "$(FILE)" "assets/images/.originals/$$(basename $(FILE)).backup" 2>/dev/null || true; \
		convert "$(FILE)" -quality 85 -strip "$(FILE).tmp" && mv "$(FILE).tmp" "$(FILE)"; \
		echo "✓ Optimized $(FILE)"; \
		ls -lh "$(FILE)"; \
	else \
		TARGET=$${PATH:-assets/images/posts}; \
		echo "Optimizing PNG images in $$TARGET..."; \
		echo "Creating backups in assets/images/.originals/..."; \
		mkdir -p assets/images/.originals; \
		find $$TARGET -name "*.png" -type f | while read img; do \
			echo "Processing: $$img"; \
			cp "$$img" "assets/images/.originals/$$(basename $$img).backup" 2>/dev/null || true; \
			convert "$$img" -quality 85 -strip "$$img.tmp" && mv "$$img.tmp" "$$img"; \
		done; \
		echo "✓ Image optimization complete"; \
		echo "Total size of $$TARGET:"; \
		du -sh $$TARGET; \
	fi
