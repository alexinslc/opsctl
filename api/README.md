# API

FastAPI application for platform engineering.

## Development

### Running the API

The following commands work identically on macOS, Linux, and Windows:

```bash
cd api
uv run uvicorn api.main:app --reload --host 0.0.0.0 --port 8000
```

### Running Tests

The following commands work identically on macOS, Linux, and Windows:

```bash
cd api
uv run pytest
```

### API Documentation

Once running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Endpoints

- `GET /` - Root endpoint
- `GET /health` - Health check
- `GET /api/v1/example` - Example endpoint
