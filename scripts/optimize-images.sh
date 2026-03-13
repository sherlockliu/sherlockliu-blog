#!/bin/bash

# Image Optimization Script
# Automatically optimizes images for web using ImageMagick
# Reduces file size by 70-90% with minimal quality loss

# Don't exit on error - we want to process all images even if one fails
set +e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
QUALITY=85                    # JPEG quality (85 is a good balance)
MAX_WIDTH=2000               # Max width for images
BACKUP_DIR="assets/images/.backups"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo -e "${RED}❌ Error: ImageMagick not found!${NC}"
    echo "Install it with: brew install imagemagick"
    exit 1
fi

# Use 'magick' command if available (ImageMagick 7+), otherwise 'convert'
if command -v magick &> /dev/null; then
    MAGICK_CMD="magick"
else
    MAGICK_CMD="convert"
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to optimize a single image
optimize_image() {
    local file="$1"
    local original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)

    # Skip if already optimized (< 500KB)
    if [ "$original_size" -lt 512000 ]; then
        echo -e "${BLUE}⏭  Skipping (already small): $file${NC}"
        return
    fi

    # Create backup
    local backup_file="$BACKUP_DIR/$(basename "$file").backup"
    cp "$file" "$backup_file" 2>/dev/null || true

    # Get file extension
    local ext="${file##*.}"
    local ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

    # Optimize based on file type
    if [[ "$ext_lower" == "png" ]]; then
        # PNG: Convert to high-quality JPEG (better compression)
        local temp_file="${file%.png}.jpg.tmp"
        $MAGICK_CMD "$file" \
            -strip \
            -resize "${MAX_WIDTH}x${MAX_WIDTH}>" \
            -quality $QUALITY \
            -interlace Plane \
            "$temp_file"

        # Replace .png with .jpg
        local new_file="${file%.png}.jpeg"
        mv "$temp_file" "$new_file"
        rm "$file"
        file="$new_file"

    elif [[ "$ext_lower" == "jpg" ]] || [[ "$ext_lower" == "jpeg" ]]; then
        # JPEG: Optimize in place
        local temp_file="${file}.tmp"
        $MAGICK_CMD "$file" \
            -strip \
            -resize "${MAX_WIDTH}x${MAX_WIDTH}>" \
            -quality $QUALITY \
            -interlace Plane \
            "$temp_file"
        mv "$temp_file" "$file"
    else
        echo -e "${YELLOW}⚠  Unsupported format: $file${NC}"
        return
    fi

    local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    local saved=$((original_size - new_size))
    local percent=$((saved * 100 / original_size))

    # Format sizes
    local orig_mb=$(awk "BEGIN {printf \"%.2f\", $original_size / 1048576}")
    local new_mb=$(awk "BEGIN {printf \"%.2f\", $new_size / 1048576}")

    echo -e "${GREEN}✓ Optimized: $file${NC}"
    echo -e "  ${orig_mb}MB → ${new_mb}MB (saved ${percent}%)"
}

# Main execution
echo -e "${BLUE}🖼  Image Optimization Tool${NC}"
echo ""

if [ $# -eq 0 ]; then
    # No arguments: optimize all post images
    echo "Optimizing all images in assets/images/posts/..."
    echo ""

    total_before=0
    total_after=0
    count=0

    while IFS= read -r -d '' file; do
        original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        total_before=$((total_before + original_size))

        optimize_image "$file"

        new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        total_after=$((total_after + new_size))
        count=$((count + 1))

    done < <(find assets/images/posts -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0)

    # Summary
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Summary${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "Images processed: $count"

    if [ "$total_before" -gt 0 ]; then
        total_saved=$((total_before - total_after))
        total_percent=$((total_saved * 100 / total_before))
        before_mb=$(awk "BEGIN {printf \"%.2f\", $total_before / 1048576}")
        after_mb=$(awk "BEGIN {printf \"%.2f\", $total_after / 1048576}")
        saved_mb=$(awk "BEGIN {printf \"%.2f\", $total_saved / 1048576}")

        echo "Total size: ${before_mb}MB → ${after_mb}MB"
        echo "Total saved: ${saved_mb}MB (${total_percent}%)"
    fi

    echo ""
    echo -e "${BLUE}💡 Backups saved to: $BACKUP_DIR${NC}"

else
    # Arguments provided: optimize specific files
    for file in "$@"; do
        if [ -f "$file" ]; then
            optimize_image "$file"
        else
            echo -e "${RED}❌ File not found: $file${NC}"
        fi
    done
fi

echo ""
echo -e "${GREEN}✅ Optimization complete!${NC}"
