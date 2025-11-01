@echo off
REM Development helper script for Windows
REM Usage: scripts\dev.bat <command>

if "%1"=="" goto help

if "%1"=="install" goto install
if "%1"=="test" goto test
if "%1"=="lint" goto lint
if "%1"=="format" goto format
if "%1"=="type-check" goto typecheck
if "%1"=="clean" goto clean
if "%1"=="run-api" goto runapi
if "%1"=="run-cli" goto runcli
if "%1"=="help" goto help

echo Unknown command: %1
goto help

:install
echo Installing dependencies...
uv sync
goto end

:test
echo Running tests...
uv run pytest
goto end

:lint
echo Running ruff linting...
uv run ruff check .
goto end

:format
echo Formatting code...
uv run ruff format .
uv run ruff check --fix .
goto end

:typecheck
echo Running type checking...
uv run mypy api\src cli\src
goto end

:clean
echo Cleaning cache files...
for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s /q "%%d"
for /d /r . %%d in (.pytest_cache) do @if exist "%%d" rd /s /q "%%d"
for /d /r . %%d in (.ruff_cache) do @if exist "%%d" rd /s /q "%%d"
for /d /r . %%d in (.mypy_cache) do @if exist "%%d" rd /s /q "%%d"
del /s /q *.pyc 2>nul
echo Clean complete!
goto end

:runapi
echo Starting API server...
cd api
uv run uvicorn api.main:app --reload --host 0.0.0.0 --port 8000
goto end

:runcli
echo CLI Help:
cd cli
uv run platform-cli --help
goto end

:help
echo Available commands:
echo   scripts\dev.bat install      - Install all dependencies
echo   scripts\dev.bat test         - Run all tests
echo   scripts\dev.bat lint         - Run ruff linting
echo   scripts\dev.bat format       - Format code with ruff
echo   scripts\dev.bat type-check   - Run mypy type checking
echo   scripts\dev.bat clean        - Clean up cache files
echo   scripts\dev.bat run-api      - Run the API server
echo   scripts\dev.bat run-cli      - Show CLI help
echo   scripts\dev.bat help         - Show this help message
goto end

:end
