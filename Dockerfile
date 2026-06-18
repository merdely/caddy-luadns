ARG CONTAINER_VERSION=2.11.4
FROM caddy:${CONTAINER_VERSION}-builder-alpine AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build --with github.com/caddy-dns/luadns
FROM caddy:${CONTAINER_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
