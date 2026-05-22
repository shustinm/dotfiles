#!/usr/bin/env bash

# Set dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
echo "Enabled dark mode"

# NOTE: "Icon & widget style" (Dark/Clear/Tinted/Default) is a macOS Tahoe feature
# with no known defaults key. Apple hasn't exposed it via UserDefaults as of macOS 26.4.
# It can only be changed manually in System Settings → Appearance.
