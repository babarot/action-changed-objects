#!/bin/bash

export CLI_LOG=${INPUT_LOG}

if ${INPUT_ADDED:-false}; then
  flags+=("--type=added")
fi

if ${INPUT_DELETED:-false}; then
  flags+=("--type=deleted")
fi

if ${INPUT_MODIFIED:-false}; then
  flags+=("--type=modified")
fi

if [[ -n ${INPUT_DEFAULT_BRANCH} ]]; then
  flags+=("--default-branch=${INPUT_DEFAULT_BRANCH}")
fi

if [[ -n ${INPUT_MERGE_BASE} ]]; then
  flags+=("--merge-base=${INPUT_MERGE_BASE}")
fi

if [[ -n ${INPUT_GROUP_BY} ]]; then
  flags+=("--group-by=${INPUT_GROUP_BY}")
fi

if [[ -n ${INPUT_DIR_EXIST} ]]; then
  flags+=("--dir-exist=${INPUT_DIR_EXIST}")
fi

if [[ -n ${INPUT_IGNORE} ]]; then
  ignores=( "${INPUT_IGNORE//$'\n'/ }" )
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

# https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/
echo "changed::${changed}" >> ${GITHUB_OUTPUT}
