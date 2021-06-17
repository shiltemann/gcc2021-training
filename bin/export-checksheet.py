#!/usr/bin/env python
import yaml
import sys
import csv

data = yaml.load(sys.stdin)
spamwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)


for k, v in data.items():
    for s in v.get('sessions', []):
        v = s.get('videos', [])
        v = [x['link'] for x in v if x['link'] is not None]
        v = [f'https://youtu.be/{x}' for x in v]

        m = s.get('material', [])
        m = [x for x in m if x['link'] is not None]
        m2 = []
        for x in m:
            if '://' not in x['link']:
                x['link'] = "https://training.galaxyproject.org/training-material/" + x['link']
            m2.append(f"{x['link']}")
        m = m2


        faq = s.get('faq', None)
        if faq:
            faq = f'=HYPERLINK("{faq}", "faq")'
        else:
            faq = "None"

        if v and m:
            data = [k, s['name'], "\n".join(v) if v else "None", "\n".join(m) if m else "None", faq]
            spamwriter.writerow(data)
