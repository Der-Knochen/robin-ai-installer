#!/bin/bash
FILE="$1"
SHA="$2"

if [ ! -f "$FILE" ]; then
  echo "[ERROR] File not found: $FILE"
  exit 1
fi

echo "$SHA  $FILE" | sha256sum -c - || {
  echo "[WARN] Checksum mismatch. Deleting $FILE"
  rm -f "$FILE"
  exit 1
}

echo "[INFO] Checksum OK."
