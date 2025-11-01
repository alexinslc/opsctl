"""Tests for API main module."""

from fastapi.testclient import TestClient
from opsctl_api.main import app

client = TestClient(app)


def test_root() -> None:
    """Test root endpoint."""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to OpsCtl API"}


def test_health() -> None:
    """Test health endpoint."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["version"] == "0.1.0"


def test_hello() -> None:
    """Test hello endpoint."""
    response = client.get("/hello/World")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "Hello World!"
