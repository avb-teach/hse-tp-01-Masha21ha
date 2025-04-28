#!/bin/bash
input_dir="$1"
output_dir="$2"
files=$(find $input_dir -maxdepth 1 -type f)
dirs=$(find $input_dir -maxdepth 1 -type d)

for file in $files; do
	if [ -e "$file" ]; then
		cp "$file" "$output_dir"
	else
		echo "$file does not exist"
	fi
done
for dir in $dirs; do
  if [ -d "$dir" ]; then
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

  else
    echo "$dir is not a valid directory"
  fi
done

