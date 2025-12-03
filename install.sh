#!/bin/bash

################################################################################
# Dotfiles Bootstrap Installer
# One-command setup for macOS development environment
################################################################################

set -e

DOTFILES_REPO="https://github.com/Mizune/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "=========================================="
echo "Dotfiles Bootstrap Installer"
echo "=========================================="
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only."
    exit 1
fi

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Installing Xcode Command Line Tools..."
    xcode-select --install
    echo ""
    echo "Please complete the Xcode Command Line Tools installation,"
    echo "then re-run this script."
    exit 1
fi

# Clone or update dotfiles repository
if [ -d "$DOTFILES_DIR" ]; then
    echo "✓ Dotfiles directory already exists at $DOTFILES_DIR"
    read -p "Update from remote? (y/n): " update_repo
    if [[ "$update_repo" == "y" ]]; then
        echo "Updating dotfiles repository..."
        cd "$DOTFILES_DIR"
        git pull origin main || git pull origin master
        echo "✓ Repository updated"
    fi
else
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    echo "✓ Repository cloned to $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
echo ""

# Make scripts executable
chmod +x setup.sh set_dotfiles.sh

# Run setup.sh
echo "=========================================="
echo "Running setup.sh..."
echo "=========================================="
echo ""
./setup.sh

echo ""
echo "=========================================="
echo "Bootstrap Complete!"
echo "=========================================="
echo ""
echo "Your development environment is ready!"
echo "Please restart your terminal or run: source ~/.zshrc"
