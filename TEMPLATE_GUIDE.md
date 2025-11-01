# Template Repository Guide

This is a complete platform engineering template repository. Here's what's included and how to use it.

## What's Included

### Core Structure
- ✅ **Monorepo Layout**: Workspace with separate CLI and API packages
- ✅ **CLI Package**: Built with Typer, includes commands and tests
- ✅ **API Package**: Built with FastAPI, includes endpoints and tests
- ✅ **Package Manager**: uv for fast dependency management

### Development Tools
- ✅ **Dev Container**: Pre-configured development container for VS Code (recommended)
- ✅ **Testing**: pytest with coverage support
- ✅ **Linting**: ruff for fast linting and formatting
- ✅ **Type Checking**: mypy for static type analysis
- ✅ **Make**: Convenient commands via Makefile
- ✅ **CI/CD**: GitHub Actions workflow included

### Documentation
- ✅ **README.md**: Overview and quick start guide
- ✅ **DEVELOPMENT.md**: Detailed development guide
- ✅ **CONTRIBUTING.md**: Contribution guidelines
- ✅ **Package READMEs**: Individual docs for CLI and API

### Docker Support
- ✅ **Dev Container**: Full VS Code development container setup
- ✅ **docker-compose.yml**: Quick start for development
- ✅ **Dockerfile.api**: Production-ready API container

## Quick Start

### Recommended: Using Dev Container

1. **Prerequisites**:
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Install [VS Code](https://code.visualstudio.com/)
   - Install [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Clone and open**:
   ```bash
   git clone <your-repo-url>
   cd <your-repo-name>
   code .
   ```

3. **Reopen in Container**:
   - Click "Reopen in Container" when prompted
   - Wait for container to build and dependencies to install

4. **Start developing**:
   ```bash
   make test      # Run tests
   make run-cli   # Run CLI
   make run-api   # Start API
   ```

### Alternative: Local Setup

1. **Use this template** on GitHub to create a new repository

2. **Clone your new repository**:
   ```bash
   git clone <your-repo-url>
   cd <your-repo-name>
   ```

3. **Install dependencies**:
   
   **macOS/Linux:**
   ```bash
   make install
   # or
   uv sync
   ```
   
   **Windows (PowerShell):**
   ```powershell
   uv sync
   ```

4. **Run tests**:
   
   **macOS/Linux:**
   ```bash
   make test
   # or
   uv run pytest
   ```
   
   **Windows (PowerShell):**
   ```powershell
   uv run pytest
   ```

5. **Try the CLI**:
   
   **macOS/Linux:**
   ```bash
   make run-cli
   # or
   uv run opsctl hello
   ```
   
   **Windows (PowerShell):**
   ```powershell
   uv run opsctl hello
   ```

6. **Start the API**:
   
   **macOS/Linux:**
   ```bash
   make run-api
   # or
   uv run uvicorn opsctl_api.main:app --reload
   ```
   
   **Windows (PowerShell):**
   ```powershell
   uv run uvicorn opsctl_api.main:app --reload
   ```

## Customization

### Rename the Project

1. Update package names in:
   - `packages/cli/pyproject.toml` (name and scripts)
   - `packages/api/pyproject.toml` (name)
   - `packages/cli/src/opsctl_cli/` → rename directory
   - `packages/api/src/opsctl_api/` → rename directory

2. Update imports in test files

3. Update README and documentation

### Add New Features

**CLI Commands**: Edit `packages/cli/src/opsctl_cli/main.py`
```python
@app.command()
def my_command() -> None:
    """My new command."""
    console.print("Hello!")
```

**API Endpoints**: Edit `packages/api/src/opsctl_api/main.py`
```python
@app.get("/my-endpoint")
async def my_endpoint() -> dict[str, str]:
    """My new endpoint."""
    return {"message": "Hello!"}
```

### Add Dependencies

**Development dependencies** (testing, linting, etc.):
Edit root `pyproject.toml` → `[dependency-groups] dev`

**CLI dependencies**:
Edit `packages/cli/pyproject.toml` → `[project] dependencies`

**API dependencies**:
Edit `packages/api/pyproject.toml` → `[project] dependencies`

Then run: `make install`

## Available Commands

**macOS/Linux (using Make):**
```bash
make help        # Show all available commands
make install     # Install/update dependencies
make test        # Run all tests
make test-cov    # Run tests with coverage report
make lint        # Check code style
make lint-fix    # Auto-fix code style issues
make format      # Format code
make typecheck   # Run type checking
make run-cli     # Run the CLI
make run-api     # Start the API server
make all         # Run lint, typecheck, and test
make clean       # Remove all cache and build files
```

**Windows (using uv directly):**
```powershell
uv sync                                        # Install/update dependencies
uv run pytest                                  # Run all tests
uv run pytest --cov=packages --cov-report=html # Run tests with coverage
uv run ruff check .                            # Check code style
uv run ruff check --fix .                      # Auto-fix code style issues
uv run ruff format .                           # Format code
uv run mypy packages/cli/src packages/api/src  # Run type checking
uv run opsctl --help                           # Run the CLI
uv run uvicorn opsctl_api.main:app --reload    # Start the API server
```

> **Note for Windows users**: The Makefile requires Make for Windows (e.g., via Chocolatey: `choco install make`) or you can use the `uv` commands directly as shown above.

## CI/CD

The template includes a GitHub Actions workflow (`.github/workflows/ci.yml`) that:
- Runs on push and pull requests
- Tests on Python 3.12
- Runs linting, type checking, and tests
- Uploads coverage to Codecov

## Docker

**Development**:
```bash
docker-compose up
```

**Production**:
```bash
docker build -t my-api -f Dockerfile.api .
docker run -p 8000:8000 my-api
```

## Best Practices

1. **Keep tests updated** - Add tests for all new features
2. **Run checks often** - Use `make all` before committing
3. **Type everything** - Use type hints for better code quality
4. **Document changes** - Update README and docs when needed
5. **Small commits** - Make focused, atomic commits

## Getting Help

- Check `DEVELOPMENT.md` for detailed development info
- Check `CONTRIBUTING.md` for contribution guidelines
- Open an issue for questions or problems

## Next Steps

1. Customize the template for your project
2. Add your own commands/endpoints
3. Update documentation
4. Set up your CI/CD secrets (if needed)
5. Start building!

---

**Happy coding!** 🚀
