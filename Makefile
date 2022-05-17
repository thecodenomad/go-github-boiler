# Setup cruft

ifndef VERBOSE
.SILENT:
endif

# Targets
.PHONY: build
build: main
main:
	go build -o main main.go

.PHONY: clean
clean:
	rm -rf coverage.out coverage.html main

.PHONY: covtest
covtest: clean
	go test -v -coverprofile=coverage.out ./...

.PHONY: covreport
covreport: clean covtest
	go tool cover -html=coverage.out -o coverage.html

.PHONY: lint
lint:
	golint -set_exit_status ./...

.PHONY: test
test:
	go test ./...

.PHONY: vet
vet:
	go vet ./...
