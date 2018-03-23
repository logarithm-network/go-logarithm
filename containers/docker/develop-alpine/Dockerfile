FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/logarithm-network/go-logarithm && \
  (cd go-logarithm && make gxlg) && \
  cp go-logarithm/build/bin/gxlg /gxlg && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-logarithm && rm -rf /var/cache/apk/*

EXPOSE 30199
EXPOSE 30909

ENTRYPOINT ["/gxlg"]
