# Project Sources

| Source | Purpose |
|---|---|
| [Linux From Scratch 13.1-systemd](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/) | Primary build instructions and package sequence |
| [Linux Kernel Documentation](https://docs.kernel.org/) | Kernel configuration, interfaces and behavior |
| [systemd Documentation](https://www.freedesktop.org/software/systemd/man/) | Init system, units, targets and service management |
| [GNU Project](https://www.gnu.org/) | GNU toolchain and core utilities |
| [GNU Binutils documentation](https://sourceware.org/binutils/docs/) | Assembler, linker and binary inspection tools |
| [GCC documentation](https://gcc.gnu.org/onlinedocs/) | Compiler behavior and options |

## Build reference

- Book edition: **Linux From Scratch 13.1-systemd**
- Architecture: `x86_64`
- LFS target triplet: `x86_64-lfs-linux-gnu`
- Host/build environment: Fedora 43 Workstation in KVM/QEMU
- LFS build root: `/mnt/lfs`

The captured compiler configuration reports `x86_64-pc-linux-gnu`. That value is preserved as the native compiler target reported by the capture and must not be confused with the LFS target triplet above.

Update this file when additional upstream documentation is used. Record exact package versions and relevant book sections when they affect a build decision.
