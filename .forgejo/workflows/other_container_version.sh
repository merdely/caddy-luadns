#!/usr/bin/env bash

sw_list="$sw_list fancyindex"
echo "fancyindex_version=$(awk -F= '/^ARG FANCYINDEX_VERSION=/{print $2;exit}' Dockerfile)" | tee -a "$GITHUB_ENV"

sw_list="$sw_list davext"
echo "davext_version=$(awk -F= '/^ARG DAVEXT_VERSION=/{print $2;exit}' Dockerfile)" | tee -a "$GITHUB_ENV"

sw_list="$sw_list thruk"
echo "thruk_version=$(awk -F= '/^ARG THRUK_VERSION=/{print $2;exit}' Dockerfile)" | tee -a "$GITHUB_ENV"
