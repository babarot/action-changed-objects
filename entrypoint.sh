#!/bin/bash

export CLI_LOG=${INPUT_LOG}

if ${INPUT_ADDED:-false}; then
  flags+=("--filter=added")
fi

if ${INPUT_DELETED:-false}; then
  flags+=("--filter=deleted")
fi

if ${INPUT_MODIFIED:-false}; then
  flags+=("--filter=modified")
fi

if ${INPUT_DIRNAME:-false}; then
  flags+=("--dirname")
fi

if [[ -n ${INPUT_OUTPUT} ]]; then
  flags+=("--output=${INPUT_OUTPUT}")
fi

if [[ -n ${INPUT_DEFAULT_BRANCH} ]]; then
  flags+=("--default-branch=${INPUT_DEFAULT_BRANCH}")
fi

changed=$(changed-objects "${flags[@]}")
if [[ $? != 0 ]]; then
  echo "[ERROR] failed to get changed objects" >&2
  exit 1
fi

echo "[INFO] get change objects: ${changed}"

echo "::set-output name=changed::${changed}"
