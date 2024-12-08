#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Function to increment the counter in a file
increment_counter() {
  local file=$1
  local counter=$(cat "$file")
  counter=$((counter + 1))
  echo "$counter" > "$file"
}

# Function to check if a file exists and is empty
is_empty(){
  [ -s "$1" ] && return 1 || return 0
}

# Start two processes to increment the counter simultaneously
pid1=$(increment_counter file1.txt & echo $!) 
pid2=$(increment_counter file2.txt & echo $!) 

# Wait for both processes to finish
wait $pid1
wait $pid2

# Expected output: The counter should be incremented twice. However, the race condition may cause unexpected results.
echo "Counter in file1.txt: $(cat file1.txt)"
echo "Counter in file2.txt: $(cat file2.txt)"

# Clean up
rm file1.txt file2.txt