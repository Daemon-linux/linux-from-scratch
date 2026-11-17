# GCC 16.2.0 — test-suite outcomes

## Environment

- Project: Linux From Scratch 13.1-systemd
- Package: GCC / G++ 16.2.0
- LFS book section: 8.32 — GCC
- Test framework: DejaGNU

## Observed result

The archived summaries record:

| Test suite | FAIL entries | XPASS entries |
|---|---:|---:|
| C | 40 | 2 |
| C++ | 33 | 0 |

These are DejaGNU result entries, not counts of distinct failing source files or proof of an equivalent number of independent compiler defects.

### C test groups

The captured C failures include test groups named in the LFS book:

- `gcc.dg/ipa/pr122458.c`
- `gcc.dg/lto/toplevel-extended-asm-1` and `toplevel-simple-asm-1`
- Nested plugin crash tests
- i386 auto-initialization, memmove, memcpy, memset and other target-specific tests, including `memset-pr120683-*.c`

The archive also records these additional groups:

- `gcc.target/i386/memset-pr70308-1a.c` and `memset-pr70308-1b.c`
- `gcc.target/i386/pr125355-2.c` and `pr125355.c`
- `gcc.target/i386/xchg-4.c`

The additional groups are not individually listed in the book's known-failure note, but the project audit found the same failures in the official LFS 13.1 reference build log.

The book conditionally identifies `gcc.target/i386/shift-gf2p8affine-2.c` as a known failure when the processor does not support AVX512. The captured project evidence does not establish whether the build CPU supports AVX512, so that condition remains unverified.

### C++ test groups

The recorded C++ failures match groups listed in the book:

- `g++.target/i386/memset-pr108585-1a.C` and `memset-pr108585-1b.C`
- `g++.target/i386/mv-symbols*.C`
- `g++.target/i386/mvc-symbols*.C`
- `g++.target/i386/pr112824-2.C`
- `g++.target/i386/pr116896-1.C`

### XPASS interpretation

The two C XPASS entries are associated with nested plugin crash tests. XPASS means a test expected to fail instead passed. It is not an ordinary PASS and must remain separate from the FAIL count.

## Assessment

The official LFS 13.1 reference log reports the same aggregate GCC outcomes: 40 C FAIL entries, 33 C++ FAIL entries and two C XPASS entries. It also corroborates the named failure groups, including the additional C groups not individually enumerated in the book.

This comparison is strong evidence that the recorded pattern is also present in the published reference build. It does not prove that every machine has identical hardware-specific behavior or establish the cause of each individual test result.

The LFS book notes that its explicitly listed known failures are non-critical and discusses test assumptions involving build options such as `--enable-default-ssp` and `--enable-default-pie`. Do not automatically apply that explanation to test groups not individually discussed by the book.

## Resolution and verification

No independent GCC source patch or test-specific workaround is recorded for these outcomes. They are documented as test-suite results and compared against the book and official reference build log. The project archive contains summary excerpts rather than all original full GCC logs.

## References

- [LFS 13.1-systemd — GCC 16.2.0, Section 8.32](https://www.linuxfromscratch.org/lfs/view/13.1-systemd/chapter08/gcc.html)
- [Official LFS 13.1 GCC test log](https://www.linuxfromscratch.org/lfs/build-logs/13.1/i7-14700K/test-logs/830-gcc-16.2.0)
- [Project test archive audit](../docs/test-archive-audit.md)
