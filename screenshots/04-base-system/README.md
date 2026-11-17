# Base System Evidence

This directory contains selected version captures and system-component evidence for the Linux From Scratch 13.1-systemd build.

## Evidence files

| File | Description |
|---|---|
| `01-core-utilities-versions.txt` | Captured versions of selected core utilities |
| `02-shell-and-tool-versions.txt` | Captured shell and development tool versions |
| `03-filesystem-utilities-versions.txt` | Captured filesystem utility versions |
| `04-system-library-versions.txt` | Original capture containing the glibc version and one unidentified version string |
| `04-pkgconf-version.txt` | Follow-up capture explicitly identifying Pkgconf 3.0.5 |
| `05-network-and-system-utilities.txt` | Captured network and system utility information |
| `06-installed-base-system-packages.txt` | Corrected explanation of the limits of the earlier presence checklist |

## Verified Pkgconf version

The follow-up capture in `04-pkgconf-version.txt` records the command and its output:

```text
Command: pkgconf --version
3.0.5
```

This confirms that the `pkgconf` command on the original LFS system reported version **3.0.5**, matching the version specified by the [LFS 13.1-systemd Pkgconf instructions](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/pkgconf.html).

The original `04-system-library-versions.txt` capture remains unchanged. Its unlabelled `3.0.5` value is still treated as unidentified on its own; the separate follow-up capture provides the explicit command-to-version evidence.

## Presence checks versus tests

The previous checklist used command/file-presence probes. It did not run package test suites, and some probes were not reliable package-identification checks. Its former statement that all packages were “installed and tested” has been removed.

Run the [component presence checker](../../scripts/collect-evidence/check-base-system.sh) for a fresh report of selected commands and paths. A presence result is not proof of package provenance, package completeness or test-suite success.
