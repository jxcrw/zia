#!/usr/bin/env python3
"""Batch-rename files in a directory with regex (2022)"""

import os
from pathlib import Path
import re
import sys


# Parse args
find = repl = ''
if len(sys.argv) >= 3:
    find = rf'{sys.argv[1]}'
    repl = rf'{sys.argv[2]}'

# Rename
cwd = os.getcwd()
path = Path(cwd)
for p in path.rglob('**/*'):
    if p.is_file():
        name = str(p.resolve())
        new_name = re.sub(find, repl, name)

        if new_name != name:
            p.replace(new_name)
            print(f'{name} → {new_name}')
