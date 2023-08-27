#!/bin/bash

# Define variables
REPO="DryMergeInc/cli"
LATEST_RELEASE=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep "tag_name" | awk -F '"' '{print $4}')
DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_RELEASE/drycli"  # Replace 'drycli' with your actual artifact name

# Download latest release
echo "Downloading latest release: $LATEST_RELEASE..."
curl -L -o drycli $DOWNLOAD_URL

# Make it executable
chmod +x drycli

# Move it to /usr/local/bin or any other directory in $PATH
sudo mv drycli /usr/local/bin/

echo "drycli installed successfully."

