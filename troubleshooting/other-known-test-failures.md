# Other package test failures documented by LFS

This report groups three additional failures found in the archived test evidence. Each recorded test name matches a package-specific known-failure note in the LFS 13.1-systemd book.

## ACL 2.4.0

**Observed test:**

```text
FAIL: test/cp.run
```

LFS Section 8.27 explains that this test is expected to fail at this point because Coreutils has not been built with ACL support yet. The official LFS 13.1 reference log records the same failure.

**Assessment:** Confirmed match to a book-documented, stage-dependent test failure. It is not evidence by itself of a defective ACL build.

Reference: [LFS 13.1-systemd — ACL 2.4.0, Section 8.27](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/acl.html).

## Findutils 4.11.0

**Observed test:**

```text
FAIL: test-regex-el
```

LFS Section 8.63 explicitly identifies this test as a known failure. The official LFS 13.1 reference log records the same result.

**Assessment:** Confirmed match to a documented known failure.

Reference: [LFS 13.1-systemd — Findutils 4.11.0, Section 8.63](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/findutils.html).

## Groff 1.24.1

**Observed test:**

```text
FAIL: src/preproc/eqn/tests/neqn-smoke-test.sh
```

LFS Section 8.64 explicitly identifies `neqn-smoke-test.sh` as a known failure. The official LFS 13.1 reference log records the same result.

**Assessment:** Confirmed match to a documented known failure.

Reference: [LFS 13.1-systemd — Groff 1.24.1, Section 8.64](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/groff.html).

## Scope and limitations

These reports classify the observed test outcomes; they do not claim that the tests were independently reproduced or fixed. The archived project bundle contains summary excerpts and an inventory, not every original full package test log.

For the complete comparison, including archive limitations and official reference-log details, see the [project test archive audit](../docs/test-archive-audit.md).
