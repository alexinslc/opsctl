.PHONY: help install test lint format type-check clean run-api run-cli

help:
	@echo "Available commands:"
	@echo "  make install      - Install all dependencies"
	@echo "  make test         - Run all tests"
	@echo "  make lint         - Run ruff linting"
	@echo "  make format       - Format code with ruff"
	@echo "  make type-check   - Run mypy type checking"
	@echo "  make clean        - Clean up cache files"
	@echo "  make run-api      - Run the API server"
	@echo "  make run-cli      - Show CLI help"

install:
	uv sync

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .
	uv run ruff check --fix .

type-check:
	uv run mypy api/src cli/src

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

run-api:
	cd api && uv run uvicorn api.main:app --reload --host 0.0.0.0 --port 8000

run-cli:
	cd cli && uv run platform-cli --help
