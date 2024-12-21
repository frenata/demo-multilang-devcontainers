FROM node:23-bookworm-slim

COPY --from=ghcr.io/atuinsh/atuin:latest /usr/local/bin /bin/
COPY images/scripts /opt/scripts

USER root

RUN apt update && apt install -y curl tar xz-utils

RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin

RUN echo 'install bash-preexec' && \
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o /opt/bash-preexec.sh

WORKDIR /app/ui/name-a-dog

COPY src/ui/name-a-dog/package.json /app/ui/name-a-dog/
COPY src/ui/name-a-dog/package-lock.json /app/ui/name-a-dog/
RUN npm install

ENTRYPOINT [ "just", "run" ]

