# syntax=docker/dockerfile:1
# docker/pages.Dockerfile — toolchain image for scripts/pages.sh.
FROM debian:bookworm-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends bash ca-certificates git curl sed \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /repo
