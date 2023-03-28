#!/bin/bash

# Set the source directory and destination directories
src_dir="$1"
dest_dir1="$2"
dest_dir2="$3"

# Check that the source and destination directories are valid
if [[ ! -d "$src_dir" ]] || [[ ! -d "$dest_dir1" ]] || [[ ! -d "$dest_dir2" ]]; then
  echo "Usage: $0 <source directory> <destination directory 1> <destination directory 2>"
  exit 1
fi

# Count the number of image files in the source directory
num_files=$(find "$src_dir" -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" | wc -l)
if [[ $num_files -eq 0 ]]; then
  echo "No image files found in source directory."
  exit 1
fi

# Calculate the number of files to move to each destination directory (15% of total)
num_to_move=$(echo "$num_files * 0.30" | bc | awk '{printf("%d\n",$1 + 0.5)}')
num_to_move_dest1=$(echo "$num_to_move / 2" | bc)
num_to_move_dest2=$(echo "$num_to_move - $num_to_move_dest1" | bc)

# Randomly select the files to move
files_to_move=$(find "$src_dir" -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" | shuf -n "$num_to_move")

# Move the selected files to the destination directories
for file in $files_to_move; do
  if [[ $num_to_move_dest1 -gt 0 ]]; then
    git mv "$file" "$dest_dir1"
    num_to_move_dest1=$(($num_to_move_dest1 - 1))
  else
    git mv "$file" "$dest_dir2"
    num_to_move_dest2=$(($num_to_move_dest2 - 1))
  fi
done

echo "Moved $num_to_move files from $src_dir to $dest_dir1 and $dest_dir2."
