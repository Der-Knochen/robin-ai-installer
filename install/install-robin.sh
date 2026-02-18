#!/bin/bash
set -e

STACK_DIR="$HOME/robin-stack"
MODEL=""
RAM_MB=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)

echo "[INFO] RAM detected: ${RAM_MB} MB"

if [ "$RAM_MB" -lt 6000 ]; then
    MODEL="tinyllama"
elif [ "$RAM_MB" -lt 12000 ]; then
    MODEL="phi3:mini"
elif [ "$RAM_MB" -lt 24000 ]; then
    MODEL="qwen2.5:3b"
else
    MODEL="mistral"
fi

echo "[INFO] Selected model: $MODEL"
mkdir -p "$STACK_DIR"
cd "$STACK_DIR"

echo "[INFO] Writing docker-compose.yml..."
cat > docker-compose.yml <<EOF
version: "3.8"
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ollama-data:/root/.ollama
    restart: unless-stopped

  robin:
    image: apurvsg/robin:latest
    container_name: robin
    ports:
      - "8501:8501"
    volumes:
      - robin-data:/data
    environment:
      - MODEL=$MODEL
    restart: unless-stopped

  tor:
    image: osminogin/tor-simple
    container_name: tor
    ports:
      - "9050:9050"
    restart: unless-stopped

volumes:
  ollama-data:
  robin-data:
EOF

echo "[INFO] Pulling images..."
docker compose pull

echo "[DONE] Robin stack is ready. Run ./start-robin.sh to launch."
