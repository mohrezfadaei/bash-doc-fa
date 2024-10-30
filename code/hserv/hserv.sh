#!/bin/bash

# Display help information
function display_help() {
    echo "Usage: hserv [command] [options]"
    echo ""
    echo "Commands:"
    echo "  help                       Display this help message"
    echo "  tcping [IP|Domain]         Perform TCP ping to the specified IP address or domain"
    echo "      --retry [RETRY]        Number of retries (default is 3)"
}

# Perform TCP ping
function tcping() {
    local target=$1
    local retries=3
    shift

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
        --retry)
            retries="$2"
            shift 2
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            exit 1
            ;;
        esac
    done

    # Initialize variables for calculations
    local total_time=0
    local count=0

    # Table header
    printf "%-10s %-15s\n" "Ping #" "Time (ms)"
    echo "---------------------------"

    # Perform the pings and calculate the average
    for ((i = 1; i <= retries; i++)); do
        local ping_time
        ping_time=$(ping -c 1 "$target" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')

        if [[ -n "$ping_time" ]]; then
            printf "%-10d %-15s\n" "$i" "$ping_time ms"
            total_time=$(echo "$total_time + $ping_time" | bc)
            ((count++))
        else
            printf "%-10d %-15s\n" "$i" "Failed"
        fi
    done

    # Calculate and display average time if successful pings exist
    if [[ "$count" -gt 0 ]]; then
        local avg_time
        avg_time=$(echo "$total_time / $count" | bc -l)
        printf "\nAverage ping time: %.2f ms\n" "$avg_time"
    else
        echo "All pings failed."
    fi
}

# Main script logic
if [[ "$#" -eq 0 ]]; then
    display_help
    exit 0
fi

case "$1" in
help)
    display_help
    ;;
tcping)
    if [[ -n "$2" ]]; then
        tcping "$2" "${@:3}"
    else
        echo "Error: Please specify an IP address or domain."
        display_help
        exit 1
    fi
    ;;
*)
    echo "Unknown command: $1"
    display_help
    exit 1
    ;;
esac
