#!/bin/bash

# Ensure that the file path is provided
if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path> <pattern>"
  exit 1
fi

file=$1
pattern=$2

# If no pattern is provided, calculate for all lines
if [[ -z $pattern ]]; then
  total=$(awk '{if ($1 ~ /^[0-9]+$/) sum += $1} END {print sum}' "$file")
  unique=$(wc -l < "$file")
else
  # If a pattern is provided, check for case-insensitive matching
  if [[ $pattern =~ [A-Z] ]]; then
    # Pattern contains uppercase, so we match case-sensitively
    total=$(grep -F "$pattern" "$file" | awk '{if ($1 ~ /^[0-9]+$/) sum += $1} END {print sum}')
    unique=$(grep -F "$pattern" "$file" | wc -l)
  else
    # Otherwise, match case-insensitively
    total=$(grep -i "$pattern" "$file" | awk '{if ($1 ~ /^[0-9]+$/) sum += $1} END {print sum}')
    unique=$(grep -i "$pattern" "$file" | wc -l)
  fi
fi

# Handle cases with no matches or no valid numbers
if [[ $unique -ne 0 && $total -gt 0 ]]; then
  # Calculate average and round to 5 decimal places
  average=$(echo "scale=5; $total / $unique" | bc)
else
  total=0
  unique=0
  average=0
fi

# Output results
echo "Pattern: \"$pattern\""
echo "Total: $total"
echo "Unique: $unique"
printf "Average: %.5f\n" "$average"

