_data/servers.yml: _data/tools.yml
	bash bin/check.sh > _data/servers.yml

_data/tools.yml: training_sessions_science.yaml
	bin/build-tool-check.sh
