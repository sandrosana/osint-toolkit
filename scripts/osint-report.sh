#!/bin/bash
# osint-report.sh - Generate an HTML report from OSINT results

DIR=$1
DOMAIN=$2
TEMPLATE="$HOME/.osint-toolkit/templates/report_template.html"
OUT="$DIR/domain_report.html"

replace() {
  sed "s|{{$1}}|$2|g" -i "$OUT"
}

cp "$TEMPLATE" "$OUT"

replace "DOMINIO" "$DOMAIN"
replace "DATA" "$(date)"
replace "WHOIS" "$(<'$DIR/whois.txt')"
replace "DNSTWIST" "$(<'$DIR/dnstwist.txt')"
replace "SUBDOMINI" "$(<'$DIR/all_subdomains.txt')"
replace "EMAILS" "$(<'$DIR/emails.txt')"
replace "HOLEHE" "$(<'$DIR/holehe.txt')"
replace "SHODAN" "$(<'$DIR/shodan_results.json')"
replace "URLSCAN" "$(<'$DIR/urlscan.txt')"
replace "SUBFINDER_COUNT" "$(wc -l <'$DIR/subfinder.txt')"
replace "AMASS_COUNT" "$(wc -l <'$DIR/amass.txt')"
replace "EMAIL_COUNT" "$(wc -l <'$DIR/emails.txt')"
