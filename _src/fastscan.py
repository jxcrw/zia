#!/usr/bin/env python3
"""Create a curated list of files to be rcloned"""

import json
import os
from subprocess import PIPE, Popen
import time

CACHE_FILE = r'C:\~\.sel\.var\fastscan.json'
TEMP_FILE = r'C:\Users\jak\Dropbox\fastscan_temp.txt'
PULL_FILE = r'C:\Users\jak\Dropbox\fastscan_pull.txt'

SCANDIRS = [r'C:\~',
            r'C:\scoop\persist\sublime-text-dev',
            r'C:\scoop\persist\idea']

def scan_filesystem() -> dict:
    """Get a list of interesting files from the filesystem."""
    start = time.time()
    print('scanning...', end='')
    command = ['fd', '-a', '--hidden', '--no-ignore', '--type', 'f', '--changed-within', '48h', '.', '--exclude', '.tox', '--exclude', 'system', '--exclude', '.git']

    process = Popen(command + SCANDIRS, stdout=PIPE, stderr=PIPE)
    out, err = process.communicate()
    files = out.decode('utf-8').strip()
    files = files.strip().split('\n')
    files.sort()

    file_info = {}
    for f in files:
        stat = os.stat(f)
        file_info[f] = {'size': stat.st_size, 'mtime': stat.st_mtime_ns}

    end = time.time()
    print(f'done ({end - start:.3f}s)')
    print(f'{len(files)} → ', end='')
    return file_info


def identify_target_files(file_info: dict) -> dict:
    """Identify new and modified files."""
    with open(CACHE_FILE, 'r', encoding='utf-8') as f:
        cache = json.load(f)

    modified = {}
    for f, info in file_info.items():
        is_new = lambda: f not in cache
        is_modified = lambda: info['size'] != cache[f]['size'] or info['mtime'] != cache[f]['mtime']
        if is_new() or is_modified():
            modified[f] = info

    # Recache latest scan results
    with open(CACHE_FILE, 'w+', newline='\n', encoding='utf-8') as f:
        json.dump(file_info, f, indent=2, ensure_ascii=False)

    return modified


def create_fastscan_list(fileset: dict) -> None:
    """Transform specified fileset into rclone-readable format."""

    # Sanitize filenames
    excludes = {'fd.log', 'fastscan.json', 'strokes_sel.log'}
    files = {f: info for f, info in fileset.items() if os.path.basename(f) not in excludes}
    filenames = {f.replace('C:\\', '') for f in files}
    filenames = [f.replace('\\', '/') for f in filenames]
    filenames.sort(reverse=True)

    # Update pull file with latest results
    with open(PULL_FILE, 'r', encoding='utf-8') as f:
        existing_files = [line.strip() for line in f]

    existing_files.extend(filenames)
    existing_files = list(set(existing_files))
    existing_files.sort(reverse=True)

    with open(PULL_FILE, 'w+', newline='\n', encoding='utf-8') as f:
        f.write('\n'.join(existing_files))

    # Create temp file for current push
    with open(TEMP_FILE, 'w+', newline='\n', encoding='utf-8') as f:
        f.write('\n'.join(filenames))

    size = sum(info['size'] for info in files.values())
    print(f'{len(files)} new files ({size/1_000_000:.0f} MB)\n')


if __name__ == '__main__':
    file_info = scan_filesystem()
    fileset = identify_target_files(file_info)
    create_fastscan_list(fileset)
