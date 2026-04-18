#!/data/data/com.termux/files/usr/bin/bash

# কালার কোড
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

# সেন্টার করার ফাংশন (tput না থাকলেও কাজ করবে)
print_center() {
    local text="$1"
    local color="$2"
    local width=$(tput cols 2>/dev/null || echo 40)
    local padding=$(( (width - ${#text}) / 2 ))
    if [ $padding -lt 0 ]; then padding=0; fi
    printf "%${padding}s%b%s%b\n" "" "$color" "$text" "$NC"
}

echo ""
print_center "==========================================" "$CYAN"
print_center "      ANDROID PHONE UNLOCKER TOOL         " "$YELLOW"
print_center "==========================================" "$CYAN"
print_center "       Status: System Logic Loaded        " "$NC"
echo ""

# ওটিজি চেক
print_center "Scanning for Connected Devices..." "$BLUE"
sleep 2

if [ -d /sys/bus/usb/devices ] && [ "$(ls -A /sys/bus/usb/devices 2>/dev/null)" ]; then
    print_center "● OTG/USB STATUS: ACTIVE" "$GREEN"
    print_center "● [ GREEN LED INDICATOR ACTIVE ]" "$GREEN"
    echo ""
    print_center "Starting Automatic Pin Scanning..." "$YELLOW"
else
    print_center "● OTG/USB STATUS: NOT CONNECTED" "$RED"
    print_center "● [ RED LED INDICATOR ACTIVE ]" "$RED"
    echo ""
    print_center "Please connect hardware to proceed." "$YELLOW"
fi

echo ""
print_center "==========================================" "$CYAN"
print_center "Press Ctrl+C to stop" "$RED"
