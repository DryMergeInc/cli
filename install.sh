#!/bin/bash

# Define variables
REPO="DryMergeInc/cli"
LATEST_RELEASE=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep "tag_name" | awk -F '"' '{print $4}')
DOWNLOAD_FILE="drycli.zip"
EXECUTABLE_NAME="drycli_exec"

# Detect the operating system
OS=$(uname)

if [ "$OS" == "Darwin" ]; then
  # macOS
  DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_RELEASE/graphapi_null_x86_64-apple-darwin.zip"
  ARTIFACT_NAME="graphapi_null_x86_64-apple-darwin.zip"
  echo "Detected macOS. Downloading latest release: $LATEST_RELEASE..."
elif [ "$OS" == "Linux" ]; then
  # Linux
  DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_RELEASE/graphapi_null_x86_64-unknown-linux-musl.tar.gz"
  ARTIFACT_NAME="graphapi_null_x86_64-unknown-linux-musl.tar.gz"
  echo "Detected Linux. Downloading latest release: $LATEST_RELEASE..."
else
  echo "Unsupported OS. Exiting."
  exit 1
fi

# Download latest release
curl -L -o $DOWNLOAD_FILE $DOWNLOAD_URL

# Unzip the downloaded file
echo "Unzipping downloaded file..."
if [ "$OS" == "Darwin" ]; then
  unzip $DOWNLOAD_FILE -d $EXECUTABLE_NAME
elif [ "$OS" == "Linux" ]; then
  tar -xzf $DOWNLOAD_FILE
  mv drycli $EXECUTABLE_NAME
fi

# Make it executable
chmod +x $EXECUTABLE_NAME/drycli

# Move it to /usr/local/bin or any other directory in $PATH
sudo mv $EXECUTABLE_NAME/drycli /usr/local/bin/dry

echo "$EXECUTABLE_NAME installed successfully."
rm $DOWNLOAD_FILE
rm -r $EXECUTABLE_NAME
