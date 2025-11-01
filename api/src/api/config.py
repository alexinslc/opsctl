"""Application configuration using pydantic-settings."""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings."""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
    )

    # API Settings
    api_host: str = "0.0.0.0"
    api_port: int = 8000
    api_reload: bool = False

    # Application Settings
    app_name: str = "Platform Engineering API"
    app_version: str = "0.1.0"
    debug: bool = False


settings = Settings()
