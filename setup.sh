#!/bin/bash

################################################################################
# macOS Development Environment Setup Script
# Unified version combining all installed packages + additional useful apps
# Last updated: 2025-12-03
################################################################################

# Arrays to track installation failures
FAILED_FORMULAE=()
FAILED_CASKS=()

echo "=========================================="
echo "macOS Development Environment Setup"
echo "=========================================="
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only."
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

################################################################################
# 1. Install Xcode Command Line Tools
################################################################################
echo "Step 1: Installing Xcode Command Line Tools..."
if ! command_exists xcode-select; then
    xcode-select --install
    echo "Please complete Xcode Command Line Tools installation and re-run this script."
    exit 1
else
    echo "✓ Xcode Command Line Tools already installed"
fi
echo ""

################################################################################
# 2. Install Homebrew
################################################################################
echo "Step 2: Installing Homebrew..."
if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✓ Homebrew already installed"
fi

# Update Homebrew
brew update
echo ""

################################################################################
# 3. Install Homebrew Formulae (CLI tools and libraries)
################################################################################
echo "Step 3: Installing Homebrew Formulae..."

FORMULAE=(
    aom
    apr
    apr-util
    argon2
    aribb24
    autoconf
    berkeley-db
    berkeley-db@5
    brotli
    c-ares
    ca-certificates
    cairo
    cjson
    composer
    curl
    cyrus-sasl
    dav1d
    docker
    docker-completion
    docker-compose
    ffmpeg
    flac
    fontconfig
    fprobe
    freetds
    freetype
    frei0r
    fribidi
    gcc
    gd
    gdbm
    gettext
    gh
    giflib
    git
    git-lfs
    glib
    gmp
    gnutls
    gradle
    graphite2
    harfbuzz
    highway
    icu4c@77
    imath
    isl
    jpeg-turbo
    jpeg-xl
    krb5
    lame
    leptonica
    libarchive
    libass
    libavif
    libb2
    libbluray
    libdeflate
    libevent
    libidn2
    libmicrohttpd
    libmpc
    libnghttp2
    libnghttp3
    libngtcp2
    libogg
    libpng
    libpq
    librist
    libsamplerate
    libsndfile
    libsodium
    libsoxr
    libssh
    libssh2
    libtasn1
    libtiff
    libtool
    libudfread
    libunibreak
    libunistring
    libuv
    libvidstab
    libvmaf
    libvorbis
    libvpx
    libx11
    libxau
    libxcb
    libxdmcp
    libxext
    libxrender
    libyaml
    libzip
    little-cms2
    lua
    lz4
    lzo
    m4
    make
    mas
    mbedtls
    mkcert
    mpdecimal
    mpfr
    mpg123
    ncurses
    net-snmp
    nettle
    node
    nodebrew
    oniguruma
    opencore-amr
    openexr
    openjdk
    openjpeg
    openjph
    openldap
    openssl@1.1
    openssl@3
    opus
    p11-kit
    pango
    pcre
    pcre2
    perl
    php
    pixman
    pkg-config
    pkgconf
    pyenv
    pyenv-virtualenv
    pyenv-virtualenvwrapper
    python@3.10
    python@3.12
    rav1e
    readline
    ripgrep
    rtmpdump
    rubberband
    ruby
    sdl2
    snappy
    speex
    sqlite
    srt
    stripe
    svt-av1
    tesseract
    theora
    tidy-html5
    tmux
    unbound
    unixodbc
    utf8proc
    vim
    webp
    x264
    x265
    xorgproto
    xvid
    xz
    zeromq
    zimg
    zsh
    zstd
)

for formula in "${FORMULAE[@]}"; do
    if brew list --formula | grep -q "^${formula}$"; then
        echo "✓ $formula already installed"
    else
        echo "Installing $formula..."
        if ! brew install "$formula" 2>&1; then
            echo "✗ Failed to install $formula"
            FAILED_FORMULAE+=("$formula")
        fi
    fi
done
echo ""

################################################################################
# 4. Install Homebrew Casks (GUI Applications)
################################################################################
echo "Step 4: Installing Homebrew Casks..."

CASKS=(
    alacritty
    alfred
    claude-code
    codex
    dbeaver-community
    discord
    fork
    gcloud-cli
    google-chrome
    google-cloud-sdk
    google-japanese-ime
    jetbrains-toolbox
    rancher
    slack
    warp
    visual-studio-code
    xbar
    zed
    zoom
)

for cask in "${CASKS[@]}"; do
    if brew list --cask | grep -q "^${cask}$"; then
        echo "✓ $cask already installed"
    else
        echo "Installing $cask..."
        if ! brew install --cask "$cask" 2>&1; then
            echo "✗ Failed to install $cask"
            FAILED_CASKS+=("$cask")
        fi
    fi
done
echo ""

################################################################################
# 5. Install Mac App Store Applications
################################################################################
echo "Step 5: Installing Mac App Store applications..."

if command_exists mas; then
    # LINE
    if mas list | grep -q "539883307"; then
        echo "✓ LINE already installed"
    else
        echo "Installing LINE..."
        if ! mas install 539883307; then
            echo "✗ Failed to install LINE"
        fi
    fi
else
    echo "⚠ mas not installed, skipping Mac App Store apps"
fi
echo ""

################################################################################
# 6. Additional Development Environment Setup
################################################################################
echo "Step 6: Setting up development environments..."

# Create Projects directory
if [ ! -d "$HOME/Projects" ]; then
    mkdir -p "$HOME/Projects"
    echo "✓ Created ~/Projects directory"
else
    echo "✓ ~/Projects directory already exists"
fi

# Setup pyenv
if command_exists pyenv; then
    echo "Setting up pyenv..."
    if ! grep -q "pyenv init" ~/.zshrc 2>/dev/null; then
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(pyenv init -)"' >> ~/.zshrc
        echo "✓ Added pyenv to .zshrc"
    else
        echo "✓ pyenv already configured in .zshrc"
    fi
fi

# Setup nodebrew
if command_exists nodebrew; then
    echo "Setting up nodebrew..."
    if [ ! -d "$HOME/.nodebrew/src" ]; then
        mkdir -p ~/.nodebrew/src
        echo "✓ Created nodebrew src directory"
    fi
    if ! nodebrew ls 2>/dev/null | grep -q "v"; then
        echo "Installing latest Node.js via nodebrew..."
        nodebrew install-binary latest
        nodebrew use latest
    else
        echo "✓ Node.js already installed via nodebrew"
    fi
fi

echo ""

################################################################################
# 7. Setup Git Configuration
################################################################################
echo "Step 7: Git configuration..."

# Setup Git LFS
if command_exists git-lfs; then
    if ! git lfs install --skip-repo 2>&1 | grep -q "Updated"; then
        git lfs install
        echo "✓ Git LFS installed"
    else
        echo "✓ Git LFS already installed"
    fi
fi

# Git user configuration
if [ ! -f "$HOME/.gitconfig" ] || ! git config --global user.name >/dev/null 2>&1; then
    echo "Please configure git with your name and email:"
    read -p "Enter your name: " git_name
    read -p "Enter your email: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo "✓ Git configured"
else
    echo "✓ Git already configured"
fi

echo ""

################################################################################
# 8. Setup Dotfiles
################################################################################
echo "Step 8: Setting up dotfiles..."
if [ -d "$HOME/dotfiles" ]; then
    cd "$HOME/dotfiles"
    if [ -f "./set_dotfiles.sh" ]; then
        chmod +x ./set_dotfiles.sh
        ./set_dotfiles.sh
        echo "✓ Dotfiles symlinked"
    fi
else
    echo "⚠ ~/dotfiles directory not found. Please clone your dotfiles repository."
fi
echo ""

################################################################################
# 9. Setup SSH Key
################################################################################
echo "Step 9: SSH Key setup..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    read -p "Generate SSH key? (y/n): " generate_ssh
    if [[ "$generate_ssh" == "y" ]]; then
        read -p "Enter your email for SSH key (default: me@mizune.ms): " ssh_email
        ssh_email=${ssh_email:-me@mizune.ms}
        ssh-keygen -t ed25519 -C "$ssh_email"
        echo "✓ SSH key generated"
        echo "Don't forget to add your SSH key to GitHub/GitLab!"
        echo "Public key location: ~/.ssh/id_ed25519.pub"
    fi
else
    echo "✓ SSH key already exists"
fi
echo ""

################################################################################
# Cleanup
################################################################################
echo "Step 10: Cleaning up..."
brew cleanup
echo "✓ Cleanup complete"
echo ""

################################################################################
# Final Steps
################################################################################
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""

# Display installation failures if any
if [ ${#FAILED_FORMULAE[@]} -gt 0 ] || [ ${#FAILED_CASKS[@]} -gt 0 ]; then
    echo "⚠️  Installation Failures Detected"
    echo "=========================================="
    
    if [ ${#FAILED_FORMULAE[@]} -gt 0 ]; then
        echo ""
        echo "Failed Formulae (${#FAILED_FORMULAE[@]}):"
        for formula in "${FAILED_FORMULAE[@]}"; do
            echo "  ✗ $formula"
        done
    fi
    
    if [ ${#FAILED_CASKS[@]} -gt 0 ]; then
        echo ""
        echo "Failed Casks (${#FAILED_CASKS[@]}):"
        for cask in "${FAILED_CASKS[@]}"; do
            echo "  ✗ $cask"
        done
    fi
    
    echo ""
    echo "To retry failed installations manually:"
    if [ ${#FAILED_FORMULAE[@]} -gt 0 ]; then
        echo "  brew install ${FAILED_FORMULAE[@]}"
    fi
    if [ ${#FAILED_CASKS[@]} -gt 0 ]; then
        echo "  brew install --cask ${FAILED_CASKS[@]}"
    fi
    echo ""
    echo "=========================================="
    echo ""
fi

echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Install desired Python versions: pyenv install 3.12.0"
echo "3. Set default Python: pyenv global 3.12.0"
echo "4. Add your SSH key to GitHub/GitLab if generated"
echo "5. Configure any application-specific settings"
echo ""
echo "Happy coding! 🚀"
