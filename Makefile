TAG = $(shell git describe --always --tags)
DOCKER_REPO = hub.docker.com/u/binhqnguyen/elte/srslte
DOCKER_IMAGE = $(DOCKER_REPO):$(TAG)
SRSLTE = srsLTE

.PHONY: docker-build
docker-build:
	@if [ ! -d "$(SRSLTE)" ]; then\
		git clone https://github.com/srsLTE/srsLTE.git $(SRSLTE); \
	fi
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run:
    sudo docker run --privileged --rm --name srsepc -dit $(DOCKER_IMAGE)   

.PHONY: docker-push
docker-push:
	docker push $(DOCKER_IMAGE)
