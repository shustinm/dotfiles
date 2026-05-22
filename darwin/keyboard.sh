#!/usr/bin/env bash

# Change "Select the previous input source" shortcut from Ctrl+Space to Opt+Space
# Key 60 = "Select the previous input source"
# Parameters: [ascii_code, key_code, modifier_flags]
#   32 = Space (ASCII), 49 = Space (keycode), 524288 = Option modifier (1 << 19)
# Using XML plist format to preserve integer types (old-style plist writes strings)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
  '<dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key><array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>524288</integer>
      </array>
    </dict>
  </dict>'
echo "Changed input source shortcut to Opt+Space"

# Key repeat rate: 2 = fastest in System Settings (1 = even faster, beyond the UI slider)
defaults write -g KeyRepeat -int 2
# Delay until repeat: 15 = shortest in System Settings (10 = even shorter, beyond the UI slider)
defaults write -g InitialKeyRepeat -int 15
echo "Set key repeat rate to fastest and delay until repeat to shortest"

# Disable smart quote substitution (straight quotes are used by default when this is off)
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
echo "Disabled smart quotes"

# Disable smart dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic spelling correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
echo "Disabled auto-correct"

# Disable automatic capitalization
defaults write -g NSAutomaticCapitalizationEnabled -bool false
echo "Disabled auto-capitalize"

# Disable adding period with double-space
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
echo "Disabled period with double-space"

# Disable the blue input source popup when switching keyboard languages
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled -bool false
echo "Disabled input source change indicator"

# Flush preferences cache and apply symbolic hotkey changes immediately
# System Settings must not be running for changes to take effect
osascript -e 'tell application "System Settings" to quit' 2>/dev/null
sleep 1
defaults read com.apple.symbolichotkeys > /dev/null 2>&1
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
