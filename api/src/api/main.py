"""FastAPI application entrypoint."""

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="Platform Engineering API",
    description="Template FastAPI application for platform engineering",
    version="0.1.0",
)


class HealthResponse(BaseModel):
    """Health check response model."""

    status: str
    version: str


class MessageResponse(BaseModel):
    """Generic message response model."""

    message: str


@app.get("/", response_model=MessageResponse)
async def root() -> MessageResponse:
    """Root endpoint."""
    return MessageResponse(message="Welcome to the Platform Engineering API")


@app.get("/health", response_model=HealthResponse)
async def health() -> HealthResponse:
    """Health check endpoint."""
    return HealthResponse(status="healthy", version="0.1.0")


@app.get("/api/v1/example", response_model=MessageResponse)
async def example_endpoint() -> MessageResponse:
    """Example API endpoint."""
    return MessageResponse(message="This is an example endpoint")
