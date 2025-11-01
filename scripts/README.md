# Development Scripts

This directory contains helper scripts for development tasks across different platforms.

## For Windows Users

Windows users have two options for running development commands:

### Option 1: PowerShell Script (Recommended)

**Usage:**
```powershell
.\scripts\dev.ps1 <command>
```

**Examples:**
```powershell
.\scripts\dev.ps1 install
.\scripts\dev.ps1 test
.\scripts\dev.ps1 lint
.\scripts\dev.ps1 format
.\scripts\dev.ps1 type-check
.\scripts\dev.ps1 clean
.\scripts\dev.ps1 run-api
.\scripts\dev.ps1 run-cli
```

### Option 2: Batch Script

**Usage:**
```cmd
scripts\dev.bat <command>
```

**Examples:**
```cmd
scripts\dev.bat install
scripts\dev.bat test
scripts\dev.bat lint
scripts\dev.bat format
scripts\dev.bat type-check
scripts\dev.bat clean
scripts\dev.bat run-api
scripts\dev.bat run-cli
```

## For macOS/Linux Users

Use the `Makefile` in the root directory:

```bash
make install
make test
make lint
make format
make type-check
make clean
make run-api
make run-cli
```

## Available Commands

All scripts support the following commands:

- **install** - Install all project dependencies using uv
- **test** - Run all tests with pytest
- **lint** - Check code style with ruff
- **format** - Format code and fix auto-fixable issues with ruff
- **type-check** - Run static type checking with mypy
- **clean** - Remove cache files and bytecode
- **run-api** - Start the FastAPI development server
- **run-cli** - Display CLI help information

## Direct Commands

Alternatively, you can run `uv` commands directly on any platform:

```bash
uv sync                              # Install dependencies
uv run pytest                        # Run tests
uv run ruff check .                  # Lint code
uv run ruff format .                 # Format code
uv run mypy api/src cli/src          # Type check
```

See the main [README.md](../README.md) for more details.
