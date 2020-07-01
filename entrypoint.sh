#!/bin/bash

# Check manifest file.
MANIFEST=${INPUT_CF_MANIFEST:-manifest.yml}
if [[ ! -r "$MANIFEST" ]]; then
  echo Manifest file \`"$MANIFEST"\` does not exist. >&2
  exit 1
fi

# Authenticate and target CF org and space.
cf api "$INPUT_CF_API"
cf auth "$INPUT_CF_USERNAME" "$INPUT_CF_PASSWORD"
cf target -o "$INPUT_CF_ORG" -s "$INPUT_CF_SPACE"

if [[ -z "$INPUT_CF_COMMAND" ]]; then
    cf v3-zdt-push -f "$MANIFEST"
else
    cf "$INPUT_CF_COMMAND"
fi
