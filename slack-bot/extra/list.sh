#!/bin/bash
process_folder(){
	folder="$1"
	slack_url="$2"

	for fn in scheduled/$1/*.json; do
		ds=$(echo "$fn" | cut -d/ -f3 | cut -c1-25)
		ts=$(date -d "$ds" "+%Y-%m-%d %H:%M %Z")
		wc=$(wc -c "$fn" | cut -d' ' -f 1)
		echo -e "$folder\t$ts\t$fn\t$wc"
	done
}

process_folder gat | sort
process_folder gtn | sort
