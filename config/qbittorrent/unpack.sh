#!/bin/bash

FOLDER="$1"

cd "${FOLDER}" || exit 1

printf "unpacking %s\n" "${FOLDER}"

unrar x -r .

chmod -R 775 .
