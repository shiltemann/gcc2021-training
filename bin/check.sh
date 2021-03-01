#!/bin/bash
for tuto in $(cat tools.yml | y2j | jq '. | to_entries[]' -c); do
	tutorial="$(echo "$tuto" | jq .key -r)"
	echo -n "$tutorial/tutorial.html:"
	tools="$(echo "$tuto" | jq '.value | .[]?' -r)"
	tools_c=$(echo "$tools" | wc -c)
	if (( tools_c == 1 )); then
		echo " {}"
	else
		printf '\n'
		emea=1
		apac=1
		amer=1
		for tool_id in $tools; do
			echo "  $tool_id:"
			for server in {eu,org,org.au}; do
				expected_version=$(echo $tool_id | cut -d/ -f6)
				seen_version=$(cache curl --silent https://usegalaxy.${server}/api/tools/$tool_id | jq -r .version)
				echo "    $server: {seen: \"$seen_version\", exp: \"$expected_version\"}"
				if [[ "$server" == "eu" ]] && [[ "$seen_version" == "null" ]]; then
					emea=0
				fi
				if [[ "$server" == "org" ]] && [[ "$seen_version" == "null" ]]; then
					amer=0
				fi
				if [[ "$server" == "org.au" ]] && [[ "$seen_version" == "null" ]]; then
					apac=0
				fi
			done
		done
		echo "  overall:"
		echo "    emea: $emea"
		echo "    apac: $apac"
		echo "    amer: $amer"

	fi

done
