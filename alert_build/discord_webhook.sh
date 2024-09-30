#!/bin/bash

# Load the .env file and export environment variables
if [ -f ".env" ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Function to send a message
send_message() {
    local msg="$1"

    # Create the JSON payload
    json_payload=$(cat <<EOF
{
  "content": "$msg",
  "username": "$bot_name"
}
EOF
)

    # Send the POST request using curl
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$json_payload" "$webhook_url")

    # Check if the request was successful
    if [ "$response" != "204" ]; then
        echo "Failed to send message: HTTP $response"
    fi
}

# Main execution: join all passed arguments into a single string
send_message "$*"
