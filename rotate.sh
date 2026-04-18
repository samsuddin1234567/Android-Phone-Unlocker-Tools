#!/bin/bash

# Colors
G='\033[1;32m'
R='\033[1;31m'
Y='\033[1;33m'
B='\033[1;34m'
W='\033[1;37m'
N='\033[0m'

clear
echo -e "${B}=========================================="
echo -e "${G}     Developer by: Samsuddin"
echo -e "${Y}     Status: Premium Proxy Active"
echo -e "${B}==========================================${N}"

# Restarting Tor
pkill tor > /dev/null 2>&1
sleep 1
tor > /dev/null 2>&1 &

echo -e "${Y}[*] Waiting for Tor to start...${N}"
sleep 15 # Tor চালু হতে সময় নেয়, তাই একটু বেশি সময় দেওয়া হলো

while true; do
    # IP check with timeout to avoid freezing
    INFO=$(curl -s --socks5 127.0.0.1:9050 --connect-timeout 20 https://ipapi.co/json/)
    IP=$(echo $INFO | grep -o '"ip": "[^"]*' | cut -d'"' -f4)
    COUNTRY=$(echo $INFO | grep -o '"country_name": "[^"]*' | cut -d'"' -f4)

    if [ -z "$IP" ]; then
        echo -e "${R}[!] Connection Failed. Retrying in 5s...${N}"
        sleep 5
        continue
    else
        clear
        echo -e "${B}=========================================="
        echo -e "${G}     Developer by: Samsuddin"
        echo -e "${Y}     Status: Premium Proxy Active"
        echo -e "${B}==========================================${N}"
        echo ""
        echo -e "${G}[✔] Proxy Connected${N}"
        echo -e "${W}Current IP: ${Y}$IP${N}"
        echo -e "${W}Country   : ${G}$COUNTRY ${G}✔${N}"
        echo -e "${B}------------------------------------------${N}"
    fi

    echo -e "${Y}[*] Next rotation in 10 minutes...${N}"
    sleep 600
    pkill -HUP tor
done

