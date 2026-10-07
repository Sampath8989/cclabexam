#!/usr/bin/env python
"""
Experiment 07: OpenStack / TryStack Workflow Simulator
Demonstrates the exact API and logical provisioning sequence performed in the
TryStack Horizon dashboard:
  1. Create private network (CIDR 192.168.1.0/24, DNS 8.8.8.8)
  2. Create virtual router and attach internal subnet to external gateway
  3. Create security group rules (allow ICMP and SSH Port 22)
  4. Launch instance (Flavor: m1.tiny, Image: cirros/ubuntu)
  5. Allocate floating IP and associate with instance
"""
import time

def simulate_openstack_workflow():
    print("=" * 70)
    print("OpenStack Horizon / TryStack Cloud Provisioning Simulation")
    print("=" * 70)

    print("\n[Step 1] Creating Local Network...")
    print("  -> Network Name: internal")
    print("  -> Subnet Name:  internal_subnet")
    print("  -> Network CIDR: 192.168.1.0/24")
    print("  -> IP Version:   IPv4")
    print("  -> DNS Servers:  8.8.8.8 (Google DNS)")
    time.sleep(0.5)
    print("  [SUCCESS] Network 'internal' created (ID: net-7a8b9c1d-001).")

    print("\n[Step 2] Configuring Virtual Router & Gateway...")
    print("  -> Router Name:      router1")
    print("  -> External Network: public (ext-net)")
    print("  -> Interface Added:  192.168.1.1 on internal_subnet")
    time.sleep(0.5)
    print("  [SUCCESS] Router active; NAT gateway connected to Internet.")

    print("\n[Step 3] Configuring Security Group Rules...")
    print("  -> Security Group: default")
    print("  -> Rule 1: Ingress ICMP (ping) from 0.0.0.0/0: ALLOW")
    print("  -> Rule 2: Ingress TCP Port 22 (SSH) from 0.0.0.0/0: ALLOW")
    time.sleep(0.5)
    print("  [SUCCESS] Security group rules updated.")

    print("\n[Step 4] Launching Instance...")
    print("  -> Instance Name:   instance-01")
    print("  -> Flavor:          m1.tiny (1 VCPU, 512 MB RAM, 1 GB Disk)")
    print("  -> Boot Source:     Image (CirrOS 0.3.5 / Ubuntu 14.04)")
    print("  -> Key Pair:        trystack_key")
    print("  -> Network:         internal (Assigned Private IP: 192.168.1.15)")
    time.sleep(0.8)
    print("  [SUCCESS] Instance spawned. Status: ACTIVE / RUNNING.")

    print("\n[Step 5] Allocating and Associating Floating IP...")
    print("  -> Pool:            public")
    print("  -> Allocated IP:    8.21.28.104")
    print("  -> Associated with: instance-01 (192.168.1.15)")
    time.sleep(0.5)
    print("  [SUCCESS] Floating IP 8.21.28.104 mapped successfully.")

    print("\n" + "=" * 70)
    print("SUMMARY / ACCESS VERIFICATION")
    print("=" * 70)
    print("Ping Test:    ping 8.21.28.104  ->  64 bytes from 8.21.28.104: icmp_seq=1 ttl=64 time=1.2 ms")
    print("SSH Command:  ssh -i trystack_key.pem cirros@8.21.28.104")
    print("=" * 70)

if __name__ == "__main__":
    simulate_openstack_workflow()
