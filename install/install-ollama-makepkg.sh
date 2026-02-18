#!/bin/bash
set -e

echo "[INFO] Starte manuelle AUR-Installation von Ollama..."

# Abhängigkeiten installieren
echo "[INFO] Installiere benötigte Tools (git, base-devel)..."
sudo pacman -S --needed git base-devel

# In temporäres Verzeichnis wechseln
WORKDIR="/tmp/ollama-aur-$$"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Repository klonen
echo "[INFO] Klone ollama-bin von AUR..."
git clone https://aur.archlinux.org/ollama-bin.git
cd ollama-bin

# Paket bauen und installieren
echo "[INFO] Baue und installiere ollama-bin..."
makepkg -si --noconfirm

# Aufräumen
echo "[INFO] Bereinige temporäre Dateien..."
cd ~
rm -rf "$WORKDIR"

# Test
echo "[INFO] Teste Installation:"
if command -v ollama >/dev/null 2>&1; then
    ollama --version
    echo "[DONE] Ollama erfolgreich installiert."
else
    echo "[ERROR] Installation fehlgeschlagen."
    exit 1
fi
