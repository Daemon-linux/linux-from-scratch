# Testing and Validation

This directory contains the archived test evidence collected during the Linux From Scratch 13.1-systemd build.

## Evidence

| File | Description |
|---|---|
| `testing-validation-evidence.tar.gz` | Archive containing an inventory, grep-based test-result excerpts, installed-system checks and a validation report |

The archive contains summaries and inventory data, not the original full package logs. Its contents have been reviewed; see the [test archive audit](../../docs/test-archive-audit.md) for the recorded outcomes and limitations.

## Inspect the archive

List its members:

```bash
tar -tzf testing-validation-evidence.tar.gz
```

Extract it into a separate review directory:

```bash
mkdir -p test-evidence-review
tar -xzf testing-validation-evidence.tar.gz -C test-evidence-review
```

The inventory contains 171 paths: 59 `test-suite.log` files and 112 other summary-format files. Some DejaGNU entries are framework self-test fixtures, so this count must not be described as 171 packages tested.

The captured summaries include non-zero failures. Do not describe the package test results as universally passing. The archive does not include the full original logs needed to diagnose root causes or verify whether failed tests were rerun.

The [test-log inventory collector](../../scripts/collect-evidence/collect-testing-validation-evidence.sh) searches existing locations for known test-log formats. It does not rerun tests. See the [testing methodology](../../docs/testing-and-validation.md).
