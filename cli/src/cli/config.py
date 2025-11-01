"""CLI configuration."""

from pathlib import Path

from pydantic import BaseModel


class CLIConfig(BaseModel):
    """CLI configuration model."""

    config_dir: Path = Path.home() / ".platform-cli"
    verbose: bool = False
    output_format: str = "text"

    def ensure_config_dir(self) -> None:
        """Ensure the config directory exists."""
        self.config_dir.mkdir(parents=True, exist_ok=True)


def load_config(config_path: Path | None = None) -> CLIConfig:
    """Load CLI configuration."""
    if config_path and config_path.exists():
        # In a real implementation, you would load from file
        pass
    return CLIConfig()
