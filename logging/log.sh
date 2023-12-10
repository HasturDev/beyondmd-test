#!/bin/bash

# Set log file location
LOG_FILE="/var/log/custom_activity_log.log"

# Create the log file if it does not exist
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Function to append output to the log file
append_to_log() {
    echo "$1" >> "$LOG_FILE"
    echo "$2" >> "$LOG_FILE"
    echo "------------------------" >> "$LOG_FILE"
}

# Function to log system logins
log_logins() {
    append_to_log "---- System Logins (who) ----" "$(who)"
}

# Function to log last logins
log_last_logins() {
    append_to_log "---- Last Logins (last) ----" "$(last -a)"
}

# Function to log current processes
log_current_processes() {
    append_to_log "---- Current Processes (ps aux) ----" "$(ps aux)"
}

# Function to log system resource usage
log_system_resources() {
    append_to_log "---- System Resources (top -b -n 1) ----" "$(top -b -n 1)"
}

# Function to log disk usage
log_disk_usage() {
    append_to_log "---- Disk Usage (df -h) ----" "$(df -h)"
}

# Running the functions
log_logins
log_last_logins
log_current_processes
log_system_resources
log_disk_usage

# Add a timestamp
echo "Log recorded on: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
