#!/bin/bash

cat savelist.txt | while read i; do
echo "copying: '$i'"
cp -R "/mnt/v1_rz2/movies/$i" /mnt/wd_passport/movies
done