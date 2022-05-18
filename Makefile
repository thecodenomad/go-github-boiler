# Setup cruft

ifndef VERBOSE
.SILENT:
endif

# Version is the current git hash being worked on
VERSION=$(shell git rev-parse --short HEAD)

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
	docker build -f docker/Dockerfile . -t go-github-boiler:${VERSION}
	echo "${VERSION}" > .work/docker_build

.PHONY: docker-run
docker-run: .work/docker_build
	export VERSION=$(cat .work/docker_build)
	docker run go-github-boiler:${VERSION}

.PHONY: lint
lint:
	golint -set_exit_status ./...

.PHONY: test
test:
	go test ./...

.PHONY: vet
vet:
	go vet ./...
