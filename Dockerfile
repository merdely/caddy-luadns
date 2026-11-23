ARG CONTAINER_VERSION=2.11.9
ARG BASE_AMD64="docker.io/caddy:${CONTAINER_VERSION}-builder-alpine AS builder"
ARG BASE_ARM64="docker.io/caddy:${CONTAINER_VERSION}-builder-alpine AS builder"

FROM ${BASE_AMD64} AS base-amd64
FROM ${BASE_ARM64} AS base-arm64

FROM base-${TARGETARCH}

LABEL maintainer="Michael Erdely <mike@erdelynet.com>"

ARG CONTAINER_VERSION

# To force Caddy to build with the latest version, bump BUMP number
ARG BUMP=0

ARG CONTAINER_VERSION

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build --with github.com/caddy-dns/luadns
#                  --with github.com/mholt/caddy-l4

FROM docker.io/caddy:${CONTAINER_VERSION}-alpine

ARG CONTAINER_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
