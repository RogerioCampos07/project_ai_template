FROM python:3.12-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    PATH="/opt/poetry/bin:/app/.venv/bin:$PATH"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python3 -

COPY pyproject.toml ./
COPY poetry.lock* ./

# Gera o lock se não existir e instala
RUN poetry lock --no-update || true && \
    poetry install --with dev --no-ansi --no-root

COPY src ./src

RUN poetry install --with dev --no-ansi --only-root

ARG UID=1000
ARG GID=1000
RUN groupadd -g "${GID}" appgroup && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" appuser \
    && chown -R appuser:appgroup /app
USER appuser