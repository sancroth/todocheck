version?=$(shell date -u +'custom_%y-%m-%dT%H:%MZ')
RELEASE_BINARIES=binaries-$(version)

build:
	go build -ldflags "-X main.version=$(version)"

test: build
	go test -v -count=1 ./...

install: build
	cp todocheck /usr/local/bin/todocheck

uninstall:
	rm -rf /usr/local/bin/todocheck || true

release:
	@echo "Generating binaries for version $(version)..."
	./release.sh $(RELEASE_BINARIES) $(version)
	@echo "Version binaries available in folder $(RELEASE_BINARIES)"

.PHONY: build test release
