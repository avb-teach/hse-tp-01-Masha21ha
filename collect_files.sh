#!/bin/bash
input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ]; then
  echo "Ошибка: Входная директория '$input_dir' не существует."
  exit 1
fi

mkdir -p "$output_dir"

files=$(find "$input_dir" -maxdepth 1 -type f)

for file in $files; do
  if [ -e "$file" ]; then
    cp "$file" "$output_dir"
  fi
done

dirs=$(find "$input_dir" -maxdepth 1 -type d)

for dir in $dirs; do
  if [ "$dir" != "$input_dir" ]; then
    inter_files=$(find "$dir" -type f)
    
    for file in $inter_files; do
      filename=$(basename "$file")
      new_filename="$output_dir/$filename"
      count=1
      
      while [ -e "$new_filename" ]; do
        new_filename="$output_dir/${filename%.*}_$count.${filename##*.}"
        count=$((count + 1))
      done
      
      cp "$file" "$new_filename"
    done
  fi
done
