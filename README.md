# OpsCtl - Platform Engineering Template

A template repository for platform engineering projects using a monorepo structure with separate CLI and API packages.

> **🎯 Recommended**: Use the included [Dev Container](#-setup-with-dev-container-recommended) for the best cross-platform development experience!

## 🚀 Technologies

- **CLI**: [Typer](https://typer.tiangolo.com/) - Modern CLI framework
- **API**: [FastAPI](https://fastapi.tiangolo.com/) - High-performance web framework
- **Package Management**: [uv](https://docs.astral.sh/uv/) - Fast Python package manager
- **Testing**: [pytest](https://docs.pytest.org/) - Testing framework
- **Linting**: [ruff](https://docs.astral.sh/ruff/) - Fast Python linter
- **Type Checking**: [mypy](https://mypy-lang.org/) - Static type checker

## 📁 Project Structure

```
opsctl/
├── .devcontainer/
│   ├── devcontainer.json      # Dev Container configuration
│   ├── docker-compose.yml     # Dev Container Docker Compose
│   └── Dockerfile             # Dev Container Dockerfile
├── .github/
│   └── workflows/
│       └── ci.yml             # GitHub Actions CI workflow
├── packages/
│   ├── api/                   # FastAPI application
│   │   ├── src/
│   │   │   └── opsctl_api/
│   │   ├── tests/
│   │   └── pyproject.toml
│   └── cli/                   # Typer CLI application
│       ├── src/
│       │   └── opsctl_cli/
│       ├── tests/
│       └── pyproject.toml
├── pyproject.toml             # Workspace configuration
├── Makefile                   # Common development tasks
├── docker-compose.yml         # Docker Compose for development
├── Dockerfile.api             # Dockerfile for API service
├── DEVELOPMENT.md             # Detailed development guide
└── CONTRIBUTING.md            # Contribution guidelines
```

## 🛠️ Setup with Dev Container (Recommended)

The easiest and most consistent way to develop across all platforms (macOS, Linux, Windows).

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (or Docker Engine + Docker Compose)
- [VS Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd opsctl
   ```

2. Open in VS Code:
   ```bash
   code .
   ```

3. When prompted, click **"Reopen in Container"** (or press `F1` and select "Dev Containers: Reopen in Container")

4. VS Code will build the container and set up the environment automatically. Once ready, you can:
   ```bash
   # Run tests
   make test
   
   # Run the CLI
   uv run opsctl hello
   
   # Start the API
   make run-api
   ```

**Benefits:**
- ✅ Identical environment across all platforms
- ✅ No local Python installation needed
- ✅ Pre-configured VS Code settings and extensions
- ✅ All dependencies pre-installed
- ✅ Port forwarding configured automatically

## 🛠️ Local Setup (Alternative)

If you prefer to develop locally without containers:

### Prerequisites

- Python 3.12+
- uv package manager

**Installing uv:**

<details>
<summary><b>macOS/Linux</b></summary>

```bash
pip install uv
```

Or using the official installer:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```
</details>

<details>
<summary><b>Windows</b></summary>

```powershell
pip install uv
```

Or using PowerShell with the official installer:
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```
</details>

### Installation

1. Clone this repository:

**macOS/Linux:**
```bash
git clone <repository-url>
cd opsctl
```

**Windows:**
```powershell
git clone <repository-url>
cd opsctl
```

2. Install dependencies:

**macOS/Linux:**
```bash
uv sync
# or
make install
```

**Windows (PowerShell):**
```powershell
uv sync
# Note: Makefile commands require Make for Windows or use uv directly
```

3. Install packages in development mode (optional):
```bash
uv pip install -e packages/cli -e packages/api
```

## 📝 Usage

### CLI

Run the CLI:

**macOS/Linux:**
```bash
uv run opsctl hello
uv run opsctl hello World
uv run opsctl version
uv run opsctl --help
# or using make
make run-cli
```

**Windows (PowerShell):**
```powershell
uv run opsctl hello
uv run opsctl hello World
uv run opsctl version
uv run opsctl --help
```

### API

Start the API server:

**macOS/Linux:**
```bash
uv run uvicorn opsctl_api.main:app --reload
# or using make
make run-api
```

**Windows (PowerShell):**
```powershell
uv run uvicorn opsctl_api.main:app --reload
```

The API will be available at:
- Main: http://localhost:8000
- Docs: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

Try the endpoints:

**macOS/Linux:**
```bash
curl http://localhost:8000/
curl http://localhost:8000/health
curl http://localhost:8000/hello/World
```

**Windows (PowerShell):**
```powershell
Invoke-WebRequest http://localhost:8000/
Invoke-WebRequest http://localhost:8000/health
Invoke-WebRequest http://localhost:8000/hello/World
# Or install curl for Windows and use curl commands
```

### Using Docker Compose

Run the API with Docker Compose:
```bash
docker-compose up
```

## 🧪 Testing

Run all tests:

**macOS/Linux:**
```bash
uv run pytest
# or
make test
```

**Windows (PowerShell):**
```powershell
uv run pytest
```

Run tests with coverage:

**macOS/Linux:**
```bash
uv run pytest --cov=packages --cov-report=html
# or
make test-cov
```

**Windows (PowerShell):**
```powershell
uv run pytest --cov=packages --cov-report=html
```

Run tests for a specific package:
```bash
uv run pytest packages/cli/tests
uv run pytest packages/api/tests
```

## 🔍 Linting and Type Checking

Run ruff linter:

**macOS/Linux:**
```bash
uv run ruff check .
# or
make lint
```

**Windows (PowerShell):**
```powershell
uv run ruff check .
```

Auto-fix linting issues:

**macOS/Linux:**
```bash
uv run ruff check --fix .
# or
make lint-fix
```

**Windows (PowerShell):**
```powershell
uv run ruff check --fix .
```

Format code:

**macOS/Linux:**
```bash
uv run ruff format .
# or
make format
```

**Windows (PowerShell):**
```powershell
uv run ruff format .
```

Run type checking:

**macOS/Linux:**
```bash
uv run mypy packages/cli/src packages/api/src
# or
make typecheck
```

**Windows (PowerShell):**
```powershell
uv run mypy packages/cli/src packages/api/src
```

Run all checks:

**macOS/Linux:**
```bash
make all
```

**Windows (PowerShell):**
```powershell
# Run each command separately
uv run ruff check .
uv run mypy packages/cli/src packages/api/src
uv run pytest
```

## 📦 Building

Build the packages:
```bash
uv build packages/cli
uv build packages/api
```

Build Docker image for API:
```bash
docker build -t opsctl-api -f Dockerfile.api .
```

## 📚 Documentation

- [DEVELOPMENT.md](DEVELOPMENT.md) - Detailed development guide
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute to this project

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
