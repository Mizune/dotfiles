# dotfiles

Personal macOS development environment configuration and setup automation.

## Quick Install

Set up your entire macOS development environment with one command:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mizune/dotfiles/master/install.sh)"
```

This will:
1. Clone this repository to `~/dotfiles`
2. Install all development tools via Homebrew
3. Set up dotfiles (vim, zsh, tmux, etc.)
4. Configure development environments (Python, Node.js, etc.)

## What's Included

### Configuration Files (Dotfiles)
- **`.zshrc`** - Zsh shell configuration with custom prompt and Git integration
- **`.vimrc`** - Vim editor configuration
- **`.gvimrc`** - GVim (GUI Vim) configuration
- **`.tmux.conf`** - tmux terminal multiplexer configuration

### Development Tools (146 packages)
#### Languages & Runtimes
- Python (pyenv, Python 3.10/3.12)
- Node.js (nodebrew)
- Ruby
- PHP
- Java (OpenJDK)
- Perl, Lua

#### Development Tools
- Git + Git LFS
- Docker + Docker Compose
- Gradle
- GCC, Make
- tmux, Vim

#### Media Processing
- FFmpeg (with extensive codec support)

#### Cloud & Infrastructure
- Google Cloud SDK
- Rancher Desktop
- Stripe CLI

### GUI Applications (18 apps)
- **Terminals**: Alacritty
- **Editors**: Visual Studio Code, Zed, Claude Code, Codex
- **IDEs**: JetBrains Toolbox
- **Browsers**: Google Chrome
- **Communication**: Slack, Zoom, Discord, LINE
- **Development**: DBeaver, Fork (Git client)
- **Productivity**: Alfred, xbar
- **Input Methods**: Google Japanese IME

## Manual Installation

If you prefer to install step by step:

```bash
# 1. Clone repository
git clone https://github.com/Mizune/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Make scripts executable
chmod +x setup.sh set_dotfiles.sh

# 3. Run setup (installs all packages)
./setup.sh

# 4. Link dotfiles (already done by setup.sh)
./set_dotfiles.sh
```

## Scripts

### `install.sh`
Bootstrap installer that clones the repository and runs setup automatically.

### `setup.sh`
Main setup script that:
- Installs Homebrew
- Installs all formulae and casks
- Sets up development environments (pyenv, nodebrew)
- Configures Git
- Links dotfiles
- Generates SSH keys (optional)
- Tracks and reports installation failures

### `set_dotfiles.sh`
Creates symbolic links for dotfiles in your home directory:
```bash
~/.vimrc -> ~/dotfiles/.vimrc
~/.zshrc -> ~/dotfiles/.zshrc
~/.gvimrc -> ~/dotfiles/.gvimrc
~/.tmux.conf -> ~/dotfiles/.tmux.conf
```

## Features

### Error Handling
The setup script continues on errors and reports failures at the end:
```
⚠️  Installation Failures Detected
==========================================

Failed Casks (1):
  ✗ some-app

To retry failed installations manually:
  brew install --cask some-app
```

### Idempotent
Safe to run multiple times - already installed packages are skipped.

### Apple Silicon Support
Automatically detects and configures for ARM-based Macs.

## Post-Installation

After installation completes:

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Install Python versions** (optional):
   ```bash
   pyenv install 3.12.0
   pyenv global 3.12.0
   ```

3. **Install Node.js** (optional, if not auto-installed):
   ```bash
   nodebrew install-binary latest
   nodebrew use latest
   ```

4. **Add SSH key to GitHub/GitLab** (if generated):
   ```bash
   cat ~/.ssh/id_ed25519.pub
   # Copy and add to GitHub Settings > SSH Keys
   ```

## Customization

To customize for your own use:

1. Fork this repository
2. Edit package lists in `setup.sh`:
   - `FORMULAE` array for CLI tools
   - `CASKS` array for GUI applications
3. Modify dotfiles (`.zshrc`, `.vimrc`, etc.)
4. Update `install.sh` to point to your fork

## Requirements

- macOS (tested on Apple Silicon)
- Internet connection
- Administrator privileges (for some installations)

## License

Personal configuration files - use at your own discretion.

## Author

Mizune
- GitHub: [@Mizune](https://github.com/Mizune)
- Email: me@mizune.ms
