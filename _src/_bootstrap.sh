#!/usr/bin/env bash
# Bootstrap system with apps/config (2022)

# Globals
WINHOME="/mnt/c/Users/jak"
APPDATA="/mnt/c/Users/jak/AppData"

bamboozle() {
  # Reroute installs to keep $HOME squeaky clean.
  SAVE=$HOME
  export HOME="$HOME/.sel"
  eval "($1)"
  export HOME=$SAVE
}


# Create symlinks
echo symlinking files...
ln ../git/{,.}* $WINHOME
ln ../zsh/.zshenv $HOME
ln ../scoop/{,.}* $WINHOME"/.config/scoop/"
ln ../windows-terminal/{,.}* $APPDATA"/Local/Microsoft/Windows Terminal"
ln ../windows-terminal/settings.json $APPDATA"/Local/Microsoft/Windows Terminal/settings.json"


# Install binaries
echo installing binaries...
$HOME/.sel/fzf/install --bin
bamboozle zoxide/install.sh


# TODO
# Add to /etc/zshenv: ZDOTDIR=~/.sel/zsh
# Set up sudoers file to start cron without password
# Directory junction sublime-text-dev

echo "done"
