# Glibc 2.44 — `io/tst-lchmod`

## Environment

- Project: Linux From Scratch 13.1-systemd
- Package: glibc 2.44
- Build target: `x86_64-lfs-linux-gnu`
- LFS book section: 8.5 — Glibc

## Observed result

The captured Glibc test summary includes:

```text
FAIL: io/tst-lchmod
```

The project troubleshooting history records that the Glibc test run initially had multiple environment-related failures while the chroot's virtual filesystems were being corrected. After the environment was corrected and the tests were rerun, `io/tst-lchmod` remained as the recorded failure.

## Assessment

The LFS 13.1-systemd book explicitly identifies `io/tst-lchmod` as a known failure in the LFS chroot environment.

This means the remaining test result must not be presented as proof that the Glibc build is defective. The book's note is the basis for this classification; this report does not claim an independently established root cause beyond that documented limitation.

## Resolution and verification

The chroot environment was corrected and the test suite was rerun. The remaining `io/tst-lchmod` failure was retained in the result record rather than being hidden or reported as a pass.

The available archive is a summary/inventory bundle and does not include every original full test log. This report therefore preserves the known outcome and its book comparison without claiming a new reproduction.

## References

- [LFS 13.1-systemd — Glibc 2.44, Section 8.5](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/glibc.html)
- [Project test archive audit](../docs/test-archive-audit.md)
- [Archived testing evidence](../screenshots/07-testing-and-validation/README.md)
