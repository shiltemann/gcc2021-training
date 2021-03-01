#!/bin/bash
cat training_sessions.yaml | \
	python -c 'import sys; import yaml; import json; [sys.stdout.write(json.dumps(doc, indent=2)) for doc in yaml.load_all(sys.stdin)]' | \
	jq '. | to_entries[].value?.sessions | .[]? | .material | .[]? | .link' -r | \
	grep tutorial.html | \
	sort -u | \
	sed 's|/tutorial.html$||g'
