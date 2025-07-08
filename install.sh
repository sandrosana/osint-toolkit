#!/bin/bash
# install.sh - Setup script for the OSINT Toolkit

echo "[*] Starting OSINT Toolkit installation..."

mkdir -p ~/.osint-toolkit/scripts
mkdir -p ~/.osint-toolkit/reports
mkdir -p ~/.osint-toolkit/templates

cp scripts/*.sh ~/.osint-toolkit/scripts/
cp templates/*.html ~/.osint-toolkit/templates/

# Detect user shell
SHELL_TYPE=$(basename "$SHELL")
ALIAS_CMD='alias osint-scan="bash ~/.osint-toolkit/scripts/osint-launch.sh"'

if [[ "$SHELL_TYPE" == "zsh" ]]; then
    TARGET_FILE=~/.zshrc
elif [[ "$SHELL_TYPE" == "bash" ]]; then
    TARGET_FILE=~/.bashrc
else
    echo "[!] Unsupported shell ($SHELL_TYPE). Please add the alias manually."
    exit 1
fi

if ! grep -q 'alias osint-scan=' "$TARGET_FILE"; then
    echo "$ALIAS_CMD" >> "$TARGET_FILE"
    echo "[+] Alias added to $TARGET_FILE"
else
    echo "[=] Alias already exists in $TARGET_FILE"
fi

source "$TARGET_FILE"

echo "[✓] OSINT Toolkit installed successfully!"
echo "[i] Use the command: osint-scan <domain>"
