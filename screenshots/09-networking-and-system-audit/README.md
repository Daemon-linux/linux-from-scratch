# Networking and System Audit Evidence

This directory contains 30 individual text captures from the Phase 2 and Phase 3 read-only audit.

## File map

### Phase 2

1. `01-network-interfaces.txt`
2. `02-ip-addresses.txt`
3. `03-routing-table.txt`
4. `04-dns-resolution.txt`
5. `05-listening-sockets.txt`
6. `06-running-services.txt`
7. `07-failed-services.txt`
8. `08-user-accounts.txt`
9. `09-groups.txt`
10. `10-account-file-permissions.txt`
11. `11-sshd-enabled-state.txt`
12. `12-kernel-information.txt`
13. `13-os-release.txt`
14. `14-hostname.txt`

### Phase 3

15. `15-resolvectl-status.txt`
16. `16-resolved-service.txt`
17. `17-networkd-service.txt`
18. `18-resolv-conf.txt`
19. `19-resolved-conf.txt`
20. `20-network-config-file-list.txt`
21. `21-enabled-services.txt`
22. `22-systemd-security.txt`
23. `23-nftables-rules.txt`
24. `24-iptables-rules.txt`
25. `25-ipv4-forwarding.txt`
26. `26-ipv6-forwarding.txt`
27. `27-kernel-network-hardening.txt`
28. `28-login-definitions.txt`
29. `29-shell-umask.txt`
30. `30-system-users-shells.txt`

## Anonymization

The published captures retain technical lines, command output, errors, versions, configuration values, and service names. Identifying values are replaced consistently:

- Hardware MAC addresses: `<MAC_ADDRESS>` (the standard all-zero loopback value is retained)
- MAC-derived IPv6 link-local interface identifier: `fe80::[ANONYMIZED_INTERFACE_ID]/64`
- Machine ID: `<MACHINE_ID>`
- Boot ID: `<BOOT_ID>`
- Product UUID: `<PRODUCT_UUID>`
- systemd invocation IDs: `<INVOCATION_ID>`

Private IPv4 addresses, interface names, and the hostname `lfs` are retained because they are needed to understand the captured virtual-network topology. The original system was not modified.

## Evidence integrity

The Phase 3 collector's exit-status annotation has a logging defect and must not be treated as authoritative. Preserve the command output and document this limitation. The Phase 2 SSH unit lookup explicitly returned `not-found` with exit status 4.

See [the audit report](../../docs/networking-and-security-audit.md) for interpretation, limitations, and findings.
