# Screenshots & Build Evidence

This directory contains visual and technical evidence for **Linux From Scratch 13.1-systemd**. Its historical name is retained for link stability; contents include screenshots, text captures, configuration snapshots, scripts and archives.

## Evidence map

| Directory | Description |
|---|---|
| `01-build-environment/` | Fedora host/build VM and virtualization |
| `02-storage-and-filesystem/` | LFS disk, partition, filesystem and mount |
| `03-toolchain/` | Binutils, GCC and glibc evidence |
| `04-base-system/` | Base-system component evidence |
| `05-system-configuration/` | Hostname, locale, timezone and systemd |
| `06-kernel-and-bootloader/` | Kernel, modules, boot files and GRUB |
| `07-testing-and-validation/` | Test-log inventory and validation archive |
| `08-final-system/` | GRUB, first boot and final system state |
| `09-networking-and-system-audit/` | 30 networking/security command captures and audit README |

## Build reference

- Book: Linux From Scratch 13.1-systemd
- Architecture: x86_64
- LFS target triplet: `x86_64-lfs-linux-gnu`
- Host/build environment: Fedora 43 Workstation in KVM/QEMU

Official book: https://www.linuxfromscratch.org/lfs/view/13.1-systemd/

## Evidence interpretation

Captured output describes what was reported at collection time. A command-presence check is not a package test result, and a compiler smoke test is not a full toolchain test suite. See [testing methodology](../docs/testing-and-validation.md) and the [network/security audit](../docs/networking-and-security-audit.md).
