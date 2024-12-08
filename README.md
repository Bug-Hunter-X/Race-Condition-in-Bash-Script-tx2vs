# Race Condition in Bash Script

This repository demonstrates a race condition bug in a bash script.  The script attempts to increment counters in two separate files concurrently, leading to unpredictable results. This is a common issue when multiple processes access and modify shared resources without proper synchronization mechanisms. The solution demonstrates how to avoid this using flock.

## Bug Description
The script uses `cat`, arithmetic expansion, and redirection to increment a counter in a file. This sequence is not atomic, so if both processes try to update the counter around the same time, data might be lost and the final counter value might be incorrect.  It also shows a case where checking an empty file can be a source of similar problems.