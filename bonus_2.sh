#!/bin/bash

if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path>"
  exit 1
fi

file=$1

# Match "pie" case-insensitively
total=$(grep -i "pie" "$file" | awk '{sum += $1} END {print sum}')
unique=$(grep -i "pie" "$file" | wc -l)

# Calculate average
if [[ $unique -ne 0 ]]; then
  average=$(echo "scale=5; $total / $unique" | bc)
else
  average=0
fi

echo "Total: $total"
echo "Unique: $unique"
printf "Average: %.5f\n" "$average"
