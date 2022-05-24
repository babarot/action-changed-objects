FROM golang:1.13.7-stretch

ENV VERSION=v0.1.14

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        jq \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install b4b4r07/changed-objects
RUN wget -O /tmp/changed-objects-${VERSION}-linux-amd64.tar.gz \
    https://github.com/b4b4r07/changed-objects/releases/download/${VERSION}/changed-objects-linux-x86_64.tar.gz \
    && cd /tmp \
    && tar -zxvf changed-objects-${VERSION}-linux-amd64.tar.gz \
    && mv changed-objects /usr/local/bin/ \
    && rm changed-objects-${VERSION}-linux-amd64.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
