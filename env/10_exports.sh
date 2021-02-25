#!/usr/bin/env zsh

#############################################################################
# Lang
#############################################################################

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8


#############################################################################
# Shell Settings
#############################################################################

export EDITOR="/usr/local/bin/mate -w"

# Increase Bash history size. Allow 32³ entries the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

# ls options
export CLICOLOR=1
export LS_OPTIONS='-hG'
export LSCOLORS=GxFxCxDxBxegedabagaced

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Umask
umask 022


#############################################################################
# Homebrew
#############################################################################

export MANPATH="/usr/local/share/man/:$MANPATH"

# Homebrew path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Install casks to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


#############################################################################
# NodeJs
#############################################################################

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history

# Allow 32³ entries the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'

# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'


#############################################################################
# NodeJs
#############################################################################

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'


#############################################################################
# Fastlane
#############################################################################

export FASTLANE_SKIP_UPDATE_CHECK="1"
export FASTLANE_OPT_OUT_USAGE="1"
export FASTLANE_OPT_OUT_CRASH_REPORTING="1"


#############################################################################
# Rust/Cargo
#############################################################################
export PATH="$HOME/.cargo/bin:$PATH"


#############################################################################
# GnuPG
#############################################################################
# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)


#############################################################################
# Google Cloud SDK
#############################################################################
export CLOUDSDK_PYTHON="/usr/local/opt/python@3.9/libexec/bin/python"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
