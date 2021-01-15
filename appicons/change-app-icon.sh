#!/bin/bash
if [ ! -d "$1" ]; then
    echo "Wrong parameter! You need to specify the full path to an Application!"
    exit 1
fi

app="$(basename "$1")"
ext="${app%.app}"
name_without_ext="${ext##*/}"
directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
icon="${directory}/${name_without_ext}.icns"

if [ ! -f "${icon}" ]; then
    echo "No icon file for ${app} found!"
    exit 1
fi

/usr/local/bin/fileicon set "$1" "${directory}/${name_without_ext}.icns"
/usr/local/bin/terminal-notifier -title "${name_without_ext}" -message "Application icon changed" -appIcon "${icon}"
