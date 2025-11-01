"""Typer CLI application entrypoint."""

import typer
from rich.console import Console
from rich.table import Table

app = typer.Typer(
    name="platform-cli",
    help="Platform Engineering CLI Tool",
    add_completion=True,
)

console = Console()


@app.command()
def hello(name: str = typer.Option("World", help="Name to greet")) -> None:
    """Say hello to someone."""
    console.print(f"[bold green]Hello {name}![/bold green]")


@app.command()
def info() -> None:
    """Display CLI information."""
    table = Table(title="Platform CLI Info")
    table.add_column("Property", style="cyan", no_wrap=True)
    table.add_column("Value", style="magenta")

    table.add_row("Name", "platform-cli")
    table.add_row("Version", "0.1.0")
    table.add_row("Description", "Platform Engineering CLI Tool")

    console.print(table)


@app.command()
def example(
    verbose: bool = typer.Option(False, "--verbose", "-v", help="Enable verbose output"),
    count: int = typer.Option(1, "--count", "-c", help="Number of times to execute"),
) -> None:
    """Example command with options."""
    for i in range(count):
        if verbose:
            console.print(f"[yellow]Executing iteration {i + 1}/{count}[/yellow]")
        console.print(f"[green]Example command executed![/green]")


if __name__ == "__main__":
    app()
