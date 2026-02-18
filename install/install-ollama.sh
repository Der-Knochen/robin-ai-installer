#!/bin/bash
set -e

ARCHIVE_URL="https://ollama.com/download/Ollama-linux-amd64.tar.gz"
ARCHIVE_NAME="ollama-linux-amd64.tar.gz"
ARCHIVE_SHA256="replace-with-correct-sha"

echo "[INFO] Installing Ollama..."

if [ -f "$ARCHIVE_NAME" ]; then
    echo "[INFO] Archive found, verifying..."
    if ! echo "$ARCHIVE_SHA256  $ARCHIVE_NAME" | sha256sum -c -; then
        echo "[WARN] Corrupted archive. Removing..."
        rm -f "$ARCHIVE_NAME"
    fi
fi

if [ ! -f "$ARCHIVE_NAME" ]; then
    curl -C - -L "$ARCHIVE_URL" -o "$ARCHIVE_NAME"
fi

echo "[INFO] Extracting..."
tar --no-same-owner -xzf "$ARCHIVE_NAME"

echo "[INFO] Done."
