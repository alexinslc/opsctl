"""Tests for the CLI application."""

from typer.testing import CliRunner

from cli.main import app

runner = CliRunner()


def test_hello_default() -> None:
    """Test the hello command with default name."""
    result = runner.invoke(app, ["hello"])
    assert result.exit_code == 0
    assert "Hello World!" in result.stdout


def test_hello_with_name() -> None:
    """Test the hello command with a custom name."""
    result = runner.invoke(app, ["hello", "--name", "Alice"])
    assert result.exit_code == 0
    assert "Hello Alice!" in result.stdout


def test_info() -> None:
    """Test the info command."""
    result = runner.invoke(app, ["info"])
    assert result.exit_code == 0
    assert "platform-cli" in result.stdout
    assert "0.1.0" in result.stdout


def test_example_default() -> None:
    """Test the example command with default options."""
    result = runner.invoke(app, ["example"])
    assert result.exit_code == 0
    assert "Example command executed!" in result.stdout


def test_example_verbose() -> None:
    """Test the example command with verbose flag."""
    result = runner.invoke(app, ["example", "--verbose"])
    assert result.exit_code == 0
    assert "Executing iteration" in result.stdout


def test_example_with_count() -> None:
    """Test the example command with count option."""
    result = runner.invoke(app, ["example", "--count", "3"])
    assert result.exit_code == 0
    assert result.stdout.count("Example command executed!") == 3
