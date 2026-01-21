#!/bin/bash
FILE=$1

BASENAME="${FILE%.pdf}"
TEMP_DIR=$(mktemp -d)

cleanup() {
  rm -rf "$TEMP_DIR"
}

trap cleanup EXIT INT TERM

magick -density 400 "${FILE}" \
  -depth 8 \
  -strip \
  -background white \
  -alpha off \
  -colorspace gray \
  -type grayscale \
  -despeckle \
  -auto-level \
  "$TEMP_DIR/page-%04d.png"

for PNG_FILE in "$TEMP_DIR"/page-*.png; do
  BASE="${PNG_FILE%.png}"
  tesseract "${PNG_FILE}" "${BASE}" -l eng --oem 3 --dpi 400
done

cat "$TEMP_DIR"/page-*.txt >"${BASENAME}.txt"
