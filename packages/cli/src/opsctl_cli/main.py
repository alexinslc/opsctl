"""Main CLI application using Typer."""

import typer
from rich.console import Console

app = typer.Typer(
    name="opsctl",
    help="Platform engineering CLI tool",
    add_completion=True,
)
console = Console()


@app.command()
def hello(name: str | None = typer.Argument(None, help="Name to greet")) -> None:
    """Say hello to someone."""
    if name:
        console.print(f"[bold green]Hello {name}![/bold green]")
    else:
        console.print("[bold green]Hello from opsctl![/bold green]")


@app.command()
def version() -> None:
    """Show the version."""
    from opsctl_cli import __version__

    console.print(f"[bold blue]opsctl version:[/bold blue] {__version__}")


if __name__ == "__main__":
    app()
