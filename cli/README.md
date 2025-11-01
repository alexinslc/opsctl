# CLI

Typer CLI application for platform engineering.

## Development

All commands below work identically on macOS, Linux, and Windows.

### Installing the CLI

```bash
cd cli
uv sync
```

### Running the CLI

```bash
cd cli
uv run platform-cli --help
```

### Available Commands

```bash
# Say hello
uv run platform-cli hello --name "World"

# Display CLI info
uv run platform-cli info

# Run example command
uv run platform-cli example --verbose --count 3
```

### Running Tests

```bash
cd cli
uv run pytest
```

## Features

- Rich terminal output with colors and tables
- Auto-completion support
- Type-safe command definitions
- Comprehensive help text
- Modular command groups for organizing related commands

## Adding Command Groups

### What are Command Groups?

In Typer, a **command group** (also called a **sub-application**) lets you organize related commands under a common namespace. For example:

```bash
uv run platform-cli grafana dashboard list
uv run platform-cli azure pipeline run --name "prod"
```

### Quick Start: Add a New Command Group

**1. Create the command group directory:**

```bash
mkdir -p src/cli/<group_name>
touch src/cli/<group_name>/__init__.py
```

**2. Create `commands.py` with your subcommands:**

```python
"""<Group name> command group."""
import typer
from typing import Optional

# Create a Typer sub-application
app = typer.Typer()


@app.command()
def status():
    """Check connection status."""
    typer.echo("✅ Connected")


@app.command()
def list(
    verbose: bool = typer.Option(False, "--verbose", "-v", help="Verbose output")
):
    """List available resources."""
    typer.echo("📋 Listing resources...")
```

**3. Register the command group in `main.py`:**

```python
# Import the command group
from cli.<group_name>.commands import app as <group_name>_app

# Register it
app.add_typer(
    <group_name>_app,
    name="<group_name>",
    help="Manage <group_name> resources"
)
```

**4. Test your commands:**

```bash
uv run platform-cli <group_name> --help
uv run platform-cli <group_name> status
uv run platform-cli <group_name> list --verbose
```

### Example: Grafana Command Group

Here's a complete example for managing Grafana dashboards:

**Directory structure:**
```
cli/src/cli/
├── main.py
└── grafana/
    ├── __init__.py
    └── commands.py
```

**`grafana/commands.py`:**

```python
"""Grafana command group - manages dashboards and alerts."""
import typer
from typing import Optional

app = typer.Typer()


@app.command()
def dashboard(
    action: str = typer.Argument(..., help="Action: list, create, delete"),
    name: Optional[str] = typer.Option(None, "--name", "-n", help="Dashboard name"),
):
    """Manage Grafana dashboards.
    
    Examples:
        platform-cli grafana dashboard list
        platform-cli grafana dashboard create --name "My Dashboard"
    """
    if action == "list":
        typer.echo("📊 Listing dashboards...")
    elif action == "create":
        if not name:
            typer.echo("❌ Error: --name required", err=True)
            raise typer.Exit(1)
        typer.echo(f"✅ Created dashboard: {name}")
    elif action == "delete":
        if not name:
            typer.echo("❌ Error: --name required", err=True)
            raise typer.Exit(1)
        typer.echo(f"🗑️  Deleted dashboard: {name}")


@app.command()
def alert(
    action: str = typer.Argument(..., help="Action: list, create, delete"),
    rule: Optional[str] = typer.Option(None, "--rule", "-r", help="Alert rule"),
):
    """Manage Grafana alert rules."""
    if action == "list":
        typer.echo("🔔 Listing alerts...")
    elif action == "create":
        if not rule:
            typer.echo("❌ Error: --rule required", err=True)
            raise typer.Exit(1)
        typer.echo(f"✅ Created alert: {rule}")
```

**Register in `main.py`:**

```python
from cli.grafana.commands import app as grafana_app

app.add_typer(
    grafana_app,
    name="grafana",
    help="Manage Grafana dashboards and alerts"
)
```

**Usage:**

```bash
uv run platform-cli grafana --help
uv run platform-cli grafana dashboard list
uv run platform-cli grafana dashboard create --name "CPU Usage"
uv run platform-cli grafana alert list
uv run platform-cli grafana alert create --rule "High Memory"
```

### Typer Terminology Reference

| Term | Definition | Example |
|------|------------|---------|
| **Typer()** | Creates a Typer application | `app = typer.Typer()` |
| **Command** | Function decorated with `@app.command()` | `@app.command()` |
| **Command Group** | Sub-application added with `add_typer()` | `app.add_typer(grafana_app, name="grafana")` |
| **Subcommand** | Command within a command group | `cli grafana dashboard` |
| **Argument** | Required positional parameter | `typer.Argument(...)` |
| **Option** | Optional flag parameter | `typer.Option(None, "--name")` |

### Common Patterns

**Required vs Optional Parameters:**

```python
# Required positional argument
action: str = typer.Argument(..., help="Action to perform")

# Optional option with default
name: str = typer.Option("default", "--name", "-n", help="Name")

# Optional option (None if not provided)
name: Optional[str] = typer.Option(None, "--name", "-n", help="Name")

# Boolean flag
verbose: bool = typer.Option(False, "--verbose", "-v", help="Verbose")
```

**Error Handling:**

```python
if something_wrong:
    typer.echo("❌ Error message", err=True)
    raise typer.Exit(1)  # Exit with error code
```

**Success Messages:**

```python
typer.echo("✅ Operation successful")
typer.echo("📊 Data retrieved")
typer.echo("🚀 Process started")
```

### Best Practices

1. **One command group per directory** - Keep related commands together
2. **Clear naming** - Use descriptive names for command groups and subcommands
3. **Helpful docstrings** - Include examples in command docstrings
4. **Consistent error handling** - Use `typer.echo(..., err=True)` and `raise typer.Exit(1)`
5. **Rich output** - Use emojis and colors for better UX
6. **Type hints** - Always use type hints with `Optional`, `str`, `bool`, etc.

### Project Structure for Multiple Command Groups

```
cli/src/cli/
├── __init__.py
├── main.py              # Main app, registers all command groups
├── grafana/             # Grafana command group
│   ├── __init__.py
│   └── commands.py      # Grafana subcommands
├── azure/               # Azure DevOps command group
│   ├── __init__.py
│   └── commands.py      # Azure subcommands
├── kubernetes/          # Kubernetes command group
│   ├── __init__.py
│   └── commands.py      # K8s subcommands
└── utils/               # Shared utilities (optional)
    ├── __init__.py
    └── common.py        # Shared functions
```
