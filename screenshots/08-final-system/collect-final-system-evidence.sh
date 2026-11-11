
#!/bin/bash

# Linux From Scratch 13.1-systemd
# Final System Evidence Collection

set -u

OUTPUT_DIR="/root/final-system-evidence"

mkdir -pv "$OUTPUT_DIR"

# 01 - Final system information
{
    echo "--- Operating System ---"
    cat /etc/os-release 2>/dev/null || true

    echo
    echo "--- Architecture ---"
    uname -m

    echo
    echo "--- Hostname ---"
    hostname

    echo
    echo "--- CPU Information ---"
    lscpu 2>/dev/null || true
} > "$OUTPUT_DIR/01-final-system-information.txt" 2>&1


# 02 - Running kernel and uptime
{
    echo "--- Running Kernel ---"
    uname -a

    echo
    echo "--- Kernel Release ---"
    uname -r

    echo
    echo "--- System Uptime ---"
    uptime

    echo
    echo "--- Boot Time ---"
    who -b 2>/dev/null || true
} > "$OUTPUT_DIR/02-running-kernel-and-uptime.txt" 2>&1


# 03 - Systemd status
{
    echo "--- Systemd Version ---"
    systemctl --version

    echo
    echo "--- Default Target ---"
    systemctl get-default

    echo
    echo "--- Failed Units ---"
    systemctl --failed --no-pager

    echo
    echo "--- Running Services ---"
    systemctl list-units \
        --type=service \
        --state=running \
        --no-pager
} > "$OUTPUT_DIR/03-systemd-status.txt" 2>&1


# 04 - Filesystem and storage
{
    echo "--- Block Devices ---"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,LABEL,MOUNTPOINTS

    echo
    echo "--- Filesystem Usage ---"
    df -hT

    echo
    echo "--- Mounted Filesystems ---"
    findmnt
} > "$OUTPUT_DIR/04-filesystem-and-storage.txt" 2>&1


# 05 - Final root filesystem structure
{
    echo "--- Root Directory ---"
    ls -lah /

    echo
    echo "--- Main System Directories ---"
    find / -maxdepth 1 -type d -printf '%f\n' | sort

    echo
    echo "--- Standard Directory Symlinks ---"
    ls -ld /bin /lib /sbin 2>/dev/null || true
} > "$OUTPUT_DIR/05-final-directory-structure.txt" 2>&1


# 06 - Project completion summary
{
    echo "Linux From Scratch Project Completion"
    echo "====================================="
    echo
    echo "Book: Linux From Scratch 13.1-systemd"
    echo "Architecture: x86_64"
    echo "Target: x86_64-lfs-linux-gnu"
    echo "Host: Fedora 43 Workstation"
    echo "Virtualization: KVM/QEMU"
    echo
    echo "Final system information was collected."
    echo "See the accompanying evidence files for details."
    echo
    echo "Collection date:"
    date --iso-8601=seconds

} > "$OUTPUT_DIR/06-project-completion.txt" 2>&1


echo
echo "Final system evidence collection completed."
echo "Output directory: $OUTPUT_DIR"
echo

ls -lh "$OUTPUT_DIR"

