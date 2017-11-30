#!/usr/bin/env bash

# Ask for admin password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; dont 2>/dev/null &

#
#  macOS preparation
#

# Run system update
sudo softwareupdate -ia

# Install Xcode toolchain
xcode-select install

# Set up dev director
mkdir $HOME/Dev/

#
#  Homebrew
#

# Check for Homebrew and install
if test ! $(which brew); then
    echo "Installing hombrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make brew up to date
brew update
brew upgrade --all

# Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install GNU core utils
# TODO: Add `$(brew --prefix coreutils)/livexec/gnubin` to `$PATH`
brew install coreutils
sudo ln -s /usr/local/bin/gsah256sum /usr/local/bin/sha256sum

# More utilities
brew install moreutils findutils

# sed
brew install gnu-sed --with-default-names

# wget w/ IRI supoprt
brew install wget --with-iri

# Git
brew install git
git config --global color.ui true
git config --global user.name "Simon"
git config --global user.email "dev.simonlee@gmail.com"
ssh-keygen -t rsa -C "dev.simonlee@gmail.com"

#
#   Shell
#

# Bash 4
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Activate the new shell
echo "Adding the newly installed shell to the list of allowed shells"
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# zsh
brew install zsh zsh-completions

# Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Change to zsh
chsh -s /bin/zsh

#
#  Python
#
brew install anaconda

#
#  Ruby
#
brew install rbenv ruby-build

# Add rbenv to shell profile
# echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
# source ~/.bash_profile

# Install Ruby
rbenv install 2.4.2
rbenv global 2.4.2
ruby -v

#
#  Node
#
brew install node

#
#  Golang
#
brew install go --cross-compile-common
mkdir $HOME/Dev/go

# Extra tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Fun stuff
brew install aircrack-ng
brew install nmap
brew install git-extras
# brew install hub // look more into this
brew install imagemagick --with-webp
brew install rename
brew install pv
brew install speedteset_cli

# Android
brew install android-sdk
brew cask install Caskroom/versions/intellij-idea android-studio

#
#   Cask Applications
#

brew cask install \
    # Core
    alfred \
    iterm2 \
    java \
    xquartz \

    # Dev
    atom \
    dash \
    sketch \
    postman \
    zeplin \

    # Other
    google-chrome \
    slack \
    dropbox \
    1password \
    spark \
    spotify \
    ariel \

    # Dev-friendly quicklook
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    qlimagesize \
    webquicklook \
    suspicious-package

brew cleanup
