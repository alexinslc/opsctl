# Contributing Guide

Thank you for contributing to this project! This guide will help you get started.

## Development Setup

1. **Install Prerequisites**

   **macOS/Linux:**
   ```bash
   # Install uv
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   **Windows (PowerShell):**
   ```powershell
   # Install uv
   powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

2. **Clone and Install**

   The following commands work the same on all platforms:
   ```bash
   git clone <repo-url>
   cd platform-engineering-template
   uv sync
   ```

## Development Workflow

### Making Changes

1. Create a new branch
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes

3. Run tests and checks
   ```bash
   make test
   make lint
   make type-check
   ```

4. Commit your changes
   ```bash
   git add .
   git commit -m "Description of changes"
   ```

5. Push and create a pull request
   ```bash
   git push origin feature/your-feature-name
   ```

### Code Style

This project uses:
- **ruff** for linting and formatting
- **mypy** for type checking
- **pytest** for testing

Before committing, ensure:

**Using Make (macOS/Linux, or Windows with Make installed):**
```bash
# Format code
make format

# Check linting
make lint

# Run type checking
make type-check

# Run tests
make test
```

**Direct commands (works on all platforms):**
```bash
# Format code
uv run ruff format .
uv run ruff check --fix .

# Check linting
uv run ruff check .

# Run type checking
uv run mypy api/src cli/src

# Run tests
uv run pytest
```

### Writing Tests

- Place API tests in `api/tests/`
- Place CLI tests in `cli/tests/`
- Follow the naming convention `test_*.py`
- Aim for high test coverage
- Write both unit and integration tests

Example test:
```python
def test_example_function() -> None:
    """Test description."""
    result = example_function()
    assert result == expected_value
```

### Type Hints

All functions must have type hints:

```python
def process_data(data: list[str]) -> dict[str, int]:
    """Process the data and return counts."""
    return {item: len(item) for item in data}
```

### Documentation

- Add docstrings to all public functions and classes
- Use Google-style docstrings
- Update README.md if adding new features
- Keep comments clear and concise

Example docstring:
```python
def example_function(param: str) -> bool:
    """
    Short description of the function.

    Args:
        param: Description of the parameter.

    Returns:
        Description of the return value.

    Raises:
        ValueError: When the parameter is invalid.
    """
    pass
```

## Pull Request Guidelines

1. **Title**: Use clear, descriptive titles
2. **Description**: Explain what and why
3. **Tests**: Include tests for new functionality
4. **Documentation**: Update docs as needed
5. **CI**: Ensure all CI checks pass

### PR Checklist

- [ ] Tests pass locally
- [ ] Code is formatted with ruff
- [ ] Type checking passes with mypy
- [ ] Documentation is updated
- [ ] Commit messages are clear
- [ ] No merge conflicts

## Project Structure

```
api/          - FastAPI application
  src/api/    - Source code
  tests/      - API tests
cli/          - Typer CLI application
  src/cli/    - Source code
  tests/      - CLI tests
```

## Adding Dependencies

**macOS/Linux:**
```bash
# Add to API
cd api && uv add <package>

# Add to CLI
cd cli && uv add <package>

# Add dev dependencies
uv add --dev <package>
```

**Windows (PowerShell):**
```powershell
# Add to API
cd api; uv add <package>

# Add to CLI
cd cli; uv add <package>

# Add dev dependencies
uv add --dev <package>
```

## Common Issues

### Import Errors
Ensure you're in the correct directory when running commands:

**macOS/Linux:**
```bash
cd api && uv run pytest  # For API tests
cd cli && uv run pytest  # For CLI tests
```

**Windows (PowerShell):**
```powershell
cd api; uv run pytest  # For API tests
cd cli; uv run pytest  # For CLI tests
```

### Type Checking Failures
Make sure all functions have type hints and pass mypy checks.

## Getting Help

- Check existing issues
- Read the documentation
- Ask questions in discussions

## Code Review Process

1. Create a pull request
2. Wait for CI checks to pass
3. Request review from maintainers
4. Address feedback
5. Merge after approval

Thank you for your contributions!
