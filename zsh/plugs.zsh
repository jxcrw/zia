#!/usr/bin/env zsh
# zsh plugins and plugin configs

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Autosuggestions
# └─────────────────────────────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char)


# ┌─────────────────────────────────────────────────────────────────────────────
# │ Syntax highlighting
# └─────────────────────────────────────────────────────────────────────────────
# Docs: https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/docs/highlighters
# ex: ZSH_HIGHLIGHT_STYLES[line]="fg=#ff00ff,bg=cyan,bold,underline"

# TODO: Change selection (region) bg color but preserve fg color (like in nvim). See: https://github.com/zsh-users/zsh-syntax-highlighting/issues/887
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

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

# zle_highlight=(region:'fg=preserve,bg=#304b4f')


# ┌─────────────────────────────────────────────────────────────────────────────
# │ Other
# └─────────────────────────────────────────────────────────────────────────────
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none


# ┌─────────────────────────────────────────────────────────────────────────────
# │ Source Everything
# └─────────────────────────────────────────────────────────────────────────────
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/zoxide.zsh
