FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install GaiaNet
RUN curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

# Set Environment Path
ENV PATH="/root/gaianet/bin:$PATH"

# FIX: Use the official JSON config for the 0.5B model. 
# This JSON tells GaiaNet to download the Qwen 0.5B model correctly.
RUN gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json

# Render uses port 10000 by default for free instances
EXPOSE 8080

# Use 'tail' to keep the container running and output logs to the terminal
CMD ["sh", "-c", "gaianet start && tail -f /root/gaianet/logs/gaianet.log"]
