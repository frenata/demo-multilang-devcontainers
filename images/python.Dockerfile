FROM python:3.12-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY --from=ghcr.io/atuinsh/atuin:latest /usr/local/bin /bin/
COPY images/scripts /opt/scripts

RUN apt update && apt install -y curl tar xz-utils

RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin

RUN echo 'install bash-preexec' && \
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o /opt/bash-preexec.sh

ENV UV_PROJECT_ENVIRONMENT /tmp/venv

WORKDIR /app/api

COPY src/api/pyproject.toml /app/api
COPY src/api/uv.lock /app/api
RUN uv sync


ENTRYPOINT [ "just", "run" ]
