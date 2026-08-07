# Dotfiles

Personal macOS development environment configuration.

Designed to work across both **work and personal Macs**, with machine-specific Git identities kept outside the repository.

## Prerequisites

Install the Xcode Command Line Tools:

```bash
xcode-select --install
```

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow Homebrew's instructions to add it to your shell environment.

## Setup

Clone this repository:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

Install Homebrew dependencies:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

Run the installer:

```bash
./install.sh
```

The installer creates symlinks for the managed configuration files and creates `~/.gitconfig-local` when one doesn't already exist.

## Structure

```text
dotfiles/
├── Brewfile
├── install.sh
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── scripts/
├── starship/
│   └── starship.toml
├── vscode/
└── zsh/
    ├── .zshrc
    └── aliases.zsh
```

## Git identities

Git's shared configuration lives in this repository, but identities are machine-specific and are **not committed**.

Configure the default identity for the current machine:

```text
~/.gitconfig-local
```

Example:

```ini
[user]
    name = Your Name
    email = you@example.com
```

Repositories under these directories can override the default:

```text
~/Code/work/
~/Code/personal/
```

using:

```text
~/.gitconfig-work
~/.gitconfig-personal
```

For example, a work Mac can use the work identity in `.gitconfig-local` and the personal identity in `.gitconfig-personal`.

## SSH

Work and personal Git accounts use separate SSH keys:

```text
~/.ssh/id_ed25519_work
~/.ssh/id_ed25519_personal
```

SSH aliases can be configured in `~/.ssh/config`, for example:

```text
github-work
github-personal
```

Clone repositories using the appropriate alias:

```bash
git clone git@github-work:company/project.git
git clone git@github-personal:username/project.git
```

SSH keys and machine-specific credentials are intentionally **not stored in this repository**.

## Updating packages

Install everything declared in the Brewfile:

```bash
brew bundle
```

Check whether everything is installed:

```bash
brew bundle check
```

