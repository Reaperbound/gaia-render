FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl ca-certificates lsof && rm -rf /var/lib/apt/lists/*

RUN curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

ENV PATH="/root/gaianet/bin:$PATH"

# Initialize ONLY the base components
RUN gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json

EXPOSE 8080

# The '--local-only' flag and skipping the dashboard saves significant RAM
CMD ["sh", "-c", "gaianet start --local-only && tail -f /root/gaianet/logs/gaianet.log"]
