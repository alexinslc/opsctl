# Multi-stage Dockerfile for both API and CLI
FROM python:3.11-slim AS base

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Set working directory
WORKDIR /workspace

# Copy workspace configuration and member pyproject.toml files
COPY pyproject.toml ./
COPY api/pyproject.toml api/
COPY cli/pyproject.toml cli/

# API stage
FROM base AS api

# Copy source files for both workspace members (needed for dependency resolution)
COPY api/src api/src/
COPY cli/src cli/src/

# Install dependencies from workspace root
RUN uv sync --no-dev

# Expose API port
EXPOSE 8000

# Run API
CMD ["uv", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]

# CLI stage
FROM base AS cli

# Copy source files for both workspace members (needed for dependency resolution)
COPY api/src api/src/
COPY cli/src cli/src/

# Install dependencies from workspace root
RUN uv sync --no-dev

# Set entrypoint to CLI
ENTRYPOINT ["uv", "run", "platform-cli"]
CMD ["--help"]

# Development stage with all tools
FROM base AS dev

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
