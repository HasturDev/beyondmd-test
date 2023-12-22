#!/bin/bash

max_retries=3
retry_count=0

while [[ $retry_count -lt $max_retries ]]
do
    service ssh start

    if [[ $? -eq 0 ]]; then
        echo "SSH service started successfully."
        exit 0
    else
        echo "Failed to start SSH service. Retrying..."
        retry_count=$((retry_count+1))
    fi
done

echo "SSH service failed to start after $max_retries attempts."
exit 1