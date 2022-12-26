 #!/bin/zsh
# Run git commands on all git repos in the current
# Jak Crow 2020/09/29

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Initialization
# └─────────────────────────────────────────────────────────────────────────────
autoload colors && colors
alias -g git='git.exe -c color.status=always'
alias -g fd='fd.exe'

export LC_ALL=C

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Functions
# └─────────────────────────────────────────────────────────────────────────────
# Inspired by: https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
function git_info() {
  local GIT_LOCATION=$(git -C $1 rev-parse --abbrev-ref HEAD)
  local GIT_TAGS=$(git -C $1 tag -l --sort=-version:refname --points-at HEAD | xargs | sed -e 's/ /|/g')

  local -a DIVERGENCES
  local -a FLAGS

  local GIT_DIR="$(git -C $1 rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "🔥" )
  fi

  local n_staged=$(git -C $1 diff --name-only --cached 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_staged -gt 0 ]]; then
    staged="%{$fg[cyan]%}$n_staged%{$reset_color%}"
    FLAGS+=( " $staged" )
  fi

  local n_modified=$(git -C $1 diff --name-only --diff-filter=M 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_modified -gt 0 ]]; then
    modified="%{$fg[yellow]%}$n_modified%{$reset_color%}"
    FLAGS+=( " $modified" )
  fi

  local n_untracked=$(git -C $1 ls-files --other --exclude-standard 2> /dev/null | wc -l | tr -d ' ')
  if [[ $n_untracked -gt 0 ]]; then
    untracked="%{$fg[green]%}$n_untracked%{$reset_color%}"
    FLAGS+=( " $untracked" )
  fi

  local n_ahead="$(git -C $1 log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$n_ahead" -gt 0 ]; then
    ahead="%F{12}$n_ahead%f%{$reset_color%}"
    DIVERGENCES+=( " $ahead" )
  fi

  local n_behind="$(git -C $1 log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$n_behind" -gt 0 ]; then
    behind="%F{9}$n_behind%f%{$reset_color%}"
    DIVERGENCES+=( " $behind" )
  fi

  local -a GIT_INFO
  [[ ${#FLAGS[@]} -ne 0 ]] || [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO=( "$PREFIX${(j::)FLAGS}${(j::)DIVERGENCES}$SUFFIX" )
  [[ ${#FLAGS[@]} -ne 0 ]] && [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO=( "$PREFIX${(j::)FLAGS}${(j::)DIVERGENCES}$SUFFIX" )
  if [ "$GIT_TAGS" != "" ]; then
    GIT_INFO+=( " %{$fg[black]%}($GIT_LOCATION)<$GIT_TAGS>" )
  else
    GIT_INFO+=( " %{$fg[black]%}($GIT_LOCATION)" )
  fi
  echo "${(j::)GIT_INFO}"
}

function length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
  echo $x
}

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Main
# └─────────────────────────────────────────────────────────────────────────────
WIDTH_HEADER=80

git_command=$1

git_repos=$(fd -HI --type d \.git$ | sort | rev | cut -c 7- | rev | cut -c 3-)
git_repos=(${(f)git_repos}) # Split plaintext list of found repos on newlines to create a proper array

echo "\nRunning $fg[green]git "$@"$reset_color on ${#git_repos[@]} repos in $fg[cyan]${PWD}$reset_color\n"
echo $fg[black]$(date)$reset_color

i=0
for repo in $git_repos; do
  case $git_command in

    fetch|pull|push) # Run expensive git operations in the background (in parallel)
      remote=$(git -C $repo remote -v)
      if [[ $remote != "" ]] then # Only do for repos that actually have a remote
        git -C $repo "$@" &
      fi
      ;;

    count) # Count number of commits for specified authors in each repo
      echo $repo
      author_regex=$2
      filename=ga_count_"$(basename $PWD)"_"$2"_"$(date +%F)".txt
      echo $repo >> $filename
      git -C $repo log --all --date=short --pretty=format:%ad --author=$author_regex >> $filename
      echo "\n" >> $filename
      ;;

    *) # Run all other git operations in the foreground
      git_output=$(git -C $repo "$@" 2>&1)

      if [[ $git_output != "" ]] then # Only print stuff for dirty repos

        repo="${repo//\\//}" # Replace backlash with forward in repo path

        title="%F{black}│ $repo%f%{$reset_color%}"
        git_status="$(git_info $repo) │"

        len_title=$(length $title)
        len_status=$(length $git_status)
        len_spacer=$(( $WIDTH_HEADER - $len_title - $len_status + 2 ))
        spacer=$(printf "%0.s " $(seq 1 $len_spacer))

        heading="$title $spacer $git_status"
        print -P "$fg[black]\n┌──────────────────────────────────────────────────────────────────────────────┐\n$heading\n└──────────────────────────────────────────────────────────────────────────────┘"
        echo "$git_output"
        # echo "len_title: $len_title"
        # echo "len_stat: $len_status"
        # echo "len_spacer: $len_spacer\n"
      fi
      ;;

  esac
  ((i++))
done

wait
