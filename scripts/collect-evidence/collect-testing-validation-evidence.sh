#!/usr/bin/env bash

# Linux From Scratch 13.1-systemd
# Inventory existing test logs; this script does not rerun tests.

set -Eeuo pipefail

OUTPUT_DIR="${1:-/root/testing-validation-evidence}"
mkdir -p "$OUTPUT_DIR"

search_paths=()
for directory in /sources /root; do
    if [[ -d "$directory" ]]; then
        search_paths+=("$directory")
    fi
done

inventory="$OUTPUT_DIR/01-test-log-inventory.txt"
summary="$OUTPUT_DIR/02-test-result-summary.txt"

{
    printf '%s\n' "LFS Test Log Inventory"
    printf '%s\n' "======================"
    printf '\n'
    if (( ${#search_paths[@]} > 0 )); then
        find "${search_paths[@]}" -type f \
            \( -name 'test-suite.log' -o -name 'test_summary' \
            -o -name 'test-summary.log' -o -name '*.sum' \) \
            -print 2>/dev/null | sort
    else
        printf '%s\n' "No search directories found."
    fi
} > "$inventory"

{
    printf '%s\n' "Package Test Result Summary"
    printf '%s\n' "==========================="
    printf '\n'

    while IFS= read -r logfile; do
        [[ -f "$logfile" ]] || continue
        printf '\nFile: %s\n' "$logfile"
        printf '%s\n' "----------------------------------------"
        grep -n -i -E \
            '(^|[[:space:]#])(TOTAL|PASS|FAIL|SKIP|XFAIL|XPASS):|tests passed|tests failed|test failures|test summary|result:|status:' \
            "$logfile" || printf '%s\n' "No recognized summary lines found."
    done < "$inventory"
} > "$summary"

{
    printf '%s\n' "LFS Testing and Validation Report"
    printf '%s\n' "================================="
    printf '\n'
    printf '%s\n' "Book: Linux From Scratch 13.1-systemd"
    printf 'Architecture: %s\n' "$(uname -m)"
    printf 'Kernel: %s\n' "$(uname -r)"
    printf '\nSearch locations:\n'
    if (( ${#search_paths[@]} > 0 )); then
        printf '%s\n' "${search_paths[@]}"
    else
        printf '%s\n' "None"
    fi
    printf '\nTest log count: '
    if (( ${#search_paths[@]} > 0 )); then
        find "${search_paths[@]}" -type f \
            \( -name 'test-suite.log' -o -name 'test_summary' \
            -o -name 'test-summary.log' -o -name '*.sum' \) \
            2>/dev/null | wc -l
    else
        printf '0\n'
    fi
    printf '\n%s\n' "This report inventories existing logs only."
    printf '%s\n' "It does not rerun tests or certify package-wide success."
} > "$OUTPUT_DIR/04-validation-report.txt"

printf 'Evidence inventory completed. Output: %s\n' "$OUTPUT_DIR"
