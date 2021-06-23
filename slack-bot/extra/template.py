#!/usr/bin/env python
import sys
import json

region = sys.argv[1]
fn = sys.argv[2]
course = sys.argv[3]

replacements = {
    'Pacific/Auckland': {
        'REGION': 'Asia/Pacific :earth_asia:',
        'BYE_REGION': 'Americas :earth_americas:'
    },
    'Europe/Amsterdam': {
        'REGION': 'Africa/Middle East/Europe :earth_africa:',
        'BYE_REGION': 'Asia/Pacific :earth_asia:'
    },
    'America/New_York': {
        'REGION': 'Americas :earth_americas:',
        'BYE_REGION': 'Europe/Middle East/Africa :earth_africa:'
    },
    'gat': {
        'SOCIAL_CHANNEL': '#general',
        'EVENT': 'GCC-GAT2021',
        'COURSE_WEBSITE': 'https://galaxyproject.org/events/gcc2021/training/admin-track',
    },
    'gtn': {
        'SOCIAL_CHANNEL': '#social',
        'EVENT': 'GCC2021',
        'COURSE_WEBSITE': 'https://galaxyproject.org/events/gcc2021/training/',
    }
}

with open(fn, 'r') as handle:
    data = handle.read()

for k, v in replacements[region].items():
    data = data.replace(f'<{k}>', v)

for k, v in replacements[course].items():
    data = data.replace(f'<{k}>', v)

print(data)
