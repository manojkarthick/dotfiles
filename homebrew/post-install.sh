#!/bin/bash

echo "Install homebrew packages"
brew bundle install

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
