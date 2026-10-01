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

link "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link "$DOTFILES/claude/skills" "$HOME/.claude/skills"
link "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"

# Machine-specific Git identity
if [ ! -f "$HOME/.gitconfig-local" ]; then
  cat > "$HOME/.gitconfig-local" <<'EOF'
[user]
    name = YOUR_NAME
    email = YOUR_EMAIL
EOF

  echo "⚠️  Created ~/.gitconfig-local — update your Git identity."
fi

# Machine-specific shell configuration, sourced by .zshrc
if [ ! -f "$HOME/.zshrc.local" ]; then
  cat > "$HOME/.zshrc.local" <<'EOF'
# Obsidian vault, required by new-task and review-pr --done
# export OBSIDIAN_VAULT="$HOME/Documents/Vault"

# Where repos are cloned, used by review-pr to find one
# export CODE_ROOT="$HOME/Code/work"

# Clones whose directory name differs from the GitHub repository
# export REPO_ALIASES="github-name=local-directory"
EOF

  echo "⚠️  Created ~/.zshrc.local — set OBSIDIAN_VAULT."
fi

link "$DOTFILES" "$HOME/.dotfiles"

echo
echo "Dotfiles installed."
