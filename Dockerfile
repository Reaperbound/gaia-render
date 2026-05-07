FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl ca-certificates python3 python3-pip
RUN curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash
ENV PATH="/root/gaianet/bin:$PATH"
RUN gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json
EXPOSE 8080
CMD ["gaianet", "start"]
