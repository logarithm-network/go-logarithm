# Build Gxlg in a stock Go builder container
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-logarithm
RUN cd /go-logarithm && make gxlg

# Pull Gxlg into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-logarithm/build/bin/gxlg /usr/local/bin/

EXPOSE 30199 30299 30909 30909/udp 30506/udp
ENTRYPOINT ["gxlg"]
