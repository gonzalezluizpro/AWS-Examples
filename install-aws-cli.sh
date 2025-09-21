#!/bin/bash
set -e

echo "=== Updating system and installing dependencies ==="
sudo apt update && sudo apt install -y unzip curl

echo "=== Downloading AWS CLI v2 ==="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "=== Extracting package ==="
unzip -o awscliv2.zip

echo "=== Installing AWS CLI v2 ==="
sudo ./aws/install --update

echo "=== Cleaning up ==="
rm -rf aws awscliv2.zip

echo "=== Configuring environment variables ==="
# Enable AWS CLI auto prompt (partial mode)
echo 'export AWS_CLI_AUTO_PROMPT=on-partial' >> ~/.bashrc
# Force English output
echo 'export LC_ALL=en_US.UTF-8' >> ~/.bashrc
echo 'export LANG=en_US.UTF-8' >> ~/.bashrc

# Reload bashrc
source ~/.bashrc

echo "=== Installation complete ==="
aws --version
