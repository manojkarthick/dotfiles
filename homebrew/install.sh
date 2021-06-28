#!/bin/bash

# By default, homebrew installs onto /usr/local/bin and updates the directory permissions
# This is unsafe and should be avoided.
# See: https://web.archive.org/web/20190925074708/https://applehelpwriter.com/2018/03/21/how-homebrew-invites-users-to-get-pwned/
# Instead, this script downloads the homebrew tarball directly and uses the Untar Anywhere installation method.
# See: https://docs.brew.sh/Installation#untar-anywhere
mkdir ~/Homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/Homebrew

