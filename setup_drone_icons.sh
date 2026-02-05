#!/bin/bash

# Configuration
SOURCE_IMAGE="/Users/kurok/.gemini/antigravity/brain/20aa5895-7585-4877-8a67-594e5d283444/drone_app_icon_1770123288959.png"
PROJECT_ROOT="/Users/kurok/StudioProjects/drone1"

# Create assets directory if it doesn't exist
mkdir -p "$PROJECT_ROOT/assets/icon"

# Copy images
if [ -f "$SOURCE_IMAGE" ]; then
    cp "$SOURCE_IMAGE" "$PROJECT_ROOT/assets/icon/drone_icon.png"
    cp "$SOURCE_IMAGE" "$PROJECT_ROOT/assets/drone_icon.png"
    echo "Successfully copied drone icon images to assets."
else
    echo "Error: Source image not found at $SOURCE_IMAGE"
    exit 1
fi

# Run flutter launcher icons update (optional, usually requires build env)
# flutter pub run flutter_launcher_icons
echo "Done. Please run 'flutter pub get' and then run the app."
