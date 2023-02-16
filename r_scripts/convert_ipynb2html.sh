#!/bin/sh
#  | sed 's#./#/#g'
for file in $(find . -type f -name "*.ipynb"); do
  # echo $(pwd)$file;
  quarto render $file;
done