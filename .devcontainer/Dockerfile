FROM mcr.microsoft.com/devcontainers/python:3.12

# Install uv
RUN pip install --no-cache-dir uv

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    make \
    curl \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Set up workspace
WORKDIR /workspace

# Create a non-root user (vscode user is already created by base image)
# Ensure proper permissions
RUN chown -R vscode:vscode /workspace

USER vscode
