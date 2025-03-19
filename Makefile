# Note: Ensure variable declarations in makefiles have NO trailing whitespace
#       This can be achieved by sliding in the # comment-sign directly after the value
TIME_TAG := $(shell date +%s)#  - the unix epoch
BUILD_TAG ?= ${TIME_TAG}#       - provide the BUILD_TAG in the environment, or fallback to time
REG_NS ?= "terriafe"#           - allow the namespace to be overridden to e.g. ghcr.io/fair-ease/terriafe

.PHONY: help docker-build docker-push docker-start docker-stop
.DEFAULT_GOAL := help


help:  ## Shows this list of available targets and their effect.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# usage `make BUILD_TAG=0.2 dc` to include a specific tag to the build docker images
dc: ## Builds the docker-images as described in the local docker-compose.yml for ${REG_NS} and ${BUILD_TAG}
	@echo "building all images as described in local docker-compose.yml for registry/namespace=${REG_NS} with tag=${BUILD_TAG}"
	@env BUILD_TAG=${BUILD_TAG} REG_NS=${REG_NS} bash -c "docker compose build --no-cache"
	

# usage `make REG_NS=ghcr.io/fair-ease/terriafe dc-push` to push images to github-container-registry
dc-push: dc ## Builds, then pushes the docker-images to ${REG_NS}
	@echo "pushing docker images tagged=${BUILD_TAG} to registry/namespace=${REG_NS}"
ifeq ($(shell echo ${REG_NS} | egrep '.+/.+'),)  # the 'shell' call is essential
# empty match indicates no registry-part is available to push to
	@echo "not pushing docker images if no / between non-empty parts in REG_NS=${REG_NS}"
	@exit 1
else
	docker push ${REG_NS}/${PROJECT}:${BUILD_TAG}; 
endif


dc-start:  ## Launches local-named variants of the containers/images in docker-compose.yml
	@echo "launching docker-stack for local test with default names and tags"
	@TMCFG="$$(./secrets-merge.sh)" docker compose up -d


dc-stop:  ## Stops local-named variants of those containers
	@echo "shutting down docker-stack from docker-start"
	@docker compose down


dc-exec:  ## Opens an interactive shell into the terria-map container
	@echo "starting endless listing of loggs - press «ctrl-c» to stop"
	@docker compose exec terriafe /bin/bash


dc-logs:  ## Opens the logs to the terria-map container
	@echo "starting endless listing of loggs - press «ctrl-c» to stop"
	@docker compose logs terriafe -f

