#!/bin/bash

set -e

# base directory for folders
script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
parent_dir="$(dirname "${script_path}")"

# loop through found .rar files
for file in $(find "${parent_dir}/data/torrents/series" -type f -name "*.rar" | sort -u); do

  folder=$(dirname "${file}")
  echo "file: ${file}"
  echo "folder: ${folder}"

  if [[ ! -f "${folder}/unpacked" ]]; then
    echo "unpacking.."
    umask 002
    unrar x "${file}" "${folder}"
    touch "${folder}/unpacked"
    chmod -R 775 "${folder}"
    echo "unpacked"
  else
    echo "already unpacked"
  fi

done