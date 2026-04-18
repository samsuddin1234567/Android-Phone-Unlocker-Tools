#!/bin/bash

# Title Section
clear
echo -e "\e[1;32m##########################################"
echo -e "#                                        #"
echo -e "#      Developer by Shamsuddin           #"
echo -e "#           Premium Proxy (Tor)          #"
echo -e "#                                        #"
echo -e "##########################################\e[0m"
echo ""

# Start Tor in background
echo -e "\e[1;33m[+] Starting Tor Service...\e[0m"
tor > /dev/null &
sleep 10

while true
do
    echo -e "\e[1;32m------------------------------------------\e[0m"
    echo -e "\e[1;34m[!] Current Identity Context:\e[0m"
    
    # Check current IP through Tor
    CURRENT_IP=$(curl -s --socks5 127.0.0.1:9050 http://ifconfig.me)
    echo -e "\e[1;32m[✔] Your Current IP: $CURRENT_IP\e[0m"
    
    echo -e "\e[1;36m[i] Next IP rotation in 10 minutes...\e[0m"
    
    # Wait for 10 minutes
    sleep 600
    
    # Requesting new identity from Tor
    echo -e "\e[1;33m[+] Rotating Identity (New Circuit)...\e[0m"
    pkill -HUP tor
    sleep 5
done
