#!/bin/bash


# List of applications to operate on
# Make sure the name of the application matches the formulae on brew.sh
applications=(
  1password
  docker
  google-chrome
  intellij-idea
  iterm2
  monitorcontrol
  slack
  spectacle
  intel-power-gadget
  visual-studio-code
  spotify
  caffeine
)

manual=(
  logitech-options
)

# Simple bash functions for installation/uninstallation of applications
installation() {

 for i in "${applications[@]}"
 do
    set -x
    brew cask install $i
 done

}

uninstallation() {
 for i in "${applications[@]}"
 do
    set -x
    brew cask uninstall $i
 done

}


case "$1" in
        help)
            echo "Available commands: install / uninstall"
            ;;
        install)
            echo "Starting installation of desired casks..."
            installation
            ;;
        uninstall)
            echo "Starting un-installation of desired casks..."
            uninstallation
            ;;
        *)
            echo "Not sure what you mean."
            ;;
esac
