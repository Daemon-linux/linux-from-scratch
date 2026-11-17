# Networking and Security Baseline Audit

## 1. Overview

This document records a read-only networking and security baseline review of the Linux From Scratch (LFS) 13.1-systemd system built for this project. The captured system identifies itself as Linux From Scratch, runs on x86_64, and reported kernel `7.1.8`. The virtual machine uses KVM/QEMU.

The purpose is to document the system as built, not to apply custom hardening. No firewall, resolver, account, kernel, or systemd service settings were changed during this audit.

This is a configuration and evidence review. It is not a penetration test, vulnerability scan, security certification, or production-readiness assessment.

## 2. Scope and methodology

The audit uses 30 command-output captures collected in two phases:

- **Phase 2 (14 captures):** interfaces, IP addressing, routing, DNS lookup, listening sockets, running and failed services, accounts, groups, account-file metadata, SSH unit lookup, kernel, OS release, and hostname.
- **Phase 3 (16 captures):** resolver status and service, networkd service, resolver files, network configuration file inventory, enabled unit files, systemd sandboxing scores, firewall command availability, forwarding settings, selected network sysctls, login definitions, shell umask, and interactive-shell account listing.

The evidence describes the state at collection time (2026-11-15). It is not a guarantee of the system's current state after later boots or configuration changes. Original command output has been retained in individual text files, with identifying values anonymized where appropriate.

### Evidence labels

- **Verified from captured output:** directly shown by one or more supplied command outputs.
- **Observed:** a recorded runtime/configuration value that is not automatically a defect.
- **Not verified:** the available commands or output do not establish the claim.
- **Out of scope:** deliberately not tested or modified.

## 3. Network configuration

**Verified from captured output:**

- Interface `enp1s0` was up.
- IPv4 address: `192.168.122.54/24`, obtained through DHCP.
- Default gateway: `192.168.122.1`.
- Connected network: `192.168.122.0/24`.
- The loopback interface was present.

The `getent hosts example.com` test returned two IPv6 address records. This verifies that this particular name lookup succeeded at collection time. It does not independently establish general Internet reachability, connectivity to arbitrary destinations, or DNS reliability.

## 4. DNS and name resolution

**Verified from captured output:**

- `systemd-resolved.service` was enabled and active (running).
- `/etc/resolv.conf` was a symbolic link to `../run/systemd/resolve/stub-resolv.conf`.
- The stub resolver file pointed local clients to `127.0.0.53`.
- `resolvectl status` reported global current DNS server `1.1.1.1` and the per-link DNS server `192.168.122.1` for `enp1s0`.
- The output listed fallback servers from Cloudflare, Google, and Quad9.

**Observed runtime protocol state:**

- Global LLMNR: enabled.
- Global mDNS: enabled.
- On `enp1s0`: LLMNR enabled and mDNS disabled.
- DNS-over-TLS: disabled in the reported status.
- DNSSEC: reported as `no/unsupported`.

The captured `/etc/systemd/resolved.conf` showed the relevant directives commented out. This means the file does not show explicit local values for those settings. The audit does not infer that the runtime state was manually configured, nor does it establish whether drop-in configuration exists outside the captured file. Runtime observations are taken from `resolvectl status`.

## 5. Network and systemd services

**Verified from captured output:**

- Phase 2 listed 11 loaded service units in the running state.
- `systemctl --failed` listed zero loaded failed units at collection time.
- `systemd-networkd.service` and `systemd-resolved.service` were enabled and active.
- Phase 3 listed 32 enabled unit files.

The 32 enabled unit files are not 32 running services. The list includes services, sockets, and targets; enabled state describes unit enablement, not necessarily current activity.

The networkd journal included:

`Could not set hostname: Access denied`

The available evidence does not establish the cause, whether the message was transient, or whether it had an operational impact. It is recorded as an observation, not diagnosed as a failure.

The command `systemctl is-enabled sshd` returned `not-found` (exit status 4). This only means the queried systemd unit name was not found. It does not prove that no SSH client, differently named unit, or other SSH server implementation exists.

## 6. Listening sockets

The `ss -tulpn` capture showed:

- DNS stub sockets on loopback addresses `127.0.0.53:53` and `127.0.0.54:53`.
- UDP sockets on wildcard addresses at port 5353.
- UDP and TCP sockets on wildcard addresses at port 5355.

Ports 5353 and 5355 are commonly associated with mDNS and LLMNR. The resolver status is consistent with LLMNR being active on the captured link and mDNS being disabled on that link, despite global mDNS being enabled.

A wildcard-bound socket is a listening-socket observation. It does not by itself prove reachability from an untrusted network, successful remote access, exploitability, or a vulnerability. Network topology and packet-filtering state were not established by these captures.

## 7. Accounts and account-file permissions

The captured account listing showed `root` as the only account whose shell did not end in `false` or `nologin`. The separate shell-filter command returned:

`root:/bin/bash`

This is a statement about the captured `getent passwd` data and the exact filter used; it is not a complete authentication or authorization audit.

The captured metadata for account files was:

| File | Mode | Owner |
|---|---:|---|
| `/etc/passwd` | `0644` | `root:root` |
| `/etc/group` | `0644` | `root:root` |
| `/etc/shadow` | `0400` | `root:root` |

Only file metadata was collected for `/etc/shadow`; its contents were not included.

## 8. Kernel network parameters

The following values were captured:

| Parameter | Observed value |
|---|---:|
| `net.ipv4.ip_forward` | `0` |
| `net.ipv6.conf.all.forwarding` | `0` |
| `net.ipv4.conf.all.rp_filter` | `0` |
| `net.ipv4.conf.all.accept_redirects` | `1` |
| `net.ipv4.conf.all.send_redirects` | `1` |
| `net.ipv4.conf.all.accept_source_route` | `0` |
| `net.ipv6.conf.all.accept_redirects` | `1` |

These are reported as observed values. They are not automatically classified as defects, and this report does not claim they are universal defaults for every LFS installation.

## 9. Firewall inspection

The two captured commands reported:

- `nft list ruleset`: `Command unavailable: nft`
- `iptables-save`: `Command unavailable: iptables-save`

**Firewall state: Not verified.**

The absence of these command-line utilities does not prove that packet filtering is disabled or that no firewall rules exist in the kernel or elsewhere. The evidence is insufficient to claim that a firewall is enabled or disabled.

## 10. systemd service sandboxing analysis

`systemd-analyze security --no-pager` returned exposure scores and labels including `UNSAFE`, `EXPOSED`, `MEDIUM`, and `OK`.

These are systemd's service-sandboxing exposure heuristics. They are not vulnerability scan findings, exploitability assessments, or evidence that a service is compromised. A score must be interpreted in the context of each unit's purpose and required privileges. No sandbox settings were changed.

## 11. Login definitions and umask

The captured `/etc/login.defs` included, among other values:

- `UMASK 022`
- `ENCRYPT_METHOD YESCRYPT`
- `PASS_MIN_LEN 5`
- `PASS_ALWAYS_WARN yes`
- `LOGIN_RETRIES 5`
- `LOGIN_TIMEOUT 60`
- `PASS_CHANGE_TRIES 5`
- `SU_WHEEL_ONLY no`
- `PREVENT_NO_AUTH superuser`
- UID/GID allocation ranges and subordinate-ID ranges as shown in the raw capture.

The separate Bash umask probe returned `0022`.

These are configuration values as printed by the system. The presence of `ENCRYPT_METHOD YESCRYPT` in `login.defs` does not prove that existing password hashes use yescrypt; the shadow-file contents and actual password-change path were not audited. Likewise, `PASS_MIN_LEN` is recorded as a setting, not proof that a particular PAM or password-change path enforces that minimum.

## 12. Findings and evidence classification

### Verified from captured output

- The system identified itself as Linux From Scratch and reported kernel `7.1.8`.
- `enp1s0` was up with the captured DHCP IPv4 address and default route.
- The tested lookup for `example.com` returned IPv6 records.
- `systemd-networkd` and `systemd-resolved` were enabled and active.
- The running-service query listed 11 units; the failed-unit query listed zero.
- The account-file metadata and selected kernel network parameters were captured.
- IPv4 and IPv6 forwarding were both reported as disabled.

### Observed, not automatically classified as defects

- LLMNR and mDNS runtime state.
- DNSSEC and DNS-over-TLS status.
- Wildcard-bound sockets on ports 5353 and 5355.
- Selected network sysctl values.
- Login defaults and Bash umask.
- systemd sandboxing exposure scores.
- The networkd hostname access-denied journal message.

### Not verified

- Effective firewall ruleset and packet-filtering state.
- General Internet reachability or DNS reliability beyond the single lookup.
- Availability of every possible SSH server implementation.
- Cause and impact of the networkd hostname message.
- Actual password-hash algorithms for existing accounts.
- Overall resistance to attack or production security posture.

### Out of scope

- Penetration testing and vulnerability scanning.
- Custom kernel hardening.
- Firewall installation or policy changes.
- Resolver or DNS policy changes.
- Account/authentication policy changes.
- systemd service sandbox modifications.
- Production security certification.

## 13. Collection limitations

The Phase 3 collector had an exit-status reporting defect: the helper could print the status of a subsequent `echo` rather than the command being tested. Consequently, the Phase 3 `Exit status` annotations are not authoritative. The command output itself, including explicit errors and unavailable-command messages, remains the evidence to interpret.

The Phase 2 `systemctl is-enabled sshd` output explicitly reported `not-found` and exit status 4. Do not generalize that result beyond the queried unit.

## 14. Conclusion

This review documents the observed networking and security baseline of the captured LFS 13.1-systemd build. It intentionally preserves the system as built and does not prescribe or apply custom hardening.

The evidence supports specific statements about the captured interfaces, resolver, service state, account metadata, and selected kernel parameters. It does not support a blanket claim that the system is secure, insecure, firewall-protected, or production-ready.

## 15. Evidence and reproducibility

The accompanying `screenshots/09-networking-and-system-audit/` directory contains the 30 individual Phase 2 and Phase 3 text captures. Identifying MAC/UUID values and the MAC-derived IPv6 link-local interface identifier are replaced with explicit placeholders; technical configuration values and command output are retained.

The read-only collector is available at `scripts/collect-evidence/collect-network-security-evidence.sh`. It writes fresh raw output to a separate directory. Review and anonymize that output before publishing; do not overwrite the existing evidence.
