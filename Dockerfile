FROM ubuntu:22.04

# Install lsof to fix the 'command not found' error in your logs
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    lsof \
    && rm -rf /var/lib/apt/lists/*

# Install GaiaNet
RUN curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

ENV PATH="/root/gaianet/bin:$PATH"

# Initialize with the 0.5B model config
RUN gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json

EXPOSE 8080

# START COMMAND: This starts ONLY the essential API server to save RAM
CMD ["sh", "-c", "gaianet start --base-port 8080 && tail -f /root/gaianet/logs/gaianet.log"]
