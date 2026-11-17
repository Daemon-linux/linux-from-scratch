# Binutils 2.47 — gprofng test result

## Environment

- Project: Linux From Scratch 13.1-systemd
- Package: Binutils 2.47
- LFS book section: 8.22 — Binutils

## Observed result

The captured test result contains:

```text
FAIL: tmpdir/gp-gmon
```

This is the gprofng-related test failure identified during review of the archived test evidence.

## Assessment

The LFS 13.1-systemd book notes that one test related to gprofng is known to fail. The official LFS 13.1 reference build log records the same `tmpdir/gp-gmon` failure.

The captured result therefore matches the documented reference outcome. It should not be described as a confirmed Binutils build defect.

## Resolution and verification

No independent corrective change is recorded for this test. The failure is retained and classified by comparison with the LFS book and official reference log. The project archive does not contain the complete original Binutils test log needed for a deeper root-cause investigation.

## References

- [LFS 13.1-systemd — Binutils 2.47, Section 8.22](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/binutils.html)
- [Official LFS 13.1 Binutils test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/820-binutils-2.47)
- [Project test archive audit](../docs/test-archive-audit.md)
