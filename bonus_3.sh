#!/bin/bash

# Ensure two arguments are provided: file path and pattern
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file_path> <pattern>"
    exit 1
fi

file_path=$1
pattern=$2

# Find all instances of the pattern and store them in a variable
matches=$(grep -o "$pattern" "$file_path" | wc -l)

# Find all unique lines containing the pattern
unique_matches=$(grep -o "$pattern" "$file_path" | sort | uniq | wc -l)

# If no matches are found, set total, unique, and average to 0
if [ "$matches" -eq 0 ]; then
    total=0
    unique=0
    average=0
else
    total=$matches
    unique=$unique_matches
    # Calculate average occurrences per unique line
    average=$(echo "$total / $unique" | bc -l)
fi

# Output the results
echo "Pattern: \"$pattern\""
echo "Total: $total"
echo "Unique: $unique"
echo "Average: $average"
