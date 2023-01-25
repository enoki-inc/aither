import sys
import pathlib
import lz4.block
import json
import os

path = pathlib.Path.home().joinpath('.mozilla/firefox')
files = path.glob('*default*/sessionstore-backups/recovery.js*')

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')
filepath = '/' + team_name + '/' + workspace_name + '/tmp/urls.txt'
if not os.path.exists(os.path.dirname(filepath)):
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
try:
    template = sys.argv[1]
except IndexError:
    template = '%s\n'
with open(filepath, 'w') as file:
    for f in files:
        b = f.read_bytes()
        if b[:8] == b'mozLz40\0':
            b = lz4.block.decompress(b[8:])
        j = json.loads(b)
        for w in j['windows']:
            for t in w['tabs']:
                i = t['index'] - 1
                file.write(t['entries'][i]['url'])
                file.write('\n')
