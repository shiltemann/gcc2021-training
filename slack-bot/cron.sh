#!/bin/bash
# We have a directory of messages with timestamps.
# If they have not been sent and time > their time, we send them.
# Once sent, we document this in a logfile.
NOW=$(date +%s)

if [[ -z "${SLACK_URL}" ]]; then
	echo Please set SLACK_URL
	exit 1
fi

for fn in scheduled/*.json; do
	ds=$(echo "$fn" | sed 's|scheduled/||g' | cut -c1-25)
	ts=$(date -d "$ds" +%s)
	if (( ts < NOW )); then
		# Send the message
		echo "$fn has not been sent"
		response=$(curl --silent -X POST -H 'Content-type: application/json' --data "@$fn" "${SLACK_URL}")
		# If it was received OK
		if [[ "$response" == "ok" ]]; then
			mv "$fn" "sent/"
		else
			echo "$response"
		fi
	else
		# We're not sending this yet
		true
	fi
done
