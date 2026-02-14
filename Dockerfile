FROM python:3.15.0a6-slim as builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml uv.lock ./
ENV UV_PROJECT_ENVIRONMENT=/opt/venv
ENV UV_PYTHON_DOWNLOADS=never
RUN uv sync --frozen --no-dev --no-install-project

FROM python:3.15.0a6-slim as runtime

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY --from=builder --chown=appuser:appuser /opt/venv /opt/venv

COPY --chown=appuser:appuser src ./src

USER appuser

EXPOSE 5000

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "5000"]
