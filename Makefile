.PHONY: help install test lint format typecheck clean run-cli run-api all

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies
	uv sync

test: ## Run all tests
	uv run pytest -v

test-cov: ## Run tests with coverage
	uv run pytest --cov=packages --cov-report=html --cov-report=term

lint: ## Run linting checks
	uv run ruff check .

lint-fix: ## Fix linting issues automatically
	uv run ruff check --fix .

format: ## Format code with ruff
	uv run ruff format .

typecheck: ## Run type checking with mypy
	uv run mypy packages/cli/src packages/api/src

clean: ## Clean up cache and build artifacts
	rm -rf .venv
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .ruff_cache
	rm -rf htmlcov
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

run-cli: ## Run the CLI
	uv run opsctl --help

run-api: ## Run the API server
	uv run uvicorn opsctl_api.main:app --reload

all: lint typecheck test ## Run lint, typecheck, and test
