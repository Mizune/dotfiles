#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Hammerspoon
mkdir -p ~/.hammerspoon
ln -sf ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config

# Starship
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# Claude Code（手動マージ方式）
setup_claude() {
    mkdir -p ~/.claude/skills

    local claude_files=(
        "CLAUDE.md"
        "settings.local.json"
    )
    local claude_skills=(
        "branch"
        "review"
        "dev"
    )

    echo "=== Claude Code Setup ==="

    # メインファイルのマージ
    for file in "${claude_files[@]}"; do
        if [ -f ~/.claude/"$file" ]; then
            if ! diff -q ~/dotfiles/claude/"$file" ~/.claude/"$file" > /dev/null 2>&1; then
                echo "⚠ ~/.claude/$file が既に存在し、内容が異なります"
                echo "  dotfiles版: ~/dotfiles/claude/$file"
                echo "  手動でマージしてください"
            else
                echo "✓ $file は同一です"
            fi
        else
            cp ~/dotfiles/claude/"$file" ~/.claude/"$file"
            echo "✓ $file をコピーしました"
        fi
    done

    # skillsのマージ
    for skill in "${claude_skills[@]}"; do
        if [ -d ~/.claude/skills/"$skill" ]; then
            if ! diff -q ~/dotfiles/claude/skills/"$skill"/SKILL.md ~/.claude/skills/"$skill"/SKILL.md > /dev/null 2>&1; then
                echo "⚠ ~/.claude/skills/$skill が既に存在し、内容が異なります"
                echo "  dotfiles版: ~/dotfiles/claude/skills/$skill/"
                echo "  手動でマージしてください"
            else
                echo "✓ skill: $skill は同一です"
            fi
        else
            cp -r ~/dotfiles/claude/skills/"$skill" ~/.claude/skills/
            echo "✓ skill: $skill をコピーしました"
        fi
    done
}

setup_claude
