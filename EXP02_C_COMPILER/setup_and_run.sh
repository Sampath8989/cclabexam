#!/bin/bash
# ==============================================================================
# Experiment 02: Environment Setup and C Program Execution
# Reproduces the directory structure and execution workflow from the lab manual.
# ==============================================================================

set -e

echo "[*] Setting up directory structure matching lab manual: /opt/axis2/axis2-1.7.3/bin"
sudo mkdir -p /opt/axis2/axis2-1.7.3/bin

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[*] Copying C source files to /opt/axis2/axis2-1.7.3/bin..."
sudo cp "$SCRIPT_DIR/hello.c" /opt/axis2/axis2-1.7.3/bin/
sudo cp "$SCRIPT_DIR/first.c" /opt/axis2/axis2-1.7.3/bin/
sudo chown -R $USER:$USER /opt/axis2/

cd /opt/axis2/axis2-1.7.3/bin

echo "[*] Ensuring gcc and build essentials are installed..."
if ! command -v gcc &> /dev/null; then
    echo "[!] GCC not found. Installing GCC..."
    sudo apt-get update && sudo apt-get install -y gcc build-essential
fi

echo "=========================================================="
echo "Compiling and executing hello.c"
echo "=========================================================="
gcc hello.c -o hello
./hello

echo "=========================================================="
echo "Compiling and executing first.c"
echo "=========================================================="
gcc first.c -o first
./first

echo "=========================================================="
echo "[+] Experiment 02 C execution completed successfully!"
echo "=========================================================="
