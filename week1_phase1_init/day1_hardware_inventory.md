# Day 1 — DGX Hardware Inventory

**Date:** 2026-06-07
**System:** NVIDIA DGX [NVIDIA_DGX_Spark]

## GPU Configuration
- GPU Count: 1
- GPU Model: NVIDIA DGX NVIDIA_DGX_Spark
- GPU Memory per card: 128 GB | Total: 128 GB
- Driver Version: XXX.XX | CUDA Version: XX.X

## GPU Topology
```
tamil@dgxspark03:~$ nvidia-smi topo -m
        GPU0    CPU Affinity    NUMA Affinity   GPU NUMA ID
GPU0     X      0-19    0               N/A

Legend:

  X    = Self
  SYS  = Connection traversing PCIe as well as the SMP interconnect between NUMA nodes (e.g., QPI/UPI)
  NODE = Connection traversing PCIe as well as the interconnect between PCIe Host Bridges within a NUMA node
  PHB  = Connection traversing PCIe as well as a PCIe Host Bridge (typically the CPU)
  PXB  = Connection traversing multiple PCIe bridges (without traversing the PCIe Host Bridge)
  PIX  = Connection traversing at most a single PCIe bridge
  NV#  = Connection traversing a bonded set of # NVLinks
tamil@dgxspark03:~$
```

## NVLink Status
```
tamil@dgxspark03:~$ nvidia-smi nvlink --status -i 0
tamil@dgxspark03:~$
```

## Key Observations
- All GPUs detected: ✅ 
- NVLink connectivity:  ❌
- Anomalies: [notes]

### OS check
```bash
tamil@dgxspark03:~$ uname -a
Linux dgxspark03 6.17.0-1021-nvidia #21-Ubuntu SMP PREEMPT_DYNAMIC Wed May 27 19:14:05 UTC 2026 aarch64 aarch64 aarch64 GNU/Linux
tamil@dgxspark03:~$ 
tamil@dgxspark03:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.4 LTS
Release:        24.04
Codename:       noble
tamil@dgxspark03:~$ 
tamil@dgxspark03:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs            13G  2.2M   13G   1% /run
efivarfs        256K   20K  237K   8% /sys/firmware/efi/efivars
/dev/nvme0n1p2  3.7T   63G  3.5T   2% /
tmpfs            61G     0   61G   0% /dev/shm
tmpfs           5.0M  8.0K  5.0M   1% /run/lock
/dev/nvme0n1p1  298M  6.4M  292M   3% /boot/efi
tmpfs            13G  104K   13G   1% /run/user/126
tmpfs            13G   96K   13G   1% /run/user/1000
tmpfs            13G   92K   13G   1% /run/user/1001
tamil@dgxspark03:~$ 
tamil@dgxspark03:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           121Gi       2.7Gi       118Gi        36Mi       1.4Gi       118Gi
Swap:           15Gi          0B        15Gi
tamil@dgxspark03:~$ 
```

### GPU Configuration 
```bash
amil@dgxspark03:~$ sudo dmidecode -s system-product-name
[sudo] password for tamil: 
NVIDIA_DGX_Spark
tamil@dgxspark03:~$ 
tamil@dgxspark03:~$ cat /etc/dgx-release
DGX_NAME="DGX Spark"
DGX_PRETTY_NAME="NVIDIA DGX Spark"
DGX_SWBUILD_DATE="2025-09-10-13-50-03"
DGX_SWBUILD_VERSION="7.2.3"
DGX_COMMIT_ID="833b4a7"
DGX_PLATFORM="DGX Server for KVM"
DGX_SERIAL_NUMBER="1983925020080"

DGX_OTA_VERSION="7.5.0"
DGX_OTA_DATE="Thu Jun 18 17:40:28 EDT 2026"
tamil@dgxspark03:~$ 
```
### GPU Inventory

```bash
tamil@dgxspark03:~$ nvidia-smi
Thu Jun 18 19:44:21 2026       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 580.159.03             Driver Version: 580.159.03     CUDA Version: 13.0     |
+-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GB10                    On  |   0000000F:01:00.0 Off |                  N/A |
| N/A   33C    P8              4W /  N/A  | Not Supported          |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A            2443      G   /usr/lib/xorg/Xorg                      126MiB |
|    0   N/A  N/A            2786      G   /usr/bin/gnome-shell                     18MiB |
+-----------------------------------------------------------------------------------------+
tamil@dgxspark03:~$ 
```

### GPU Topology (Used to validate additional GPU's connected via NVLink or PCIe devices)

```bash
tamil@dgxspark03:~$ nvidia-smi topo -m
        GPU0    CPU Affinity    NUMA Affinity   GPU NUMA ID
GPU0     X      0-19    0               N/A

Legend:

  X    = Self
  SYS  = Connection traversing PCIe as well as the SMP interconnect between NUMA nodes (e.g., QPI/UPI)
  NODE = Connection traversing PCIe as well as the interconnect between PCIe Host Bridges within a NUMA node
  PHB  = Connection traversing PCIe as well as a PCIe Host Bridge (typically the CPU)
  PXB  = Connection traversing multiple PCIe bridges (without traversing the PCIe Host Bridge)
  PIX  = Connection traversing at most a single PCIe bridge
  NV#  = Connection traversing a bonded set of # NVLinks
tamil@dgxspark03:~$
```

### NVLink Status 
```bash
tamil@dgxspark03:~$ nvidia-smi nvlink --status -i 0
tamil@dgxspark03:~$
```

### Unified GPU Memory
```bash
tamil@dgxspark03:~$ sudo lshw -short -C memory
H/W path      Device          Class          Description
========================================================
/0/1                          memory         64KiB BIOS
/0/a                          memory         64KiB L1 cache
/0/b                          memory         64KiB L1 cache
/0/c                          memory         512KiB L2 cache
/0/d                          memory         8MiB L3 cache
/0/10                         memory         128GiB System Memory
/0/10/0                       memory         128GiB Chip Synchronous 8533 MHz (0.1 ns)
tamil@dgxspark03:~$
```