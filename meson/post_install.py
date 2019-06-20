#!/usr/bin/env python3
import os
import subprocess

if not os.environ.get('DESTDIR'):
    print('Rebuilding desktop icons cache...')
    subprocess.call(['gtk-update-icon-cache', '/usr/share/icons/hicolor/'], shell=False)
