#!/usr/bin/env fish
# Jak Crow 2022-∞ 💗

set -U fish_greeting
set -U EDITOR nano
set -U WINHOME 'C:/~'


# General
alias home='cd ~'
alias u='cd ..'
alias ls='LC_COLLATE=C command ls -NA --color --group-directories-first'
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
alias lines='scc.exe'

alias python='python.exe'
alias pip='pip3.exe'
alias pi='ipython.exe'
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

# Misc
alias matrix='cmatrix -u 15 -s'
alias fgit='zsh "$HOME/.sel/_src/fgit.zsh"'
alias rename='python "$WINHOME/.sel/_src/rename.py"'
alias Chinese='python "$WINHOME/lang/zh/Chinese Grammar Wiki/study.py"'

# robocopy() { robocopy.exe "$1" "$2" /mir /MT:14 /unilog:"C:/~/.sel/.var/robocopy.log" }

function fish_title
    echo (prompt_pwd -d 0)
end

function fish_prompt
    set_color cyan; echo -n (prompt_pwd -D 2)
    set_color magenta; echo -n ' > '
    set_color normal
end

set -U LS_COLOR 'rs=0:di=01;34:ln=01;3:mh=00:fi=40;33:pi=40;33:so=01;35:do=01;35:bd=40;33;cd=40;33;or=40;31;mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=01;37'


function profile
    for x in (seq 3)
    time fish -i -c exit
    end
end


zoxide init --cmd a fish | source
