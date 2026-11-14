# Troubleshooting

This directory is the place for reproducible reports of build failures and unexpected system behavior. The repository currently provides the reporting standard; do not treat the absence of a report as evidence that no failures occurred.

## Issue report template

1. **Title** — package or component and a short description.
2. **Environment** — host, target architecture, package version and LFS book section.
3. **Symptoms** — exact error message or failing test name.
4. **Investigation** — commands, logs and evidence used during diagnosis.
5. **Root cause** — confirmed cause, or clearly marked hypothesis if not confirmed.
6. **Resolution** — exact change and verification performed.
7. **References** — upstream documentation and related project evidence.

## Guidelines

- Do not call a workaround a root-cause fix unless the cause is understood.
- Preserve failed test names and meaningful error output.
- State whether the failing test or build was rerun after the change.
- Link the original log and relevant evidence.
- Never claim all tests passed when the recorded summary contains failures or skips.

The goal is to preserve reproducible troubleshooting knowledge, not just commands that happened to work.
