# Evidence Collection Scripts

These scripts collect selected information from the system where they are executed.

| Script | Purpose |
|---|---|
| `check-base-system.sh` | Checks selected command and path presence; not a package manifest or test runner |
| `collect-kernel-bootloader-evidence.sh` | Captures kernel, modules, boot files and GRUB information |
| `collect-testing-validation-evidence.sh` | Inventories existing package test logs and extracts recognizable counters |
| `collect-final-system-evidence.sh` | Captures final system, kernel, systemd and filesystem state |

## Execution

The scripts default to output directories under `/root/`. Run them with appropriate privileges inside the LFS system, or provide an alternate output directory as the first argument where supported.

Review each script before execution. Captured reports may contain machine-specific details such as disk names, mount points, hostnames and hardware information.

These are collectors, not installers. They do not modify the bootloader or kernel configuration. The testing collector does not rerun package test suites.
