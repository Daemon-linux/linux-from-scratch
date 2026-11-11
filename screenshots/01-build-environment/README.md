# Host Environment & Virtualization

This directory contains screenshots documenting the host operating system, virtualization platform, and hardware resources allocated to the virtual machine used for the Linux From Scratch (LFS) build.

The purpose of these screenshots is to provide a clear overview of the infrastructure and environment in which the LFS system was built.

## Screenshots

### 01. Host System — `host-system.png`

Shows the host operating system and its system information.

This screenshot documents the physical host environment running the virtualization platform.

### 02. Virtualization Platform — `virtualization-platform.png`

Shows the virtualization platform used for this project.

The LFS build environment runs inside a virtual machine managed through KVM/QEMU and libvirt.

### 03. Virtual Machine Information — `virtual-machine-info.png`

Shows the virtual machine configuration and general information, including its name, state, operating system type, and virtualization details where available.

This helps identify the specific virtual machine used for the LFS build.

### 04. Resource Allocation — `resource-allocation.png`

Shows the hardware resources assigned to the virtual machine, including:

- **CPU:** Allocated virtual processors.
- **Memory:** Assigned RAM.
- **Storage:** Virtual disk configuration and capacity.

These resources define the virtual hardware available to the Fedora guest operating system during the LFS build process.

## Build Environment Overview

| Component | Description |
|---|---|
| Host OS | Fedora 43 |
| Virtualization | KVM / QEMU |
| Management | libvirt / Virtual Machine Manager |
| Guest OS | Fedora 43 |
| Target Architecture | x86_64 |
| Project | Linux From Scratch 13.1-systemd |

## Notes

These screenshots document the initial build infrastructure. They are provided as supporting evidence and do not represent the final LFS system configuration.

Hardware resource allocation and system configuration may change during the project.
