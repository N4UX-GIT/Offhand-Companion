# Changelog

## 2.1.2 Beta 14 — signing candidate

- Record the exact Companion informational version in the generated addon topology
  file so the addon can diagnose Companion/addon version mismatches.
- Point the user-initiated update check at the standalone Offhand Companion
  repository.
- Compare complete beta release versions, so Beta 14 is correctly recognized as
  newer than Beta 13 even though both share the `2.1.2` base version.
- Preserve the Beta 13 runtime security boundary: no telemetry, automatic update
  checks, executable downloads, startup persistence, token inspection, packer, or
  obfuscation.

## 2.1.2 Beta 13

- Imported source corresponding to the established unsigned Beta 13 release.
