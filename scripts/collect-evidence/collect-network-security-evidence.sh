#!/usr/bin/env bash
# Read-only LFS networking/security evidence collector.
# Writes raw output only to the selected output directory.
set -u

OUTPUT_DIR="${1:-$PWD/lfs-network-security-evidence-raw}"
mkdir -p -- "$OUTPUT_DIR" || exit 1
OUTPUT_DIR="$(cd -- "$OUTPUT_DIR" && pwd -P)" || exit 1

capture() {
    local filename="$1"
    shift
    local status
    {
        printf 'Command:'
        printf ' %q' "$@"
        printf '\n\n'
        if "$@" 2>&1; then
            status=0
        else
            status=$?
        fi
        printf '\nExit status: %d\n' "$status"
    } > "$OUTPUT_DIR/$filename"
}

capture 01-network-interfaces.txt ip -br link
capture 02-ip-addresses.txt ip -br address
capture 03-routing-table.txt ip route show
capture 04-dns-resolution.txt getent hosts example.com
capture 05-listening-sockets.txt ss -tulpn
capture 06-running-services.txt systemctl list-units --type=service --state=running --no-pager
capture 07-failed-services.txt systemctl --failed --no-pager
capture 08-user-accounts.txt getent passwd
capture 09-groups.txt getent group
capture 10-account-file-permissions.txt stat /etc/passwd /etc/group /etc/shadow
capture 11-sshd-enabled-state.txt systemctl is-enabled sshd
capture 12-kernel-information.txt uname -a
capture 13-os-release.txt cat /etc/os-release
capture 14-hostname.txt hostnamectl status

capture 15-resolvectl-status.txt resolvectl status
capture 16-resolved-service.txt systemctl status systemd-resolved --no-pager
capture 17-networkd-service.txt systemctl status systemd-networkd --no-pager
capture 18-resolv-conf.txt bash -c 'printf "resolv.conf symlink:\n"; readlink /etc/resolv.conf; printf "\nresolv.conf contents:\n"; cat /etc/resolv.conf'
capture 19-resolved-conf.txt cat /etc/systemd/resolved.conf
capture 20-network-config-file-list.txt find /etc/systemd/network -maxdepth 1 -type f -print
capture 21-enabled-services.txt systemctl list-unit-files --state=enabled --no-pager
capture 22-systemd-security.txt systemd-analyze security --no-pager
capture 23-nftables-rules.txt nft list ruleset
capture 24-iptables-rules.txt iptables-save
capture 25-ipv4-forwarding.txt sysctl net.ipv4.ip_forward
capture 26-ipv6-forwarding.txt sysctl net.ipv6.conf.all.forwarding
capture 27-kernel-network-hardening.txt sysctl net.ipv4.conf.all.rp_filter net.ipv4.conf.all.accept_redirects net.ipv4.conf.all.send_redirects net.ipv4.conf.all.accept_source_route net.ipv6.conf.all.accept_redirects
capture 28-login-definitions.txt cat /etc/login.defs
capture 29-shell-umask.txt bash -c umask
capture 30-system-users-shells.txt awk -F: '$7 !~ /(false|nologin)$/ {print $1 ":" $7}' /etc/passwd

{
    printf 'LFS Networking and Security Evidence Collection\n\n'
    printf 'Collected: '
    date --iso-8601=seconds
    printf 'Hostname: '
    hostname
    printf 'Kernel: '
    uname -r
    printf '\nRead-only collection; no system configuration was changed.\n'
} > "$OUTPUT_DIR/collection-metadata.txt"

if command -v sha256sum >/dev/null 2>&1; then
    (cd -- "$OUTPUT_DIR" && sha256sum -- *.txt > SHA256SUMS)
else
    printf 'sha256sum unavailable; checksums not generated.\n' > "$OUTPUT_DIR/SHA256SUMS"
fi

printf 'Raw evidence written to: %s\n' "$OUTPUT_DIR"
printf 'Review and anonymize the output before publishing.\n'
