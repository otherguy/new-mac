#!/usr/bin/env zsh

SCRIPT_PATH="${0:A:h}"
cd "${SCRIPT_PATH}" || exit 1

folderify ../icons/folders/dropbox.png ~/Dropbox
folderify ../icons/folders/obsidian.png ~/Documents/Obsidian
folderify ../icons/folders/calibre.png ~/Documents/Calibre\ Library
