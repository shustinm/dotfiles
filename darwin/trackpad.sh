#!/usr/bin/env bash

# === Point & Click ===

# Enable tap to click (both built-in and Bluetooth trackpad)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
echo "Enabled tap to click"

# === More Gestures ===

# Swipe between full-screen applications: 4 fingers
# ThreeFingerHorizSwipe = 0 disables 3-finger, FourFingerHorizSwipe = 2 enables 4-finger
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
echo "Set swipe between full-screen apps to 4 fingers"

# Mission Control: 4 fingers
# ThreeFingerVertSwipe = 0 disables 3-finger, FourFingerVertSwipe = 2 enables 4-finger
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
echo "Set Mission Control gesture to 4 fingers"

# App Expose: 4 fingers (enable + set to 4-finger swipe down)
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
echo "Set App Expose gesture to 4 fingers"

killall Dock 2>/dev/null
