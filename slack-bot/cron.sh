#!/bin/bash
# We have a directory of messages with timestamps.
# If they have not been sent and time > their time, we send them.
# Once sent, we document this in a logfile.
NOW=$(date +%s)

process_folder(){
	folder="$1"
	slack_url="$2"

	for fn in scheduled/$1/*.json; do
		ds=$(echo "$fn" | cut -d/ -f3 | cut -c1-25)
		ts=$(date -d "$ds" +%s)
		if (( ts < NOW )); then
			# Send the message
			echo "$fn has not been sent"
			response=$(curl --silent -X POST -H 'Content-type: application/json' --data "@$fn" "${slack_url}")

			# If it was received OK
			if [[ "$response" == "ok" ]]; then
				mv "$fn" "sent/$1/"
			else
				echo "$response"
			fi
		fi
	done
}

process_folder gat "$SLACK_API_GAT_GENERAL"
process_folder gtn "$SLACK_API_ANNOUNCEMENTS"
