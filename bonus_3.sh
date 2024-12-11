#!/bin/bash

# Check if a pattern is provided as an argument
if [ -z "$2" ]; then
    echo "Usage: $0 <file-path> <pattern>"
    exit 1
fi

# File path and pattern to search for
file="$1"
pattern="$2"

# If the pattern is empty, treat it as an empty string and process all lines
if [ -z "$pattern" ]; then
    echo "Pattern: \"\""
    total=0
    unique_count=0
    # Count all occurrences from the first column (instances) and unique passwords in the second column
    awk '{total += $1; unique[$2]++} END { 
        if (length(unique) > 0) {
            print "Total:", total
            print "Unique:", length(unique)
            avg = total / length(unique)
            printf "Average: %.4f\n", avg
        } else {
            print "Total: 0"
            print "Unique: 0"
            print "Average: 0"
        }
    }' "$file"
    exit 0
fi

# Search for the pattern in the file and process the results
echo "Pattern: \"$pattern\""

# Use grep to find lines containing the pattern and pipe them to awk for further processing
grep "$pattern" "$file" | awk -v pattern="$pattern" '
    {
        # For each matching line, increment total count by first column value (instances)
        total += $1
        
        # Track unique passwords in the second column
        unique[$2]++
    }
    END {
        # Calculate unique passwords count
        unique_count = length(unique)

        # If we have unique passwords, calculate average
        if (unique_count > 0) {
            avg = total / unique_count
            printf "Total: %d\n", total
            printf "Unique: %d\n", unique_count
            printf "Average: %.4f\n", avg
        } else {
            print "Total: 0"
            print "Unique: 0"
            print "Average: 0"
        }
    }'
