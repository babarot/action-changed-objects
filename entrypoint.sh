#!/bin/bash

if ${INPUT_ADDED:-false}; then
  flags+=("--filter=added")
fi

if ${INPUT_DELETED:-false}; then
  flags+=("--filter=deleted")
fi

if ${INPUT_MODIFIED:-false}; then
  flags+=("--filter=modified")
fi

objects=( $(changed-objects "${flags[@]}") )

echo "[INFO] get change objects: ${objects[@]}"

echo "::set-output name=changed::${objects[@]}"
