#!/bin/bash
for tuto in $(cat _data/tools.yml | y2j | jq '. | to_entries[]' -c); do
	tutorial="$(echo "$tuto" | jq .key -r)"
	echo -n "$tutorial/tutorial.html:"
	tools="$(echo "$tuto" | jq '.value | .[]?' -r)"
	tools_c=$(echo "$tools" | wc -c)
	if (( tools_c == 1 )); then
		echo " {}"
	else
		printf '\n'

		eu=1
		usa=1
		au=1
		be=1

		for tool_id in $tools; do
			echo "  $tool_id:"
			for server in {eu,org,org.au,be}; do
				expected_version=$(echo $tool_id | cut -d/ -f6)
				seen_version=$(cache curl --silent https://usegalaxy.${server}/api/tools/$tool_id | jq -r .version)
				echo "    $server: {seen: \"$seen_version\", exp: \"$expected_version\"}"
				if [[ "$server" == "eu" ]] && [[ "$seen_version" == "null" ]]; then
					eu=0
				fi
				if [[ "$server" == "org" ]] && [[ "$seen_version" == "null" ]]; then
					usa=0
				fi
				if [[ "$server" == "org.au" ]] && [[ "$seen_version" == "null" ]]; then
					au=0
				fi
				if [[ "$server" == "be" ]] && [[ "$seen_version" == "null" ]]; then
					be=0
				fi
			done
		done
		echo "  overall:"
		echo "    eu: $eu"
		echo "    org: $usa"
		echo "    org.au: $au"
		echo "    be: $be"

	fi

done
