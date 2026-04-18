#!/bin/bash

# কালার কোড
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

while true; do
    echo -e "${YELLOW}[*] Requesting New Identity...${NC}"
    
    # Tor-কে নতুন আইপি নিতে বলা (Signal NEWNYM)
    (echo authenticate ""; echo signal newnym; echo quit) | nc localhost 9051 > /dev/null
    
    # ২ সেকেন্ড অপেক্ষা যাতে নতুন আইপি কানেক্ট হয়
    sleep 5
    
    # বর্তমান আইপি এবং দেশের তথ্য নেওয়া
    DATA=$(curl -s --socks5-hostname 127.0.0.1:9050 https://ipapi.co/json/)
    IP=$(echo $DATA | jq -r '.ip')
    COUNTRY=$(echo $DATA | jq -r '.country_name')
    CITY=$(echo $DATA | jq -r '.city')

    echo -e "${GREEN}-------------------------------------"
    echo -e "[+] Status: Successful"
    echo -e "[+] Current IP: ${CYAN}$IP"
    echo -e "[+] Country: ${CYAN}$COUNTRY ($CITY)"
    echo -e "${GREEN}-------------------------------------${NC}"
    
    echo -e "${YELLOW}[i] Next rotation in 10 minutes...${NC}"
    
    # ১০ মিনিট বা ৬০০ সেকেন্ড অপেক্ষা
    sleep 600
done
