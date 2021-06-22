#!/usr/bin/env python
import sys
import json

region = sys.argv[1]
fn = sys.argv[2]

replacements = {
    'Pacific/Auckland': {
        'WELCOME_REGION': '*Good morning/afternoon Africa, Middle East, and Europe!* :earth_africa:',
        'BYE_REGION': 'Asia/Pacific :earth_asia: region helpers are ending their workday, so it\'s over to Middle East/Europe/Africa :earth_africa:!'
    },
    'Europe/Amsterdam': {
        'WELCOME_REGION': 'Good Morning/Afternoon South, Central, and North America! :earth_americas:',
        'BYE_REGION': 'Europe/Middle East/Africa :earth_africa: region helpers are ending their workday, so it\'s over to the Americas :earth_americas:!'
    },
    'America/New_York': {
        'WELCOME_REGION': '*Good morning/afternoon Asia/Pacific!* :earth_asia:',
        'BYE_REGION': 'Americas :earth_americas: region helpers are ending their workday, so it\'s over to Asia/Pacific :earth_asia:!'
    }
}

with open(fn, 'r') as handle:
    data = handle.read()

for k, v in replacements[region].items():
    data = data.replace(f'<{k}>', v)

print(data)
