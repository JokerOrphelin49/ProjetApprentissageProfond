#!/bin/bash

# set the directory where the HEIC files are located
dir=$PWD

# loop through all HEIC files in the directory and convert them to JPG
for file in "$dir"/*.HEIC; do
  # get the base name of the file (without extension)
  base=$(basename "$file" .HEIC)
  # run the heif-convert command to convert the HEIC file to JPG
  heif-convert "$file" "$dir/$base.jpg"
done
