import os
import re
from subprocess import PIPE, STDOUT, Popen, call

from colorama import Fore

# TODO: Add support for conflicts

GIT = 'git.exe'


def run_git(cmd):
    cmd = [GIT] + cmd
    sp = Popen(cmd, stdin=PIPE, stdout=PIPE, shell=True)
    sp.wait()
    stdout, _ = sp.communicate()
    return stdout.decode('utf-8')


def is_repo() -> bool:
    r = 'yep'
    if call(["git", "rev-parse", '--is-inside-work-tree'], stderr=STDOUT, stdout=open(os.devnull, 'w')) != 0:
        r = None
    return r


def get_git_info() -> str:
    gs = run_git(['status'])
    staged = get_num_xyz(gs, 'staged')
    mod = get_num_xyz(gs, 'modified')
    untracked = get_num_xyz(gs, 'untracked')
    ahead = get_num_ahead(gs)
    behind = get_num_behind(gs)
    branch = get_branch(gs)
    infos = [staged, mod, untracked, ahead, behind, branch]

    git_info = [i[0] + i[1] for i in infos if i[1]]
    git_info = ' '.join(git_info)
    return git_info


def get_num_xyz(git_status: str, xyz: str) -> str:
    color, r = None, ''
    match xyz:
        case 'staged':
            pattern = 'Changes to be committed:(.*?)$'
            color = Fore.CYAN
        case 'modified':
            pattern = 'Changes not staged for commit:(.*?)$'
            color = Fore.YELLOW
        case 'untracked':
            pattern = 'Untracked files:(.*?)$'
            color = Fore.GREEN
    if search := re.findall(pattern, git_status, re.DOTALL):
        search = search[0].split('\n\n') # Handles two cases: end of string or additional status info
        search = search[0].strip().split('\n')
        r = str(len(search))
    return color, r


def get_num_ahead(git_status: str) -> str:
    r = ''
    ahead1 = re.findall(r'Your branch is ahead of .* by (\d+) commit', git_status, re.DOTALL)
    ahead2 = re.findall(r'diverged,\nand have (\d+) and .* different commits each', git_status, re.DOTALL)
    if ahead1: r = str(ahead1[0])
    if ahead2: r = str(ahead2[0])
    return Fore.BLUE, r


def get_num_behind(git_status: str) -> str:
    r = ''
    behind1 = re.findall(r'Your branch is behind .* by (\d+) commit', git_status, re.DOTALL)
    behind2 = re.findall(r'diverged,\nand have .* and (\d+) different commits each', git_status, re.DOTALL)
    if behind1: r = str(behind1[0])
    if behind2: r = str(behind2[0])
    return Fore.RED, r


def get_branch(git_status: str) -> str:
    r = ''
    search = re.findall(r'On branch (.*?)\n', git_status)
    if search: r = search[0]
    return Fore.BLACK, r


if __name__ == '__main__':
    if is_repo():
        print(get_git_info())
