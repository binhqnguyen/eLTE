TAG = $(shell git describe --always --tags)
DOCKER_REPO = hub.docker.com/u/binhqnguyen/elte/srslte
DOCKER_IMAGE = $(DOCKER_REPO):$(TAG)
SRSLTE = srsLTE


.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


.PHONY: docker-build
docker-build:  ## Build the srsLte docker
	@if [ ! -d "$(SRSLTE)" ]; then\
		git clone https://github.com/srsLTE/srsLTE.git $(SRSLTE); \
	fi
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run: ## Run the srslte docker
	sudo docker run --privileged --rm --name srsepc -dit $(DOCKER_IMAGE)   

.PHONY: docker-push
docker-push: ## Push the srslte docker
	docker push $(DOCKER_IMAGE)

.PHONY: docker-in-ubuntu
docker-in-ubuntu: ## Build/run the srslte docker in virtualbox's ubuntu
	ansible-playbook elte_playbook_ubuntu.yml -K -e github_key="id_rsa"   

.PHONY: docker-in-centos
docker-in-centos: ## Build/run the srslte docker in virtualbox's centos
	ansible-playbook elte_playbook_centos.yml -K -e github_key="id_rsa"   
