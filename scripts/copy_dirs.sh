#!/bin/bash

# run script after entering new `screen` session when copying large amounts of data
textfile="savelist.txt"
source="/mnt/v1_rz2/series"
dest="/mnt/wd_passport/series"

cat "$textfile" | while read i; do
  echo "copying: '$i'"
  cp -R "${source}/$i" "${dest}"
done