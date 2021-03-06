# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gxlg android ios gxlg-cross swarm evm all test clean
.PHONY: gxlg-linux gxlg-linux-386 gxlg-linux-amd64 gxlg-linux-mips64 gxlg-linux-mips64le
.PHONY: gxlg-linux-arm gxlg-linux-arm-5 gxlg-linux-arm-6 gxlg-linux-arm-7 gxlg-linux-arm64
.PHONY: gxlg-darwin gxlg-darwin-386 gxlg-darwin-amd64
.PHONY: gxlg-windows gxlg-windows-386 gxlg-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gxlg:
	build/env.sh go run build/ci.go install ./cmd/gxlg
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gxlg\" to launch gxlg."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gxlg.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Gxlg.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gxlg-cross: gxlg-linux gxlg-darwin gxlg-windows gxlg-android gxlg-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-*

gxlg-linux: gxlg-linux-386 gxlg-linux-amd64 gxlg-linux-arm gxlg-linux-mips64 gxlg-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-*

gxlg-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gxlg
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep 386

gxlg-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gxlg
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep amd64

gxlg-linux-arm: gxlg-linux-arm-5 gxlg-linux-arm-6 gxlg-linux-arm-7 gxlg-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep arm

gxlg-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gxlg
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep arm-5

gxlg-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gxlg
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep arm-6

gxlg-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gxlg
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep arm-7

gxlg-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gxlg
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep arm64

gxlg-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gxlg
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep mips

gxlg-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gxlg
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep mipsle

gxlg-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gxlg
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep mips64

gxlg-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gxlg
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-linux-* | grep mips64le

gxlg-darwin: gxlg-darwin-386 gxlg-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-darwin-*

gxlg-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gxlg
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-darwin-* | grep 386

gxlg-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gxlg
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-darwin-* | grep amd64

gxlg-windows: gxlg-windows-386 gxlg-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-windows-*

gxlg-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gxlg
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-windows-* | grep 386

gxlg-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gxlg
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxlg-windows-* | grep amd64
