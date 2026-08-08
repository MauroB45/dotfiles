# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prompt
eval "$(starship init zsh)"

# Navigation
eval "$(zoxide init zsh)"

# Fuzzy finder
source <(fzf --zsh)

# Node
eval "$(fnm env --use-on-cd --shell zsh)"

# Aliases
source "$HOME/dotfiles/zsh/aliases.zsh"
