#!/bin/bash

FILE=$1

BASENAME="${FILE%.txt}"
PIPER_DIR="${HOME}"/Documents/piper/

piper -m "${PIPER_DIR}"/en_US-bryce-medium.onnx -c "${PIPER_DIR}"/en_US-bryce-medium.onnx.json -i "${BASENAME}".txt -f "${BASENAME}".wav
