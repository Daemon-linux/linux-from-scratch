#!/usr/bin/env bash

# Check selected commands and paths in the currently running LFS environment.
# This is a presence check only; it does not identify every installed package
# and does not run package test suites.

set -Eeuo pipefail

OUTPUT_FILE="${1:-/root/base-system-evidence/06-system-component-presence.txt}"
OUTPUT_DIRECTORY="$(dirname "$OUTPUT_FILE")"
mkdir -p "$OUTPUT_DIRECTORY"

commands=(
    bash gcc g++ ld as make
    find grep sed awk
    ls cp mv rm install
    tar gzip xz zstd
    mount findmnt lsblk
    ip ping systemctl
    grub-install grub-probe modprobe
    python3 perl
)

paths=(
    /etc/passwd /etc/group /etc/fstab /etc/hosts /etc/protocols
    /bin /lib /usr /var
)

{
    printf '%s\n' "LFS selected component presence report"
    printf '%s\n' "======================================"
    printf 'Collection time: %s\n' "$(date --iso-8601=seconds)"
    printf 'Architecture: %s\n' "$(uname -m)"
    printf 'Kernel: %s\n' "$(uname -r)"
    printf '\n%s\n' "Command checks (command -v)"
    printf '%s\n' "---------------------------"

    command_found=0
    command_missing=0

    for command_name in "${commands[@]}"; do
        if command_path="$(command -v "$command_name" 2>/dev/null)"; then
            printf '[FOUND] %-18s %s\n' "$command_name" "$command_path"
            command_found=$((command_found + 1))
        else
            printf '[MISSING] %s\n' "$command_name"
            command_missing=$((command_missing + 1))
        fi
    done

    printf '\n%s\n' "Path checks"
    printf '%s\n' "-----------"

    path_found=0
    path_missing=0

    for path_name in "${paths[@]}"; do
        if [[ -e "$path_name" ]]; then
            printf '[FOUND] %s\n' "$path_name"
            path_found=$((path_found + 1))
        else
            printf '[MISSING] %s\n' "$path_name"
            path_missing=$((path_missing + 1))
        fi
    done

    printf '\n%s\n' "Summary"
    printf '%s\n' "-------"
    printf 'Commands found: %d\n' "$command_found"
    printf 'Commands missing: %d\n' "$command_missing"
    printf 'Paths found: %d\n' "$path_found"
    printf 'Paths missing: %d\n' "$path_missing"
    printf '\n'
    printf '%s\n' "Presence checks only: this report does not prove package"
    printf '%s\n' "provenance, package completeness or test-suite success."
} > "$OUTPUT_FILE"

cat "$OUTPUT_FILE"
