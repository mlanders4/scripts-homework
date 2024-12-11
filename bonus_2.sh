#!/bin/bash

# Check if the file path is provided
if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path>"
  exit 1
fi

file=$1

# Match "pie" case-insensitively and sum the first column (assuming it's numeric)
total=$(grep -i "pie" "$file" | awk '{if ($1 ~ /^[0-9]+$/) sum += $1} END {print sum}')
unique=$(grep -i "pie" "$file" | wc -l)

# Calculate average
if [[ $unique -ne 0 && $total -gt 0 ]]; then
  average=$(echo "scale=5; $total / $unique" | bc)
else
  average=0
fi

# Output results
echo "Total: $total"
echo "Unique: $unique"
printf "Average: %.5f\n" "$average"
