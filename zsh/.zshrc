#!/usr/bin/env zsh
# Jak Crow 2018-2022 💗

# TODO: Overwrite selected text (region)
# TODO: Keep current input on history-substring-search-up

fish
# # ┌─────────────────────────────────────────────────────────────────────────────
# # │ Options/Setup
# # └─────────────────────────────────────────────────────────────────────────────
# setopt sharehistory                                         # Immediately append history instead of overwriting
# setopt extendedhistory                                      # Save timestamps of commands
# setopt histignorealldups                                    # If a new command is a duplicate, remove the older one
# setopt autocd                                               # If only directory path is entered, cd there.
# setopt autopushd pushdsilent pushdignoredups pushdtohome    # Maintain stack of recently visited directories
# setopt correct                                              # Auto correct mistakes
# setopt extendedglob                                         # Extended globbing. Allows using regular expressions with *
# setopt nobeep                                               # No beep
# setopt prompt_subst                                         # Enable prompt substitution
# setopt nocaseglob                                           # Case insensitive globbing
# setopt nocheckjobs                                          # Don't warn about running processes when exiting
# setopt numericglobsort                                      # Sort filenames numerically when it makes sense
# setopt rcexpandparam                                        # Array expension with parameters
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive tab completion
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors for dirs/files/etc)
# zstyle ':completion:*' rehash true                          # automatically find new executables in path
# zstyle ':completion:*' menu select                          # Fancy menus for z
# zstyle ':completion:*' accept-exact '*(N)'                  # Speed up completions
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path ~/.zsh/cache

# DIRSTACKSIZE=12
# HISTSIZE=1000000000 # billion
# SAVEHIST=1000000000 # billion
# HISTFILE=$ZDOTDIR/.zsh_hist
# WORDCHARS='-:_*?.[]~=&;!#$%^(){}<>'

# export WINHOME='C:/~'
# # export PATH="$PATH:$HOME/.zia/.local/bin:$HOME/.local/bin"

# export XDG_CONFIG_HOME="$HOME/.zia"
# export XDG_DATA_HOME="$HOME/.zia/.xdg/data"
# export XDG_STATE_HOME="$HOME/.zia/.xdg/state"
# export XDG_CACHE_HOME="$HOME/.zia/.xdg/cache"

# export EDITOR=nano

# # autoload -Uz compinit colors
# # compinit -D && colors

# autoload -Uz compinit colors
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C && colors


# # ┌─────────────────────────────────────────────────────────────────────────────
# # │ Source Everything
# # └─────────────────────────────────────────────────────────────────────────────
# source $ZDOTDIR/do.zsh
# source $ZDOTDIR/keys.zsh
# source $ZDOTDIR/theme.zsh
# source $ZDOTDIR/plugs.zsh
