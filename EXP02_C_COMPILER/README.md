# Experiment 02: C Compiler Installation in Virtual Machine & Execution

## 1. Experiment Overview
- **Title**: Install a C compiler in the virtual machine created using VirtualBox and execute Simple Programs.
- **Primary Source**: Lab Manual Section *EX.NO.: 2* (Pages 12–15).
- **Aim**: To configure a Linux virtual machine environment inside Oracle VM VirtualBox, install/verify the GCC compiler toolchain, and compile and execute simple C programs within a designated directory structure.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Status / Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Ubuntu VM Appliance** | GT6 Custom Lab Image | `ubuntu_gt6.ova` | Internal College Lab Mirror / Local Media | Proprietary/Academic custom pre-configured VM image |
| **GNU C Compiler** | GCC 4.8+ / 5.x / Modern | Pre-installed or `build-essential` | Ubuntu Package Archive (`apt-get`) | Standard Linux compiler toolchain |
| **Text Editor** | Gedit 3.x / Nano / Vi | `gedit` | Ubuntu Package Archive | GUI text editor specified in manual |
| **C Source Program 1** | 1.0 | `hello.c` | Included in repository | Manual sample test file |
| **C Source Program 2** | 1.0 | `first.c` | Included in repository | Manual arithmetic calculation test file |
| **Automated Setup Script** | 1.0 | `setup_and_run.sh` | Included in repository | Reproduces `/opt/axis2/axis2-1.7.3/bin` workflow |

---

## 3. Appliance Credentials & Lab Settings
- **Virtual Machine Name**: `ubuntu_gt6`
- **Default Login Username**: `dinesh` (or `raju` in legacy variants)
- **Default Login Password**: `99425`
- **VirtualBox USB Controller**: **USB 1.1 (OHCI)** (Critical: manual requires USB 1.1 to prevent device initialization stalls on legacy kernels)
- **Manual Working Directory**: `/opt/axis2/axis2-1.7.3/bin`

---

## 4. Status of `ubuntu_gt6.ova`
- **Why this file is not hosted on public mirrors**: `ubuntu_gt6.ova` is not an official Canonical Ubuntu release; it is a custom virtual appliance created and customized by university laboratory administrators (Anna University / Amrita Vishwa Vidyapeetham / regional lab syllabi) with pre-configured Apache Axis2 directories and local user accounts.
- **Reproducibility**: Any standard Ubuntu Virtual Machine (e.g., Ubuntu 14.04, 16.04, or modern Ubuntu LTS) or WSL2 instance running under VirtualBox can reproduce this experiment with 100% fidelity using the provided `setup_and_run.sh` script or the manual steps below.

---

## 5. Step-by-Step Execution Workflow

### Step A: Import Appliance in VirtualBox (If using `ubuntu_gt6.ova`)
1. Open **Oracle VM VirtualBox**.
2. Click **File** > **Import Appliance...**
3. Browse and select `ubuntu_gt6.ova`.
4. Click **Next**, then click **Import**.
5. Once imported, select the VM and click **Settings**.
6. Go to **Ports** > **USB** and ensure **USB 1.1 (OHCI) Controller** is enabled.
7. Click **OK** and start the virtual machine.
8. Log in with:
   - **Username**: `dinesh`
   - **Password**: `99425`

### Step B: Manual Execution Steps from Lab Manual
1. Open the Terminal in Ubuntu (`Ctrl + Alt + T`).
2. Navigate to the Axis2 binary directory:
   ```bash
   cd /opt/axis2/axis2-1.7.3/bin
   ```
3. Create/Edit the first C program:
   ```bash
   gedit hello.c
   ```
4. Enter the program code:
   ```c
   #include <stdio.h>
   int main() {
       printf("Hello, World!\n");
       return 0;
   }
   ```
5. Compile and execute:
   ```bash
   gcc hello.c
   ./a.out
   ```
6. Create/Edit the second C program:
   ```bash
   gedit first.c
   ```
7. Compile and execute:
   ```bash
   gcc first.c
   ./a.out
   ```

### Step C: Automated Local Reproduction (On any Linux VM or Host)
If using an existing Ubuntu installation or if `/opt/axis2/axis2-1.7.3/bin` does not yet exist:
```bash
chmod +x setup_and_run.sh
./setup_and_run.sh
```

---

## 6. Compatibility & Offline Status
- **Internet Required During Experiment**: **NO** (Fully offline once the VM is booted).
- **Obsolete / Discontinued Status**: GCC and Ubuntu are actively maintained; the specific pre-baked `ubuntu_gt6.ova` image and Axis2 1.7.3 path are historical lab artifacts.
- **Modern Windows PC Notes**: VirtualBox 5.0.x may conflict with modern Windows 10/11 Hyper-V / Core Isolation (Memory Integrity). If running on a modern Windows 11 host, use modern VirtualBox 7.x or run via WSL2/Hyper-V if legacy VirtualBox 5.0 fails driver installation.
