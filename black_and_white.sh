#!/bin/bash

for file in *.jpg; do
    convert "$file" -colorspace Gray "${file%.jpg}_bw.jpg"
done
