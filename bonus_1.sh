#!/bin/bash

# Check if a file path is provided
if [[ -z $1 ]]; then
  echo "Usage: $0 <file-path>"
  exit 1
fi

# Use awk to sum the first column of the file
awk '{sum += $1} END {print sum}' "$1"
