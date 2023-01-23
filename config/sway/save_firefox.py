import sys
import pathlib
import lz4.block
import json

path = pathlib.Path.home().joinpath('.mozilla/firefox')
files = path.glob('*default*/sessionstore-backups/recovery.js*')

try:
    template = sys.argv[1]
except IndexError:
    template = '%s\n'
with open('/Users/sergionahas/enoki/storage/urls.txt', 'w') as file:
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