# Linux From Scratch — 13.1-systemd

<p align="center">
  <img src="https://img.shields.io/badge/PROJECT-LINUX%20FROM%20SCRATCH-38BDF8?style=for-the-badge&logo=linux&logoColor=white" alt="Linux From Scratch project" />
  <img src="https://img.shields.io/badge/ARCHITECTURE-x86__64-2563EB?style=for-the-badge" alt="x86_64 architecture" />
  <img src="https://img.shields.io/badge/INIT-SYSTEMD-475569?style=for-the-badge&logo=systemd&logoColor=white" alt="systemd" />
</p>

A hands-on build of a complete Linux system from source, following the **Linux From Scratch 13.1-systemd** book.

## Project status

**System built and booted.** The repository documents the build environment, toolchain, base system, system configuration, kernel, GRUB, first boot, test-log review, and a read-only networking/security baseline audit.

This status does **not** mean every package test suite passed. Test results are documented separately and interpreted from their original logs.

## Build environment

| Component | Configuration |
|---|---|
| Book | Linux From Scratch 13.1-systemd |
| Host / build VM | Fedora 43 Workstation |
| Virtualization | KVM / QEMU |
| Architecture | x86_64 |
| LFS target triplet | `x86_64-lfs-linux-gnu` |
| LFS build root | `/mnt/lfs` |
| Build user | `lfs` |
| Filesystem | ext4 |
| Init system | systemd |

## Build stages and evidence

| Stage | Contents |
|---|---|
| [01 — Build environment](screenshots/01-build-environment/README.md) | Host and build VM |
| [02 — Storage and filesystem](screenshots/02-storage-and-filesystem/README.md) | LFS disk, partition and ext4 |
| [03 — Toolchain](screenshots/03-toolchain/README.md) | Binutils, GCC and glibc evidence |
| [04 — Base system](screenshots/04-base-system/README.md) | Base-system component evidence |
| [05 — System configuration](screenshots/05-system-configuration/README.md) | Hostname, locale, timezone and systemd |
| [06 — Kernel and bootloader](screenshots/06-kernel-and-bootloader/README.md) | Kernel, modules and GRUB |
| [07 — Testing and validation](screenshots/07-testing-and-validation/README.md) | Test-log inventory and limitations |
| [08 — Final system](screenshots/08-final-system/README.md) | First boot and final system state |
| [09 — Networking and system audit](screenshots/09-networking-and-system-audit/README.md) | 30 raw text captures, anonymized identifiers and audit report |

The `screenshots/` directory retains its historical name but also contains text captures and scripts.

## Technical documentation

- [Build process](docs/build-process.md)
- [Boot process](docs/boot-process.md)
- [ELF and dynamic linking](docs/elf-and-dynamic-linking.md)
- [Testing and validation](docs/testing-and-validation.md)
- [Networking and security baseline audit](docs/networking-and-security-audit.md)
- [Troubleshooting](troubleshooting/README.md)
- [Build reference](references/BUILD-REFERENCE.md)

## Evidence policy

- Captured output records what a command reported at collection time.
- A command-presence check is not proof that a package test suite passed.
- Test failures, skips and incomplete records are not relabeled as successful results.
- The network/security audit is read-only and does not claim penetration testing, firewall verification, or production readiness.
- The LFS book itself is not included; see the official [LFS 13.1-systemd book](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/).

## License

Original repository materials are licensed under [GPL-3.0-only](LICENSE). See [NOTICE](NOTICE) for third-party licensing notes.
