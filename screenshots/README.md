# Screenshots & Build Evidence

This directory contains visual and technical evidence for **Linux From Scratch 13.1-systemd**. Its historical name is retained for link stability, but the contents include screenshots, text captures, configuration snapshots, scripts and an archive.

## Evidence map

| Directory | Description |
|---|---|
| `01-build-environment/` | Fedora host/build VM, virtualization platform and allocated resources |
| `02-storage-and-filesystem/` | Dedicated LFS disk, partition, filesystem and mount configuration |
| `03-toolchain/` | Captured Binutils, GCC and glibc information and a compiler smoke test |
| `04-base-system/` | Selected base-system component versions and presence-check limitations |
| `05-system-configuration/` | Hostname, locale, timezone, mounts, systemd and shell settings |
| `06-kernel-and-bootloader/` | Kernel configuration, modules, boot files and GRUB |
| `07-testing-and-validation/` | Existing test-log inventory and validation archive |
| `08-final-system/` | GRUB menu, first boot and final system state |
| `09-networking-and-system-audit/` | 30 individual network/security command captures, anonymized identifiers and audit documentation |

## Build reference

- Book: Linux From Scratch 13.1-systemd
- Architecture: x86_64
- LFS target triplet: `x86_64-lfs-linux-gnu`
- Host/build environment: Fedora 43 Workstation in KVM/QEMU

Official book: https://www.linuxfromscratch.org/lfs/view/13.1-systemd/

## Evidence interpretation

Captured output describes what was reported at collection time. A command-presence check is not a package test result, and a compiler smoke test is not a full toolchain test suite. The compiler capture reporting `x86_64-pc-linux-gnu` is kept distinct from the LFS target triplet. See [the testing methodology](../docs/testing-and-validation.md).

The test archive is retained as collected; its contents should be inspected before drawing package-wide conclusions.

The networking/security evidence is a read-only baseline snapshot, not a penetration test or a firewall verification. See the [networking and security audit](../docs/networking-and-security-audit.md) for scope and limitations.
