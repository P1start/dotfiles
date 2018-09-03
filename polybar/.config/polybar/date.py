#!/usr/bin/env python3

import datetime
import itertools
import sys
import os

filename = os.path.join(os.path.dirname(sys.argv[0]), 'timemode')

if not os.path.exists(filename):
    with open(filename, 'x') as f:
        f.write('0')

with open(filename) as f:
    mode = int(f.read())

if len(sys.argv) > 1:
    with open(filename, 'w') as f:
        f.write(str((mode + 1) % 2))

def card_character(suit, value):
    if value > 10:
        value += 1
    return chr(0x1F0A1 + 16*suit + value)

weekdays = ['☾', '♂', '☿', '♃', '♀', '♄', '%{T3}☉%{T1}']
suits = '♠♡♢♣'
values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

def name(day):
    acc = list(itertools.accumulate([0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]))

    # Day of year, starting from zero
    day_of_year = acc[day.month - 1] + day.day - 1

    if day_of_year == 364:
        return "🂿"
        #return "♕"
    elif day_of_year == 365:
        return "🃏"
        #return "♛"

    week = day_of_year // 7
    weekday = day_of_year % 7
    value = week % 13
    suit = week // 13

    return str(day.year) + ' %{T1}' + card_character(suit, value) + '%{T1}' + weekdays[weekday]
    #return str(day.year) + ' %{T13}3' + '%{T1}' + values[value] + ' ' + weekdays[weekday]

months = ['%{T3}♑', '%{T3}♒', '%{T3}♓', '%{T3}♈', '%{T6}♉', '%{T3}♊', '%{T6}♋', '%{T3}♌', '%{T5}♍', '%{T3}♎', '%{T3}♏', '%{T6}♐']
def symbolic_name(day):
    weekday = day.isoweekday() - 1
    return str(day.year) + ' ' + weekdays[weekday] + ' ' + '{:02d}'.format(day.day) + ' %{T1}' + months[day.month - 1] + '%{T1}'

def decimal_time(t):
    return (t.hour*3600 + t.minute*60 + t.second + t.microsecond*1e-6) / 3600 / 24

def cool_time():
    # Days start approximately at sunrise, years start approximately on 'December' solstice (December 21)
    now = datetime.datetime.now() + datetime.timedelta(days=11, hours=-6)
    today = now.date()
    return name(today) + ' %{T10} %{T1}' + '{:.04f}'.format(decimal_time(now.time()))[2:]

def iso_time():
    now = datetime.datetime.now()
    return now.strftime('%Y-%m-%d %H:%M')

def symbolic_time():
    now = datetime.datetime.now()
    return symbolic_name(now) + now.strftime(' %H%M')

if mode == 0:
    print(cool_time())
elif mode == 1:
    print(symbolic_time())
elif mode == 2:
    print(iso_time())
