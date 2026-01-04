# Repository Guidelines

## Project Structure & Module Organization
- Root contains setup automation for macOS development: `install.sh` (bootstrap), `setup.sh` (Homebrew installs + language runtimes), and `set_dotfiles.sh` (symlink creation).
- Dotfiles live in the repo root (`.zshrc`, `.vimrc`, `.gvimrc`, `.tmux.conf`); they are linked into `$HOME` by `set_dotfiles.sh`.
- No nested modules or tests; changes should keep scripts idempotent and safe to rerun.

## Build, Test, and Development Commands
- First-time install (remote): `bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mizune/dotfiles/master/install.sh)"` — clones to `~/dotfiles` and runs the full setup.
- Local bootstrap: `./install.sh` — updates/clones, ensures executability, then calls `setup.sh`.
- Direct setup: `./setup.sh` — installs Xcode CLT, Homebrew, formulae/casks, language managers, and links dotfiles. Re-running should be safe; it skips installed items.
- Link only: `./set_dotfiles.sh` — recreates symlinks without reinstalling packages.
- Optional validation: `shellcheck install.sh setup.sh set_dotfiles.sh` before committing to catch shell pitfalls.

## Coding Style & Naming Conventions
- Scripts use Bash; prefer portable, POSIX-friendly constructs and guard with `[[ "$OSTYPE" == "darwin"* ]]` where applicable.
- Follow existing patterns: uppercase arrays/constants (`FORMULAE`, `CASKS`), helper functions like `command_exists`, and clear step banners for output.
- Use double quotes for variables, four-space indentation inside conditionals/loops, and avoid hardcoding user paths beyond `$HOME`.
- Keep operations idempotent; check for existing installs or files before modifying.

## Testing Guidelines
- No automated suite; validate changes by running the target script on a macOS shell session. For package edits, spot-check installs with `brew install <formula>` or `brew install --cask <app>` in isolation.
- When adjusting dotfiles, open a new shell or `source ~/.zshrc` to confirm prompt/plugins load without errors.

## Commit & Pull Request Guidelines
- Commit messages in history are short and imperative (e.g., “Add bootstrap installer”); follow that style and keep the scope focused.
- For PRs/patches, include: purpose, key changes (notable package additions/removals or dotfile tweaks), tested commands, and any required post-install steps. Screenshots are unnecessary unless changing visual tooling configs.

## Security & Configuration Tips
- Never commit secrets or machine-specific tokens; keep credentials in environment or macOS Keychain.
- If adding new packages or scripts, ensure they respect least privilege and do not assume sudo without prompting the user.***
