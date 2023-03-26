#!/bin/bash

dir_name=$(basename "$PWD")

# get the list of files and sort them by name
file_list=$(ls -1 "${dir_name}_"*.jpg 2>/dev/null | sort)

# initialize the counter
count=1

# loop through the files
for file in $file_list; do
  # get the current file number
  file_number=$(echo "$file" | grep -o '[0-9]\{3\}')

  # check if the file number is equal to the counter
  if [ "$file_number" != "$(printf '%03d' "$count")" ]; then
    # fill in the gap
    new_number=$(printf '%03d' "$count")
    new_name="${dir_name}_${new_number}.jpg"

    # rename the file
    mv "$file" "$new_name"
  fi

  # increment the counter
  ((count++))
done
