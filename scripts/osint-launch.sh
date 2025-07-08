#!/bin/bash
# osint-launch.sh - Run a full OSINT workflow on a given domain
# Requirements: subfinder, amass, theHarvester, dnstwist, urlscanio, whois, shodan, jq

if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN="$1"
TS=$(date +"%Y-%m-%d_%H-%M")
OUTPUT_DIR="$HOME/.osint-toolkit/reports/$DOMAIN-$TS"
mkdir -p "$OUTPUT_DIR"

# WHOIS
whois "$DOMAIN" > "$OUTPUT_DIR/whois.txt"

# DNS Twist
dnstwist "$DOMAIN" > "$OUTPUT_DIR/dnstwist.txt"

# Subfinder
subfinder -d "$DOMAIN" -silent > "$OUTPUT_DIR/subfinder.txt"

# Amass
amass enum -d "$DOMAIN" -o "$OUTPUT_DIR/amass.txt"

# theHarvester (email + hosts)
theHarvester -d "$DOMAIN" -b all -f "$OUTPUT_DIR/theharvester"

# Extract subdomains for Shodan lookup
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
urlscanio search "$DOMAIN" > "$OUTPUT_DIR/urlscan.txt"

# Extract emails and check with Holehe
if [ -f "$OUTPUT_DIR/theharvester.xml" ]; then
  grep -Eo '[a-zA-Z0-9._%+-]+@$DOMAIN' "$OUTPUT_DIR/theharvester.xml" | sort -u > "$OUTPUT_DIR/emails.txt"
else
  touch "$OUTPUT_DIR/emails.txt"
fi

> "$OUTPUT_DIR/holehe.txt"
while read EMAIL; do
  holehe -e "$EMAIL" >> "$OUTPUT_DIR/holehe.txt"
done < "$OUTPUT_DIR/emails.txt"

# Generate the HTML report
~/.osint-toolkit/scripts/osint-report.sh "$OUTPUT_DIR" "$DOMAIN"

echo "[✓] OSINT report generated at: $OUTPUT_DIR/domain_report.html"
