#!/bin/bash

set -e # Exit immediately if any command fails

# Helper function for custom error handling
handle_error() {
  echo "$1" # Print the custom error message
  exit 1    # Exit with status 1
}

# Check if $1 is set
if [ -z "$1" ]; then
  handle_error "Usage: ./patch.sh path/to/jars/"
fi

for file in "$1"/*; do
  echo $file
  zip -d "$file" "org/sqlite/native/*" ||
    echo -e "Failed to delete libraries for $file, might be incorrect file or already patched.\n" \
      "Patching is only needed for Distant Horizons v2.0≥"
  zip -r "$file" "org/sqlite/native/" || handle_error "Failed to add android libraries $file"

done
