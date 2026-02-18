#!/bin/bash
set -e

echo "[INFO] Starte Installation von Ollama über yay..."

# Prüfe, ob yay installiert ist
if ! command -v yay >/dev/null 2>&1; then
    echo "[ERROR] 'yay' ist nicht installiert. Bitte installiere es zuerst mit:"
    echo "  sudo pacman -S yay"
    exit 1
fi

# Prüfe ob Ollama bereits installiert ist
if yay -Q ollama-bin >/dev/null 2>&1; then
    echo "[INFO] Ollama ist bereits installiert."
else
    yay -S --noconfirm ollama-bin
    echo "[INFO] Ollama erfolgreich installiert."
fi
