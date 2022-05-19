#########################
# Configuration Options #
#########################

ifndef VERBOSE
.SILENT:
endif

DOCKER_REPO="codenomad/go-github-boiler"

###################
# Support Targets #
###################

.work:
	mkdir -p .work

#################
# Build Targets #
#################

.PHONY: build
build: main
.work/main: .work
	go build -o .work/main main.go

.PHONY: clean
clean:
	rm -rf coverage.out coverage.html main .work

.PHONY: covreport
covreport: clean covtest
	go tool cover -html=coverage.out -o coverage.html

.PHONY: covtest
covtest: clean
	go test -v -coverprofile=coverage.out ./...

.PHONY: docker
docker: .work/docker_build
.work/docker_build: .work/main
	docker build -f docker/Dockerfile . -t ${DOCKER_REPO}
	touch .work/docker_build

.PHONY: docker-run
docker-run: .work/docker_build
	docker run ${DOCKER_REPO}

.PHONY: lint
lint:
	golint -set_exit_status ./...

.PHONY: test
test:
	go test ./...

.PHONY: vet
vet:
	go vet ./...
