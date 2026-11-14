# Final System Evidence

This directory documents the final Linux From Scratch 13.1-systemd system and its captured boot and runtime state.

## Evidence files

| File | Description |
|---|---|
| `01-grub-boot-menu.png` | GRUB menu showing the LFS boot entry |
| `02-first-look-after-boot.png` | First-look image captured after boot |
| `01-final-system-information.txt` | Operating system, architecture and CPU information |
| `02-running-kernel-and-uptime.txt` | Running kernel and uptime |
| `03-systemd-status.txt` | systemd version, default target and service state |
| `04-filesystem-and-storage.txt` | Block devices, filesystems and mount information |
| `05-final-directory-structure.txt` | Top-level filesystem structure |
| `06-project-completion.txt` | Build reference and evidence collection summary |

The [final-system collector](../../scripts/collect-evidence/collect-final-system-evidence.sh) can collect a fresh runtime snapshot. Review its output for host-specific information before publishing.

## Project status

The captured records document a booted LFS system and its runtime state. This supports the claim that the resulting system reached userspace. It does not imply that every package test suite passed; see [Testing and Validation](../07-testing-and-validation/README.md).
