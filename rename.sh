#!/bin/bash
dir_name=$(basename "$PWD")
highest_number=$(ls -1 ${dir_name}_*.jpg 2>/dev/null | grep -o '[0-9]\{3\}' | sort -n | tail -1)
count=${highest_number:-0}
count="${count#"${count%%[!0]*}"}"

for file in *.jpg; do
  if [[ "$file" =~ ^${dir_name}_[0-9]{3}\.jpg$ ]]; then
    :
  else
    ((count++))
    number=$(printf "%03d" $count)
    new_name="${dir_name}_$number.jpg"
    git "mv "$file" "$new_name"
  fi
done
