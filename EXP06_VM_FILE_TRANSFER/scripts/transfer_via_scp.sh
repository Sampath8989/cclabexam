#!/bin/bash
# ==============================================================================
# Experiment 06: Method 4 - SCP/SSH File Transfer Between Virtual Machines
# ==============================================================================

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./transfer_via_scp.sh <file_to_send> <target_vm_user@target_vm_ip:/target/directory>"
    echo "Example: ./transfer_via_scp.sh hello.c dinesh@192.168.56.102:/home/dinesh/"
    exit 1
fi

FILE_SRC="$1"
TARGET="$2"

echo "[*] Checking if openssh-client and ssh are available..."
if ! command -v scp &> /dev/null; then
    echo "[!] SCP client not found. Installing openssh-client..."
    sudo apt-get update && sudo apt-get install -y openssh-client
fi

echo "[*] Transferring $FILE_SRC to $TARGET via SCP..."
scp -o StrictHostKeyChecking=no "$FILE_SRC" "$TARGET"

if [ $? -eq 0 ]; then
    echo "[+] File transfer successful!"
else
    echo "[!] File transfer failed. Ensure target VM has openssh-server running (sudo service ssh status)."
fi
