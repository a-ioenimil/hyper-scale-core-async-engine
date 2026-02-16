# hyper-scale-core-async-engine

`hyper-scale-core-async-engine` is a minimal FastAPI service with asynchronous endpoints and a Dockerized runtime.

## Features

- FastAPI-based REST API
- Async route handlers
- Versioned Python project metadata in `pyproject.toml`
- Multi-stage Docker build with `uv` for dependency sync
- Non-root runtime container user

## Tech Stack

- Python 3.10+
- FastAPI
- Uvicorn
- uv (Astral) for dependency management
- Docker

## Project Structure

```text
.
├── Dockerfile
├── pyproject.toml
├── README.md
└── src
		├── __init__.py
		├── main.py
		└── presentation
				└── restAPI
						└── routers
								└── whoami_router.py
```

## API Endpoints

### `GET /`

Returns a basic health-style message.

Example response:

```json
{
	"message": "Hello World"
}
```

### `GET /whoami/`

Returns an identity message from the `whoami` router.

Example response:

```json
{
	"message": "I am the low-level guy who has been part of training frontier AI models from Anthropic and OpenAI on agentic reasoning."
}
```

## Local Development

### Prerequisites

- Python 3.10 or higher
- `uv` installed

Install `uv` (Linux/macOS):

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Setup and Run

1. Install dependencies:

```bash
uv sync
```

2. Start the API server:

```bash
uv run uvicorn src.main:app --host 0.0.0.0 --port 5000 --reload
```

3. Open:

- API root: `http://localhost:5000/`
- Whoami endpoint: `http://localhost:5000/whoami/`
- Swagger docs: `http://localhost:5000/docs`
- ReDoc: `http://localhost:5000/redoc`

## Running with Docker

### Build Image

```bash
docker build -t hyper-scale-core-async-engine .
```

### Run Container

```bash
docker run --rm -p 5000:5000 hyper-scale-core-async-engine
```

The service will be available at `http://localhost:5000`.

## Notes

- The container runs as a non-root user (`appuser`) for better security.
- The Docker image exposes port `5000` and starts `uvicorn` with `src.main:app`.
