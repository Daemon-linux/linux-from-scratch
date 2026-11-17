#!/usr/bin/env python3
"""Write anonymized copies of LFS audit text evidence; never modify originals."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

MAC_RE = re.compile(r"(?i)\b(?:[0-9a-f]{2}:){5}[0-9a-f]{2}\b")
IPV6_LL_RE = re.compile(r"(?i)(?P<address>\bfe80::[0-9a-f:]+)(?P<prefix>/\d{1,3})?\b")
UUID_FIELD_RE = re.compile(
    r"(?im)(?P<prefix>\b(?:Machine\s+ID|Boot\s+ID|Product\s+UUID|Hardware\s+UUID|Invocation(?:\s+ID)?)\s*:\s*)"
    r"(?P<value>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[0-9a-f]{32})"
)


def anonymize(text: str) -> str:
    text = MAC_RE.sub(
        lambda match: match.group(0)
        if match.group(0) == "00:00:00:00:00:00"
        else "<MAC_ADDRESS>",
        text,
    )
    text = IPV6_LL_RE.sub(
        lambda match: "fe80::[ANONYMIZED_INTERFACE_ID]" + (match.group("prefix") or ""),
        text,
    )

    def replace_uuid(match: re.Match[str]) -> str:
        label = match.group("prefix").lower()
        if "machine" in label:
            token = "<MACHINE_ID>"
        elif "boot" in label:
            token = "<BOOT_ID>"
        elif "product" in label or "hardware" in label:
            token = "<PRODUCT_UUID>"
        else:
            token = "<INVOCATION_ID>"
        return match.group("prefix") + token

    text = UUID_FIELD_RE.sub(replace_uuid, text)
    text = re.sub(r"(?im)(\bInvocation:\s*)[0-9a-f]{32}\b", r"\1<INVOCATION_ID>", text)
    return text


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path, help="Directory containing original .txt evidence")
    parser.add_argument("destination", type=Path, help="Separate directory for anonymized copies")
    args = parser.parse_args()

    source = args.source.resolve()
    destination = args.destination.resolve()
    if not source.is_dir():
        parser.error(f"source directory does not exist: {source}")
    if source == destination or source in destination.parents or destination in source.parents:
        parser.error("source and destination directories must not overlap")

    files = sorted(source.glob("*.txt"))
    if not files:
        parser.error(f"no .txt files found in {source}")

    destination.mkdir(parents=True, exist_ok=True)
    for original_path in files:
        original = original_path.read_text(encoding="utf-8", errors="replace")
        (destination / original_path.name).write_text(anonymize(original), encoding="utf-8")

    print(f"Anonymized copies written: {len(files)}")
    print(f"Originals unchanged: {source}")
    print(f"Anonymized output: {destination}")
    print("Review every output manually before publication.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
