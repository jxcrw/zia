# Set up fzf
fd='fd.exe'

# if [[ ! "$PATH" == */mnt/c/~/.sel/fzf/bin* ]]; then
#   PATH="${PATH:+${PATH}:}/mnt/c/~/.sel/fzf/bin"
# fi

# Auto-completion
[[ $- == *i* ]] && source "/mnt/c/~/.sel/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/mnt/c/~/.sel/zsh/fzf-keys.zsh"

# Customization
colors=' --color=fg:#565f89,bg:-1,preview-fg:-1,preview-bg:-1,hl:#73daca,fg+:#c0caf5,bg+:-1,gutter:-1,query:#c0caf5,hl+:#73daca,info:#565f89,border:-1,prompt:#F7B273,pointer:#F7B273,marker:#F7B273,spinner:#565f89,header:#565f89'
export FZF_DEFAULT_OPTS='--exact --reverse --height 40%'$colors

export FZF_DEFAULT_COMMAND=$fd' --hidden --no-ignore  --path-separator /'

export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND' --type d'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND' --type f'

# Overrides
_fzf_compgen_path() {
  $fd --hidden --follow --exclude ".git" . "$1" --path-separator /
}

_fzf_compgen_dir() {
  $fd --type d --hidden --follow --exclude ".git" . "$1" --path-separator /
}
