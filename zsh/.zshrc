#!/usr/bin/env zsh
# Jak Crow 2018-2022 💗

# TODO: Overwrite selected text (region)
# TODO: Keep current input on history-substring-search-up


# ┌─────────────────────────────────────────────────────────────────────────────
# │ OPTIONS/SETUP
# └─────────────────────────────────────────────────────────────────────────────
setopt sharehistory                                         # Immediately append history instead of overwriting
setopt extendedhistory                                      # Save timestamps of commands
setopt histignorealldups                                    # If a new command is a duplicate, remove the older one
setopt autocd                                               # If only directory path is entered, cd there.
setopt autopushd pushdsilent pushdignoredups pushdtohome    # Maintain stack of recently visited directories
setopt correct                                              # Auto correct mistakes
setopt extendedglob                                         # Extended globbing. Allows using regular expressions with *
setopt nobeep                                               # No beep
setopt prompt_subst                                         # Enable prompt substitution
setopt nocaseglob                                           # Case insensitive globbing
setopt nocheckjobs                                          # Don't warn about running processes when exiting
setopt numericglobsort                                      # Sort filenames numerically when it makes sense
setopt rcexpandparam                                        # Array expension with parameters
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                          # automatically find new executables in path
zstyle ':completion:*' menu select                          # Fancy menus for z
zstyle ':completion:*' accept-exact '*(N)'                  # Speed up completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

DIRSTACKSIZE=12
HISTSIZE=1000000000 # billion
SAVEHIST=1000000000 # billion
HISTFILE=$ZDOTDIR/.zsh_hist
WORDCHARS='-:_*?.[]~=&;!#$%^(){}<>'

export WINHOME='C:/~'
# export PATH="$PATH:$HOME/.sel/.local/bin:$HOME/.local/bin"

export XDG_DATA_HOME="$HOME/.sel/.local/share"
export XDG_CONFIG_HOME="$HOME/.sel"

export EDITOR=nano

# autoload -Uz compinit colors
# compinit -D && colors

autoload -Uz compinit colors
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C && colors

# ┌─────────────────────────────────────────────────────────────────────────────
# │ LOAD EVERYTHING
# └─────────────────────────────────────────────────────────────────────────────
# Main
source $ZDOTDIR/do.zsh
source $ZDOTDIR/keys.zsh
source $ZDOTDIR/theme.zsh

# Plug-ins
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/zoxide.zsh

# Syntax highlighting docs: https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/docs/highlighters
# ex: ZSH_HIGHLIGHT_STYLES[line]="fg=#ff00ff,bg=cyan,bold,underline"

# TODO: Change selection (region) bg color but preserve fg color (like in nvim). See: https://github.com/zsh-users/zsh-syntax-highlighting/issues/887
# zle_highlight=(region:'fg=preserve,bg=#304b4f')

typeset -A ZSH_IGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,underline'

ZSH_HIGHLIGHT_STYLES[path]='fg=green'
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta'

ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=green'


ZSH_HIGHLIGHT_STYLES[region]='fg=blue'
