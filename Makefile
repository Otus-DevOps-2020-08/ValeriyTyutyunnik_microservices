USER_NAME=allien

build_all: build_comment build_ui build_post build_prometheus

build_ui: ./src/ui/
	cd ./src/ui && bash ./docker_build.sh

build_comment: ./src/comment
	cd ./src/comment && bash ./docker_build.sh

build_post: ./src/post-py
	cd ./src/post-py && bash ./docker_build.sh

build_prometheus: ./monitoring/prometheus/prometheus.yml
	cd ./monitoring/prometheus && docker build -t $(USER_NAME)/prometheus .

push_ui:
	docker push $(USER_NAME)/ui

push_comment:
	docker push $(USER_NAME)/comment

push_post:
	docker push $(USER_NAME)/post

push_prometheus:
	docker push $(USER_NAME)/prometheus

push_all: push_ui push_comment push_post push_prometheus
