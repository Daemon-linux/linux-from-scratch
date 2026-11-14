# Project Scripts

Executable evidence collectors are maintained here, separately from their captured output.

## Evidence collectors

See [collect-evidence/](collect-evidence/README.md) for the script inventory and execution notes.

## Safety

- Review each script before running it.
- Run it in the environment it is intended to inspect.
- Confirm the output directory before execution; the default paths are under `/root/`.
- Some collectors require root privileges to read system configuration and boot files.
- These scripts collect information. They are not installers and do not rerun package test suites unless explicitly stated.
