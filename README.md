# OpsCtl - Platform Engineering Template

A template repository for platform engineering projects using a monorepo structure with separate CLI and API packages.

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
├── .github/
│   └── workflows/
│       └── ci.yml           # GitHub Actions CI workflow
├── packages/
│   ├── api/                 # FastAPI application
│   │   ├── src/
│   │   │   └── opsctl_api/
│   │   ├── tests/
│   │   └── pyproject.toml
│   └── cli/                 # Typer CLI application
│       ├── src/
│       │   └── opsctl_cli/
│       ├── tests/
│       └── pyproject.toml
├── pyproject.toml           # Workspace configuration
├── Makefile                 # Common development tasks
├── docker-compose.yml       # Docker Compose for development
├── Dockerfile.api           # Dockerfile for API service
├── DEVELOPMENT.md           # Detailed development guide
└── CONTRIBUTING.md          # Contribution guidelines
```

## 🛠️ Setup

### Prerequisites

- Python 3.12+
- uv (install with `pip install uv`)

### Installation

1. Clone this repository:
```bash
git clone <repository-url>
cd opsctl
```

2. Install dependencies:
```bash
uv sync
# or
make install
```

3. Install packages in development mode:
```bash
uv pip install -e packages/cli -e packages/api
```

## 📝 Usage

### CLI

Run the CLI:
```bash
opsctl hello
opsctl hello World
opsctl version
opsctl --help
# or
make run-cli
```

### API

Start the API server:
```bash
uvicorn opsctl_api.main:app --reload
# or
make run-api
```

The API will be available at:
- Main: http://localhost:8000
- Docs: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

Try the endpoints:
```bash
curl http://localhost:8000/
curl http://localhost:8000/health
curl http://localhost:8000/hello/World
```

### Using Docker Compose

Run the API with Docker Compose:
```bash
docker-compose up
```

## 🧪 Testing

Run all tests:
```bash
uv run pytest
# or
make test
```

Run tests with coverage:
```bash
uv run pytest --cov=packages --cov-report=html
# or
make test-cov
```

Run tests for a specific package:
```bash
uv run pytest packages/cli/tests
uv run pytest packages/api/tests
```

## 🔍 Linting and Type Checking

Run ruff linter:
```bash
uv run ruff check .
# or
make lint
```

Auto-fix linting issues:
```bash
uv run ruff check --fix .
# or
make lint-fix
```

Format code:
```bash
uv run ruff format .
# or
make format
```

Run type checking:
```bash
uv run mypy packages/cli/src packages/api/src
# or
make typecheck
```

Run all checks:
```bash
make all
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
