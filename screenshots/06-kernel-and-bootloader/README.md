# Kernel and Bootloader

This directory contains evidence of the Linux kernel configuration and bootloader setup for the Linux From Scratch 13.1-systemd system.

## Scope

- Linux kernel image and version information
- Kernel configuration and installed modules
- Boot directory contents
- GRUB version, installation files and configuration

## Evidence files

| File | Description |
|---|---|
| `01-kernel-version.txt` | Installed kernel images and module directory versions |
| `02-kernel-configuration.txt` | Linux kernel configuration |
| `03-kernel-modules.txt` | Installed kernel module inventory |
| `04-boot-files.txt` | Boot and EFI directory contents |
| `05-grub-version-and-installation.txt` | GRUB version and installation evidence |
| `06-grub-configuration.txt` | GRUB bootloader configuration |

The [kernel and bootloader collector](../../scripts/collect-evidence/collect-kernel-bootloader-evidence.sh) gathers a fresh snapshot. Review its output before publishing it; configuration and device paths are machine-specific.

This evidence records installed files and configuration. Successful boot is documented separately in the [final-system evidence](../08-final-system/README.md).
