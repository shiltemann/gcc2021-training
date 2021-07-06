import glob
import os
import subprocess

fns = glob.glob("*.json")

hits = {}

for f in fns:
    key = f[0:24]
    if key not in hits:
        hits[key] = []

    hits[key].append(f)

for k, v in hits.items():
    if len(v) == 1:
        continue

    print(f"=== {k} ===")
    bad = []
    for file in v:
        date = subprocess.check_output(['stat', '-c', '%Y', file]).decode('utf-8').strip()
        date = int(date)
        bad.append((file, date))
    bad = sorted(bad, key=lambda x: x[1])

    os.unlink(bad[0][0])
