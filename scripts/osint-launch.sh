#!/bin/bash
# osint-launch.sh - Avvia un workflow completo OSINT su un dominio
# Requisiti: subfinder, amass, theHarvester, dnstwist, urlscanio, whois, shodan, jq

if [ -z "$1" ]; then
  echo "Uso: $0 <dominio>"
  exit 1
fi

DOMINIO="$1"
TS=$(date +"%Y-%m-%d_%H-%M")
OUTPUT_DIR="$HOME/.osint-toolkit/reports/$DOMINIO-$TS"
mkdir -p "$OUTPUT_DIR"

# WHOIS
whois "$DOMINIO" > "$OUTPUT_DIR/whois.txt"

# DNS Twist
dnstwist "$DOMINIO" > "$OUTPUT_DIR/dnstwist.txt"

# Subfinder
subfinder -d "$DOMINIO" -silent > "$OUTPUT_DIR/subfinder.txt"

# Amass
amass enum -d "$DOMINIO" -o "$OUTPUT_DIR/amass.txt"

# theHarvester (mail + host)
theHarvester -d "$DOMINIO" -b all -f "$OUTPUT_DIR/theharvester"

# Estrai subdomini per Shodan
cat "$OUTPUT_DIR/subfinder.txt" "$OUTPUT_DIR/amass.txt" | sort -u > "$OUTPUT_DIR/all_subdomains.txt"
> "$OUTPUT_DIR/shodan_results.json"
while read SUB; do
  IP=$(dig +short "$SUB" | head -n1)
  if [ -n "$IP" ]; then
    echo "[*] Scanning $SUB ($IP)..."
    shodan host "$IP" >> "$OUTPUT_DIR/shodan_results.json"
  fi
done < "$OUTPUT_DIR/all_subdomains.txt"

# URLScan
urlscanio search "$DOMINIO" > "$OUTPUT_DIR/urlscan.txt"

# Estrai mail e verifica con holehe
if [ -f "$OUTPUT_DIR/theharvester.xml" ]; then
  grep -Eo '[a-zA-Z0-9._%+-]+@$DOMINIO' "$OUTPUT_DIR/theharvester.xml" | sort -u > "$OUTPUT_DIR/emails.txt"
else
  touch "$OUTPUT_DIR/emails.txt"
fi

> "$OUTPUT_DIR/holehe.txt"
while read EMAIL; do
  holehe -e "$EMAIL" >> "$OUTPUT_DIR/holehe.txt"
done < "$OUTPUT_DIR/emails.txt"

# Lancia il report generator
~/.osint-toolkit/scripts/osint-report.sh "$OUTPUT_DIR" "$DOMINIO"

echo "[✓] Report OSINT generato in: $OUTPUT_DIR/domain_report.html"

