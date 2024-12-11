#!/bin/bash

# File path to short-rockyou.txt
file="$1"

# Use grep to find lines containing 'pie' and pipe them to awk for further processing
grep 'pie' "$file" | awk '{total+=$1; unique[$2]++} END { 
    # Calculate total, unique passwords and the average
    print "Total : " total
    print "Unique : " length(unique)
    print "Average : " total/length(unique)
}'
