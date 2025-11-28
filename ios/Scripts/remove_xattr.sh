#!/bin/bash
# Remove extended attributes from Flutter framework before code signing

set -e

FLUTTER_FRAMEWORK="${BUILT_PRODUCTS_DIR}/Flutter.framework"

if [ -d "$FLUTTER_FRAMEWORK" ]; then
    echo "Removing extended attributes from Flutter.framework..."
    xattr -cr "$FLUTTER_FRAMEWORK" 2>/dev/null || true
    echo "Extended attributes removed successfully"
fi
