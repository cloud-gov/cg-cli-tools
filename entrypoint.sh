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

# If no cf CLI command is set, push app with manifest or vars file.
if [[ -z "$INPUT_CF_COMMAND" ]]; then  
  if [[ -r "$INPUT_CF_VARS_FILE" ]]; then 
    echo "Pushing with vars file: $INPUT_CF_VARS_FILE"
    cf push --vars-file "$CF_VARS_FILE"
  else 
    echo "Pusing with manifest file: $MANIFEST"
    cf push -f "$MANIFEST"
  fi
# Otherwise, run the specified cf CLI command.
else
    echo "Running command: $INPUT_CF_COMMAND"
    cf $INPUT_CF_COMMAND
fi
