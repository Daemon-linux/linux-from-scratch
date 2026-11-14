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

## Package test-suite summaries

The 59 `test-suite.log` captures with recognizable Automake-style counters include three logs with a non-zero `FAIL` count:

| Package / log | Total | Pass | Skip | XFAIL | Fail | XPASS |
|---|---:|---:|---:|---:|---:|---:|
| ACL 2.4.0 — `test-suite.log` | 16 | 13 | 0 | 2 | 1 | 0 |
| Findutils 4.11.0 — `gnulib-tests/test-suite.log` | 424 | 379 | 44 | 0 | 1 | 0 |
| Groff 1.24.1 — `test-suite.log` | 316 | 297 | 14 | 4 | 1 | 0 |

The other 56 captured `test-suite.log` summaries show `FAIL: 0`. This statement applies only to those captured log summaries; it does not imply that every package in LFS was tested.

Failed test names recorded in those three logs:

- ACL: `test/cp`
- Findutils: `test-regex-el`
- Groff: `src/preproc/eqn/tests/neqn-smoke-test.sh`

## Additional DejaGNU summary entries

The archive also contains these failed entries in package-specific `.sum` files:

| Component | Captured file | Failed entries |
|---|---|---:|
| GCC 16.2.0 C tests | `build/gcc/testsuite/gcc/gcc.sum` | 40 FAIL, 2 XPASS |
| GCC 16.2.0 C++ tests | `build/gcc/testsuite/g++/g++.sum` | 33 FAIL |
| Binutils 2.47 | `build/gprofng/gprofng.sum` | 1 FAIL |
| glibc 2.44 | `build/io/subdir-tests.sum` and `build/tests.sum` | 1 unique failing test |

Notable names in the captured summaries:

- GCC C: i386 code-generation and assembly checks, LTO link tests, and compiler-plugin crash-test checks.
- GCC C++: i386 `memset` function-body checks and IFUNC / multiversion assembly checks.
- Binutils: `tmpdir/gp-gmon`.
- glibc: `io/tst-lchmod` (listed in both a subdirectory summary and the top-level summary; counted once here).

These are counts of failed DejaGNU result entries, not package-level test-suite totals. The two GCC C `XPASS` entries are unexpected-pass outcomes and should remain distinct from ordinary PASS results.

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
- It does not provide enough diagnostic output to determine the root cause of any listed failure.
- It does not show that each failed test was rerun after a change.
- It does not prove that every LFS package test suite was run.
- It does not support a claim that all tests passed.

For root-cause analysis, retain or collect the original package logs and relevant build output for each failed test. Until then, report the test names and recorded outcomes without guessing at causes.
