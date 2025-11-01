# Development Guide

## Getting Started

This guide will help you get started with developing in this monorepo template.

## Setup Options

### Option 1: Dev Container (Recommended)

The easiest way to get started with a consistent development environment across all platforms.

**Prerequisites:**
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [VS Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

**Steps:**

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd opsctl
   ```

2. **Open in VS Code**:
   ```bash
   code .
   ```

3. **Reopen in Container**:
   - Click "Reopen in Container" when prompted
   - Or press `F1` and select "Dev Containers: Reopen in Container"

4. **Start developing**:
   The container will automatically install all dependencies via the `postCreateCommand`. Once ready:
   ```bash
   make test      # Run tests
   make run-cli   # Run the CLI
   make run-api   # Start the API
   ```

**Benefits:**
- ✅ Works identically on macOS, Linux, and Windows
- ✅ No need to install Python or uv locally
- ✅ Pre-configured VS Code extensions and settings
- ✅ Isolated environment per project
- ✅ Automatic port forwarding

### Option 2: Local Setup

1. **Install uv** (if not already installed):

   **macOS/Linux:**
   ```bash
   pip install uv
   ```
   
   Or using the official installer:
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   **Windows:**
   ```powershell
   pip install uv
   ```
   
   Or using PowerShell with the official installer:
   ```powershell
   powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

2. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd opsctl
   ```

3. **Install dependencies**:
   ```bash
   uv sync
   ```

This will create a virtual environment at `.venv/` and install all dependencies.

## Development Workflow

### Running the CLI

**macOS/Linux:**
```bash
# Activate the virtual environment (optional, uv run will handle this)
source .venv/bin/activate

# Run the CLI
uv run opsctl --help
uv run opsctl hello
uv run opsctl hello "Your Name"
uv run opsctl version
```

**Windows (PowerShell):**
```powershell
# Activate the virtual environment (optional, uv run will handle this)
.venv\Scripts\Activate.ps1

# Run the CLI
uv run opsctl --help
uv run opsctl hello
uv run opsctl hello "Your Name"
uv run opsctl version
```

**Windows (Command Prompt):**
```cmd
# Activate the virtual environment (optional, uv run will handle this)
.venv\Scripts\activate.bat

# Run the CLI
uv run opsctl --help
uv run opsctl hello
uv run opsctl hello "Your Name"
uv run opsctl version
```

### Running the API

Start the API server in development mode with auto-reload:

```bash
uv run uvicorn opsctl_api.main:app --reload
```

The API will be available at:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc
- OpenAPI JSON: http://localhost:8000/openapi.json

### Testing

Run all tests:
```bash
uv run pytest
```

Run tests with coverage:
```bash
uv run pytest --cov=packages --cov-report=html
```

Run tests for a specific package:
```bash
cd packages/cli && uv run pytest
cd packages/api && uv run pytest
```

### Linting and Formatting

Check code with ruff:
```bash
uv run ruff check .
```

Auto-fix linting issues:
```bash
uv run ruff check --fix .
```

Format code:
```bash
uv run ruff format .
```

### Type Checking

Run mypy for type checking:
```bash
uv run mypy packages/cli/src packages/api/src
```

## Project Structure

```
opsctl/
├── packages/
│   ├── api/                    # FastAPI application
│   │   ├── src/
│   │   │   └── opsctl_api/    # API source code
│   │   │       ├── __init__.py
│   │   │       └── main.py    # FastAPI app
│   │   ├── tests/             # API tests
│   │   │   ├── __init__.py
│   │   │   └── test_api.py
│   │   ├── pyproject.toml     # API package config
│   │   └── README.md
│   └── cli/                   # Typer CLI application
│       ├── src/
│       │   └── opsctl_cli/    # CLI source code
│       │       ├── __init__.py
│       │       └── main.py    # Typer app
│       ├── tests/             # CLI tests
│       │   ├── __init__.py
│       │   └── test_cli.py
│       ├── pyproject.toml     # CLI package config
│       └── README.md
├── pyproject.toml             # Workspace configuration
├── .gitignore
├── .python-version            # Python version
└── README.md
```

## Adding Dependencies

### Workspace (dev) dependencies

Edit `pyproject.toml` at the root and add to the `[dependency-groups]` section:

```toml
[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "new-package>=1.0.0",  # Add new dev dependency here
]
```

Then run:
```bash
uv sync
```

### Package-specific dependencies

Edit the respective `pyproject.toml` in `packages/cli/` or `packages/api/`:

```toml
[project]
dependencies = [
    "existing-package>=1.0.0",
    "new-package>=2.0.0",  # Add new dependency here
]
```

Then run:
```bash
uv sync
```

## Creating New Commands (CLI)

Add new commands in `packages/cli/src/opsctl_cli/main.py`:

```python
@app.command()
def new_command(arg: str) -> None:
    """Description of your new command."""
    console.print(f"[bold]You passed: {arg}[/bold]")
```

## Creating New Endpoints (API)

Add new endpoints in `packages/api/src/opsctl_api/main.py`:

```python
@app.get("/new-endpoint")
async def new_endpoint() -> dict[str, str]:
    """Description of your endpoint."""
    return {"message": "Response from new endpoint"}
```

## Best Practices

1. **Write Tests**: Always add tests for new functionality
2. **Type Hints**: Use type hints for all functions
3. **Documentation**: Add docstrings to functions and classes
4. **Linting**: Run ruff before committing
5. **Type Checking**: Run mypy to catch type errors early
6. **Commit Often**: Make small, focused commits

## Troubleshooting

### Virtual Environment Issues

If you encounter issues with the virtual environment:

**macOS/Linux:**
```bash
# Remove the virtual environment
rm -rf .venv

# Recreate it
uv sync
```

**Windows (PowerShell):**
```powershell
# Remove the virtual environment
Remove-Item -Recurse -Force .venv

# Recreate it
uv sync
```

### Import Errors

Make sure you're running commands with `uv run` or have activated the virtual environment:

**macOS/Linux:**
```bash
source .venv/bin/activate
```

**Windows (PowerShell):**
```powershell
.venv\Scripts\Activate.ps1
```

**Windows (Command Prompt):**
```cmd
.venv\Scripts\activate.bat
```

### Port Already in Use

If the API server fails to start because port 8000 is in use:

```bash
# Use a different port
uv run uvicorn opsctl_api.main:app --reload --port 8001
```

## Resources

- [uv Documentation](https://docs.astral.sh/uv/)
- [Typer Documentation](https://typer.tiangolo.com/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [pytest Documentation](https://docs.pytest.org/)
- [ruff Documentation](https://docs.astral.sh/ruff/)
