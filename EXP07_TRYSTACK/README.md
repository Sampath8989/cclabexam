# Experiment 07: OpenStack Virtual Machine Launch via TryStack (Online Demo)

## 1. Experiment Overview
- **Title**: Find a procedure to launch virtual machine using TryStack (Online OpenStack Demo Version).
- **Primary Source**: Lab Manual Section *EX.NO: 7* (Pages 42–50).
- **Aim**: To understand Infrastructure as a Service (IaaS) cloud provisioning using OpenStack, configure software-defined networking (Neutron subnets, routers, gateways), launch compute instances (Nova), manage SSH key pairs and security groups, allocate floating public IP addresses, and verify connectivity.

---

## 2. What the Lab Manual Requires
The manual describes using **TryStack.org**, a free hosted multi-tenant OpenStack sandbox environment:
1. **Registration**: Joining the TryStack Facebook Group for invitation approval.
2. **Horizon Dashboard**: Logging into the web-based OpenStack Compute Dashboard.
3. **Network Configuration**:
   - Network Name: `internal`
   - CIDR: `192.168.1.0/24` (Private IPv4 block)
   - DNS Name Server: `8.8.8.8` (Google Public DNS)
4. **Router Configuration**: Creating a virtual router to connect the `internal` network to the external `public` gateway.
5. **Security Groups**: Opening ICMP (ping) and TCP Port 22 (SSH).
6. **Key Pair**: Creating and downloading an RSA private key file (`.pem`).
7. **Instance Launch**: Selecting image (CirrOS / Ubuntu), flavor (`m1.tiny`), connecting to `internal` network.
8. **Floating IP**: Binding a public floating IP address to the instance and connecting via SSH.

---

## 3. Discontinuation Status & Availability Analysis
- **What is no longer available**: **TryStack.org has been permanently shut down and decommissioned.** The OpenStack Foundation retired the legacy sandbox cluster and its Facebook authentication mechanism. Any attempt to register or navigate to `trystack.org` will fail or redirect.
- **What can still be prepared offline**:
  1. **Detailed Architecture Documentation**: All configuration steps, network CIDRs, security rules, and parameter tables from the manual are fully preserved here.
  2. **Workflow Simulation Script**: `scripts/openstack_topology_simulation.py` demonstrates the step-by-step OpenStack API logic and networking lifecycle.
  3. **SSH Key Generator**: `scripts/generate_ssh_keypair.py` creates the required 2048-bit RSA key pair.
  4. **Local OpenStack Alternative (DevStack / MicroStack)**: How students can run the identical OpenStack Horizon dashboard completely free on a local Ubuntu VM.

---

## 4. Step-by-Step Procedure (Preserved from Manual)

### Step 1: Create Network & Subnet
1. In the Horizon Dashboard: Navigate to **Network** > **Networks** > Click **Create Network**.
2. **Network Tab**: Enter Network Name `internal`. Click **Next**.
3. **Subnet Tab**:
   - Subnet Name: `internal_subnet`
   - Network Address: `192.168.1.0/24`
   - IP Version: `IPv4`
   - Gateway IP: `192.168.1.1` (or leave default)
   - Click **Next**.
4. **Subnet Details Tab**:
   - DNS Name Servers: `8.8.8.8`
   - Click **Create**.

### Step 2: Configure Router & External Gateway
1. Navigate to **Network** > **Routers** > Click **Create Router**.
2. Name: `router1`, External Network: `public`.
3. Click into `router1` > **Interfaces** tab > Click **Add Interface**.
4. Select Subnet: `internal: 192.168.1.0/24`. Click **Add Interface**.

### Step 3: Access & Security (Key Pair & Firewall)
1. Go to **Compute** > **Access & Security** > **Key Pairs** tab.
2. Click **Create Key Pair** > Name: `trystack_key` > Download `trystack_key.pem`.
3. Under **Security Groups** tab > Click **Manage Rules** for `default` group:
   - Add Rule: **All ICMP** (Ingress, CIDR: `0.0.0.0/0`).
   - Add Rule: **SSH** (Port 22, Ingress, CIDR: `0.0.0.0/0`).

### Step 4: Launch Instance
1. Go to **Compute** > **Instances** > Click **Launch Instance**.
2. **Details**: Instance Name: `instance-01`, Flavor: `m1.tiny`, Instance Boot Source: `Boot from image`, Image Name: `cirros` or `Ubuntu`.
3. **Access & Security**: Key Pair: `trystack_key`, Security Groups: check `default`.
4. **Networking**: Selected Networks: drag `internal` to selected.
5. Click **Launch**.

### Step 5: Associate Floating IP & Verification
1. Once status is `ACTIVE`: Click the dropdown menu next to the instance > **Associate Floating IP**.
2. Allocate an IP from the `public` pool and click **Associate**.
3. Open terminal/PowerShell:
   ```bash
   ping <Floating_IP>
   ssh -i trystack_key.pem cirros@<Floating_IP>
   ```

---

## 5. Running the Offline Simulation
To run the included Python workflow simulation demonstrating the complete provisioning lifecycle:
```powershell
python .\scripts\openstack_topology_simulation.py
```
To generate the required SSH key pair offline:
```powershell
python .\scripts\generate_ssh_keypair.py
```

---

## 6. How to Run Real OpenStack Horizon Locally (Optional Self-Hosted Lab)
If you wish to interact with the real OpenStack Horizon web interface offline:
1. Boot a clean Ubuntu 20.04/22.04 VM in VirtualBox (with 8GB RAM, 2 CPUs).
2. Install **MicroStack** (Official single-node OpenStack distribution by Canonical):
   ```bash
   sudo snap install microstack --devmode --beta
   sudo microstack init --auto --control
   ```
3. Access Horizon Dashboard locally at: `https://10.20.20.1` (or local VM IP).
4. You will see the exact same OpenStack Horizon Dashboard interface used in TryStack!
