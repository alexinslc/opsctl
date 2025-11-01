# Docker Guide

Complete guide to using Docker and dev containers with this template.

## Table of Contents

- [Quick Start](#quick-start)
- [Docker Compose Services](#docker-compose-services)
- [Dev Containers (VS Code)](#dev-containers-vs-code)
- [Common Workflows](#common-workflows)
- [Production Deployment](#production-deployment)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Prerequisites

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/):
- **macOS:** Download and install from website
- **Windows:** Download and install from website (requires WSL2)
- **Linux:** Install Docker Engine and Docker Compose

### Start Services

```bash
# Start the API server
docker-compose up api

# Start in detached mode
docker-compose up -d api

# View logs
docker-compose logs -f api

# Stop services
docker-compose down
```

## Docker Compose Services

### Available Services

#### `dev` - Development Environment

Full development environment with all tools installed.

```bash
# Interactive shell
docker-compose run dev bash

# Run commands
docker-compose run dev uv run pytest
docker-compose run dev uv run ruff check .

# Keep running for multiple commands
docker-compose up -d dev
docker-compose exec dev bash
```

#### `api` - FastAPI Server

Runs the FastAPI application with hot-reload enabled.

```bash
# Start API
docker-compose up api

# Access at http://localhost:8000
# API docs at http://localhost:8000/docs

# View logs
docker-compose logs -f api

# Restart after code changes (if not auto-reloading)
docker-compose restart api
```

#### `cli` - CLI Tool

Runs the Typer CLI application.

```bash
# Run CLI commands
docker-compose run cli --help
docker-compose run cli hello --name "Docker"
docker-compose run cli info

# Interactive mode
docker-compose run cli bash
```

## Dev Containers (VS Code)

### Setup

1. Install [VS Code](https://code.visualstudio.com/)
2. Install [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Open the project folder in VS Code
4. Click "Reopen in Container" when prompted (or press F1 → "Dev Containers: Reopen in Container")

### Features

When you open the project in a dev container:

✅ **Auto-configured Python environment**
- Python 3.11 with all dependencies installed
- uv package manager ready to use

✅ **Pre-installed VS Code extensions**
- Python language support (Pylance)
- Ruff for linting and formatting
- TOML support
- GitHub Copilot (if you have it)
- Error Lens
- GitLens

✅ **Integrated development**
- Run tests from VS Code
- Debug API and CLI
- Terminal with all tools available
- Port forwarding for API (8000)

✅ **Consistent environment**
- Same setup for all team members
- Works identically on macOS, Windows, Linux

### Working in Dev Container

```bash
# Terminal is already inside the container
# Run any command directly:
uv run pytest
uv run ruff check .
cd api && uv run uvicorn api.main:app --reload

# All VS Code features work normally:
# - Integrated debugging
# - Test explorer
# - Git integration
```

## Common Workflows

### Running Tests

```bash
# All tests
docker-compose run dev uv run pytest

# With coverage
docker-compose run dev uv run pytest --cov=api --cov=cli

# Specific test file
docker-compose run dev uv run pytest api/tests/test_main.py

# In interactive mode
docker-compose run dev bash
uv run pytest -v
```

### Code Quality

```bash
# Lint code
docker-compose run dev uv run ruff check .

# Format code
docker-compose run dev uv run ruff format .

# Auto-fix issues
docker-compose run dev uv run ruff check --fix .

# Type checking
docker-compose run dev uv run mypy api/src cli/src
```

### Adding Dependencies

```bash
# 1. Add dependency
docker-compose run dev bash
cd api  # or cli
uv add <package-name>
exit

# 2. Rebuild image to include new dependency
docker-compose build

# 3. Restart services
docker-compose up -d api
```

### Development Iteration

```bash
# Start API with live reload
docker-compose up api

# In another terminal, make changes to code
# API will automatically reload

# Run tests
docker-compose run dev uv run pytest

# Check types
docker-compose run dev uv run mypy api/src
```

## Production Deployment

### Building Production Images

```bash
# Build API image
docker build --target api -t myapp-api:latest .

# Build CLI image
docker build --target cli -t myapp-cli:latest .

# Test production image
docker run -p 8000:8000 myapp-api:latest
```

### Production docker-compose

Create `docker-compose.prod.yml`:

```yaml
version: '3.8'

services:
  api:
    build:
      context: .
      target: api
    ports:
      - "8000:8000"
    environment:
      - API_HOST=0.0.0.0
      - API_PORT=8000
      - DEBUG=false
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

Deploy:
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Kubernetes Deployment

Example deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
      - name: api
        image: myapp-api:latest
        ports:
        - containerPort: 8000
        env:
        - name: API_HOST
          value: "0.0.0.0"
        - name: API_PORT
          value: "8000"
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 30
          periodSeconds: 10
```

## Troubleshooting

### Port Already in Use

```bash
# Check what's using port 8000
lsof -i :8000  # macOS/Linux
netstat -ano | findstr :8000  # Windows

# Stop conflicting service or change port
docker-compose up api -p 8001:8000
```

### Container Won't Start

```bash
# View logs
docker-compose logs api

# Rebuild from scratch
docker-compose down
docker-compose build --no-cache
docker-compose up
```

### Permission Issues (Linux)

```bash
# Fix file permissions
sudo chown -R $USER:$USER .

# Or run with user ID
docker-compose run --user $(id -u):$(id -g) dev bash
```

### Slow Performance (Windows/macOS)

Docker Desktop on Windows/macOS uses a VM, which can be slower for file operations.

**Solutions:**
- Use named volumes instead of bind mounts for dependencies
- Enable file sharing in Docker Desktop settings
- Allocate more resources to Docker Desktop

### Clean Up

```bash
# Stop and remove containers
docker-compose down

# Remove volumes
docker-compose down -v

# Remove images
docker-compose down --rmi all

# Clean up all Docker resources
docker system prune -a
```

### VS Code Dev Container Issues

```bash
# Rebuild container
F1 → "Dev Containers: Rebuild Container"

# Or rebuild without cache
F1 → "Dev Containers: Rebuild Container Without Cache"

# View container logs
F1 → "Dev Containers: Show Container Log"
```

## Best Practices

### 1. Use .dockerignore

Already configured to exclude:
- `.git` directory
- Python cache files
- Virtual environments
- Test artifacts

### 2. Layer Caching

The Dockerfile is optimized for layer caching:
- Dependencies installed before copying source code
- Changes to source don't invalidate dependency layers

### 3. Multi-stage Builds

Separate stages for:
- **api**: Production API (minimal size)
- **cli**: Production CLI (minimal size)
- **dev**: Development with all tools

### 4. Volume Mounts

Use volumes for:
- Source code (live reload during development)
- uv cache (faster dependency installation)

### 5. Health Checks

API service includes health check:
- Ensures container is ready
- Enables rolling updates
- Works with orchestrators (Kubernetes, Docker Swarm)

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dev Containers Documentation](https://containers.dev/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
