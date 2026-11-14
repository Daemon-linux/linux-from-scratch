# Testing and Validation

This directory contains the archived test evidence collected during the Linux From Scratch 13.1-systemd build.

## Evidence

| File | Description |
|---|---|
| `testing-validation-evidence.tar.gz` | Archive of collected test and validation material |

The [test-log inventory collector](../../scripts/collect-evidence/collect-testing-validation-evidence.sh) searches existing locations for known test-log formats. It does not rerun tests.

## Inspect the archive

Before relying on the archive for a package-wide summary, inspect its file list:

```bash
tar -tzf testing-validation-evidence.tar.gz
```

Extract it into a separate review directory:

```bash
mkdir -p test-evidence-review
tar -xzf testing-validation-evidence.tar.gz -C test-evidence-review
```

The archive is retained as collected evidence, but its contents have not been individually audited during this repository cleanup. Do not infer that every test passed from the archive's existence.

Review each package's original log and preserve PASS, FAIL, SKIP, XFAIL and XPASS counts. See [the testing methodology](../../docs/testing-and-validation.md).
