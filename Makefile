_data/servers.yml: tools.yml
	bash bin/check.sh > _data/servers.yml

tools.yml: training_sessions.yaml
	bin/build-tool-check.sh
