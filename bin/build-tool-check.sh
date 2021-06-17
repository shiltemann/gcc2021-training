#!/bin/bash
mkdir -p .cache
rm -f _data/tools.yml
for directory in $(./bin/extract-tutorials.sh); do
	tutorial="../training-material/$directory/tutorial.md"
	safe="$(echo "$directory" | sed 's|/|-|g')"
	wf_dir="../training-material/$directory/workflows"
	echo "$directory:" >> _data/tools.yml
	if [[ -d "$wf_dir" ]]; then
		for ga in $(find "$wf_dir/"*.ga); do
			echo "  ## $ga" >> _data/tools.yml
			grep 'toolshed.g2.bx.psu.edu/repos[^"]*' -o  "$ga" | sort -u | sed 's/^/  - /g' >> _data/tools.yml
		done
	fi

	echo "  ## tools" >> _data/tools.yml
	tool_ids="$(cat "$tutorial" | grep '{% tool' | sed 's/%}.*//g' | grep '(toolshed.*)' -o | sed -e 's/(\|)//g' | sort -u)"
	lines=$(echo "$tool_ids" | wc -l)
	if (( lines > 0 )); then
		for tool_id in $tool_ids; do
			echo "$tool_id" | sed 's/^/  - /g' >> _data/tools.yml
		done
	fi
done
