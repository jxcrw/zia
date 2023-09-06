#!/usr/bin/env fish
# Jak Crow 2022 - ∞ 💗

set -U fish_greeting
set -g fish_term24bit 1
set -U EDITOR nano
set -U WINHOME 'C:/~'

set -U fish_color_selection --background='304B4F'

# TODO: Have fisher install plugins into dedicated folders, then source folders (better organization)
# set fish_function_path ~/.zia/fish/functions/*/ $fish_function_path


# General
alias home='cd ~'
alias zia='cd ~/.zia'
alias crow='cd ~/arc/crow'
alias u='cd ..'
alias ls='LC_COLLATE=C command ls -NA --color --group-directories-first'
alias copy='cp'
alias move='mv'
alias remove='rm -rf'
alias file='touch'
alias folder='mkdir'
alias directory='echo $PWD'
alias directories='dirh'
alias stats='df -h && echo && free -g' # ROM and RAM usage (GB)
alias dist='cat /etc/*-release'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias suspend='systemctl suspend'
alias calendar='cal -wy'

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
alias fgit='zsh "$HOME/.zia/_src/fgit.zsh"'
alias rename='python "$WINHOME/.zia/_src/rename.py"'
alias Chinese='python "$WINHOME/lang/zh/Chinese Grammar Wiki/study.py"'
alias lifehud='python "$WINHOME/dev/lifehud/lifehud.py"'
alias cards='python cli.py'

# robocopy() { robocopy.exe "$1" "$2" /mir /MT:14 /unilog:"C:/~/.zia/.var/robocopy.log" }

function fish_title
    echo (prompt_pwd -d 0)
end

function fish_prompt
    set_color cyan; echo -n (prompt_pwd -D 2)
    set_color magenta; echo -n ' > '
    set_color normal
end

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

function bye
    freeze
    python "C:\~\.zia\_src\fastscan.py"
    echo "kopia snapshot..."
    kopia.exe snapshot create --all --log-level=warning --no-progress >> /mnt/c/~/.zia/.logs/kopia.log 2>&1
    echo "push all..."

    set exclude_file 'C:\~\.zia\_env\rclone_exclude.txt'
    set log_file 'C:\~\.zia\.logs\rclone_push.log'
    rclone sync 'C:\~' 'GD:\~' --fast-list --progress --drive-skip-gdocs --exclude-from=$exclude_file --log-file=$log_file --copy-links

    rundll32.exe powrprof.dll, SetSuspendState Sleep
end


function freeze # Freeze current environment (apps/packages/envars/etc.)
  set_color cyan
  echo -n freezing scoop... ; scoop export > '/mnt/c/~/.zia/_env/scoop.json'
  echo -n python... ; pipdeptree > '/mnt/c/~/.zia/_env/python.txt'
  echo -n envars... ; reg.exe export 'HKEY_CURRENT_USER\Environment' 'C:\~\.zia\_env\envars.reg' /y > /dev/null
  echo "done"; set_color normal
  # freeze file associations
  # freeze non-scoop apps
end


function fish_right_prompt
    # TODO: Make this fast, see tide (https://github.com/IlanCosman/tide) and gitstatus (https://github.com/romkatv/gitstatus)
    set git_info (python 'C:/~/.zia/fish/functions/git_info.py')
    echo $git_info
end

function space_prompts --on-event fish_postexec
   echo
end

set -U LS_COLOR 'rs=0:di=01;34:ln=01;3:mh=00:fi=40;33:pi=40;33:so=01;35:do=01;35:bd=40;33;cd=40;33;or=40;31;mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=01;37'


# printf \e\[H\e\[2J

function print_pizza
    echo "pizza"
end

function profile
    for x in (seq 3)
    time fish -i -c exit
    end
end


zoxide init --cmd a fish | source


# Tweak according to need. This is not a complete list of keys!
set --local letters 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'
set --local numbers '1234567890'
set --local special '!@#$%^&*_+-=\\;,./<>?:|'
set --local pairs '\'"()[]{}'
set --local characters (string split '' "$letters$numbers$special$pairs")

# Use fish_key_reader to find out bindings. These are a combination of escape sequences and hex codes.
# The following should already be sent by your terminal:
set --local left                \e'[C'
set --local right               \e'[D'
set --local shift_left          \e'[1;2D'
set --local shift_right         \e'[1;2C'
set --local backspace           \x7f
set --local delete              \e'[3~'
set --local option_left         \eb
set --local option_right        \ef
# The following will need to be added to be sent by your terminal:
set --local option_shift_left   \e'[1;6D'
set --local option_shift_right  \e'[1;6C'
set --local command_shift_left  \e\[1\;2H
set --local command_shift_right \e\[1\;2F
set --local command_left        \ca
set --local command_right       \ce
set --local command_backspace   \cU
set --local command_delete      \ck
set --local option_backspace    \cw
set --local option_delete       \ed
set --local command_c           \cC
set --local command_x           \cX
set --local command_v           \cV

if functions --query _natural_selection
  bind $left                '_natural_selection forward-char'
  bind $right               '_natural_selection backward-char'
  bind $shift_left          '_natural_selection backward-char --is-selecting'
  bind $shift_right         '_natural_selection forward-char --is-selecting'
  bind $command_left        '_natural_selection beginning-of-line'
  bind $command_right       '_natural_selection end-of-line'
  bind $command_shift_left  '_natural_selection beginning-of-line --is-selecting'
  bind $command_shift_right '_natural_selection end-of-line --is-selecting'
  bind $option_left         '_natural_selection backward-word'
  bind $option_right        '_natural_selection forward-word'
  bind $option_shift_left   '_natural_selection backward-word --is-selecting'
  bind $option_shift_right  '_natural_selection forward-word --is-selecting'
  bind $delete              '_natural_selection delete-char'
  bind $backspace           '_natural_selection backward-delete-char'
  bind $command_delete      '_natural_selection kill-line'
  bind $command_backspace   '_natural_selection backward-kill-line'
  bind $option_backspace    '_natural_selection backward-kill-word'
  bind $option_delete       '_natural_selection kill-word'
  bind $command_c           'fish_clipboard_copy'
  bind $command_x           '_natural_selection cut-to-clipboard'
  bind $command_v           'fish_clipboard_paste'

  for character in $characters
    set --local escaped (string escape -- $character)
    bind $character "_natural_selection --is-character -- $escaped"
  end
end

function fish_user_key_bindings
    bind \e\[3\;8~ 'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'
    bind \b backward-kill-word
    bind \cU kill-whole-line
    bind \cY redo

    # Filesystem navigation
    # bind \e\[1\;5A prevd-or-backward-word # TODO: Do cd .. (up) in place like prevd/nextd
    bind \e\[1\;5D prevd-or-backward-word
    bind \e\[1\;5B prevd-or-backward-word
    bind \e\[1\;5C nextd-or-forward-word
end
