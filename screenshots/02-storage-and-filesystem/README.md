# Storage and Filesystem

This section documents the storage architecture and filesystem configuration used for the Linux From Scratch 13.1-systemd build.

A dedicated virtual disk was assigned to the LFS environment to keep the build system separate from the Fedora guest operating system.

## Storage Overview

| Component | Configuration |
|---|---|
| Virtual Disk | `/dev/vdb` |
| LFS Partition | `/dev/vdb1` |
| Filesystem | ext4 |
| Filesystem Label | LFS |
| Mount Point | `/mnt/lfs` |
| Partition Capacity | 80 GB |

## Evidence

| File | Description |
|---|---|
| `01-disk-and-partition-layout.txt` | Displays the available disks, partition layout, filesystem types, UUIDs, and mount points. |
| `02-lfs-storage-capacity.txt` | Shows the total, used, and available storage capacity of the LFS partition. |
| `03-lfs-mount-configuration.txt` | Documents the active mount configuration of the LFS partition. |
| `04-lfs-root-directory.txt` | Shows the top-level directory structure of the LFS filesystem. |

## Design Considerations

- A dedicated partition isolates the LFS build environment from the Fedora guest system.
- The ext4 filesystem provides the storage environment for the LFS installation.
- The `/mnt/lfs` mount point serves as the root directory of the LFS build environment.

---

*This documentation records the storage configuration used during the project build.*
