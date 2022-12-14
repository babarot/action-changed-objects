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

if ${INPUT_DIR_EXIST:-false}; then
  flags+=("--dir-exist")
fi

if ${INPUT_DIR_NOT_EXIST:-false}; then
  flags+=("--dir-not-exist")
fi

if [[ -n ${INPUT_OUTPUT} ]]; then
  flags+=("--output=${INPUT_OUTPUT}")
fi

if [[ -n ${INPUT_BRANCH} ]]; then
  flags+=("--default-branch=${INPUT_BRANCH}")
fi

if [[ -n ${INPUT_BASE} ]]; then
  flags+=("--merge-base=${INPUT_BASE}")
fi

if [[ -n ${INPUT_IGNORE} ]]; then
  ignores=( "${INPUT_IGNORE//\n/ }" )
  for ig in ${ignores[@]}
  do
    flags+=("--ignore=${ig}")
  done
fi

if [[ -n ${INPUT_DIRECTORIES} ]]; then
  args+=(${INPUT_DIRECTORIES})
fi

changed=$(changed-objects ${flags[@]} ${args[@]})
if [[ $? != 0 ]]; then
  echo "[ERROR] failed to get changed objects" >&2
  exit 1
fi

echo "[INFO] get change objects: ${changed}"

echo "::set-output name=changed::${changed}"
