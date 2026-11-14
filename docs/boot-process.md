# Linux Boot Process

This document describes the general boot path relevant to the LFS system. Exact firmware behavior depends on whether the VM uses BIOS or UEFI; consult the captured boot and GRUB evidence before making a claim about a particular firmware path.

## Boot stages

1. **Platform firmware** initializes virtual hardware and selects a boot device.
2. **GRUB** loads its configuration, presents the boot entry and loads the selected Linux kernel. Do not assume an initramfs is used unless it appears in the boot evidence.
3. **Linux kernel** initializes memory management and devices, discovers storage, mounts the root filesystem and starts the configured initial userspace process.
4. **systemd (PID 1)** becomes the first userspace process and activates units and dependencies required to reach the configured target.
5. **System services and login** provide the userspace environment after the system reaches its target.

## Evidence

- [Kernel and GRUB evidence](../screenshots/06-kernel-and-bootloader/README.md)
- [GRUB boot menu and first-boot records](../screenshots/08-final-system/README.md)

## Useful inspection commands

```bash
uname -a
cat /proc/cmdline
ps -p 1 -o pid,comm,args
systemctl get-default
systemctl --failed --no-pager
findmnt /
```

These commands inspect the running kernel, kernel command line, PID 1, default systemd target, failed units and root mount. They do not prove that every boot configuration path is correct.
