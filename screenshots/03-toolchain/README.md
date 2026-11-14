# Toolchain Evidence

This section records compiler, assembler/linker and C library information captured during the project.

## Evidence

| File | Description |
|---|---|
| `01-binutils-version.txt` | Captured GNU ld and GNU assembler version output |
| `02-gcc-version.txt` | Captured GCC and G++ version output |
| `03-glibc-version.txt` | Captured glibc version string |
| `04-toolchain-target.txt` | Native compiler/assembler target reported by the captured output |
| `05-compiler-configuration.txt` | GCC configuration and target information |
| `06-toolchain-test-results.txt` | One minimal compile-link-execute smoke test |

## Target distinction

The captured compiler configuration and assembler output report `x86_64-pc-linux-gnu`. The LFS project target triplet is separately recorded as `x86_64-lfs-linux-gnu`. The captured files do not establish that the reported native compiler was the cross-compiler or the final LFS compiler. Do not present the native target as proof of the LFS target toolchain.

The smoke test demonstrates only that one small program compiled, linked and ran in the environment where it was executed. It is not a substitute for GCC, Binutils, glibc or complete LFS package test suites.
