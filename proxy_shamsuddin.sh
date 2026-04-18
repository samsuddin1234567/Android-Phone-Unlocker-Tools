#!/bin/bash

# Title Section
clear
echo -e "\e[1;32m##########################################"
echo -e "#                                        #"
echo -e "#      Developer by Shamsuddin           #"
echo -e "#           Premium Proxy                #"
echo -e "#                                        #"
echo -e "##########################################\e[0m"
echo ""

# Country List for display
echo -e "\e[1;34mTarget Countries: Japan, Indonesia, London, Dubai, Kuwait, India, Bangladesh, USA, Germany, France, Canada\e[0m"
echo ""

while true
do
    echo -e "\e[1;33m[+] Fetching and rotating new proxy...\e[0m"
    
    # Fetching a random public proxy (Example from a public API)
    # Note: Public proxies are slow, trying to fetch the best available
    export http_proxy=$(curl -s "https://api.proxyscrape.com/v2/?request=displayproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all" | shuf -n 1)
    export https_proxy=$http_proxy
    
    echo -e "\e[1;32m[✔] Current Proxy Set to: $http_proxy\e[0m"
    echo -e "\e[1;36m[i] Next rotation in 10 minutes...\e[0m"
    
    # Wait for 10 minutes (600 seconds)
    sleep 600
done
