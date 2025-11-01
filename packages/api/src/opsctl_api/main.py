"""Main API application using FastAPI."""

from fastapi import FastAPI
from pydantic import BaseModel

from opsctl_api import __version__

app = FastAPI(
    title="OpsCtl API",
    description="Platform engineering API service",
    version=__version__,
)


class HealthResponse(BaseModel):
    """Health check response model."""

    status: str
    version: str


class HelloResponse(BaseModel):
    """Hello response model."""

    message: str


@app.get("/")
async def root() -> dict[str, str]:
    """Root endpoint."""
    return {"message": "Welcome to OpsCtl API"}


@app.get("/health", response_model=HealthResponse)
async def health() -> HealthResponse:
    """Health check endpoint."""
    return HealthResponse(status="healthy", version=__version__)


@app.get("/hello/{name}", response_model=HelloResponse)
async def hello(name: str) -> HelloResponse:
    """Say hello to someone."""
    return HelloResponse(message=f"Hello {name}!")
