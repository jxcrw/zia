#!/usr/bin/env zsh
# zsh aliases/functions

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Aliases
# └─────────────────────────────────────────────────────────────────────────────
# General
alias {home,h}='cd ~'
alias {up,u}='cd ..'
alias ls='LC_COLLATE=C ls -NA --color --group-directories-first'
alias copy='cp'
alias move='mv'
alias remove='rm -rf'
alias file='touch'
alias folder='mkdir'
alias directory='echo $PWD'
alias directories='dirs -v'
alias stats='df -h && echo && free -g' # ROM and RAM usage (GB)
alias dist='cat /etc/*-release'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias suspend='systemctl suspend'

# WSL
alias bash='bash.exe'
alias git='git.exe'
alias fd='fd.exe'
alias rip='rg.exe'
alias count='scc.exe'

alias python='python.exe'
alias pip='pip3.exe'
alias pipdeptree='pipdeptree.exe'
alias poetry='poetry.exe'
alias pytest='pytest.exe'
alias virtualenv='virtualenv.exe'
alias tox='tox.exe'

alias cargo='cargo.exe'
alias rust='rustc.exe'
alias rustup='rustup.exe'
alias rustlings='rustlings.exe'

alias subl='subl.exe'
alias edit='neovide.exe --multigrid'
alias neovide='neovide.exe --multigrid'
alias choco='choco.exe'
alias rclone='rclone.exe'
alias kopia='kopia.exe'

# Dotfile VC (https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/)
# TODO: sel scan command to pick up directories of dotfiles that can change
alias sel='git.exe --git-dir=C:/~/.sel/.git --work-tree=C:/'
selall() { sel commit -am "$1" }

# Other
alias fgit='zsh "$HOME/.sel/_src/fgit.zsh"'

# Misc
alias Chinese='python "$HOME/langs/zh/Chinese Grammar Wiki/study.py"'
alias matrix='cmatrix -u 15 -s'
alias rename='python "$WINHOME/.sel/_src/rename.py"'

robocopy() { robocopy.exe "$1" "$2" /mir /MT:14 /unilog:"C:/~/.sel/.var/robocopy.log" }

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Zsh General
# └─────────────────────────────────────────────────────────────────────────────
precmd() {
  # Stuff to do after every command
  set_shell_title

  precmd() {
    # Stuff to do for all commands other than first command
    set_shell_title
    echo
  }
}

set_shell_title() {
  # Set shell title to abbreviated CWD
  print -Pn "\e]2;%(4~|%-1~/../%2~|%~)\a"
}

a() {
  # Cross-platform zoxide.
  n_args=$#
  if [[ $n_args -eq 0 ]] then
    __zoxide_zi
  else
    if [[ "$@" == *\\* ]] then
      __zoxide_z $(wslpath "$1") # Windows-style path
    else
      __zoxide_z "$@"            # Unix-style path
    fi
  fi
}

profile() {
  # Profile shell startup time
  for i in $(seq 1 10); do
    time $SHELL -i -c exit
  done
}

alias o='open'
open() {
  # Fuzzy-find and open files
  target_file="$( cat /mnt/c/~/.sel/.var/fd.log | fzf )"

  if [[ $1 == "aslauncher" ]] then
    AutoHotkey.exe 'C:\~\dev\superhi\fzf_open.ahk' 'end'
  fi

  sleep 0.1
  if [ -z "$target_file" ];
    then # nothing
    else explorer.exe "$target_file"
  fi
}

path() {
  n_args=$#
  if [[ $n_args -eq 0 ]] then
    echo $PWD
  else
    wslpath $@
  fi
}

pretty() {
  # Display %F codes for colors.
  for c in {0..7}; do
  b=$((c+8))
  print -P - "%F{$c}$c%f -> %F{$b}$b%f"
  done
}

foldercd() {
  mkdir $1 && cd $_
}

function length() {
  # Calculate length of visible string.
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
# │ Git
# └─────────────────────────────────────────────────────────────────────────────
git_submodule_remove() {
  # Fully remove a submodule (https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule).
  git rm $1
  rm -rf .git/modules/$1
  git config --remove-section submodule.$1
}

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Sys Admin
# └─────────────────────────────────────────────────────────────────────────────
fastscan_temp='C:\Users\jak\Dropbox\fastscan_temp.txt'
fastscan_pull='C:\Users\jak\Dropbox\fastscan_pull.txt'

hi() {
  # pull all
  thaw
}

bye() { freeze ; push all ; rundll32.exe powrprof.dll, SetSuspendState Sleep}

push() {
  # Sync files to remote
  n_args=$#
  log_file='C:\~\.sel\.logs\rclone_push.log'
  exclude_file='C:\~\.sel\_env\rclone_exclude.txt'

  if [[ $n_args -eq 0 ]] then
    python "C:\~\.sel\_src\fastscan.py"
    echo "push fast..."
    rclone copy "C:/" "GD:/" --progress --no-traverse --files-from $fastscan_temp --copy-links

  elif [[ $1 == "all" ]] then
    python "C:\~\.sel\_src\fastscan.py"
    echo "kopia snapshot..."
    kopia.exe snapshot create --all --log-level=warning --no-progress >> /mnt/c/~/.sel/.logs/kopia.log 2>&1
    echo "push all..."
    rclone sync "C:\~" "GD:\~" --fast-list --progress --drive-skip-gdocs --exclude-from=$exclude_file --log-file=$log_file --copy-links

  elif [[ $n_args -eq 2 ]] then
    echo "push specified..."
    rclone sync "$1" "$2" --fast-list --progress --drive-skip-gdocs --exclude-from=$exclude_file --log-file=$log_file

  else
    echo "no mode specified"
  fi
}

pull() {
  # Sync files from remote
  n_args=$#
  log_file='C:\~\.sel\.logs\rclone_pull.log'

  if [[ $n_args -eq 0 ]] then
    echo "pull fast..."
    rclone copy "GD:/" "C:/" --progress --no-traverse --files-from $fastscan_pull
    echo "" > $(path $fastscan_pull)

  elif [[ $1 == "all" ]] then
    echo "pull all..."
    rclone sync "GD:\~" "C:\~" --fast-list --progress --drive-export-formats link.html --log-file=$log_file
    echo "" > $(path $fastscan_pull)

  elif [[ $n_args -eq 2 ]] then
    echo "pull specified..."
    rclone sync "$1" "$2" --fast-list --progress --drive-export-formats link.html --log-file=$log_file

  else
    echo "no mode specified"
  fi

  exec zsh
}

freeze() {
  # Freeze current environment (apps/packages/envars/etc.)
  echo -n $fg[cyan]
  echo -n freezing scoop... ; scoop export > '/mnt/c/~/.sel/_env/scoop.json'
  echo -n python... ; pipdeptree > '/mnt/c/~/.sel/_env/python.txt'
  echo -n envars... ; reg.exe export 'HKEY_CURRENT_USER\Environment' 'C:\~\.sel\_env\envars.reg' /y > /dev/null
  echo "done\n"$reset_color
  # freeze file associations
  # freeze non-scoop apps
}

thaw() {
  # Thaw frozen environment (packages/envars/etc.)
  echo "thawing..."
  scoop import "C:\~\.sel\_env\scoop.json"
  pip install -r 'C:\~\.sel\_env\python.txt' --upgrade
  reg.exe import 'C:\~\.sel\_env\envars.reg'
  # everything opposite of freeze :)
}
