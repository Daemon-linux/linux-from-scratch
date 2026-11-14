# Test Archive Audit

**Scope:** Review of `screenshots/07-testing-and-validation/testing-validation-evidence.tar.gz`.

**Review method:** The archive was inspected without rerunning package tests. The review covers the four files stored in the archive: an inventory, a result-summary capture, an installed-system check capture and a validation report. The original package logs are not included in this archive, so this is an audit of captured summaries, not a reproduction of the test runs.

## Archive contents

| Archive member | Observation |
|---|---|
| `01-test-log-inventory.txt` | Lists 171 distinct paths found under `/sources` and `/root` |
| `02-test-result-summary.txt` | Grep-based excerpts from the listed files |
| `03-installed-system-checks.txt` | Captured versions and selected system checks |
| `04-validation-report.txt` | Validation metadata and a large captured result-summary section |

The inventory contains 59 files named `test-suite.log`; the remaining 112 entries are other summary formats, including DejaGNU `.sum` files and one GCC `test_summary`. Some DejaGNU paths are framework self-test fixtures rather than independent LFS package test runs. Therefore, 171 is an inventory-entry count, not a count of packages tested.

## Interpreting the recorded test outcomes

A non-zero `FAIL` counter is a recorded test outcome, not by itself proof that the LFS build is defective. The LFS 13.1-systemd book explicitly warns that some package test suites have known, non-critical failures and directs readers to the version-specific LFS build logs to determine whether failures are expected.

### glibc 2.44

The archive records `io/tst-lchmod` as a failing test. This exact test is explicitly listed by the LFS 13.1-systemd Glibc instructions as known to fail in the LFS chroot environment and usually safe to ignore. It should be documented as a book-documented expected failure, not as an unresolved project defect.

### GCC 16.2.0

The archive records 40 FAIL and 2 XPASS entries in the C tests, and 33 FAIL entries in the C++ tests. The LFS 13.1-systemd instructions explicitly list several known failures in the `gcc.target/i386` and `g++.target/i386` test groups, as well as selected LTO and compiler-plugin tests. The book states that the editors investigated those listed failures and confirmed that they do not indicate a critical issue.

The archived summary excerpt does not preserve enough individual test names here to establish that every one of the 73 FAIL entries matches the book's known-failure list. Therefore, the aggregate counts must not be described as either all expected or all unexpected. A name-by-name comparison against the full `.sum` files and the book's list is required before classifying the remaining entries. The two XPASS entries are a separate DejaGNU outcome and are not counted as ordinary PASS.

### Binutils 2.47

The archive records one `gprofng` failure: `tmpdir/gp-gmon`. The LFS book's general test-suite guidance says that some Binutils failures are known and non-critical, and points to the official LFS 13.1 build logs for the authoritative comparison. The evidence currently available here does not establish whether this exact test is listed as an expected failure in those logs. It is therefore classified as **needs comparison with the official 13.1 build log**, not as a confirmed project defect.

### ACL, Findutils, and Groff

The captured Automake-style summaries contain one FAIL each:

| Package / log | Total | Pass | Skip | XFAIL | Fail | XPASS | Failed test |
|---|---:|---:|---:|---:|---:|---:|---|
| ACL 2.4.0 — `test-suite.log` | 16 | 13 | 0 | 2 | 1 | 0 | `test/cp` |
| Findutils 4.11.0 — `gnulib-tests/test-suite.log` | 424 | 379 | 44 | 0 | 1 | 0 | `test-regex-el` |
| Groff 1.24.1 — `test-suite.log` | 316 | 297 | 14 | 4 | 1 | 0 | `src/preproc/eqn/tests/neqn-smoke-test.sh` |

These are recorded failures, but the summary archive alone does not establish their cause or whether they are among the expected outcomes in the official 13.1 build logs. They should be checked against those logs before being called defects or expected failures.

The other 56 captured `test-suite.log` summaries with recognizable Automake-style counters show `FAIL: 0`. This statement applies only to those captured log summaries; it does not imply that every package in LFS was tested.

## Captured environment

The installed-system check capture reports:

- Bash 5.3.0
- GCC / G++ 16.2.0
- GNU Binutils 2.47.20260726
- glibc 2.44
- GNU Make 4.4.1
- systemd 261.2

The same capture reports the compiler target as `x86_64-pc-linux-gnu`. The validation report separately records the LFS target triplet as `x86_64-lfs-linux-gnu`. These are different values; the native compiler target must not be presented as proof of the LFS cross-compiler target.

## Collection-quality issue

The archived summary files are unusually large (about 46 MB each when uncompressed). The collector's grep expression included generic `result:` and `status:` matches. Those expressions also match ordinary configure output such as `configure:... result: yes`, rather than only test outcomes.

The collector has been tightened so future summaries focus on test counters and PASS / FAIL / SKIP / XFAIL / XPASS result lines. Existing archive contents are preserved as historical evidence and are not rewritten.

## What this archive does not establish

- It does not contain the original full logs for the failed tests.
- It does not provide enough diagnostic output to determine the root cause of every listed failure.
- It does not show that each failed test was rerun after a change.
- It does not prove that every LFS package test suite was run.
- It does not support a claim that all tests passed, nor does a non-zero FAIL counter alone establish a defective LFS build.

## References

- [LFS 13.1-systemd, Section 4.6 — About the Test Suites](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter04/abouttestsuites.html)
- [LFS 13.1-systemd, Section 8.5 — Glibc 2.44](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/glibc.html)
- [Official LFS 13.1 build logs](https://www.linuxfromscratch.org/lfs/build-logs/13.1/)

The book recommends comparing recorded outcomes with the official build logs. Until the exact entries are matched, do not infer root causes or label them as project defects.
