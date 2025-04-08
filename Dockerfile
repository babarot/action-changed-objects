FROM golang:1.20.3-bullseye

ENV VERSION=v0.3.8

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  jq \
  vim \
  && rm -rf /var/lib/apt/lists/*

# Install babarot/changed-objects
RUN wget -O /tmp/changed-objects-${VERSION}-linux-amd64.tar.gz \
  https://github.com/babarot/changed-objects/releases/download/${VERSION}/changed-objects_Linux_x86_64.tar.gz \
  && cd /tmp \
  && tar -zxvf changed-objects-${VERSION}-linux-amd64.tar.gz \
  && mv changed-objects /usr/local/bin/ \
  && rm changed-objects-${VERSION}-linux-amd64.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
