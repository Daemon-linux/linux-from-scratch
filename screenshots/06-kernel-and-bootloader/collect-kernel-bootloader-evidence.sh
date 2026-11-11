
#!/bin/bash

# Linux From Scratch 13.1-systemd
# Kernel and Bootloader Evidence Collection

set -u

OUTPUT_DIR="/root/kernel-bootloader-evidence"

mkdir -pv "$OUTPUT_DIR"

# 01 - Kernel version and installed kernel images
{
    echo "Linux Kernel Images:"
    find /boot -maxdepth 1 -type f \
        \( -name 'vmlinuz*' -o -name 'Image*' \) \
        -printf '%f\n' | sort

    echo
    echo "Installed Kernel Module Directories:"
    if [ -d /lib/modules ]; then
        find /lib/modules -mindepth 1 -maxdepth 1 \
            -type d -printf '%f\n' | sort
    else
        echo "/lib/modules not found"
    fi
} > "$OUTPUT_DIR/01-kernel-version.txt" 2>&1


# 02 - Kernel configuration
{
    echo "Kernel Configuration Files:"

    found=0

    for config in /boot/config-*; do
        if [ -f "$config" ]; then
            found=1
            echo
            echo "Configuration file: $config"
            cat "$config"
        fi
    done

    if [ "$found" -eq 0 ]; then
        echo "No /boot/config-* files found."
    fi
} > "$OUTPUT_DIR/02-kernel-configuration.txt" 2>&1


# 03 - Installed kernel modules
{
    echo "Installed Kernel Modules:"

    if [ -d /lib/modules ]; then
        find /lib/modules -type f \
            \( -name '*.ko' -o -name '*.ko.xz' -o -name '*.ko.zst' \) \
            -printf '%p\n' | sort

        echo
        echo "Module Directory Sizes:"
        du -sh /lib/modules/* 2>/dev/null
    else
        echo "/lib/modules not found"
    fi
} > "$OUTPUT_DIR/03-kernel-modules.txt" 2>&1


# 04 - Boot and EFI files
{
    echo "--- /boot directory ---"
    ls -lah /boot

    echo
    echo "--- EFI directory ---"

    if [ -d /boot/efi ]; then
        find /boot/efi -maxdepth 4 -type f -print
    else
        echo "No /boot/efi directory"
    fi
} > "$OUTPUT_DIR/04-boot-files.txt" 2>&1


# 05 - GRUB version and installation files
{
    echo "--- GRUB version ---"

    if command -v grub-install >/dev/null 2>&1; then
        grub-install --version
    else
        echo "grub-install command not found"
    fi

    echo
    echo "--- GRUB probe version ---"

    if command -v grub-probe >/dev/null 2>&1; then
        grub-probe --version
    else
        echo "grub-probe command not found"
    fi

    echo
    echo "--- GRUB installation files ---"

    if [ -d /boot/grub ]; then
        find /boot/grub -maxdepth 3 -type f -print
    else
        echo "/boot/grub directory not found"
    fi
} > "$OUTPUT_DIR/05-grub-version-and-installation.txt" 2>&1


# 06 - GRUB configuration
{
    echo "--- GRUB configuration ---"

    if [ -f /boot/grub/grub.cfg ]; then
        cat /boot/grub/grub.cfg
    else
        echo "grub.cfg not found"
    fi
} > "$OUTPUT_DIR/06-grub-configuration.txt" 2>&1


echo
echo "Evidence collection completed."
echo "Output directory: $OUTPUT_DIR"
echo
ls -lh "$OUTPUT_DIR"

