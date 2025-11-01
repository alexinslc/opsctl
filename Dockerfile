# Multi-stage Dockerfile for both API and CLI
FROM python:3.11-slim as base

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Set working directory
WORKDIR /workspace

# Copy workspace configuration
COPY pyproject.toml ./

# API stage
FROM base as api

# Copy API project files
COPY api/pyproject.toml api/
COPY api/src api/src/

# Install dependencies
RUN cd api && uv sync --no-dev

# Expose API port
EXPOSE 8000

# Run API
CMD ["uv", "run", "--directory", "api", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]

# CLI stage
FROM base as cli

# Copy CLI project files
COPY cli/pyproject.toml cli/
COPY cli/src cli/src/

# Install dependencies
RUN cd cli && uv sync --no-dev

# Set entrypoint to CLI
ENTRYPOINT ["uv", "run", "--directory", "cli", "platform-cli"]
CMD ["--help"]

# Development stage with all tools
FROM base as dev

# Install system dependencies for development
RUN apt-get update && apt-get install -y \
    git \
    make \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy all project files
COPY . .

# Install all dependencies (including dev)
RUN uv sync

# Default command for development
CMD ["/bin/bash"]
