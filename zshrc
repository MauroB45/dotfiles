# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prompt
eval "$(starship init zsh)"

# Navigation
eval "$(zoxide init zsh)"

# Aliases
source "$HOME/dotfiles/zsh/aliases.zsh"
