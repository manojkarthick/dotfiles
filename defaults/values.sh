#!/bin/zsh

# Obtained from https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Dock
defaults write com.apple.dock orientation -string bottom
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string scale

# Screenshots
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture include-date -bool true
defaults write com.apple.screencapture location -string ~/Desktop/Screenshots/
defaults write com.apple.screencapture show-thumbnail -bool true
defaults write com.apple.screencapture type -string png

# Finder
defaults write com.apple.finder QuitMenuItem -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

killall Dock
killall Finder
