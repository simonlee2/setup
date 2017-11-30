#!/usr/bin/env bash

# Ask for admin password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
#  macOS preparation
#

# Run system update
sudo softwareupdate -ia

# Install Xcode toolchain
sudo xcodebuild -license accept
xcode-select --install

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
brew upgrade

# Install GNU core utils
brew install coreutils --with-default-names

# More utilities
brew install moreutils findutils --with-default-names

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
brew install bash-completion2

# Activate the new shell
echo "Adding the newly installed shell to the list of allowed shells"
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# zsh
brew install zsh zsh-completions

#
#  Python
#
# TODO: Add to zshrc `export PATH=/usr/local/anaconda3/bin:"$PATH"`
brew cask install anaconda


#
#  Ruby
#
brew install rbenv ruby-build

# Add rbenv to shell profile
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rbenv install 2.4.2
rbenv global 2.4.2
ruby -v

# rbenv-doctor: check rbenv installation
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# Set up .gemrc
printf 'install: --no-ri --no-rdoc\nupdate: --no-ri --no-rdoc\n' >> ~/.gemrc

# bundler
gem install bundler

#
#  iOS
#
brew install carthage
gem install cocoapods
gem install fastlane

#
#  Node
#
brew install node

#
#  Golang
#
# TODO: Set up GOPATH
brew install go
mkdir $HOME/Dev/go

# Extra tools
brew install vim --with-override-system-vi
brew install grep --with-default-names
brew install openssh
brew install screen

Fun stuff
brew install aircrack-ng
brew install nmap
# TODO: Add to .zshrc `source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh`
brew install git-extras
# brew install hub // look more into this
brew install imagemagick --with-webp
brew install rename
brew install pv
brew install speedtest_cli

# Android
brew cask install caskroom/versions/java8
brew cask install android-sdk
# TODO Add to .zshrc `export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"`
brew cask install intellij-idea android-studio

#
#   Cask Applications
#

brew cask install \
    atom \
    slack \
    1password \
    spark \
    alfred \
    iterm2 \
    xquartz \
    dash \
    sketch \
    postman \
    zeplin \
    google-chrome \
    dropbox \
    spotify \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    qlimagesize \
    suspicious-package

brew cleanup

# .vimrc
# .vim/colors
