#!/usr/bin/env python3
"""Ghostwrite history of previously private repo as empty commits (2022)"""

import os
import re
import subprocess

from tqdm import tqdm

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Setup
# └─────────────────────────────────────────────────────────────────────────────
history_file = r'C:\~\log.txt'
repo_dir = r'C:\~\.sel2'
os.chdir(repo_dir)

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Main
# └─────────────────────────────────────────────────────────────────────────────
with open(history_file, 'r', encoding='utf-8') as f:
    history = f.read()
commits = re.split(r'^commit .*?$', history, flags=re.M)
commits = [c.strip() for c in commits if c]

print(f'ghostwriting {len(commits)} commits...')
for c in tqdm(reversed(commits)):
    date = re.search(r'Date:\s+(.*)', c)[1]
    lines = c.split('\n')
    message = lines[3:]
    message = [line.strip() for line in message]
    message = '\n'.join(message)

    command = ['git', 'commit', '--allow-empty', '-m', message, '--date', date, '--quiet']
    subprocess.run(command)
print('done\n')

# Fix up commit/author dates by running:
# git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"' -f
