#!/bin/bash
# osint-menu.sh - Interactive CLI menu for individual OSINT tools

clear
echo "===== OSINT TOOLKIT MENU ====="
select opt in "WHOIS" "Subfinder" "Amass" "DNS Twist" "theHarvester" "Shodan" "Holehe" "Exit"
do
    case $opt in
        "WHOIS")
            read -p "Enter domain: " dom
            whois $dom | less
            ;;
        "Subfinder")
            read -p "Enter domain: " dom
            subfinder -d $dom
            ;;
        "Amass")
            read -p "Enter domain: " dom
            amass enum -d $dom
            ;;
        "DNS Twist")
            read -p "Enter domain: " dom
            dnstwist $dom | less
            ;;
        "theHarvester")
            read -p "Enter domain: " dom
            theHarvester -d $dom -b all
            ;;
        "Shodan")
            read -p "Enter IP address: " ip
            shodan host $ip
            ;;
        "Holehe")
            read -p "Enter email address: " email
            holehe -e $email
            ;;
        "Exit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
