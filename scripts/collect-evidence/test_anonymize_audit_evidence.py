#!/usr/bin/env python3
"""Unit tests for anonymize-audit-evidence.py."""

from __future__ import annotations

import importlib.util
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).with_name("anonymize-audit-evidence.py")
SPEC = importlib.util.spec_from_file_location("anonymize_audit_evidence", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class AnonymizeTests(unittest.TestCase):
    def test_replaces_mac_and_preserves_other_values(self) -> None:
        source = "MAC=52:54:00:73:b0:78 IP=192.168.122.54"
        result = MODULE.anonymize(source)
        self.assertEqual(result, "MAC=<MAC_ADDRESS> IP=192.168.122.54")

    def test_link_local_prefix_is_preserved_when_present(self) -> None:
        self.assertEqual(
            MODULE.anonymize("fe80::5054:ff:fe73:b078/64"),
            "fe80::[ANONYMIZED_INTERFACE_ID]/64",
        )

    def test_link_local_without_prefix_does_not_gain_one(self) -> None:
        self.assertEqual(
            MODULE.anonymize("fe80::5054:ff:fe73:b078"),
            "fe80::[ANONYMIZED_INTERFACE_ID]",
        )

    def test_uuid_fields_are_replaced(self) -> None:
        source = (
            "Machine ID: 0123456789abcdef0123456789abcdef\n"
            "Boot ID: 01234567-89ab-cdef-0123-456789abcdef\n"
            "Product UUID: 01234567-89ab-cdef-0123-456789abcdef\n"
            "Invocation: 0123456789abcdef0123456789abcdef"
        )
        result = MODULE.anonymize(source)
        self.assertIn("Machine ID: <MACHINE_ID>", result)
        self.assertIn("Boot ID: <BOOT_ID>", result)
        self.assertIn("Product UUID: <PRODUCT_UUID>", result)
        self.assertIn("Invocation: <INVOCATION_ID>", result)

    def test_cli_writes_separate_copy_and_preserves_original(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "source"
            destination = root / "destination"
            source.mkdir()
            original = source / "capture.txt"
            original.write_text("52:54:00:73:b0:78\n", encoding="utf-8")

            result = subprocess.run(
                [sys.executable, str(SCRIPT), str(source), str(destination)],
                check=False,
                capture_output=True,
                text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(original.read_text(encoding="utf-8"), "52:54:00:73:b0:78\n")
            self.assertEqual(
                (destination / "capture.txt").read_text(encoding="utf-8"),
                "<MAC_ADDRESS>\n",
            )

    def test_cli_rejects_overlapping_directories(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "source"
            source.mkdir()
            nested = source / "nested"
            result = subprocess.run(
                [sys.executable, str(SCRIPT), str(source), str(nested)],
                check=False,
                capture_output=True,
                text=True,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("must not overlap", result.stderr)

    def test_cli_rejects_destination_that_contains_source(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "parent" / "source"
            source.mkdir(parents=True)
            destination = source.parent
            result = subprocess.run(
                [sys.executable, str(SCRIPT), str(source), str(destination)],
                check=False,
                capture_output=True,
                text=True,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("must not overlap", result.stderr)


if __name__ == "__main__":
    unittest.main()
