#!/usr/bin/env bash
# pages.sh — build a static site into _site/ for GitHub Pages.
# Run by the hub "pages" workflow inside docker/pages.Dockerfile.
# Generic demo fallback: renders README.md; override per repo as needed.
set -euo pipefail

echo "== pages =="
rm -rf _site
mkdir -p _site
if [[ -f README.md ]]; then
  {
    echo '<!doctype html><meta charset="utf-8">'
    echo "<title>$(basename "$PWD")</title>"
    echo '<pre>'
    sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' README.md
    echo '</pre>'
  } > _site/index.html
fi

echo "== done =="
