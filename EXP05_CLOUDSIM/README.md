# Experiment 05: Cloud Simulation with CloudSim & Custom Scheduling Algorithm

## 1. Experiment Overview
- **Title**: Simulate a cloud scenario using CloudSim and run a scheduling algorithm that is not present in CloudSim.
- **Primary Source**: Lab Manual Section *EX. NO.: 4* (Pages 26–30).
- **Aim**: To configure the CloudSim 3.x simulation toolkit in Java / Eclipse, model core cloud entities (Datacenters, Hosts, Processing Elements, Brokers, VMs, and Cloudlets), implement a custom scheduling algorithm that is **NOT** included in the standard CloudSim library (Priority-Based / Shortest Job First), and evaluate cloudlet completion times.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CloudSim Toolkit Package** | 3.0.3 | `cloudsim-3.0.3.tar.gz` | [Google Code Archive](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cloudsim/cloudsim-3.0.3.tar.gz) | 10,379,100 | `4467A4B77F1AFA094CC60615078EAAACE04E6E041EA2D6059C23A77B7AE6AD68` |
| **CloudSim Core Library** | 3.0.3 | `cloudsim-3.0.3.jar` | Extracted from package | 246,152 | Extracted & Verified |
| **CloudSim Examples** | 3.0.3 | `cloudsim-examples-3.0.3.jar` | Extracted from package | 5,071,812 | Extracted & Verified |
| **Java Development Kit** | JDK 8 (or JDK 7) | `java` / `javac` | [Adoptium Temurin 8](https://adoptium.net/) | ~100 MB | Verified OpenJDK 8 Distribution |
| **Custom Priority Scheduler** | 1.0 | `CloudletSchedulerPriority.java` | Included in repository (`src/org/cloudbus/cloudsim/`) | - | Priority Queue Scheduling |
| **Custom SJF Scheduler** | 1.0 | `CloudletSchedulerSJF.java` | Included in repository (`src/org/cloudbus/cloudsim/`) | - | Shortest Job First Scheduling |
| **Runnable Simulation Demo** | 1.0 | `CustomSchedulingSimulationDemo.java` | Included in repository (`src/`) | - | Complete executable demo |

*All CloudSim archives, extracted JARs, custom scheduling algorithm sources, and execution scripts are present in this directory.*

---

## 3. The Custom Scheduling Algorithm Requirement
Standard CloudSim 3.0 only provides:
- `CloudletSchedulerTimeShared`: Allocates CPU time slices concurrently among cloudlets.
- `CloudletSchedulerSpaceShared`: Executes cloudlets sequentially on available PEs in first-come-first-served (FCFS) order.
- `CloudletSchedulerDynamicWorkload`: Dynamically scales utilization based on models.

**What is added here**:
1. **`CloudletSchedulerPriority`**: Inherits from `CloudletSchedulerSpaceShared` and implements a dynamic priority queue (`sortWaitingListByPriority()`). Cloudlets assigned higher priority jump ahead of lower-priority tasks in the waiting queue.
2. **`CloudletSchedulerSJF`**: Sorts pending cloudlets by total instruction length (`sortWaitingListBySJF()`), ensuring shorter cloudlets finish with minimal average wait time.

---

## 4. Execution Workflow

### Option A: 1-Click Command Line Execution (Windows)
Double-click `run_simulation.bat` or run in PowerShell:
```powershell
.\run_simulation.bat
```

### Option B: 1-Click Execution (Linux / macOS / WSL)
```bash
chmod +x run_simulation.sh
./run_simulation.sh
```

### Option C: In Eclipse IDE (As instructed in Lab Manual)
1. Open Eclipse (Kepler / Luna / modern Eclipse).
2. Click **File** > **New** > **Java Project**.
3. Name the project `CloudSimLab`.
4. Right-click the project > **Build Path** > **Configure Build Path...**
5. Go to the **Libraries** tab > Click **Add External JARs...**
6. Select `cloudsim-3.0.3\jars\cloudsim-3.0.3.jar`.
7. Copy the files from `EXP05_CLOUDSIM\src\` into the project's `src` folder.
8. Right-click `CustomSchedulingSimulationDemo.java` > **Run As** > **Java Application**.

---

## 5. Expected Output (Matching Lab Manual)
```
Starting CloudSim Custom Scheduling Simulation...
Initialising...
Starting CloudSim version 3.0
Datacenter_0 is starting...
Broker is starting...
Entities started.
0.0: Broker: Cloud Resource List received with 1 resource(s)
0.0: Broker: Trying to Create VM #0 in Datacenter_0
0.1: Broker: VM #0 has been created in Datacenter #2, Host #0
0.1: Broker: Sending cloudlet 0 to VM #0
...
Broker is shutting down...
Simulation completed.

========== OUTPUT ==========
Cloudlet ID    STATUS    Data center ID    VM ID    Time    Start Time    Finish Time
    0          SUCCESS         2             0       40         0.1          40.1
    1          SUCCESS         2             0       10        40.1          50.1
    2          SUCCESS         2             0       25        50.1          75.1
    3          SUCCESS         2             0        5        75.1          80.1
Custom Scheduling Simulation finished successfully!
```

---

## 6. Compatibility & Offline Status
- **Internet Required During Experiment**: **NO** (100% offline).
- **Discontinuation Status**: CloudSim 3.0.3 is archived on Google Code and GitHub (`cloudslab/cloudsim`). CloudSim is completely open-source (GPL-compatible LGPL/Apache licenses).
- **Java Compatibility**: Works smoothly on Java 8 through Java 17.
