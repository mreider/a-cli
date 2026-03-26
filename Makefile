GO ?= $(shell which go)
BINARY := a-cli
VERSION ?= $(shell git tag -l 'v*' --sort=-v:refname --merged HEAD 2>/dev/null | head -n1 || echo dev)
DIRTY := $(shell git diff --quiet 2>/dev/null || echo -dirty)
VERSION := $(VERSION)$(DIRTY)

.PHONY: build clean install

build:
	CGO_ENABLED=0 $(GO) build -ldflags="-s -w -X github.com/mreider/a-cli/cmd.version=$(VERSION)" -o $(BINARY) .

clean:
	rm -f $(BINARY)

install: build
	cp $(BINARY) $(HOME)/bin/$(BINARY)
