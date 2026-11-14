# Testing and Validation

Build completion, command availability, a successful smoke test and a passing package test suite are different claims. Keep them separate.

| Evidence | What it supports | What it does not prove |
|---|---|---|
| Command or file presence | A selected executable or path existed at collection time | Package provenance, completeness or test success |
| Compiler smoke test | One small program compiled, linked and ran | That GCC, Binutils, glibc or the full toolchain suites passed |
| Package test log | The outcomes recorded in that log | That every package test passed or no tests were skipped |
| Final boot evidence | The system reached a running userspace state | That every package test suite passed |
| systemd status capture | systemd's state at collection time | That every service or optional feature is correctly configured |

## Test counters

- `PASS` — tests reported as passed.
- `FAIL` — tests reported as failed.
- `SKIP` — tests not run.
- `XFAIL` / `XPASS` — expected-failure outcomes; interpret using that package's test framework.

A non-zero `FAIL` counter is a recorded test outcome, not automatically proof of a defective build. LFS 13.1-systemd documents some known, non-critical failures and directs readers to the official version-specific build logs. Compare exact test names before classifying a failure as expected or unexpected.

## Archived test evidence

The [testing evidence directory](../screenshots/07-testing-and-validation/README.md) contains the collected archive and its inspection notes. The archive inventory lists 171 paths, including 59 `test-suite.log` files and other DejaGNU summary files. This is an inventory of captured files, not proof that 171 packages were tested.

The [test archive audit](test-archive-audit.md) distinguishes failures explicitly documented by the book from outcomes that still need comparison with the official LFS 13.1 build logs. For example, `glibc/io/tst-lchmod` is explicitly documented as a known failure in the LFS chroot environment. The GCC instructions also list specific known non-critical test failures; aggregate counters alone are not enough to classify every GCC result.

The collector inventories existing logs; it does not rerun tests or certify success. Its summary filter is deliberately limited to test counters and test-result lines so generic configure output is not mistaken for test status.

The [compiler smoke-test record](../screenshots/03-toolchain/06-toolchain-test-results.txt) is a smoke test only, not a complete toolchain test suite.

## References

- [LFS 13.1-systemd — About the Test Suites](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter04/abouttestsuites.html)
- [LFS 13.1-systemd — Glibc 2.44](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/glibc.html)
- [Official LFS 13.1 build logs](https://www.linuxfromscratch.org/lfs/build-logs/13.1/)
