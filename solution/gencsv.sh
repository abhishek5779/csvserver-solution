#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_index> <end_index>"
    exit 1
fi

start=$1
end=$2

# Ensure start is less than or equal to end
if [ "$start" -gt "$end" ]
then
    echo "Error: start_index should be less than or equal to end_index"
    exit 1
fi

# Generate the file
> inputFile  # Truncate or create the file
for ((i=start; i<=end; i++)); do
    echo "$i, $RANDOM" >> inputFile
done
