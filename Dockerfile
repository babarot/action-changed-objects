FROM golang:1.13.7-stretch

ENV VERSION=v0.1.2

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        jq \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install b4b4r07/get-changed-objects
RUN wget -O /tmp/get-changed-objects-${VERSION}-linux-amd64.tar.gz \
    https://github.com/b4b4r07/get-changed-objects/releases/download/${VERSION}/get-changed-objects-linux-amd64.tar.gz \
    && cd /tmp \
    && tar -zxvf get-changed-objects-${VERSION}-linux-amd64.tar.gz \
    && mv get-changed-objects /usr/local/bin/ \
    && rm get-changed-objects-${VERSION}-linux-amd64.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
