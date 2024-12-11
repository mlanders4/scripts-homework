#!/bin/bash

# Check if a pattern is provided as an argument
if [ -z "$2" ]; then
    echo "Usage: $0 <file-path> <pattern>"
    exit 1
fi

# File path and pattern to search for
file="$1"
pattern="$2"

# Check if the pattern is empty
if [ -z "$pattern" ]; then
    echo "Pattern: \"\""
    echo "Total: 0"
    echo "Unique: 0"
    echo "Average: 0"
    exit 0
fi

# Search the file for the pattern and store the result
results=$(grep -o "$pattern" "$file")

# If no results are found, print 0 for all statistics
if [ -z "$results" ]; then
    echo "Pattern: \"$pattern\""
    echo "Total: 0"
    echo "Unique: 0"
    echo "Average: 0"
else
    # Use grep to find lines containing the pattern and pipe them to awk for further processing
    echo "Pattern: \"$pattern\""
    grep "$pattern" "$file" | awk -v pattern="$pattern" '{
        total+=$1; unique[$2]++
    } END { 
        # Calculate total, unique passwords, and the average
        if (length(unique) > 0) {
            avg = total / length(unique)
            printf "Total: %d\n", total
            printf "Unique: %d\n", length(unique)
            printf "Average: %.4f\n", avg
        } else {
            print "Total: 0"
            print "Unique: 0"
            print "Average: 0"
        }
    }'
fi
