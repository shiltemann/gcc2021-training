#!/bin/bash
mkdir -p .cache
rm -f tools.yml
for directory in $(./bin/extract-tutorials.sh); do
	tutorial="../training-material/$directory/tutorial.md"
	safe="$(echo "$directory" | sed 's|/|-|g')"
	wf_dir="../training-material/$directory/workflows"
	echo "$directory:" >> tools.yml
	if [[ -d "$wf_dir" ]]; then
		for ga in $(find "$wf_dir/"*.ga); do
			echo "  ## $ga" >> tools.yml
			grep 'toolshed.g2.bx.psu.edu/repos[^"]*' -o  "$ga" | sort -u | sed 's/^/  - /g' >> tools.yml
		done
	fi

	echo "  ## tools" >> tools.yml
	tool_ids="$(cat "$tutorial" | grep '{% tool' | sed 's/%}.*//g' | grep '(toolshed.*)' -o | sed -e 's/(\|)//g' | sort -u)"
	lines=$(echo "$tool_ids" | wc -l)
	if (( lines > 1 )); then
		for tool_id in $tool_ids; do
			echo "$tool_id" | sed 's/^/  - /g' >> tools.yml

		done
	else
		echo "$tutorial missing tool IDs"
	fi
done
