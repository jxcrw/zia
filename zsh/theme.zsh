#!/usr/bin/env zsh
# zsh theme

# Color LS files (TODO: see if WSL ever doesn't mark almost all files as executable)
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:fi=40;33:pi=40;33:so=01;35:do=01;35:bd=40;33;cd=40;33;or=40;31;mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=01;37';
export LS_COLORS

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Prompt (https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html)
PROMPT="%{$fg[cyan]%}%(4~|%-1~/../%2~|%~)%u %(?.%{$fg[magenta]%}.%{$fg[red]%})>%{$reset_color%} "
RPROMPT='$(git_info)'
ZLE_RPROMPT_INDENT=0
# RPROMPT='%{$fg[magenta]%}< %{$fg[cyan]%}~%{$reset_color%}'

git_info() {
  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  local GIT_LOCATION=$(git rev-parse --abbrev-ref HEAD)
  local GIT_TAGS=$(git tag -l --sort=-version:refname --points-at HEAD | xargs | sed -e 's/ /|/g')

  local -a DIVERGENCES
  local -a FLAGS

  # Merging
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "🔥 " )
  fi

  # Staged
  local n_staged=$(git diff --name-only --cached 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_staged -gt 0 ]]; then
    staged="%{$fg[cyan]%}$n_staged%{$reset_color%}"
    FLAGS+=( " $staged" )
  fi

  # Modified
  local n_modified=$(git diff --name-only --diff-filter=M 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_modified -gt 0 ]]; then
    modified="%{$fg[yellow]%}$n_modified%{$reset_color%}"
    FLAGS+=( " $modified" )
  fi

  # Untracked
  local n_untracked=$(git ls-files --other --exclude-standard 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_untracked -gt 0 ]]; then
    untracked="%{$fg[green]%}$n_untracked%{$reset_color%}"
    FLAGS+=( " $untracked" )
  fi

  # Ahead
  local n_ahead="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$n_ahead" -gt 0 ]; then
    ahead="%F{12}$n_ahead%f%{$reset_color%}"
    DIVERGENCES+=( " $ahead" )
  fi

  # Behind
  local n_behind="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$n_behind" -gt 0 ]; then
    behind="%F{9}$n_behind%f%{$reset_color%}"
    DIVERGENCES+=( " $behind" )
  fi

  # Put it all together
  local -a GIT_INFO
  [[ ${#FLAGS[@]} -ne 0 ]] || [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO=( "$PREFIX${(j::)FLAGS}${(j::)DIVERGENCES}$SUFFIX" )
  [[ ${#FLAGS[@]} -ne 0 ]] && [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO=( "$PREFIX${(j::)FLAGS}"%{$fg[black]%}%{$reset_color%}"${(j::)DIVERGENCES}$SUFFIX" )
  if [ "$GIT_TAGS" != "" ]; then
    GIT_INFO+=( " %{$fg[black]%}$GIT_LOCATION <$GIT_TAGS>%{$reset_color%}" )
  else
    GIT_INFO+=( " %{$fg[black]%}$GIT_LOCATION%{$reset_color%}" )
  fi
  echo "${(j::)GIT_INFO}"
}
