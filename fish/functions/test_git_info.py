#!/usr/bin/env python3
"""Test git_info"""

from git_info import get_git_info

gs0 = r'''
On branch main
Your branch and 'origin/main' have diverged,
and have 3 and 1 different commits each, respectively.

Changes to be committed:
        new file:   fish/config.fish
        new file:   fish/fish_variables
        new file:   fish/hello.py
        modified:   zsh/.zshrc

Changes not staged for commit:
        modified:   fish/config.fish
        modified:   fish/fish_variables
        modified:   fish/hello.py
        modified:   zsh/.zshrc
        modified:   zsh/do.zsh

Untracked files:
        fish/functions/
        pizza.txt
'''

gs1 = '''
On branch main
Your branch is ahead of 'origin/main' by 1 commit.

Changes to be committed:
        modified:   README.md
'''

gs2 = '''
On branch main
Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.

nothing to commit, working tree clean
'''


def test_get_git_info():
    # gs0: 4c 5y 2g 1b 1r main
    # gs1: 1c 1b main
    # gs2: 1r main
    pass
