#!/usr/bin/env bash
# Gera docs/ (versão publicada, minificada/ofuscada) a partir do index.html (fonte, legível).
# Rodar sempre antes de publicar: bash build.sh
set -e
cd "$(dirname "$0")"

mkdir -p docs/assets
cp assets/* docs/assets/

for page in index.html roleta-1/index.html roleta-2/index.html; do
  mkdir -p "docs/$(dirname "$page")"
  npx --yes html-minifier-terser "$page" \
    --collapse-whitespace --remove-comments --minify-css true --minify-js true \
    -o "docs/$page"
  echo "docs/$page gerado a partir de $page."
done
