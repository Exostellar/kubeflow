IMG ?= jupyter-web-app
#TAG ?= $(shell git describe --tags --always --dirty)
TAG ?= latest
DOCKERFILE ?= jupyter/Dockerfile
ARCH ?= linux/amd64

docker-build:
	cd ../ && docker build -t ${IMG}:${TAG} -f ${DOCKERFILE} .

docker-push:
	docker tag ${IMG}:${TAG} 374070299695.dkr.ecr.us-east-2.amazonaws.com/kubeflow/${IMG}:${TAG}
	docker push 374070299695.dkr.ecr.us-east-2.amazonaws.com/kubeflow/${IMG}:${TAG}

.PHONY: docker-build-multi-arch
docker-build-multi-arch: ##  Build multi-arch docker images with docker buildx
	cd ../ && docker buildx build --platform ${ARCH} --tag ${IMG}:${TAG} -f ${DOCKERFILE} .

.PHONY: docker-build-push-multi-arch
docker-build-push-multi-arch: ## Build multi-arch docker images with docker buildx and push to docker registry 
	cd ../ && docker buildx build --platform ${ARCH} --tag ${IMG}:${TAG} --push -f ${DOCKERFILE} .

image: docker-build docker-push
all: image
