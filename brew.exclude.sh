#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Install homebrew if it is not installed
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo "Homebrew not installed. Attempting to install Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	if [ ! "$?" -eq 0 ] ; then
		echo "Something went wrong. Exiting..." && exit 1
	fi
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Core Utils
brew install coreutils


# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------

# NodeJS 
brew install node

# Python 3
brew install python

# Golang
brew install go


# ---------------------------------------------
# Tools I use often
# ---------------------------------------------

# Default source control
brew install git

echo "This utility will generate a ssh key"
echo "Proceed? (y/n)"
read resp
if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
	# Generate key
	read -p "Enter Your Email: "  email
	ssh-keygen -t rsa -C $email

	# Copy key
	cat ~/.ssh/id_rsa.pub | pbcopy

	# Add to Github
	# [Github SSH keys](https://github.com/settings/ssh)

	# Test connection
	ssh -T git@github.com
else
	echo "SSH key installation cancelled"
fi


# Docker for containerization
brew cask install docker
brew install docker-compose

# ---------------------------------------------
# Useful tools
# ---------------------------------------------

# Development tool
brew install make

# Make requests with awesome response formatting
brew install httpie

# Show directory structure with excellent formatting
brew install tree


# ---------------------------------------------
# Misc
# ---------------------------------------------

# Zsh 
brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# use custom file configuration. add to config file if it does not exist
LINE='. ~/.my-zshrc'
FILE=$HOME/.zshrc
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


# ---------------------------------------------
# Terminal gimmicks xD
# ---------------------------------------------

# The computer fortune teller 
brew install fortune

# The famous cowsay
brew install cowsay

# Multicolored text output
brew install lolcat


# ---------------------------------------------
# Programs cask
# ---------------------------------------------

# The Fire Code font
# https://github.com/tonsky/FiraCode
# This method of installation is
# not officially supported, might install outdated version
# Change font in terminal preferences
brew tap caskroom/fonts
brew cask install font-fira-code

# My favorite text editor
brew cask install visual-studio-code

# Secure passwords
brew cask install 1password

# google drive utilities
brew cask install google-backup-and-sync

# is there any other??
brew cask install google-chrome

# terminal with steroids
brew cask install iterm2-nightly

# quick api test
brew cask install postman

# team communication
brew cask install slack


# Remove outdated versions from the cellar
brew cleanup