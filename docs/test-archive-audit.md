# Test Archive Audit

**Scope:** Review of `screenshots/07-testing-and-validation/testing-validation-evidence.tar.gz`.

**Book baseline:** Linux From Scratch 13.1-systemd, dated September 1, 2026. This audit compares the exact captured test names with the package-specific instructions in Chapter 8 and the general guidance in Section 4.6.

**Review method:** The archive was inspected without rerunning package tests. The archive contains an inventory, grep-based result excerpts, installed-system checks, and a validation report. It does not contain every original full test log. This is therefore a comparison of recorded outcomes with the book, not a reproduction of the test runs.

## Archive contents

| Archive member | Observation |
|---|---|
| `01-test-log-inventory.txt` | Lists 171 distinct paths found under `/sources` and `/root` |
| `02-test-result-summary.txt` | Grep-based excerpts from the listed files |
| `03-installed-system-checks.txt` | Captured versions and selected system checks |
| `04-validation-report.txt` | Validation metadata and a large captured result-summary section |

The inventory contains 59 files named `test-suite.log`; the remaining 112 entries are other summary formats, including DejaGNU `.sum` files and one GCC `test_summary`. Some DejaGNU paths are framework self-test fixtures rather than independent LFS package test runs. In particular, the archived paths under `/sources/dejagnu-1.6.3/build/testsuite/report-card.all/` are DejaGNU's own report-card test fixtures (including deliberately named `one-fail`, `basic-a`, and `basic-b` cases); their synthetic FAIL lines are not failures from an LFS package test suite and are excluded from the package-failure assessment. Therefore, 171 is an inventory-entry count, not a count of packages tested.

## Failures explicitly documented by LFS 13.1-systemd

The following recorded failures match the book's package-specific known-failure notes:

| Package | Recorded failure | Book comparison | Classification |
|---|---|---|---|
| ACL 2.4.0 | `test/cp.run` (the archived excerpt shortens this to `test/cp`) | Section 8.27 explicitly says this test is known to fail because Coreutils is not built with ACL support yet; the official 13.1 reference log records the same FAIL | **Confirmed known failure** |
| Findutils 4.11.0 | `test-regex-el` | Section 8.63 explicitly says this test is known to fail | **Confirmed known failure** |
| Groff 1.24.1 | `src/preproc/eqn/tests/neqn-smoke-test.sh` | Section 8.64 explicitly says `neqn-smoke-test.sh` is known to fail | **Confirmed known failure** |
| Binutils 2.47 | `tmpdir/gp-gmon` | Section 8.22 says one test related to gprofng is known to fail; the official 13.1 reference log records this exact FAIL as the gprofng test failure | **Confirmed match to the documented gprofng failure** |
| glibc 2.44 | `io/tst-lchmod` | Section 8.5 explicitly says this test is known to fail in the LFS chroot environment | **Confirmed known failure** |

These outcomes must not be reported as demonstrated defects in the LFS build. For ACL, the book gives the specific reason: Coreutils is not built with ACL support yet at the point ACL is tested.

## GCC 16.2.0: exact comparison

The archive contains 40 FAIL result entries in the C summary and 33 FAIL result entries in the C++ summary. It also contains two XPASS entries in the C summary. These are DejaGNU result entries, not 73 distinct failing test programs.

### C tests

The following recorded test names match the known-failure list in Section 8.32:

- `gcc.dg/ipa/pr122458.c`
- `gcc.dg/lto/toplevel-extended-asm-1` and `gcc.dg/lto/toplevel-simple-asm-1`
- `gcc.dg/plugin/crash-test-nested-ice.c` and `gcc.dg/plugin/crash-test-nested-write-through-null.c`
- `gcc.target/i386/auto-init-padding-9.c`
- `gcc.target/i386/builtin-memmove-12.c` and `builtin-memmove-13.c`
- `gcc.target/i386/memcpy-pr120683-*.c`
- `gcc.target/i386/memset-pr120683-*.c`
- `gcc.target/i386/pr111657-1.c`
- `gcc.target/i386/pr115102.c`
- `gcc.target/i386/pr116896.c`
- `gcc.target/i386/pr120881-2a.c`
- `gcc.target/i386/pr122343-4a.c`

The book additionally says `gcc.target/i386/shift-gf2p8affine-2.c` is known to fail **if the processor does not support AVX512**. The archive records this failure, but the captured evidence does not establish whether the CPU supports AVX512. Its classification is therefore **conditionally documented; CPU capability not verified**.

The following three C test-name groups are not individually enumerated in the book's known-failure list:

- `gcc.target/i386/memset-pr70308-1a.c` and `memset-pr70308-1b.c`
- `gcc.target/i386/pr125355-2.c` and `pr125355.c`
- `gcc.target/i386/xchg-4.c`

However, all three groups appear as FAIL entries in the official LFS 13.1 GCC reference log for GCC 16.2.0 on the i7-14700K build host. They are therefore **corroborated by the official reference build log**, although they are not individually named in the book's known-failure list. This is the comparison Section 8.32 directs builders to perform. The reference host is not the user's host, so this comparison does not prove identical hardware-specific causes.

The two XPASS entries are separate DejaGNU outcomes for the nested plugin crash tests. XPASS means an outcome expected to fail instead passed; it must not be added to the FAIL count or described as an ordinary PASS. The book's known-failure note does not itself classify these two XPASS entries.

### C++ tests

All recorded C++ failure test names match groups explicitly listed in Section 8.32:

- `g++.target/i386/memset-pr108585-1a.C` and `memset-pr108585-1b.C`
- `g++.target/i386/mv-symbols*.C`
- `g++.target/i386/mvc-symbols*.C`
- `g++.target/i386/pr112824-2.C`
- `g++.target/i386/pr116896-1.C`

The multiple FAIL entries for a single source file arise from separate test variants / checks in DejaGNU. The book says these named groups are known to fail and that the LFS editors investigated them and found no critical issue.

### GCC conclusion

The official LFS 13.1 reference log records the same aggregate GCC outcomes as this archive: 40 unexpected failures in the C suite, 33 in the C++ suite, and two unexpected successes in the C suite. Its named C and C++ FAIL entries match the names summarized from the user's archive, including the three C groups not individually listed in the book. This is strong corroboration that the observed result pattern is also present in the official reference build; it is not a guarantee that all machines will produce identical outcomes.

The book says the failures in its explicit known-failure list are non-critical; most are due to test authors not anticipating `--enable-default-ssp` or `--enable-default-pie`. For the additional C groups, the evidence supports the narrower conclusion that the same failures occur in the official 13.1 reference log. Do not extend the book's specific explanation to tests it does not name.

The two XPASS outcomes remain separate from the 40 FAIL count. The official reference log also records the two XPASS outcomes for the nested plugin crash tests. XPASS is not an ordinary PASS and should be reported independently.

## Other captured test-suite summaries

The 59 `test-suite.log` captures with recognizable Automake-style counters include the three package logs listed above with non-zero FAIL. The other 56 captured summaries show `FAIL: 0`. This applies only to those captured log summaries; it does not imply that every package in LFS was tested.

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

## Official reference-log comparison and remaining limits

The official LFS 13.1 build-log index publishes a reference build for an Intel Core i7-14700K host. Its package test logs corroborate these exact outcomes:

- ACL 2.4.0: `FAIL: test/cp.run` (with two separate XFAIL results).
- Binutils 2.47: `FAIL: tmpdir/gp-gmon`.
- GCC 16.2.0: the same 40 C FAIL and 33 C++ FAIL aggregate counts, the same named test groups, and two separate XPASS outcomes.
- Findutils 4.11.0: `FAIL: test-regex-el`.
- Groff 1.24.1: `FAIL: src/preproc/eqn/tests/neqn-smoke-test.sh`.

The official Glibc test log is too large for the web retrieval interface to inspect in this review; the specific `io/tst-lchmod` result is nevertheless explicitly documented by Section 8.5 of the 13.1-systemd book as a known failure in the LFS chroot.

These comparisons establish that the same named failures occur in the published reference build. They do not prove identical causes on different host hardware or establish the AVX512 capability of the user's build CPU. The GCC `shift-gf2p8affine-2.c` failure remains conditional in the book on lack of AVX512 support; the archive does not contain a CPU feature capture sufficient to resolve that condition.

The archive itself contains inventories and grep-based excerpts, not every original full package log needed for root-cause diagnosis. It also does not prove that every LFS package test suite was run or support a claim that all tests passed. A non-zero FAIL counter alone does not establish a defective LFS build.

## References

- [LFS 13.1-systemd — About the Test Suites](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter04/abouttestsuites.html)
- [LFS 13.1-systemd — ACL 2.4.0](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/acl.html)
- [LFS 13.1-systemd — Binutils 2.47](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/binutils.html)
- [LFS 13.1-systemd — GCC 16.2.0](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/gcc.html)
- [LFS 13.1-systemd — Glibc 2.44](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/glibc.html)
- [LFS 13.1-systemd — Findutils 4.11.0](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/findutils.html)
- [LFS 13.1-systemd — Groff 1.24.1](https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter08/groff.html)
- [Official LFS 13.1 build-log index](https://www.linuxfromscratch.org/lfs/build-logs/13.1/)
- [Official Binutils 2.47 test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/820-binutils-2.47)
- [Official ACL 2.4.0 test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/825-acl-2.4.0)
- [Official GCC 16.2.0 test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/830-gcc-16.2.0)
- [Official Findutils 4.11.0 test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/861-findutils-4.11.0)
- [Official Groff 1.24.1 test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/862-groff-1.24.1)

Section 4.6 directs builders to the official 13.1 build logs to verify failures not explicitly listed as known. That comparison has now been performed for the package logs above; the Glibc reference log remains unreadable through the retrieval interface, while its named failure is directly documented in Section 8.5.
