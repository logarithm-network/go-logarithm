.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/logarithm-network/go-logarithm/cmd/swarm
	go build -o bin/gxlg     github.com/logarithm-network/go-logarithm/cmd/gxlg
	go build -o bin/bootnode github.com/logarithm-network/go-logarithm/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/logarithm-network/go-logarithm/swarm/...
