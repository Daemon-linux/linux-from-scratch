
#!/bin/bash

# Linux From Scratch 13.1-systemd
# Testing and Validation Evidence Collection

set -u

OUTPUT_DIR="/root/testing-validation-evidence"

mkdir -pv "$OUTPUT_DIR"

# Search locations for existing test logs.
SEARCH_PATHS=()

for directory in /sources /root; do
    if [ -d "$directory" ]; then
        SEARCH_PATHS+=("$directory")
    fi
done

# 01 - Inventory of existing test logs
{
    echo "LFS Test Log Inventory"
    echo "======================"
    echo

    if [ "${#SEARCH_PATHS[@]}" -gt 0 ]; then
        find "${SEARCH_PATHS[@]}" -type f \
            \( -name 'test-suite.log' \
            -o -name 'test_summary' \
            -o -name 'test-summary.log' \
            -o -name '*.sum' \) \
            -print 2>/dev/null | sort
    else
        echo "No search directories found."
    fi
} > "$OUTPUT_DIR/01-test-log-inventory.txt" 2>&1


# 02 - Extract test result summaries
{
    echo "Package Test Result Summary"
    echo "==========================="
    echo

    while IFS= read -r logfile; do
        [ -f "$logfile" ] || continue

        echo
        echo "File: $logfile"
        echo "----------------------------------------"

        grep -n -i -E \
            '(^|[[:space:]#])(TOTAL|PASS|FAIL|SKIP|XFAIL|XPASS):|tests passed|tests failed|test failures|test summary|result:|status:' \
            "$logfile" || echo "No recognized summary lines found."

    done < "$OUTPUT_DIR/01-test-log-inventory.txt"

} > "$OUTPUT_DIR/02-test-result-summary.txt" 2>&1


# 03 - Installed system utility checks
{
    echo "Installed System Checks"
    echo "======================="
    echo

    check_command() {
        command_name="$1"

        echo
        echo "--- $command_name ---"

        if command -v "$command_name" >/dev/null 2>&1; then
            case "$command_name" in
                bash|gcc|g++|ld|make|find|grep|sed|coreutils|systemctl)
                    "$command_name" --version 2>&1 | head -n 3
                    ;;
                getconf)
                    getconf GNU_LIBC_VERSION 2>&1
                    ;;
                *)
                    command -v "$command_name"
                    ;;
            esac
        else
            echo "Command not found: $command_name"
        fi
    }

    check_command bash
    check_command gcc
    check_command g++
    check_command ld
    check_command make
    check_command find
    check_command grep
    check_command sed
    check_command getconf
    check_command systemctl

    echo
    echo "--- Compiler Target ---"
    if command -v gcc >/dev/null 2>&1; then
        gcc -dumpmachine
    else
        echo "GCC not found."
    fi

} > "$OUTPUT_DIR/03-installed-system-checks.txt" 2>&1


# 04 - Validation report
{
    echo "LFS Testing and Validation Report"
    echo "================================="
    echo

    echo "Book: Linux From Scratch 13.1-systemd"
    echo "Architecture: x86_64"
    echo "Target: x86_64-lfs-linux-gnu"
    echo

    echo "Search locations:"
    printf '%s\n' "${SEARCH_PATHS[@]}"
    echo

    echo "Available test log count:"
    find "${SEARCH_PATHS[@]}" -type f \
        \( -name 'test-suite.log' \
        -o -name 'test_summary' \
        -o -name 'test-summary.log' \
        -o -name '*.sum' \) \
        2>/dev/null | wc -l

    echo
    echo "Collected result summary:"
    if [ -f "$OUTPUT_DIR/02-test-result-summary.txt" ]; then
        grep -E 'TOTAL:|PASS:|FAIL:|SKIP:|XFAIL:|XPASS:' \
            "$OUTPUT_DIR/02-test-result-summary.txt" || \
            echo "No standard test counters were extracted."
    fi

    echo
    echo "Note:"
    echo "This report inventories existing evidence."
    echo "It does not rerun tests or independently certify test success."

} > "$OUTPUT_DIR/04-validation-report.txt" 2>&1


echo
echo "Evidence collection completed."
echo "Output directory: $OUTPUT_DIR"
echo

ls -lh "$OUTPUT_DIR"

