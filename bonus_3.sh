#!/bin/bash

# Check if file path and pattern are provided
if [[ -z $1 || -z $2 ]]; then
  echo "Usage: $0 <file-path> <pattern>"
  exit 1
fi

file=$1
pattern=$2

# Extract lines matching the pattern, calculate total frequency and unique count
total=$(grep -i "$pattern" "$file" | awk '{sum += $1} END {print sum}')
unique=$(grep -i "$pattern" "$file" | wc -l)

# Calculate average
if [[ $unique -ne 0 ]]; then
  average=$(echo "scale=5; $total / $unique" | bc)
else
  total=0
  unique=0
  average=0
fi

# Output the results
echo "Pattern: \"$pattern\""
echo "Total: $total"
echo "Unique: $unique"
echo "Average: $average"
