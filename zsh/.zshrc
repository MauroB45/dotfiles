export PATH="$HOME/.local/bin:$PATH"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prompt
eval "$(starship init zsh)"

# Navigation
eval "$(zoxide init zsh)"

# Fuzzy finder
source <(fzf --zsh)

# Suggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Syntax highlighting — keep last
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Node
eval "$(fnm env --use-on-cd --shell zsh)"

# GPG
export GPG_TTY=$(tty)

# Dotfiles zsh directory
DOTFILES_ZSH_DIR="${0:A:h}"

# Aliases
source "$DOTFILES_ZSH_DIR/aliases.zsh"

# Machine-specific configuration
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
