# Contributing to OpsCtl

Thank you for considering contributing to this project!

## How to Contribute

1. **Fork the repository**
2. **Create a new branch** for your feature or bugfix
3. **Make your changes** following our coding standards
4. **Add tests** for your changes
5. **Run tests and linting** to ensure everything passes
6. **Submit a pull request**

## Development Setup

See [DEVELOPMENT.md](DEVELOPMENT.md) for detailed setup instructions.

## Code Style

This project uses:
- **ruff** for linting and formatting
- **mypy** for type checking
- **pytest** for testing

Before submitting a PR, ensure:

```bash
# All tests pass
uv run pytest

# Code is formatted
uv run ruff format .

# No linting errors
uv run ruff check .

# No type errors
uv run mypy packages/cli/src packages/api/src
```

## Pull Request Guidelines

- Write clear, descriptive commit messages
- Keep PRs focused on a single feature or bugfix
- Update documentation if needed
- Add tests for new functionality
- Ensure all CI checks pass

## Reporting Issues

When reporting issues, please include:
- A clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, Python version, etc.)

## Questions?

Feel free to open an issue for questions or discussions!
