#!/usr/bin/env python3

import time
import sys
import os
import datetime

os.chdir(os.path.dirname(sys.argv[0]))

f = open('reminders').read()

if f.strip() == '':
    sys.exit()

current_date = datetime.datetime.now() - datetime.timedelta(hours=6)
if len(sys.argv) > 1 and sys.argv[1] == 'dismiss':
    f = open('reminder-dismissed', 'w')
    f.write(current_date.strftime('%Y-%m-%d'))
    f.close()

if os.path.exists('reminder-dismissed') and open('reminder-dismissed').read().strip() == current_date.strftime('%Y-%m-%d'):
    sys.exit(1)

highlight_colour = {i.split(':')[0]: i.split(':')[1].strip() for i in open(os.path.join(os.environ['HOME'], '.Xresources')).read().split('\n') if i.strip() != ''}

good_colour = '%{F' + highlight_colour['colorscheme.foreground'].strip('#') + '}'
bad_colour = '%{F' + highlight_colour['colorscheme.highlight'].strip('#') + '}'

now = datetime.datetime.now()
colour = [good_colour, bad_colour][now.hour >= 19]

print('%{T0}' + colour + f)
