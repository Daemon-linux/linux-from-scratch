# LFS Build Process

This project follows **Linux From Scratch 13.1-systemd** on an x86_64 Fedora 43 environment running under KVM/QEMU. The dedicated LFS partition is ext4 and mounted at `/mnt/lfs`.

## Build phases

1. **Host preparation** — verify host tools, architecture, environment variables and prerequisites.
2. **Storage preparation** — prepare the dedicated LFS filesystem, mount it and establish the required directory layout and ownership.
3. **Temporary toolchain** — construct the cross-compilation toolchain and temporary utilities.
4. **Chroot transition** — enter the LFS filesystem as the build root.
5. **Base system** — compile and install the required user-space packages from source.
6. **System configuration** — configure users, locale, timezone, filesystems and systemd.
7. **Kernel and bootloader** — configure and build Linux, install modules and prepare GRUB.
8. **First boot and validation** — boot the resulting system and capture kernel, service and filesystem state.

See the [evidence index](../screenshots/README.md) for the records grouped by build stage.

## Reproducibility

This repository records one completed build; it is not an automated installer. Reproduction requires following the official [LFS 13.1-systemd book](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/) in order and adapting device names and resource allocation to the target environment. Captured command output is time-specific and may differ with later package and host versions.
