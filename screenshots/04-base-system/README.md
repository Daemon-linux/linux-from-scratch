# Base System Evidence

This directory contains selected version captures and system-component evidence for the Linux From Scratch 13.1-systemd build.

## Evidence files

| File | Description |
|---|---|
| `01-core-utilities-versions.txt` | Captured versions of selected core utilities |
| `02-shell-and-tool-versions.txt` | Captured shell and development tool versions |
| `03-filesystem-utilities-versions.txt` | Captured filesystem utility versions |
| `04-system-library-versions.txt` | Original capture containing the glibc version and one unidentified version string |
| `05-network-and-system-utilities.txt` | Captured network and system utility information |
| `06-installed-base-system-packages.txt` | Corrected explanation of the limits of the earlier presence checklist |

## Unidentified version string

The original `04-system-library-versions.txt` capture contains:

```text
glibc 2.44
3.0.5
```

The LFS 13.1-systemd book specifies **Pkgconf 3.0.5** ([official package instructions](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/pkgconf.html)). This makes Pkgconf a plausible explanation for the unlabelled `3.0.5` value, but the captured file does not include the command or package name. The value is therefore preserved as unidentified and is not counted as verified Pkgconf evidence. If the original LFS system is still available, confirm it with `pkgconf --version` and retain the command alongside its output.

## Presence checks versus tests

The previous checklist used command/file-presence probes. It did not run package test suites, and some probes were not reliable package-identification checks. Its former statement that all packages were “installed and tested” has been removed.

Run the [component presence checker](../../scripts/collect-evidence/check-base-system.sh) for a fresh report of selected commands and paths. A presence result is not proof of package provenance, package completeness or test-suite success.
