#!/bin/bash

# p2simulation.sh
# Runs 20 trials in separate processes for Q2

# Kick off different trials in different 
for i in {1..20}
do
	echo "Starting simulation $i"

	# Start the trial
	# Notice that we seed the random number generator with the current time upon each trial
	# as matlab always starts with it's random number generator in the same state
	matlab -r "rand('seed',sum(100*clock()));p2simulation($i);exit" &

	# Sleep to ensure we get a different current time to seed the random number generator
	sleep 0.05
done