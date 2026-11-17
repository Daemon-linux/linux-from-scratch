# Troubleshooting

This directory records issues and test outcomes observed during this Linux From Scratch 13.1-systemd build. The reports distinguish between a confirmed build problem, a test failure explicitly documented by the LFS book, and an outcome whose cause has not been established.

## Reports

| Report | Observed item | Assessment |
|---|---|---|
| [Glibc 2.44](glibc-2.44-tst-lchmod.md) | `io/tst-lchmod` | Known failure explicitly documented for the LFS chroot environment |
| [Binutils 2.47](binutils-2.47-gprofng.md) | `tmpdir/gp-gmon` | Matches the gprofng test failure documented by LFS |
| [GCC 16.2.0](gcc-16.2.0-test-results.md) | C and C++ DejaGNU summaries | Compared with the book and official LFS reference log; includes known failures and separately reported XPASS results |
| [Other documented package test failures](other-known-test-failures.md) | ACL, Findutils and Groff | Recorded failures match package-specific notes in the LFS book |

## Evidence and interpretation

The primary evidence for these reports is the archived test-evidence bundle:

- [Testing evidence archive and inspection notes](../screenshots/07-testing-and-validation/README.md)
- [Full test archive audit](../docs/test-archive-audit.md)
- [Testing and validation methodology](../docs/testing-and-validation.md)

The archive contains inventories and extracted result summaries, not every original full package log. The audit compares captured test names with the LFS 13.1-systemd book and, where available, the official LFS 13.1 reference build logs.

## Reporting rules

- A failing test is not automatically evidence of a defective build.
- A failure documented by the LFS book must be identified as such.
- Keep `FAIL`, `XFAIL` and `XPASS` distinct; they are not interchangeable.
- Do not infer a root cause from a test name alone.
- Do not claim a test was rerun or fixed unless the repository contains evidence of that rerun.
- Where the original full log or host-specific information is unavailable, state the limitation.

No separate incident report has been added for a generic chroot or mount failure: the available project evidence supports the Glibc test's documented chroot limitation, but does not preserve enough detail to claim a distinct mount incident with a verified root cause and resolution.
