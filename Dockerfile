FROM debian:bookworm-slim

ENV VERSION=v0.3.11

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Install babarot/changed-objects
RUN curl -fsSL https://github.com/babarot/changed-objects/releases/download/${VERSION}/changed-objects_Linux_x86_64.tar.gz \
  | tar -xz -C /usr/local/bin changed-objects

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
