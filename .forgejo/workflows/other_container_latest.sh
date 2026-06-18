#!/usr/bin/env bash

echo fancyindex_latest=$(curl -s https://api.github.com/repos/aperezdc/ngx-fancyindex/releases/latest | \
  jq -r '.tag_name' | \
  sed 's/^v//') | tee -a "$GITHUB_ENV"

echo davext_latest=$(curl -s https://api.github.com/repos/arut/nginx-dav-ext-module/releases/latest | \
  jq -r '.tag_name' | \
  sed 's/^v//') | tee -a "$GITHUB_ENV"

echo thruk_latest=$(curl -s https://api.github.com/repos/sni/Thruk/tags | \
  jq -r '.[].name' | \
  grep -Ev '(-[a-z]+)$' | \
  sort -Vr | \
  head -n1 | \
  sed 's/^v//') | tee -a "$GITHUB_ENV"
