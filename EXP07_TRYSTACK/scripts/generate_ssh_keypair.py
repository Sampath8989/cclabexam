#!/usr/bin/env python
"""
Experiment 07: SSH Key Pair Generator for OpenStack / TryStack Instances
Generates an RSA 2048-bit key pair (id_rsa private key and id_rsa.pub public key)
matching the Key Pair generation step in the TryStack manual.
"""
import os
import subprocess
import sys

def generate_keys():
    key_dir = os.path.dirname(os.path.abspath(__file__))
    priv_key = os.path.join(key_dir, "trystack_key.pem")
    pub_key = os.path.join(key_dir, "trystack_key.pub")

    if os.path.exists(priv_key):
        print("[*] Key pair already exists: %s" % priv_key)
        return

    print("[*] Generating 2048-bit RSA key pair for OpenStack instance access...")
    try:
        subprocess.check_call(["ssh-keygen", "-t", "rsa", "-b", "2048", "-f", priv_key, "-N", ""])
        print("[+] Private key created: %s" % priv_key)
        print("[+] Public key created:  %s" % pub_key)
        print("[*] Upload trystack_key.pub to OpenStack Horizon Dashboard under Compute > Access & Security > Key Pairs.")
    except Exception as e:
        print("[!] ssh-keygen error: %s" % str(e))
        print("[*] You can run ssh-keygen manually in PowerShell/Bash: ssh-keygen -t rsa -f trystack_key.pem")

if __name__ == "__main__":
    generate_keys()
