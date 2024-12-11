#!/bin/bash

if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path> <pattern>"
  exit 1
fi

file=$1
pattern=$2

# If no pattern is provided, calculate for all passwords
if [[ -z $pattern ]]; then
  total=$(awk '{sum += $1} END {print sum}' "$file")
  unique=$(wc -l < "$file")
else
  # Match pattern case-insensitively and robustly
  total=$(grep -i "$pattern" "$file" | awk '{sum += $1} END {print sum}')
  unique=$(grep -i "$pattern" "$file" | wc -l)
fi

# Calculate average
if [[ $unique -ne 0 ]]; then
  average=$(echo "scale=5; $total / $unique" | bc)
else
  total=0
  unique=0
  average=0
fi

echo "Pattern: \"$pattern\""
echo "Total: $total"
echo "Unique: $unique"
printf "Average: %.5f\n" "$average"
