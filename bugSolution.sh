#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Function to increment the counter in a file using flock for atomic operations
increment_counter() {
  local file=$1
  flock -n "$file" || exit 1 # Exit if we cannot obtain the lock.
  local counter=$(cat "$file" || echo 0) #Handle empty file case
  counter=$((counter + 1))
  echo "$counter" > "$file"
  flock -u "$file" # Release the lock
}

# Start two processes to increment the counter simultaneously
increment_counter file1.txt &
increment_counter file2.txt &

wait

# Expected output: The counter should be incremented twice correctly.
echo "Counter in file1.txt: $(cat file1.txt)"
echo "Counter in file2.txt: $(cat file2.txt)"

# Clean up
rm file1.txt file2.txt