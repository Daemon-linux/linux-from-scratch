# Evidence Collection Scripts

These scripts collect selected information from the system where they are executed.

| Script | Purpose |
|---|---|
| `check-base-system.sh` | Checks selected command and path presence; not a package manifest or test runner |
| `collect-kernel-bootloader-evidence.sh` | Captures kernel, modules, boot files and GRUB information |
| `collect-testing-validation-evidence.sh` | Inventories existing package test logs and extracts recognizable counters |
| `collect-final-system-evidence.sh` | Captures final system, kernel, systemd and filesystem state |
| `collect-network-security-evidence.sh` | Read-only collection of 30 networking/security command outputs with correct exit-status capture |
| `anonymize-audit-evidence.py` | Writes anonymized copies of text evidence without modifying originals |

## Network/security evidence

Run the collector with Bash and an optional output directory:

```bash
bash scripts/collect-evidence/collect-network-security-evidence.sh /path/to/raw-evidence
```

The collector writes raw output, collection metadata, and a SHA256 checksum manifest. It does not change system configuration. Raw captures may contain machine-specific identifiers; create a separate anonymized copy before publishing:

```bash
python3 scripts/collect-evidence/anonymize-audit-evidence.py /path/to/raw-evidence /path/to/anonymized-evidence
```

Review every anonymized file manually. Do not overwrite the originals.

## General execution

Review each script before execution. Captured reports may contain host-specific details such as disk names, mount points, hostnames and hardware information. These scripts are collectors, not installers.
