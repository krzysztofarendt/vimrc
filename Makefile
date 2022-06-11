.PHONE: build run stop rm

build: stop rm
	DOCKER_BUILDKIT=1 docker build -t vim .

run:
	docker run \
		-ti \
		--mount type=bind,source="$(PWD)",target="/workdir" \
		--name vim_container \
		vim vim .

stop:
	-docker stop vim_container

rm:
	-docker rm vim_container
