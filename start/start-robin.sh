#!/bin/bash
cd "$HOME/robin-stack"
echo "[INFO] Starting Robin stack..."
docker compose up -d
echo "[READY] Access Robin at http://localhost:8501"
