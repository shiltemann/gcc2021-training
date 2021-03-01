#!/bin/bash
start="2021-02-14 11:09:25+01:00"

for day in {15..18}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-02-$day 18:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 template.py $region shift-change-template.json > "scheduled/${sendafter}-shift-change.json"
	done
done
