#!/bin/bash
mkdir -p ~/.osint-toolkit/scripts
mkdir -p ~/.osint-toolkit/reports
mkdir -p ~/.osint-toolkit/templates
cp scripts/*.sh ~/.osint-toolkit/scripts/
cp templates/*.html ~/.osint-toolkit/templates/
echo 'alias osint-scan="bash ~/.osint-toolkit/scripts/osint-launch.sh"' >> ~/.bashrc
source ~/.bashrc
echo "[*] OSINT Toolkit installato. Usa 'osint-scan dominio.it' da qualsiasi directory."
EOF
chmod +x ~/.osint-toolkit/install.sh
