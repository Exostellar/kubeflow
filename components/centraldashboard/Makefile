IMG ?= kubeflow/centraldashboard
TAG ?= $(shell git describe --tags --always --dirty)
COMMIT = $(shell git rev-parse HEAD)
DOCKERFILE ?= Dockerfile
ARCH ?= linux/amd64
AWS_ACCOUNT_ID = 374070299695
REGION = us-east-2
ECR_REPO = $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(IMG)

all: build

clean:
	rm -rf coverage/ dist/ node_modules/ .nyc_output/

build-local:
	npm install

test: build-local
	npm run coverage

docker-build:
	docker build ${DOCKER_BUILD_OPTS} -t $(IMG):$(TAG) . \
	  --build-arg kubeflowversion=$(shell git describe --abbrev=0 --tags) \
	  --build-arg commit=$(COMMIT) \
      --label=git-version=$(TAG)
	@echo Built $(IMG):$(TAG)

docker-push: docker-build
	# Tag the image for ECR
	docker tag $(IMG):$(TAG) $(ECR_REPO):$(TAG)
	# Push to ECR
	docker push $(ECR_REPO):$(TAG)


.PHONY: docker-build-multi-arch
docker-build-multi-arch: ##  Build multi-arch docker images with docker buildx
	docker buildx build --load --platform ${ARCH} --tag ${IMG}:${TAG} -f ${DOCKERFILE} . --build-arg kubeflowversion=$(shell git describe --abbrev=0 --tags) --build-arg commit=$(COMMIT) --label=git-version=$(TAG)


.PHONY: docker-build-push-multi-arch
docker-build-push-multi-arch: ## Build multi-arch docker images with docker buildx and push to docker registry
	docker buildx build --platform ${ARCH} --tag ${IMG}:${TAG} --push -f ${DOCKERFILE} . --build-arg kubeflowversion=$(shell git describe --abbrev=0 --tags) --build-arg commit=$(COMMIT) --label=git-version=$(TAG)

# Build but don't attach the latest tag. This allows manual testing/inspection of the image
# first.
push: build
	gcloud docker -- push $(IMG):$(TAG)
	@echo Pushed $(IMG) with  :$(TAG) tags

