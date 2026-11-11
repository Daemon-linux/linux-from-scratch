# Linux From Scratch

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=20&duration=2800&pause=900&color=38BDF8&center=true&vCenter=true&width=750&lines=Building+Linux+from+Source;Understanding+the+Linux+System+Internals;From+Toolchain+to+Bootable+System" alt="Typing SVG" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PROJECT-LINUX%20FROM%20SCRATCH-38BDF8?style=for-the-badge&logo=linux&logoColor=white" />
  <img src="https://img.shields.io/badge/ARCHITECTURE-x86__64-0D1117?style=for-the-badge" />
  <img src="https://img.shields.io/badge/BUILD-SYSTEMD-0D1117?style=for-the-badge" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/STATUS-IN%20PROGRESS-orange?style=flat-square" />
  <img src="https://img.shields.io/badge/ENVIRONMENT-Fedora%2043-294172?style=flat-square&logo=fedora&logoColor=white" />
  <img src="https://img.shields.io/badge/VIRTUALIZATION-KVM%2FQEMU-38BDF8?style=flat-square" />
</p>

---

## `01` / PROJECT OVERVIEW

**Linux From Scratch (LFS)** is a hands-on project focused on building a complete Linux system directly from source code.

Instead of installing a prebuilt distribution, this project follows the Linux From Scratch book to construct the system step by step — from the initial toolchain to a functional Linux environment.

The main objective is to understand how Linux distributions are assembled, how their core components interact, and how a minimal Linux system operates internally.

## `02` / PROJECT OBJECTIVES

- Build a Linux system entirely from source.
- Understand cross-compilation and toolchain construction.
- Explore the GNU toolchain and core system utilities.
- Understand the Linux filesystem hierarchy.
- Study system libraries, linking, and dynamic loading.
- Configure the kernel and system boot process.
- Understand system initialization with systemd.
- Document build procedures, test results, and troubleshooting.

## `03` / BUILD ENVIRONMENT

| Component | Configuration |
|---|---|
| Host OS | Fedora 43 Workstation |
| Virtualization | KVM / QEMU |
| Architecture | x86_64 |
| Target Triplet | `x86_64-lfs-linux-gnu` |
| Build Method | Cross-compilation and native compilation |
| Build System | LFS with systemd |
| Build Directory | `/mnt/lfs` |
| Build User | `lfs` |

## `04` / BUILD PROCESS

The project follows the structure of the official LFS book.

| Stage | Description |
|---|---|
| Preparation | Host environment and build prerequisites |
| Temporary Toolchain | Cross-compiler and temporary system tools |
| Chroot Environment | Entering the isolated LFS build environment |
| Base System | Building essential system packages |
| System Configuration | Configuring users, filesystems, and system services |
| Kernel | Linux kernel configuration and compilation |
| Bootloader | Preparing the bootable system |


## `05` / TECHNOLOGIES & COMPONENTS

<p align="center">
  <img src="https://img.shields.io/badge/Linux-Systems-FCC624?style=for-the-badge&logo=linux&logoColor=black" />
  <img src="https://img.shields.io/badge/GNU-Toolchain-A42E2B?style=for-the-badge&logo=gnu&logoColor=white" />
  <img src="https://img.shields.io/badge/GCC-Compiler-00599C?style=for-the-badge&logo=c&logoColor=white" />
  <img src="https://img.shields.io/badge/Bash-Shell-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" />
  <img src="https://img.shields.io/badge/systemd-Init_System-000000?style=for-the-badge&logo=systemd&logoColor=white" />
</p>

### Core Components

| Component | Technologies |
|---|---|
| GNU Toolchain | GCC, Binutils, GNU Make |
| C Library | glibc |
| Shell | Bash |
| Core Utilities | Coreutils, Findutils, Grep, Sed, Gawk |
| System Libraries | Readline, Libcap |
| Build Tools | Make, Bison, M4, Flex |
| System Initialization | systemd |
| Kernel | Linux |

### Technical Focus

- Cross-compilation and toolchain construction
- Compilation from source code
- Shared libraries and dynamic linking
- Filesystem hierarchy and system configuration
- Package testing and troubleshooting
- Linux kernel and system initialization
## `06` / DOCUMENTATION & TROUBLESHOOTING

This repository documents the actual build process, including:

- Build commands and configuration details.
- Package versions and dependencies.
- Test-suite results and failures.
- Compilation and linking issues.
- Root-cause analysis and applied fixes.
- Important configuration files and system changes.

The goal is not only to record successful builds, but also to understand why failures happen and how they are resolved.

## `07` / CURRENT PROGRESS

<badge color="warning">In Progress</badge>

The base system construction is underway.

Current work includes building and validating essential system components, running package test suites, and resolving build-related issues.

Progress is documented incrementally as the project develops.

## `08` / ENGINEERING APPROACH

```text
Source Code
     |
     v
Build Toolchain
     |
     v
Compile Packages
     |
     v
Test & Validate
     |
     v
Configure System
     |
     v
Bootable Linux
```

Every component is built and examined to understand its role in the operating system.

**Build · Inspect · Test · Understand**

---

<p align="center">
  <strong>Building Linux to understand Linux.</strong>
  <br />
  <sub>Daemon-linux | Linux From Scratch Project</sub>
</p>
