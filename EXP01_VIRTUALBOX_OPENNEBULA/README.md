# Experiment 01: VirtualBox Installation & OpenNebula Cloud Sandbox

## 1. Experiment Overview
- **Title**: Install VirtualBox / VMware Workstation with different flavours of Linux or Windows OS on top of Windows 7 or 8.
- **Primary Source**: Lab Manual Section *EX NO. : 1* (Pages 5–11).
- **Aim**: To install Oracle VM VirtualBox 5.0.20, import the OpenNebula 5.0 Sandbox virtual appliance, configure USB virtualization settings, boot into the OpenNebula cloud controller, and provision virtual machines via the Sunstone web dashboard.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Oracle VM VirtualBox** | 5.0.20-106931 | `VirtualBox-5.0.20-106931-Win.exe` | [Oracle VirtualBox Archive](https://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Win.exe) | 113,110,496 | `4F167B0967E3C2283EEF986B8FFA3FEC82390CD79038568EAE3CA65C6AB4C294` |
| **VirtualBox Extension Pack** | 5.0.20-106931a | `Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack` | [Oracle VirtualBox Archive](https://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack) | 16,431,947 | `2857AAAB640C906F5B77D88C38A65010B0EA2816239CE3B905433B610A859889` |
| **OpenNebula Sandbox Appliance** | 5.0.0 | `OpenNebula-Sandbox-5.0.ova` | Historical OpenNebula Release (Archived) | ~1.8 GB | N/A (Discontinued OVA) |

---

## 3. Appliance Credentials & Lab Parameters
- **Console / Root Login**:
  - **Username**: `root`
  - **Password**: `opennebula`
- **Sunstone Web GUI URL**: `http://localhost:9869`
- **Sunstone Login**:
  - **Username**: `oneadmin`
  - **Password**: `opennebula`
- **USB Controller Setting**: **USB 1.1 (OHCI)** (Mandatory: manual specifies USB 1.1 to avoid boot freeze on legacy CentOS/OpenNebula kernel)

---

## 4. Discontinuation Status & Availability Analysis
- **VirtualBox 5.0.20**: Fully preserved and available on Oracle's historical archive.
- **OpenNebula-Sandbox-5.0.ova**: Released in 2016 by OpenNebula Systems. The OpenNebula project officially phased out pre-packaged monolithic `.ova` sandboxes in favor of:
  1. **miniONE**: Automated one-command deployment script on standard Linux instances (`https://github.com/OpenNebula/minione`).
  2. **OpenNebula ISO**: Bootable appliance ISO based on AlmaLinux/CentOS.
- **Offline Lab Instructions**: If `OpenNebula-Sandbox-5.0.ova` is provided on lab flash drives or internal college intranet shares, copy it directly into this directory and follow the manual workflow below.

---

## 5. Step-by-Step Execution Workflow (From Lab Manual)

### Step 1: Install VirtualBox 5.0.20
1. Run `VirtualBox-5.0.20-106931-Win.exe`.
2. Follow the setup wizard: click **Next** > **Next** > **Yes** (Network interfaces reset warning) > **Install**.
3. Install the Extension Pack by double-clicking `Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack` and accepting the license agreement.

### Step 2: Import OpenNebula Sandbox Appliance
1. Launch **Oracle VM VirtualBox**.
2. Go to **File** > **Import Appliance...** (`Ctrl + I`).
3. Click the folder icon, browse to this directory, and select `OpenNebula-Sandbox-5.0.ova`.
4. Click **Next**, review the VM hardware specifications, and click **Import**.
5. Once imported, select the **OpenNebula-Sandbox** VM and click **Settings**.
6. In the left panel, click **Ports** > **USB**.
7. Select **USB 1.1 (OHCI) Controller** (as instructed in Step 4 of the manual).
8. Click **OK**.

### Step 3: Start and Log In to the Controller
1. Click the green **Start** arrow to power on the VM.
2. Allow the system to boot to the login prompt.
3. At the login prompt:
   - Login: `root`
   - Password: `opennebula`

### Step 4: Access Sunstone Web Interface & Provision VM
1. Open a web browser on the host machine (or inside the VM).
2. Navigate to: `http://localhost:9869`
3. Log in with:
   - Username: `oneadmin`
   - Password: `opennebula`
4. Under the dashboard menu:
   - Click **Instances** > **VMs**.
   - Expand the **`+`** (plus) icon to create a new Virtual Machine.
   - Select user `oneadmin`.
   - Specify the VM Name, number of instances, and allocated CPU/Memory.
   - Click the green **Create** button.
   - Verify that the new VM appears in the instance table with status `RUNNING`.

---

## 6. Modern Windows Compatibility Notes
- **Windows 10/11 Hypervisor Conflict**: VirtualBox 5.0.20 is a 2016 release. On modern Windows 10/11 systems with **Memory Integrity (HVCI)** or **Windows Hypervisor Platform (WHPX)** enabled, VirtualBox 5.0 may fail to install network filter drivers or crash with blue screen `VERR_VMX_NO_VMX`.
- **Workaround on Modern Host**: If installing on a modern PC outside the lab, temporarily disable Hyper-V (`bcdedit /set hypervisorlaunchtype off`), or alternatively use VirtualBox 7.x which includes Hyper-V coexistence support. The `.ova` appliance imports identically on VirtualBox 5.x, 6.x, and 7.x.
- **Internet Required During Experiment**: **NO** (Entirely local on host machine).
