#!/bin/bash

# Check if a file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

# Validate that the file exists
if [ ! -f "$file" ]; then
    echo "Error: File not found."
    exit 1
fi

# Process the file and output the 25 most frequent words
sed 's/ /\n/g' "$file" | \
awk 'NF' | \
# Remove non-alphanumeric characters
sed 's/[^a-zA-Z0-9]/\n/g' | \
# Convert all uppercase letters to lowercase
tr '[:upper:]' '[:lower:]' | \
# Sort words alphabetically
sort | \
# Count unique occurrences
uniq -c | \
# Sort by frequency in descending order
sort -hr | \
# Extract only the words (not their counts)
awk '{print $2}' | \
# Show the top 25 most frequent words
head -n 25
