#!/bin/bash

# Declare an associative array to store failure counters for each target
declare -A counters
declare -A temp_files

# Create temporary files for each target to store their counters
for target in "$@"; do
    temp_files[$target]=$(mktemp)
    echo 0 > "${temp_files[$target]}"  # Initialize each target's counter to 0
done

# Function to ping a target and return its failure counter
ping_target() {
    local target=$1
    local temp_file=${temp_files[$target]}
    local counter=$(<"$temp_file")  # Read the current counter from the temporary file
    local timestamp=$(TZ="utc-7" date '+%Y-%m-%d %H:%M:%S')  # Get current date and time in UTC+7

    # Perform a ping with 5 packets
    output=$(ping -c 5 -q "$target" 2>&1)

    # Check if the ping command was successful
    if [ $? -eq 0 ]; then
        # Target is up
        echo "[$timestamp] $target is up."
        if [ "$counter" -gt 0 ]; then
            echo "[$timestamp] $target just went up from being down."
            ./discord_webhook.sh "[$timestamp] \`$target\` just went up from being down."
        fi
        counter=0  # Reset the counter if target is up
    else
        # Target is down, increment the counter
        counter=$((counter + 1))

        # Only echo if counter is less than 3
        if [ "$counter" -lt 3 ]; then
            echo "[$timestamp] $target is down. Counter: $counter"
            ./discord_webhook.sh "[$timestamp] \`$target\` is down. Counter: $counter"
        fi

        # Check if the target has been down for 3 or more consecutive checks
        if [ "$counter" -eq 3 ]; then
            echo "[$timestamp] $target has been down for 3 consecutive checks."
            ./discord_webhook.sh "[$timestamp] \`$target\` has been down for 3 consecutive checks."
        fi
    fi

    echo "$counter" > "$temp_file"  # Write the updated counter back to the temporary file
}

# Main loop: iterate over all passed arguments (targets)
while true; do
    for target in "$@"; do
        (
            # Run each ping in a separate thread (background process)
            ping_target "$target"
        ) &
    done

    wait  # Wait for all background processes (threads) to complete
    sleep 5  # Add a delay of 5 seconds before the next iteration
done
