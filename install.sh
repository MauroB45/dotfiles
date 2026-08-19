#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

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
link "$DOTFILES/scripts/review-pr" "$HOME/.local/bin/review-pr"
link "$DOTFILES/scripts/prs" "$HOME/.local/bin/prs"

# Claude Code
mkdir -p "$HOME/.claude"

ln -sfn "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sfn "$DOTFILES/claude/skills" "$HOME/.claude/skills"

# Machine-specific Git identity
if [ ! -f "$HOME/.gitconfig-local" ]; then
  cat > "$HOME/.gitconfig-local" <<'EOF'
[user]
    name = YOUR_NAME
    email = YOUR_EMAIL
EOF

  echo "⚠️  Created ~/.gitconfig-local — update your Git identity."
fi

link "$DOTFILES" "$HOME/.dotfiles"

echo
echo "Dotfiles installed."
