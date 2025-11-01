# Platform Engineering Template

A modern Python monorepo template for platform engineering projects, featuring FastAPI and Typer with best practices built-in.

## Features

- **Platform Agnostic**: Docker and devcontainer support for consistent development across all platforms
- **Monorepo Structure**: Organized workspace with separate API and CLI projects
- **Modern Tooling**:
  - [Docker](https://www.docker.com/) & [Dev Containers](https://containers.dev/) for consistent environments
  - [uv](https://docs.astral.sh/uv/) for fast, reliable package management
  - [FastAPI](https://fastapi.tiangolo.com/) for high-performance APIs
  - [Typer](https://typer.tiangolo.com/) for beautiful CLIs
  - [pytest](https://docs.pytest.org/) for testing
  - [ruff](https://docs.astral.sh/ruff/) for lightning-fast linting
  - [mypy](https://mypy.readthedocs.io/) for static type checking
- **Type Safety**: Fully typed codebase with mypy/pyright configuration
- **Best Practices**: Pre-configured linting, formatting, testing, and containerization

## Project Structure

```
.
├── .devcontainer/          # VS Code dev container configuration
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── ci.yml          # GitHub Actions CI/CD
├── api/                    # FastAPI application
│   ├── src/api/
│   │   ├── main.py         # FastAPI app
│   │   └── config.py       # Settings management
│   ├── tests/
│   │   └── test_main.py    # API tests
│   ├── pyproject.toml
│   └── README.md
├── cli/                    # Typer CLI application
│   ├── src/cli/
│   │   ├── main.py         # CLI app
│   │   └── config.py       # CLI configuration
│   ├── tests/
│   │   └── test_main.py    # CLI tests
│   ├── pyproject.toml
│   └── README.md
├── scripts/                # Platform-specific dev scripts
│   ├── dev.bat             # Windows batch script
│   ├── dev.ps1             # Windows PowerShell script
│   └── README.md
├── Dockerfile              # Multi-stage Docker build
├── docker-compose.yml      # Docker Compose for development
├── .dockerignore
├── pyproject.toml          # Workspace configuration
├── Makefile                # macOS/Linux shortcuts
├── DOCKER.md               # Docker guide
├── CONTRIBUTING.md         # Contributing guidelines
└── README.md
```

## Prerequisites

Choose one of the following approaches:

### Option 1: Docker (Recommended - Platform Agnostic)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (macOS, Windows, Linux)
- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (optional but recommended)

### Option 2: Local Development
- Python 3.11 or higher
- [uv](https://docs.astral.sh/uv/) package manager

## Quick Start

### 🐳 Option A: Docker (Recommended)

**Why Docker?** Platform-agnostic, consistent environment, matches production, zero Python installation needed.

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd platform-engineering-template
   ```

2. **Start with Docker Compose**
   ```bash
   # Start the API
   docker-compose up api

   # Or start development environment
   docker-compose up dev

   # Run CLI
   docker-compose run cli hello --name "Docker"
   ```

3. **Access the API**
   - Visit http://localhost:8000/docs for interactive API documentation

**VS Code Users:** Open the project in VS Code and click "Reopen in Container" when prompted. Everything will be set up automatically!

### 💻 Option B: Local Development

<details>
<summary>Click to expand local development instructions</summary>

1. **Install uv**
   ```bash
   # macOS/Linux
   curl -LsSf https://astral.sh/uv/install.sh | sh

   # Windows
   powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

2. **Clone and Install**
   ```bash
   git clone <your-repo-url>
   cd platform-engineering-template
   uv sync
   ```

3. **Run the API**
   ```bash
   cd api
   uv run uvicorn api.main:app --reload
   ```

4. **Run the CLI**
   ```bash
   cd cli
   uv run platform-cli --help
   ```

</details>

## Development

### Running Tests

**With Docker (all platforms):**
```bash
# Run all tests
docker-compose run dev uv run pytest

# Run with coverage
docker-compose run dev uv run pytest --cov=api --cov=cli

# Or inside the dev container
docker-compose run dev bash
uv run pytest
```

**Local development:**
```bash
# Run all tests
uv run pytest

# Run API tests only
cd api && uv run pytest

# Run CLI tests only
cd cli && uv run pytest

# Run with coverage
uv run pytest --cov=api --cov=cli
```

### Linting and Formatting

**With Docker:**
```bash
# Check code style
docker-compose run dev uv run ruff check .

# Fix and format
docker-compose run dev uv run ruff format .
docker-compose run dev uv run ruff check --fix .
```

**Local development:**
```bash
# Check code style
uv run ruff check .

# Fix auto-fixable issues
uv run ruff check --fix .

# Format code
uv run ruff format .
```

### Type Checking

**With Docker:**
```bash
docker-compose run dev uv run mypy api/src cli/src
```

**Local development:**
```bash
# Run mypy
uv run mypy api/src cli/src

# Or use pyright
uv run pyright
```

### Adding Dependencies

When adding dependencies, you'll need to rebuild Docker images:

**With Docker:**
```bash
# 1. Add dependency to pyproject.toml
cd api  # or cli
uv add <package-name>

# 2. Rebuild Docker image
docker-compose build
```

**Local development:**
```bash
# Add to API
cd api
uv add <package-name>

# Add to CLI
cd cli
uv add <package-name>

# Add dev dependencies
uv add --dev <package-name>
```

## API Development

The API uses FastAPI with the following features:

- Automatic OpenAPI documentation
- Pydantic models for request/response validation
- Settings management with pydantic-settings
- Health check endpoint
- Example REST endpoints

See [api/README.md](api/README.md) for more details.

## CLI Development

The CLI uses Typer with the following features:

- Rich terminal output with colors
- Auto-completion support
- Type-safe command definitions
- Comprehensive help text

See [cli/README.md](cli/README.md) for more details.

## Configuration

### API Configuration

The API can be configured via environment variables or a `.env` file:

```bash
API_HOST=0.0.0.0
API_PORT=8000
DEBUG=false
```

### CLI Configuration

The CLI stores configuration in `~/.platform-cli/` by default.

## Development Approaches

This template supports multiple development workflows. Choose what works best for your team:

### 🐳 Docker / Dev Containers (Recommended)

**Best for:** Platform engineering, team consistency, CI/CD alignment

**Pros:**
- ✅ Platform-agnostic (works on macOS, Windows, Linux)
- ✅ Zero local Python setup required
- ✅ Consistent environment across team
- ✅ Matches production environment
- ✅ Easy CI/CD integration

**Quick commands:**
```bash
docker-compose up api              # Start API
docker-compose run dev bash        # Interactive dev shell
docker-compose run dev uv run pytest  # Run tests
```

**VS Code:** Install [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and click "Reopen in Container"

### 💻 Local Development

**Best for:** Quick iterations, offline development, resource constraints

**macOS/Linux - Using Make:**
```bash
make install      # Install all dependencies
make test         # Run all tests
make lint         # Run ruff linting
make format       # Format code with ruff
make type-check   # Run mypy type checking
make run-api      # Run the API server
```

**Windows - Using Scripts:**
```powershell
# PowerShell
.\scripts\dev.ps1 install
.\scripts\dev.ps1 test
.\scripts\dev.ps1 run-api

# Or Command Prompt
scripts\dev.bat install
scripts\dev.bat test
scripts\dev.bat run-api
```

**Direct commands (all platforms):**
```bash
uv sync                          # Install dependencies
uv run pytest                    # Run tests
uv run ruff check .              # Lint
```

See [scripts/README.md](scripts/README.md) for more details on local development helpers.

## CI/CD

This template is ready for CI/CD integration. Example GitHub Actions workflow:

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - name: Install uv
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      - name: Install dependencies
        run: uv sync
      - name: Run linting
        run: uv run ruff check .
      - name: Run type checking
        run: uv run mypy api/src cli/src
      - name: Run tests
        run: uv run pytest
```

## Best Practices

1. **Use Docker for Development**: Ensures consistency across team and matches production
2. **Type Hints**: Always use type hints for function parameters and return values
3. **Testing**: Write tests for all new functionality
4. **Documentation**: Keep docstrings up to date
5. **Code Style**: Run ruff before committing
6. **Dependencies**: Keep dependencies minimal and up to date
7. **Dev Containers**: Use VS Code dev containers for the best experience

## Customization

### Renaming Projects

1. Update project names in `pyproject.toml` files
2. Rename directory structures
3. Update import statements
4. Update CLI entry point in `cli/pyproject.toml`

### Adding New Packages

Create new directories under the root and add them to the workspace in the root `pyproject.toml`:

```toml
[tool.uv.workspace]
members = ["api", "cli", "new-package"]
```

## License

MIT License - feel free to use this template for your projects.

## Resources

### Documentation
- [DOCKER.md](DOCKER.md) - Comprehensive Docker and dev container guide
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contributing guidelines
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [api/README.md](api/README.md) - API documentation
- [cli/README.md](cli/README.md) - CLI documentation

### External Resources
- [Docker Documentation](https://docs.docker.com/)
- [Dev Containers](https://containers.dev/)
- [uv Documentation](https://docs.astral.sh/uv/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Typer Documentation](https://typer.tiangolo.com/)
- [pytest Documentation](https://docs.pytest.org/)
- [ruff Documentation](https://docs.astral.sh/ruff/)
