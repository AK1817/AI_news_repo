FROM python:3.11-slim

# Same uv version as local tooling
COPY --from=ghcr.io/astral-sh/uv:0.7.3 /uv /bin/uv

WORKDIR /app

# Install dependencies first so this layer is cached between code changes
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project

COPY . .

CMD ["uv", "run", "--frozen", "main.py"]
