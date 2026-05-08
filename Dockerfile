FROM ubuntu:22.04

# Added 'lsof' to fix the line 494 error and 'tzdata' for system stability
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    lsof \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

ENV PATH="/root/gaianet/bin:$PATH"

# Initialize with the 0.5B config
RUN gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json

EXPOSE 8080

# Start command with manual log tailing
CMD ["sh", "-c", "gaianet start && tail -f /root/gaianet/logs/gaianet.log"]
