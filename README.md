# cclabexam

# Cloud Computing Laboratory (22AIE305) - Complete Offline Software & Experiment Bundle

This repository contains the software packages, installers, configuration templates, custom algorithms, simulation engines, and runbooks for all 8 experiments in the **Cloud Computing Laboratory Manual (22AIE305 - School of Computing, Amrita Vishwa Vidyapeetham)**.

---

## 1. Directory Structure

```
cloud-computing-lab/
├── README.md                                # Master repository documentation
├── MANUAL/
│   └── CCLABMANUAL.pdf                      # Official primary source lab manual
├── EXP01_VIRTUALBOX_OPENNEBULA/             # Experiment 1: VirtualBox & OpenNebula Sandbox
│   ├── Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack
│   └── README.md
├── EXP02_C_COMPILER/                        # Experiment 2: C Compiler in VM (ubuntu_gt6)
│   ├── hello.c                              # C sample program 1
│   ├── first.c                              # C arithmetic program 2
│   ├── setup_and_run.sh                     # Automated setup for /opt/axis2/axis2-1.7.3/bin
│   └── README.md
├── EXP03_GOOGLE_APP_ENGINE/                 # Experiment 3: Google App Engine Java Hello World
│   ├── HelloWorld/                          # Complete GAE Java web application project
│   │   ├── src/com/mkyong/HelloWorldServlet.java
│   │   └── war/
│   │       ├── index.html
│   │       └── WEB-INF/
│   │           ├── appengine-web.xml
│   │           ├── web.xml
│   │           └── logging.properties
│   └── README.md
├── EXP04_GAE_LAUNCHER/                      # Experiment 4: GAE Launcher (Python) on localhost:8080
│   ├── GoogleAppEngine-1.8.9.msi            # Legacy GAE SDK with GoogleAppEngineLauncher.exe
│   ├── python-2.7.18.amd64.msi              # Official Python 2.7 runtime installer
│   ├── apps/
│   │   └── ae-01-trivial/                   # Manual sample application
│   │       ├── app.yaml
│   │       ├── index.py
│   │       └── run_local_server.bat
│   └── README.md
├── EXP05_CLOUDSIM/                          # Experiment 5: CloudSim & Custom Scheduling
│   ├── cloudsim-3.0.3.tar.gz                # Official CloudSim 3.0.3 distribution
│   ├── cloudsim-3.0.3/jars/                 # Extracted core JARs (cloudsim-3.0.3.jar)
│   ├── src/                                 # Custom scheduling algorithms (Not in CloudSim)
│   │   ├── org/cloudbus/cloudsim/CloudletSchedulerPriority.java
│   │   ├── org/cloudbus/cloudsim/CloudletSchedulerSJF.java
│   │   └── CustomSchedulingSimulationDemo.java
│   ├── run_simulation.bat                   # 1-click execution script for Windows
│   ├── run_simulation.sh                    # 1-click execution script for Linux/macOS
│   └── README.md
├── EXP06_VM_FILE_TRANSFER/                  # Experiment 6: VM-to-VM File Transfer Procedures
│   ├── VBoxGuestAdditions_5.0.20.iso        # VirtualBox 5.0.20 Guest Additions
│   ├── scripts/
│   │   ├── transfer_via_scp.sh              # Automated SCP file transfer
│   │   └── local_http_transfer.py           # Python local HTTP sharing server
│   └── README.md
├── EXP07_TRYSTACK/                          # Experiment 7: OpenStack Virtual Machine Launch (TryStack)
│   ├── scripts/
│   │   ├── generate_ssh_keypair.py          # RSA key generator for instances
│   │   └── openstack_topology_simulation.py # Horizon provisioning workflow simulator
│   └── README.md
├── EXP08_HADOOP/                            # Experiment 8: Hadoop 2.7.3 Single-Node Cluster & WordCount
│   ├── config/                              # Pre-configured Hadoop XML descriptors
│   │   ├── core-site.xml
│   │   ├── hdfs-site.xml
│   │   ├── mapred-site.xml
│   │   ├── yarn-site.xml
│   │   ├── hadoop-env.sh
│   │   └── slaves
│   ├── src/WordCount.java                   # MapReduce WordCount application
│   ├── data/input.txt                       # Sample text dataset
│   ├── scripts/setup_hadoop_env.sh          # Automated cluster formatter and starter
│   └── README.md
└── TOOLS/                                   # Download Management & Verification Automation
    ├── download_manifest.csv                # Master manifest of all packages, sizes, and hashes
    ├── download_all.ps1                     # Automated downloader for missing large packages
    ├── verify_all.ps1                       # Automated integrity & SHA256 audit script
    └── README.md
```

---

## 2. Experiments & Software Overview

| Exp # | Experiment Title | Required Software & Versions | Offline Capable? | Obsolete / Legacy Status |
| :---: | :--- | :--- | :---: | :--- |
| **01** | VirtualBox & OpenNebula Sandbox | VirtualBox 5.0.20, Ext Pack 5.0.20, `OpenNebula-Sandbox-5.0.ova` | **YES** | OpenNebula 5.0 Sandbox OVA discontinued (2016) |
| **02** | C Compiler in Linux VM | `ubuntu_gt6.ova`, GCC, Gedit, `/opt/axis2/axis2-1.7.3/bin` | **YES** | `ubuntu_gt6.ova` is custom academic lab image |
| **03** | Google App Engine (Java) | App Engine Java SDK 1.8.9/1.9.76, Eclipse Kepler 4.3.2, JDK 8 | **YES (Local Dev)** | GPE decommissioned (Jan 2018); appengine.google.com retired |
| **04** | GAE Launcher (Python) | `GoogleAppEngine-1.8.9.msi`, `python-2.7.18.amd64.msi` | **YES** | GAE Launcher discontinued (Jul 2020); Python 2.7 EOL |
| **05** | CloudSim Simulation | CloudSim 3.0.3, Java 8, Priority & SJF Schedulers | **YES** | Active research toolkit; CloudSim 3.0 legacy baseline |
| **06** | VM-to-VM File Transfer | `VBoxGuestAdditions_5.0.20.iso`, Shared Folders, SCP, HTTP | **YES** | Active VirtualBox workflow |
| **07** | OpenStack Launch (TryStack) | TryStack.org Web Dashboard, SSH Keygen, CirrOS/Ubuntu | **SIMULATED** | TryStack.org service permanently decommissioned |
| **08** | Hadoop 2.7.3 Single Node Cluster| Apache Hadoop 2.7.3, Adoptium OpenJDK 8u412, WordCount MapReduce | **YES** | Hadoop 2.x superseded by 3.x; strictly requires Java 8 |

---

## 3. Storage Footprint Summary
- **Current Git Repository Size**: ~160 MB (Contains all source codes, XML templates, GAE Python SDK 1.8.9 MSI, Python 2.7.18 MSI, CloudSim 3.0.3 tar.gz, VBox Extension Pack, VBox Guest Additions ISO, and automation scripts).
- **With Large Dependencies (VirtualBox 5.0, Hadoop 2.7.3, Eclipse Kepler, Java SDK)**: ~850 MB total.
- **With Full Virtual Appliances (OpenNebula OVA + Ubuntu GT6 OVA)**: ~4.5 GB total.

---

## 4. Fresh Windows Lab PC Setup: Installation Order

When setting up a fresh Windows lab PC, follow this installation order:

1. **Install VirtualBox 5.0.20 & Extension Pack**:
   - Run `VirtualBox-5.0.20-106931-Win.exe`.
   - Double-click `Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack` to enable USB 1.1 virtualization.
2. **Install Python 2.7.18 & Google App Engine Launcher (EXP04)**:
   - Run `EXP04_GAE_LAUNCHER\python-2.7.18.amd64.msi` (Check "Add python.exe to PATH").
   - Run `EXP04_GAE_LAUNCHER\GoogleAppEngine-1.8.9.msi`.
3. **Install Java JDK 8**:
   - Install Adoptium Eclipse Temurin OpenJDK 8 (or Oracle JDK 8). Set `JAVA_HOME`.
4. **Import Virtual Machines (EXP01, EXP02, EXP06)**:
   - Open VirtualBox > File > Import Appliance > Select `OpenNebula-Sandbox-5.0.ova` (Set USB 1.1).
   - Open VirtualBox > File > Import Appliance > Select `ubuntu_gt6.ova` (Set USB 1.1).
5. **Set Up Hadoop & CloudSim**:
   - Extract `EXP05_CLOUDSIM\cloudsim-3.0.3.tar.gz`.
   - Copy `EXP08_HADOOP\config\*` to Hadoop installation directory on Linux VM or WSL.

---

## 5. First Commands to Run After Cloning

Open PowerShell as Administrator:
```powershell
# 1. Clone repository
git clone https://github.com/Sampath8989/cclabexam.git
cd cclabexam

# 2. Run integrity verification audit
powershell -ExecutionPolicy Bypass -File .\TOOLS\verify_all.ps1

# 3. (Optional) Download any missing large files (>100MB) directly from official archives
powershell -ExecutionPolicy Bypass -File .\TOOLS\download_all.ps1

# 4. Test CloudSim custom scheduler immediately
cd EXP05_CLOUDSIM
.\run_simulation.bat

# 5. Test Google App Engine local server
cd ..\EXP04_GAE_LAUNCHER\apps\ae-01-trivial
.\run_local_server.bat
```

---

## 6. Offline vs. Online Capabilities
- **Experiments Working 100% Offline**: **EXP01, EXP02, EXP03 (Local), EXP04, EXP05, EXP06, EXP08**.
- **Experiments Requiring Internet**:
  - **EXP07 (TryStack)**: The original manual required connecting to `trystack.org`. Because TryStack is decommissioned, offline simulation scripts and local MicroStack runbooks are provided instead.
  - **EXP03 (Cloud Deploy Step)**: Deploying to `appspot.com` required an active Google Cloud account with internet connectivity; the local development server (`localhost:8888`) operates 100% offline.
