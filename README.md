# Linux From Scratch — 13.1-systemd

<p align="center">
  <img src="https://img.shields.io/badge/PROJECT-LINUX%20FROM%20SCRATCH-38BDF8?style=for-the-badge&logo=linux&logoColor=white" alt="Linux From Scratch project" />
  <img src="https://img.shields.io/badge/ARCHITECTURE-x86__64-2563EB?style=for-the-badge" alt="x86_64 architecture" />
  <img src="https://img.shields.io/badge/INIT-SYSTEMD-475569?style=for-the-badge&logo=systemd&logoColor=white" alt="systemd" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/STATUS-BOOTED%20%26%20DOCUMENTED-15803D?style=flat-square" alt="Booted and documented" />
  <img src="https://img.shields.io/badge/HOST-FEDORA%2043-294172?style=flat-square&logo=fedora&logoColor=white" alt="Fedora 43" />
  <img src="https://img.shields.io/badge/VIRTUALIZATION-KVM%20%2F%20QEMU-0E7490?style=flat-square" alt="KVM and QEMU" />
</p>

A hands-on build of a complete Linux system from source, following the **Linux From Scratch 13.1-systemd** book. The project covers the build environment, toolchain, base user space, system configuration, Linux kernel, GRUB and first boot.

## Project status

**System built and booted.** The repository contains evidence of the final system boot, running kernel, systemd state, filesystem layout and GRUB configuration.

This status describes the existence of a bootable system; it does **not** mean every package test suite passed. Test results are documented separately and must be interpreted from their original logs.

## Projects

| Project | Description | Status |
|---|---|---|
| [Linux From Scratch](https://github.com/Daemon-linux/linux-from-scratch) | Building a Linux system from source | **Completed** |
| Homelab Infrastructure | VMware ESXi and nested virtualization | In Progress |
| Networking Labs | Routing, switching and network labs | Planned |
| Linux Administration | Linux administration and troubleshooting | In Progress |
| Cybersecurity Labs | Defensive security and hardening | Planned |
| Automation Labs | Bash, Python and infrastructure automation | Planned |
| Technical Notes | Technical documentation and notes | Active |

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

See [the build reference](references/BUILD-REFERENCE.md) and [build environment evidence](screenshots/01-build-environment/README.md).

## Build stages and evidence

| Stage | Contents |
|---|---|
| [01 — Build environment](screenshots/01-build-environment/README.md) | Fedora environment, KVM/QEMU VM and allocated resources |
| [02 — Storage and filesystem](screenshots/02-storage-and-filesystem/README.md) | Dedicated LFS disk, partition, ext4 and mount point |
| [03 — Toolchain](screenshots/03-toolchain/README.md) | Captured Binutils/GCC/glibc information and compiler smoke test |
| [04 — Base system](screenshots/04-base-system/README.md) | Selected component versions and presence-check methodology |
| [05 — System configuration](screenshots/05-system-configuration/README.md) | Hostname, locale, timezone, mounts, systemd and shell |
| [06 — Kernel and bootloader](screenshots/06-kernel-and-bootloader/README.md) | Kernel configuration, modules, boot files and GRUB |
| [07 — Testing and validation](screenshots/07-testing-and-validation/README.md) | Existing test-log inventory and validation limitations |
| [08 — Final system](screenshots/08-final-system/README.md) | GRUB menu, first boot and final system state |
| [09 — Networking and security baseline audit](screenshots/09-networking-and-system-audit/README.md) | 30 anonymized network/security command captures and audit report |

The `screenshots/` directory retains its historical name, but includes text captures, scripts and archives as well as images.

## Technical documentation

- [Build process](docs/build-process.md)
- [Boot process: firmware, GRUB, kernel and systemd](docs/boot-process.md)
- [ELF binaries and dynamic linking](docs/elf-and-dynamic-linking.md)
- [Testing and validation methodology](docs/testing-and-validation.md)
- [Networking and security baseline audit](docs/networking-and-security-audit.md)
- [Troubleshooting](troubleshooting/README.md)
- [Project sources](references/sources.md)

## Technical focus

- Cross-compilation and toolchain construction
- GNU Binutils, GCC and glibc
- ELF executables, shared libraries and dynamic linking
- Filesystem hierarchy and system configuration
- Linux kernel configuration and modules
- GRUB bootloader and system initialization with systemd
- Test-log interpretation and troubleshooting
- Networking, name resolution, service state and security-baseline evidence

## Evidence policy

- Captured output records what a command reported at collection time.
- A command-presence check is not proof that a package test suite passed.
- A compiler's native target is not automatically the LFS target triplet.
- Test failures, skips and incomplete records must not be relabeled as successful results.
- The networking/security audit is read-only; it is not a penetration test or security certification.
- The LFS book itself is not included; use the official [LFS 13.1-systemd book](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/).

## License

Original repository materials are licensed under [GPL-3.0-only](LICENSE). Project copyright and third-party licensing notes are recorded in [NOTICE](NOTICE). The LFS book and upstream software remain subject to their own copyright and license terms; see [the build reference](references/BUILD-REFERENCE.md).

---

<p align="center"><strong>Build · Inspect · Test · Understand</strong></p>
