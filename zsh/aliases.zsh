# =============================================================================
# Navigation
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'

alias ll='eza -la --git'
alias tree='eza --tree'


# =============================================================================
# Search
# =============================================================================

# Interactive process search
alias psg='ps aux | fzf'

# Fuzzy file finder with preview
alias ff='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Search file contents using ripgrep + fzf + bat preview
#
# Usage:
#   rf defineProps
#   rf "useRoute" -g "*.ts"
#   rf "defineEmits" -g "*.vue"
rf() {
  rg --line-number --no-heading --color=always "$@" |
    fzf --ansi \
      --delimiter : \
      --preview 'bat --color=always --highlight-line {2} {1}' \
      --preview-window '+{2}-5'
}


# =============================================================================
# Git
# =============================================================================

alias gs='git status'
alias gp='git pull'

alias glog='git log --graph --decorate --oneline'
alias gloga='git log --graph --decorate --oneline --all'


# =============================================================================
# System
# =============================================================================

alias hosts='code /etc/hosts'

