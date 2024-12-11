#!/bin/bash

# Check if a file path is provided
if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path>"
  exit 1
fi

# Extract lines containing "pie," calculate total frequency and unique count
total=$(grep -i "pie" "$1" | awk '{sum += $1} END {print sum}')
unique=$(grep -i "pie" "$1" | wc -l)

# Calculate average
if [[ $unique -ne 0 ]]; then
  average=$(echo "scale=5; $total / $unique" | bc)
else
  average=0
fi

# Output the results
echo "Total: $total"
echo "Unique: $unique"
echo "Average: $average"
