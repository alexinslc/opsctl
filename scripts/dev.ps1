# Development helper script for Windows (PowerShell)
# Usage: .\scripts\dev.ps1 <command>

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function Show-Help {
    Write-Host "Available commands:" -ForegroundColor Cyan
    Write-Host "  .\scripts\dev.ps1 install      - Install all dependencies"
    Write-Host "  .\scripts\dev.ps1 test         - Run all tests"
    Write-Host "  .\scripts\dev.ps1 lint         - Run ruff linting"
    Write-Host "  .\scripts\dev.ps1 format       - Format code with ruff"
    Write-Host "  .\scripts\dev.ps1 type-check   - Run mypy type checking"
    Write-Host "  .\scripts\dev.ps1 clean        - Clean up cache files"
    Write-Host "  .\scripts\dev.ps1 run-api      - Run the API server"
    Write-Host "  .\scripts\dev.ps1 run-cli      - Show CLI help"
    Write-Host "  .\scripts\dev.ps1 help         - Show this help message"
}

function Install-Dependencies {
    Write-Host "Installing dependencies..." -ForegroundColor Green
    uv sync
}

function Run-Tests {
    Write-Host "Running tests..." -ForegroundColor Green
    uv run pytest
}

function Run-Lint {
    Write-Host "Running ruff linting..." -ForegroundColor Green
    uv run ruff check .
}

function Format-Code {
    Write-Host "Formatting code..." -ForegroundColor Green
    uv run ruff format .
    uv run ruff check --fix .
}

function Run-TypeCheck {
    Write-Host "Running type checking..." -ForegroundColor Green
    uv run mypy api/src cli/src
}

function Clean-Cache {
    Write-Host "Cleaning cache files..." -ForegroundColor Green
    Get-ChildItem -Path . -Include __pycache__,.pytest_cache,.ruff_cache,.mypy_cache -Recurse -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path . -Filter "*.pyc" -Recurse -Force | Remove-Item -Force -ErrorAction SilentlyContinue
    Write-Host "Clean complete!" -ForegroundColor Green
}

function Run-Api {
    Write-Host "Starting API server..." -ForegroundColor Green
    Push-Location api
    uv run uvicorn api.main:app --reload --host 0.0.0.0 --port 8000
    Pop-Location
}

function Run-Cli {
    Write-Host "CLI Help:" -ForegroundColor Green
    Push-Location cli
    uv run platform-cli --help
    Pop-Location
}

switch ($Command.ToLower()) {
    "install" { Install-Dependencies }
    "test" { Run-Tests }
    "lint" { Run-Lint }
    "format" { Format-Code }
    "type-check" { Run-TypeCheck }
    "clean" { Clean-Cache }
    "run-api" { Run-Api }
    "run-cli" { Run-Cli }
    "help" { Show-Help }
    default {
        Write-Host "Unknown command: $Command" -ForegroundColor Red
        Show-Help
    }
}
