#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

link() {
  source="$1"
  target="$2"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "⚠️  $target already exists — skipping"
    return
  fi

  ln -sfn "$source" "$target"
  echo "✓ $target → $source"
}

# Dotfile symlinks
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/scripts/new-task" "$HOME/.local/bin/new-task"

# Machine-specific Git identity
if [ ! -f "$HOME/.gitconfig-local" ]; then
  cat > "$HOME/.gitconfig-local" <<'EOF'
[user]
    name = YOUR_NAME
    email = YOUR_EMAIL
EOF

  echo "⚠️  Created ~/.gitconfig-local — update your Git identity."
fi

echo
echo "Dotfiles installed."
