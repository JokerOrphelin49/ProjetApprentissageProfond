#!/bin/bash

counter=0
total=$(find . -maxdepth 1 -name "*.jpg" | wc -l)
for file in *.jpg; do
    if [ $counter -lt $(($total / 2)) ]; then
        convert "$file" -colorspace Gray "${file%.jpg}_bw.jpg"
        counter=$((counter + 1))
    else
        break
    fi
done
