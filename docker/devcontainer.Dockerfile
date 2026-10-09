FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

USER vscode

RUN curl -fsSL https://opencode.ai/install | bash

ENV PATH="/home/vscode/.opencode/bin:${PATH}"
