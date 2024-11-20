#!/bin/bash

# Check if a file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

# Validate that the file exists
if [ ! -f "$1" ]; then
    echo "Error: File not found."
    exit 1
fi

# Process the file to extract the 25 most frequent words
sed 's/[^a-zA-Z0-9]/\n/g' "$1" | \
awk 'NF' | \
tr '[:upper:]' '[:lower:]' | \
sort | \
uniq -c | \
sort -hr | \
awk '{print $2}' | \
head -n 25
