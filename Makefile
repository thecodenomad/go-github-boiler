# Setup cruft

ifndef VERBOSE
.SILENT:
endif

DOCKER_REPO="codenomad/go-github-boiler"

# Default to LOCAL builds unless explicity set to 0
LOCAL ?= $(or ${local},1)
VERSION ?= $(or ${version},$(shell git rev-parse --short HEAD))
ifeq ($(LOCAL), 1)
	VERSION="local"
endif

# Work directory
.work:
	mkdir -p .work

# Targets
.PHONY: build
build: main
.work/main: .work
	go build -o .work/main main.go

.PHONY: clean
clean:
	rm -rf coverage.out coverage.html main .work

.PHONY: covtest
covtest: clean
	go test -v -coverprofile=coverage.out ./...

.PHONY: covreport
covreport: clean covtest
	go tool cover -html=coverage.out -o coverage.html

.PHONY: docker
docker: .work/docker_build
.work/docker_build: .work/main
	echo "Creating docker image version: ${VERSION}"
	docker build -f docker/Dockerfile . -t ${DOCKER_REPO} -t ${DOCKER_REPO}:${VERSION}
	echo "${VERSION}" > .work/docker_build

.PHONY: docker-run
docker-run: .work/docker_build
	echo "Running go-github-boiler version: ${VERSION}"
	docker run ${DOCKER_REPO}:${VERSION}

.PHONY: docker-push
docker-push: .work/docker_build
	if [[ "${VERSION}" == "local" ]]; then echo "Running locally, won't push"; exit 1; fi
	echo "Running go-github-boiler version: ${VERSION}"
	docker push ${DOCKER_REPO}:${VERSION}

.PHONY: lint
lint:
	golint -set_exit_status ./...

.PHONY: test
test:
	go test ./...

.PHONY: vet
vet:
	go vet ./...
