# Experiment 06: File Transfer Procedures Between Virtual Machines

## 1. Experiment Overview
- **Title**: Find a procedure to transfer the files from one virtual machine to another virtual machine.
- **Primary Source**: Lab Manual Section *EX.NO: 6* (Pages 35–41).
- **Aim**: To explore, configure, and demonstrate multiple mechanisms for transferring data, source files, and documents between two distinct virtual machines running in Oracle VM VirtualBox (or between Host OS and multiple Guest OSes).

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **VirtualBox Guest Additions** | 5.0.20 | `VBoxGuestAdditions_5.0.20.iso` | [Oracle VirtualBox Archive](https://download.virtualbox.org/virtualbox/5.0.20/VBoxGuestAdditions_5.0.20.iso) | 58,157,056 | `6FBB59FD22E5F1B287A8A2B623604F0849B702A4AC737B57833F7CEC006F01E6` |
| **Source Virtual Machine** | EXP02 VM | `ubuntu_gt6.ova` (or VM 1) | Reused from `EXP02_C_COMPILER/` | - | Avoids multi-GB duplication |
| **Target Virtual Machine** | EXP01 VM | `OpenNebula-Sandbox-5.0.ova` (or VM 2) | Reused from `EXP01_VIRTUALBOX_OPENNEBULA/` | - | Avoids multi-GB duplication |
| **SCP Transfer Script** | 1.0 | `scripts/transfer_via_scp.sh` | Included in repository | - | Automated SSH/SCP file copy |
| **HTTP Transfer Server** | 1.0 | `scripts/local_http_transfer.py` | Included in repository | - | Python local web file server |

*The `VBoxGuestAdditions_5.0.20.iso` installer is directly downloaded, verified, and present in this directory.*

---

## 3. Five Transfer Procedures (From Lab Manual)

### Method 1: Shared Clipboard (Copy & Paste)
1. In VirtualBox Manager, select **VM 1** > **Settings** > **General** > **Advanced**.
2. Set **Shared Clipboard** to **Bidirectional**.
3. Repeat for **VM 2** (Set Shared Clipboard to **Bidirectional**).
4. Start both VMs and install Guest Additions:
   - In the VM menu bar: **Devices** > **Insert Guest Additions CD image...**
   - In Linux terminal: `sudo /media/cdrom/VBoxLinuxAdditions.run`
   - Reboot both VMs.
5. In VM 1: Open a file or text editor, select text/code, and press `Ctrl + C`.
6. Text passes into the shared clipboard buffer on the Host OS.
7. In VM 2: Open target editor/terminal and press `Ctrl + V` (or `Shift + Ctrl + V`).

### Method 2: Drag and Drop
1. In VirtualBox Manager, select each VM > **Settings** > **General** > **Advanced**.
2. Set **Drag'n'Drop** to **Bidirectional**.
3. Ensure Guest Additions are installed and VMs restarted.
4. Drag a file from VM 1's file manager out onto the Host desktop, then drag it directly into VM 2's file manager window.

### Method 3: Common Shared Folder (Buffer Directory)
1. On the Host OS, create a dedicated folder (e.g., `C:\vbox_share`).
2. In VirtualBox Manager, select **VM 1** > **Settings** > **Shared Folders**.
   - Click the **Add Folder** icon (`+`).
   - Folder Path: `C:\vbox_share`, Folder Name: `vbox_share`.
   - Check **Auto-mount** and **Make Permanent**.
3. Repeat the exact same step for **VM 2** with the same Host path `C:\vbox_share`.
4. In Linux guests, the folder appears at `/media/sf_vbox_share`.
   - Add your user to the `vboxsf` group:
     ```bash
     sudo usermod -aG vboxsf $USER
     ```
5. Any file copied into `/media/sf_vbox_share` from VM 1 is instantaneously visible and writable in VM 2.

### Method 4: Client-Server Network Transfer (SSH / SCP)
1. Configure both VMs to be on the same VirtualBox network:
   - Select VM > **Settings** > **Network** > **Adapter 1** > Attached to: **Host-only Adapter** (or **Internal Network** / **Bridged Adapter**).
2. On the receiving machine (VM 2):
   - Check if SSH daemon is running:
     ```bash
     pgrep sshd
     ```
   - If not installed, install OpenSSH server:
     ```bash
     sudo apt-get update && sudo apt-get install -y openssh-server
     ```
   - Note the IP address: `ifconfig` or `ip addr show` (e.g., `192.168.56.102`).
3. On the sending machine (VM 1):
   - Transfer file using SCP:
     ```bash
     scp /path/to/file user@192.168.56.102:/home/user/
     ```
   - Or execute the included automated script:
     ```bash
     ./scripts/transfer_via_scp.sh myfile.txt user@192.168.56.102:/home/user/
     ```

### Method 5: Network File System (NFS / SSHFS / Samba)
1. Mount a directory from VM 1 onto VM 2 using SSHFS:
   ```bash
   sudo apt-get install sshfs
   mkdir -p ~/remote_vm1
   sshfs user@<VM1_IP>:/home/user/shared_files ~/remote_vm1
   ```
2. Any operations inside `~/remote_vm1` execute directly on VM 1 across the network.

---

## 4. Offline Status & Compatibility Notes
- **Internet Required During Experiment**: **NO** (All 5 methods run 100% offline within local host memory and VirtualBox internal networks).
- **File Deduplication Policy**: Does not duplicate the multi-gigabyte OVA appliances from EXP01 and EXP02. Both existing appliances or any standard Ubuntu VMs can be used interchangeably.
