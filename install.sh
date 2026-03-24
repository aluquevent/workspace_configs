#!/bin/bash
# Install script for 42 cluster
# Run: bash install.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Backup existing configs
for f in ~/.tmux.conf ~/.zshrc; do
    if [ -f "$f" ] && [ ! -L "$f" ]; then
        echo "Backing up $f -> ${f}.bak"
        cp "$f" "${f}.bak"
    fi
done

# Symlink configs
ln -sf "$REPO_DIR/.tmux.conf" ~/.tmux.conf
ln -sf "$REPO_DIR/.zshrc" ~/.zshrc
echo "Symlinked .tmux.conf and .zshrc"

# Install oh-my-zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins if missing
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo ""
echo "Done! Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Open tmux: t"
echo "  3. Install tmux plugins: Ctrl+a then Shift+I"
