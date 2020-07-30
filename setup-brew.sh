#!/bin/bash

mkdir ~/Homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/Homebrew
brew install wget
brew install fzf
$(brew --prefix)/opt/fzf/install

