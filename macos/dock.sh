#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Fastmail.app"
dockutil --no-restart --add "/Applications/Fantastical.app"
dockutil --no-restart --add "/Applications/Things3.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Tower.app"
dockutil --no-restart --add "/Applications/iTerm.app"

killall Dock
