# Dev Container Configuration

This directory contains the configuration for developing in a containerized environment using Visual Studio Code's Dev Containers feature.

## What's Included

### Pre-installed Tools
- Python 3.12
- uv package manager
- make
- git
- curl
- zsh with Oh My Zsh

### VS Code Extensions
The following extensions are automatically installed:
- Python (Microsoft)
- Pylance (Microsoft)
- Ruff (Linter and Formatter)
- Mypy Type Checker
- Even Better TOML
- GitHub Copilot

### VS Code Settings
Pre-configured settings for:
- Python interpreter pointing to workspace `.venv`
- Automatic formatting with Ruff on save
- pytest test discovery
- Linting and type checking integration

### Port Forwarding
- Port 8000 is automatically forwarded for the FastAPI server

### Automatic Setup
When the container is created, `uv sync` runs automatically to install all dependencies.

## Usage

1. Open this repository in VS Code
2. Install the "Dev Containers" extension if you haven't already
3. Press `F1` and select "Dev Containers: Reopen in Container"
4. Wait for the container to build (first time only)
5. Start coding!

## Customization

Edit the following files to customize your dev container:

- `devcontainer.json` - Main configuration (extensions, settings, ports)
- `Dockerfile` - Add system packages or tools
- `docker-compose.yml` - Modify Docker Compose configuration

## Benefits

- **Consistent Environment**: Everyone on your team uses the same development environment
- **No Local Setup**: No need to install Python, uv, or other tools locally
- **Isolated**: Each project has its own containerized environment
- **Cross-Platform**: Works identically on macOS, Linux, and Windows

## Learn More

- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev Containers Tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)
