#!/usr/bin/env bash

# Prevent automatic sleeping on power adapter when the display is off
# (System Settings → Battery → Options)
sudo pmset -c sleep 0
echo "Enabled prevent sleep on AC when display is off"
