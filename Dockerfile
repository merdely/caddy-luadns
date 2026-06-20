ARG CONTAINER_VERSION=2.11.4
FROM caddy:${CONTAINER_VERSION}-builder-alpine AS builder

# To force Caddy to build with the latest version, bump BUMP number
ARG BUMP=0

ARG CONTAINER_VERSION
ARG THRUK_VERSION=3.28

# Install some thruk files
RUN echo THRUK_VERSION=${THRUK_VERSION} && \
    curl -sLo /tmp/thruk-src.tar.gz https://download.thruk.org/pkg/v${THRUK_VERSION}/src/thruk-${THRUK_VERSION}.tar.gz && \
    tar -C /tmp -xzpf /tmp/thruk-src.tar.gz && \
    mkdir -p /usr/share/thruk/plugins && \
    mkdir -p /usr/share/thruk/root && \
    mkdir -p /usr/share/thruk/themes && \
    cp -R /tmp/thruk-${THRUK_VERSION}/root /usr/share/thruk/ && \
    rm -Rf /usr/share/thruk/root/themes && \
    cp -R /tmp/thruk-${THRUK_VERSION}/plugins/plugins-available /usr/share/thruk/plugins/ && \
    cp -R /tmp/thruk-${THRUK_VERSION}/themes/themes-available /usr/share/thruk/themes/ && \
    rm -Rf /tmp/thruk-*

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build --with github.com/caddy-dns/luadns \
                 --with github.com/mholt/caddy-webdav

FROM caddy:${CONTAINER_VERSION}-alpine

ARG CONTAINER_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
