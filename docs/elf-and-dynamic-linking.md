# ELF and Dynamic Linking

Linux executables and shared libraries on x86_64 commonly use the **Executable and Linkable Format (ELF)**. Understanding ELF is useful when building and debugging Binutils, GCC, glibc and the LFS user space.

## Key concepts

- **ELF header** identifies the object type, architecture and entry point.
- **Program headers** describe segments used when an executable is loaded.
- **Section headers** describe link-time sections such as `.text`, `.data` and `.dynamic`.
- **Dynamic section** records runtime dependencies and loader-related metadata.
- **Shared objects** (`.so`) provide code that can be loaded by multiple processes.
- **Program interpreter** (usually the dynamic linker) loads shared objects and prepares a dynamically linked program for execution.

The executable records its required shared libraries and, for dynamically linked binaries, the path to its program interpreter. The dynamic linker resolves dependencies using the system's library search configuration and applicable environment settings.

## Inspection commands

```bash
file /bin/bash
readelf -h /bin/bash
readelf -l /bin/bash
readelf -d /bin/bash
readelf -l /bin/bash | grep interpreter
objdump -p /bin/bash | grep NEEDED
```

Use `readelf` and `objdump` to inspect ELF metadata without executing the target binary. Use `ldd` only on trusted executables; depending on the binary and implementation, invoking it can execute code.

## Why this matters to LFS

The toolchain, C library, dynamic loader and shared libraries must agree on architecture, ABI and filesystem layout. A mismatch can prevent a program from starting even when the executable exists and has execute permission.

This is a technical guide, not a claim that every binary in the final system has undergone a complete dependency audit.
