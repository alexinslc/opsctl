"""Tests for the main API endpoints."""

from api.main import app
from fastapi.testclient import TestClient

client = TestClient(app)


def test_root() -> None:
    """Test the root endpoint."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "Welcome to the Platform Engineering API"


def test_health() -> None:
    """Test the health check endpoint."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["version"] == "0.1.0"


def test_example_endpoint() -> None:
    """Test the example API endpoint."""
    response = client.get("/api/v1/example")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "This is an example endpoint"
