#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <positive integer>"
    exit 1
fi

# Validate that the input is a positive integer
if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
    echo "Error: Input must be a positive integer."
    exit 1
fi

# Initialize variables
n=$1
a=0
b=1

# Print the first n Fibonacci numbers
for ((i=0; i<n; i++)); do
    echo "$a"
    temp=$((a + b))
    a=$b
    b=$temp
done
