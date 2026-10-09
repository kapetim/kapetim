# syntax=docker/dockerfile:1
# docker/data-ingestor.Dockerfile — toolchain image for scripts/data-ingestor.sh.
FROM debian:bookworm-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends bash ca-certificates git curl \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /repo
