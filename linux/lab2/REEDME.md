# 💾 Lab 2: Disk Management and Logical Volume Setup (LVM)

This lab demonstrates how to manage storage disks in Linux using **LVM (Logical Volume Manager)**. The exercise simulates real-world scenarios where storage needs to be resized, extended, or aggregated dynamically without data loss or downtime.

---

## 🧠 Objective

- Attach and configure a new virtual disk (6GB).
- Create two partitions (2GB and 3GB).
- Set up an LVM structure using the 2GB partition.
- Extend the logical volume by adding the 3GB partition dynamically.

---

## 🛠️ Steps Performed

### 1. Attach a New Virtual Disk

A new 6GB disk (`/dev/sdb`) is attached to the virtual machine.

### 2. Partitioning the Disk

```bash
sudo fdisk /dev/sdb
# Create /dev/sdb1 → 2GB
# Create /dev/sdb2 → 3GB
```

### 3. Initialize the First Partition for LVM

```bash
sudo pvcreate /dev/sdb1
sudo vgcreate vg_ivolve /dev/sdb1
sudo lvcreate -L 2G -n lv_ivolve vg_ivolve
```

### 4. Create Filesystem and Mount the LV

```bash
sudo mkfs.ext4 /dev/vg_ivolve/lv_ivolve
sudo mkdir /mnt/lv_ivolve
sudo mount /dev/vg_ivolve/lv_ivolve /mnt/lv_ivolve
```

### 5. Extend the Volume Group and Logical Volume

```bash
sudo pvcreate /dev/sdb2
sudo vgextend vg_ivolve /dev/sdb2
sudo lvextend -L 5G /dev/vg_ivolve/lv_ivolve
sudo resize2fs /dev/vg_ivolve/lv_ivolve
```

## ✅ Expected Outcome

** Logical Volume "lv_ivolve" successfully extended to 5GB.
** Filesystem resized and mounted at /mnt/lv_ivolve.
** Disk managed and extended without data loss.

## 📌 Notes

** LVM allows dynamic volume management without service interruption
** resize2fs must be executed after lvextend to reflect the new size on the filesystem.
** Always check disk layout using lsblk, lvdisplay, vgs, and df -h.


