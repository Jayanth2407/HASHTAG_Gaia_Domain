#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Try: sudo $0"
    exit 1
fi

# Function to check if a package is installed
is_installed() {
    dpkg -s "$1" &>/dev/null
}

# Fix Google Chrome GPG key issue
if ! test -f /etc/apt/trusted.gpg.d/google-chrome.asc; then
    echo "Adding Google Chrome GPG key..."
    wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google-chrome.asc
else
    echo "Google Chrome GPG key already exists, skipping."
fi

# Update and upgrade base system
echo "Running full system update and upgrade..."
apt update && apt upgrade -y

# Install additional base packages
echo "Installing essential utilities..."
apt install pciutils lsof curl nvtop btop jq -y

# Update package lists again (just in case)
echo "Updating package list..."
apt update -q

# Show upgradable packages
echo "Checking for upgradable packages..."
UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." || true)

if [ -z "$UPGRADABLE" ]; then
    echo "All packages are up to date. Skipping upgrade."
else
    echo "Upgradable packages found:"
    echo "$UPGRADABLE"
    echo "Upgrading packages..."
    apt upgrade -y
fi

# Install required packages only if not already installed
REQUIRED_PACKAGES=(nvtop sudo curl htop systemd fonts-noto-color-emoji jq coreutils pciutils lsof btop)
ALL_INSTALLED=true

for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! is_installed "$pkg"; then
        echo "Installing $pkg..."
        apt install -y "$pkg"
        ALL_INSTALLED=false
    else
        echo "$pkg is already installed, skipping."
    fi
done

if $ALL_INSTALLED; then
    echo "All required packages are already installed. Skipping installation."
fi

# Install NVIDIA CUDA Toolkit 12.8
if ! dpkg -s cuda-toolkit-12-8 &>/dev/null; then
    echo "Installing CUDA Toolkit 12.8..."
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
    dpkg -i cuda-keyring_1.1-1_all.deb
    apt-get update
    apt-get -y install cuda-toolkit-12-8
else
    echo "CUDA Toolkit 12.8 is already installed, skipping."
fi
