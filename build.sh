#!/usr/bin/env bash
# Gera docs/ (versão publicada, minificada/ofuscada) a partir do index.html (fonte, legível).
# Rodar sempre antes de publicar: bash build.sh
set -e
cd "$(dirname "$0")"

mkdir -p docs/assets
cp assets/* docs/assets/

npx --yes html-minifier-terser index.html \
  --collapse-whitespace --remove-comments --minify-css true --minify-js true \
  -o docs/index.html

echo "docs/index.html gerado a partir de index.html."
