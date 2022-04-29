FROM alpine:latest as builder
ARG TARGETOS
ARG TARGETARCH
ARG VERSION
RUN mkdir /build
WORKDIR /build

RUN wget https://github.com/upx/upx/releases/download/v${VERSION}/upx-${VERSION}-${TARGETARCH}_${TARGETOS}.tar.xz
RUN tar -xJf upx-${VERSION}-${TARGETARCH}_${TARGETOS}.tar.xz

FROM busybox:latest as production
ARG TARGETOS
ARG TARGETARCH
ARG VERSION
COPY --from=builder /build/upx-${VERSION}-${TARGETARCH}_${TARGETOS}/upx /usr/bin/upx
ENTRYPOINT ["/usr/bin/upx"]