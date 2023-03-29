#!/bin/bash

counter=0
total=$(find . -maxdepth 1 -name "*.jpg" | wc -l)
while [ $counter -lt $(($total / 2)) ]; do
    file=$(ls *.jpg | shuf -n 1)
    if [ ! -f "${file%.jpg}_bw.jpg" ]; then
        convert "$file" -colorspace Gray "${file%.jpg}_bw.jpg"
        counter=$((counter + 1))
    fi
done
