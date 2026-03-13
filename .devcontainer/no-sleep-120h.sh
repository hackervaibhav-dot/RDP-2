#!/bin/bash

# ============================================
# DURANTO RDP - 120 HOURS NO SLEEP PERSISTENT
# ============================================

echo "🚀 Duranto RDP - 120 Hours No Sleep Activated"

# Infinite loop - never stops
while true; do
    # Light CPU activity
    echo "scale=10000; 4*a(1)" | bc -l > /dev/null 2>&1
    
    # Network ping
    ping -c 1 8.8.8.8 > /dev/null 2>&1
    curl -s https://github.com > /dev/null 2>&1
    
    # Write timestamp
    echo "$(date) - ACTIVE" >> /tmp/duranto-120h.log
    
    # Mouse movement
    if command -v xdotool &> /dev/null; then
        xdotool mousemove_relative -- 1 1 2>/dev/null
        xdotool mousemove_relative -- -1 -1 2>/dev/null
    fi
    
    # Sleep 2 minutes
    sleep 120
done