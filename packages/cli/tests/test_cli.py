"""Tests for CLI main module."""

from opsctl_cli.main import app
from typer.testing import CliRunner

runner = CliRunner()


def test_hello_without_name() -> None:
    """Test hello command without a name."""
    result = runner.invoke(app, ["hello"])
    assert result.exit_code == 0
    assert "Hello from opsctl!" in result.stdout


def test_hello_with_name() -> None:
    """Test hello command with a name."""
    result = runner.invoke(app, ["hello", "World"])
    assert result.exit_code == 0
    assert "Hello World!" in result.stdout


def test_version() -> None:
    """Test version command."""
    result = runner.invoke(app, ["version"])
    assert result.exit_code == 0
    assert "opsctl version:" in result.stdout
    assert "0.1.0" in result.stdout
