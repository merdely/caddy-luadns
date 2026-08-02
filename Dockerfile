ARG CONTAINER_VERSION=2.11.4
FROM caddy:${CONTAINER_VERSION}-builder-alpine AS builder

# To force Caddy to build with the latest version, bump BUMP number
ARG BUMP=0

ARG CONTAINER_VERSION

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build --with github.com/caddy-dns/luadns \
                 --with github.com/mholt/caddy-l4

FROM caddy:${CONTAINER_VERSION}-alpine

ARG CONTAINER_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
