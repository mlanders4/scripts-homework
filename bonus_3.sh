#!/bin/bash

if [[ -z $1 || -z $2 ]]; then
  echo "Usage: $0 <file-path> <pattern>"
  exit 1
fi

file=$1
pattern=$2

# Match exact pattern with case sensitivity
total=$(grep -w "$pattern" "$file" | awk '{sum += $1} END {print sum}')
unique=$(grep -w "$pattern" "$file" | wc -l)

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
