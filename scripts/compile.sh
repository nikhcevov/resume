#!/usr/bin/env bash
# Compiles resume.tex inside the Docker container.
# Usage: compile [once|watch]  (default: once)
set -euo pipefail

JOBNAME="vladimir_ovechkin_resume"
SOURCE="resume.tex"

build() {
  echo "Compiling $SOURCE -> $JOBNAME.pdf"
  pdflatex -interaction=nonstopmode -halt-on-error -jobname="$JOBNAME" "$SOURCE"
  pdftoppm -png -r 300 -singlefile "$JOBNAME.pdf" "$JOBNAME"
  echo "Done: $JOBNAME.pdf, $JOBNAME.png"
}

watch() {
  build
  echo "Watching $SOURCE for changes..."
  while inotifywait -q -e close_write -e moved_to "$SOURCE"; do
    sleep 0.2 # debounce burst writes from editors
    build
  done
}

case "${1:-once}" in
  once)  build ;;
  watch) watch ;;
  *)     echo "Usage: compile [once|watch]" >&2; exit 1 ;;
esac
