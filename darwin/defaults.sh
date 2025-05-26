#!/usr/bin/env bash

# ===============================
# ======= Begin Aerospace =======
# ===============================

# Disable windows opening animations
# https://nikitabobko.github.io/AeroSpace/goodies#disable-open-animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
echo "Disabled window opening animation"

# For some reason, mission control doesn’t like that AeroSpace puts a lot of windows in the bottom right corner of the screen.
# Mission control shows windows too small even there is enough space to show them bigger.
#
# There is a workaround. You can enable Group windows by application setting:
#
# https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
defaults write com.apple.dock expose-group-apps -bool true && killall Dock
echo "Enbaled group windows by application in expose (System Settings → Desktop & Dock → Group windows by application)"

# macOS works better and more stable if you disable Displays have separate Spaces. (It’s enabled by default)
# If you don’t care about macOS native fullscreen in multi monitor setup (which is itself clunky anyway, since it creates a separate Space instance)
# I recommend disabling Displays have separate Spaces.
#
# https://nikitabobko.github.io/AeroSpace/guide#a-note-on-displays-have-separate-spaces
defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer
echo "Disabled separate display spaces (System Settings → Desktop & Dock → Displays have separate Spaces)"


# ===============================
# ======   End Aerospace   ======
# ===============================
