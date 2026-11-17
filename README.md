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

The installer creates symlinks for the managed configuration files and creates `~/.gitconfig-local` and `~/.zshrc.local` when they don't already exist.

## Machine-specific shell configuration

Paths differ between machines, so they live in `~/.zshrc.local`, which is sourced by `.zshrc` and is **not committed**.

```bash
export OBSIDIAN_VAULT="$HOME/Documents/Vault"
export CODE_ROOT="$HOME/Code/work"
export REPO_ALIASES="geppetto-sender-ui=sender-ui"
```

`OBSIDIAN_VAULT` points at the Obsidian vault holding ticket notes and review logs. `new-task` and `review-pr --done` exit without it.

`new-task` and `review-pr` open the worktree in VS Code and run Claude in its chat. When the vault is under `~/Documents`, give Visual Studio Code access to the Documents folder in **System Settings → Privacy & Security → Files and Folders**, or macOS blocks the chat from reading the notes.

`CODE_ROOT` is where repositories are cloned. Only `review-pr` uses it, to find the clone for a pull request, and it defaults to `~/Code/work`.

`REPO_ALIASES` maps a GitHub repository to the directory it is cloned into, as a space-separated list of `github-name=local-directory` pairs. `review-pr` is given a GitHub repository name, so it needs the mapping to find a clone whose directory is named differently. The local directory name is also the vault folder, which keeps a project's tickets and review log together.

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

## GPG commit signing

Work machines use GPG commit signing. GPG and the macOS pinentry application are installed through the `Brewfile`:

```ruby
brew "gnupg"
brew "pinentry-mac"
```

Generate a machine-specific GPG key:

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
```

Configure the work identity in `~/.gitconfig-local`:

```ini
[user]
    name = Your Name
    email = your.work@example.com
    signingkey = YOUR_KEY_ID

[commit]
    gpgsign = true

[tag]
    gpgSign = true
```

Configure `~/.gnupg/gpg-agent.conf`:

```text
pinentry-program /opt/homebrew/bin/pinentry-mac

default-cache-ttl 28800
max-cache-ttl 28800
```

Restart the agent after changing its configuration:

```bash
gpgconf --kill gpg-agent
```

Add the public key to the work GitHub account:

```bash
gpg --armor --export YOUR_KEY_ID > /tmp/work-gpg.pub
gh gpg-key add /tmp/work-gpg.pub --title "Work Mac"
rm /tmp/work-gpg.pub
```

Verify signing:

```bash
git commit --allow-empty -m "Test GPG signing"
git log --show-signature -1
```

GPG private keys, `~/.gnupg`, and machine-specific signing key IDs are intentionally not stored in this repository.
