# Kernel and Bootloader

This directory contains evidence of the Linux kernel configuration and bootloader setup for the Linux From Scratch 13.1-systemd system.

## Scope

This section documents the kernel and bootloader components, including:

- Linux kernel image and version information
- Kernel configuration
- Installed kernel modules
- Boot directory contents
- GRUB version and installation files
- GRUB boot configuration

## Evidence Files

| File | Description |
|---|---|
| `01-kernel-version.txt` | Installed kernel images and module directory versions |
| `02-kernel-configuration.txt` | Linux kernel configuration |
| `03-kernel-modules.txt` | Installed kernel module inventory |
| `04-boot-files.txt` | Boot and EFI directory contents |
| `05-grub-version-and-installation.txt` | GRUB version and installation evidence |
| `06-grub-configuration.txt` | GRUB bootloader configuration |

## Build Reference

- **Distribution:** Linux From Scratch
- **Book Version:** 13.1-systemd
- **Architecture:** x86_64
- **Target Triplet:** `x86_64-lfs-linux-gnu`

These files document the kernel and bootloader setup of the resulting LFS system.

Note: This evidence records installed files and configuration. It does not independently prove that the system successfully booted.
