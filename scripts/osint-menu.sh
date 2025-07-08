#!/bin/bash
clear
echo "===== OSINT TOOLKIT MENU ====="
select opt in "WHOIS" "Subfinder" "Amass" "DNS Twist" "theHarvester" "Shodan" "Holehe" "Esci"
do
    case \$opt in
        "WHOIS")
            read -p "Dominio: " dom
            whois \$dom | less
            ;;
        "Subfinder")
            read -p "Dominio: " dom
            subfinder -d \$dom
            ;;
        "Amass")
            read -p "Dominio: " dom
            amass enum -d \$dom
            ;;
        "DNS Twist")
            read -p "Dominio: " dom
            dnstwist \$dom | less
            ;;
        "theHarvester")
            read -p "Dominio: " dom
            theHarvester -d \$dom -b all
            ;;
        "Shodan")
            read -p "IP: " ip
            shodan host \$ip
            ;;
        "Holehe")
            read -p "Email: " email
            holehe -e \$email
            ;;
        "Esci")
            break
            ;;
        *) echo "Opzione non valida";;
    esac
done
EOF
chmod +x ~/.osint-toolkit/scripts/osint-menu.sh
