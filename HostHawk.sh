#!/bin/bash

# Auto-elevate to root if needed
if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

# Simulating ctrl+L
echo -en "\033[H\033[J"

echo -e "\033[1;36m=======================================\033[0m"
echo -e "\033[1;32m     Active Hosts Scan by Debanjan     \033[0m"
echo -e "\033[1;36m=======================================\033[0m"

# Prompt for network and CIDR
read -p "Enter network address: " net
read -p "Enter CIDR: " cidr

subnet="$net/$cidr"
echo

# table header
printf "%s\n" "------------------------------------------------------------------------------------------------------------------------"
printf "%-15s %-18s %-20s %-40s %-20s\n" "IP Address" "Latency" "MAC Address" "Vendor" "Hostname"
printf "%s\n" "------------------------------------------------------------------------------------------------------------------------"

# Initialize vars
ip=""
hostname="-"
latency="-"
mac="-"
vendor="-"

# Run Nmap and parse line-by-line
nmap -sn "$subnet" | while IFS= read -r line; do
    if [[ "$line" =~ ^Nmap\ scan\ report\ for\ (.+)\ \((.+)\) ]]; then
        hostname="${BASH_REMATCH[1]}"
        ip="${BASH_REMATCH[2]}"
    elif [[ "$line" =~ ^Nmap\ scan\ report\ for\ ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) ]]; then
        ip="${BASH_REMATCH[1]}"
        hostname="-"
    elif [[ "$line" =~ ^Host\ is\ up\ \((.*)\) ]]; then
        latency="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^MAC\ Address:\ ([0-9A-F:]{17})\ \((.+)\) ]]; then
        mac="${BASH_REMATCH[1]}"
        vendor="${BASH_REMATCH[2]}"

        # Clean up vendor
        vendor=$(echo "$vendor" | tr -cd '\11\12\15\40-\176')  # remove non-ASCII
        vendor=$(echo "$vendor" | sed 's/[()（）]//g')         # remove brackets
        vendor=$(echo "$vendor" | sed 's/^[ \t]*//;s/[ \t]*$//') # trim

        if [[ ${#vendor} -gt 40 ]]; then
            vendor="${vendor:0:39}..."
        fi

        # Print line
        printf "%-15s %-18s %-20s %-40s %-20s\n" "$ip" "$latency" "$mac" "$vendor" "$hostname"

        # Reset vars for next block
        ip=""
        hostname="-"
        latency="-"
        mac="-"
        vendor="-"
    fi
done

