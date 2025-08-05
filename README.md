# HostHawk

**HostHawk** is a lightweight, real-time network scanner built entirely in Bash. It leverages Nmap to discover active hosts on a local subnet, displaying key information like IP address, latency, MAC address, vendor, and hostname in a structured, terminal-friendly table.

Created by **Debanjan**, a cybersecurity testing engineer focused on real-world tooling for network analysis and device discovery.

---

## Features

- Real-time per-host discovery output (not delayed)
- Shows IP address, MAC address, latency, vendor, and hostname
- ARP-based scanning for accuracy on local networks
- Minimal dependencies: just `nmap` and Bash
- Neatly aligned tabular display in any terminal

---

Example output:
<img width="1219" height="292" alt="image" src="https://github.com/user-attachments/assets/93684fc3-6a02-47b2-a5ef-40b831d2d1a5" />


---

## Requirements

- Linux system (tested on Kali Linux)
- `nmap` must be installed
- Root privileges (automatically requested if not already)

---

## Installation and Usage

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/HostHawk.git
```
```bash
cd HostHawk
```
### 2. Make the script executable
```bash
chmod +x HostHawk.sh
```
### 3. Run the script
```bash
./HostHawk.sh
```
### Alternatively, create a symlink to run it globally:
```bash
sudo ln -s "$(pwd)/HostHawk.sh" /usr/local/bin/hosthawk
```
```bash
hosthawk
```
