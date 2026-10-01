# Offhand Companion

Offhand Companion is the native Windows helper for the
[Offhand World of Warcraft addon](https://github.com/N4UX-GIT/Offhand-DualMonitor).
It makes WoW borderless across the displays selected by the user, passes exact
display geometry to the addon, restores a safe window when a display disappears,
and prepares a guarded recovery snapshot for the current WoW Forever beta.

The Companion is free, open-source software licensed under the MIT License. It is
non-commercial and contains no advertising, telemetry, analytics, account system,
or automatic background updater.

> **Signing status:** This repository is being prepared for free open-source code
> signing through SignPath.io with a certificate provided by SignPath Foundation.
> Until that application is accepted and a signed release is published, verify
> downloads using the release SHA-256 checksums and GitHub build provenance.

Free code signing provided by SignPath.io, certificate by SignPath Foundation.

## Security and trust

- Read the complete [security and behavior disclosure](SECURITY.md).
- Read the [privacy statement](PRIVACY.md).
- Read the project's [code signing policy](CODE_SIGNING_POLICY.md).
- Official release artifacts are built on GitHub-hosted Windows runners.
- Signing requests will be submitted directly from the GitHub Actions build that
  produced the artifact; local binaries are never substituted into that process.
- Signed releases will be timestamped and checked with Windows Authenticode before
  publication.

Never download `Offhand.exe` from a mirror, attachment, or unofficial website.

## What it does

- Detects only the allowlisted World of Warcraft process names.
- Removes the ordinary window border and positions WoW across the selected displays.
- Writes `Core\CompanionTopology.lua` inside an installed Offhand addon so the addon
  can use the exact Windows display rectangles.
- Restores WoW to a bordered Mainhand window when requested or when a selected
  display disconnects.
- After WoW has fully closed, reads Offhand's own SavedVariables and creates the
  guarded `Core\ForeverState.lua` recovery snapshot used by WoW Forever.
- Registers optional in-session global hotkeys for Span and Restore.
- Stores preferences in `%LOCALAPPDATA%\Offhand\OffhandConfig.ini`.
- Contacts GitHub only when the user clicks **Check for Updates**.

The Companion does not inject code, read WoW process memory, install a driver,
request administrator rights, create startup persistence, inspect security tokens,
collect gameplay or chat data, or accept commands from the network.

## Build

Windows 10 or Windows 11 with .NET Framework is sufficient:

```bat
build.bat
```

The build uses the Windows .NET Framework C# compiler already present on supported
Windows systems. It does not use PyInstaller, Electron, AutoHotkey, an executable
packer, obfuscation, or a downloaded compiler.

Run the standalone validation suite with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\run.ps1
```

## Releases

The imported `v2.1.2-beta.13` tag records the exact source used for the established
Beta 13 Companion. The first signed artifact will be treated as a deliberate
Companion release because Authenticode signing necessarily changes its bytes and
SHA-256 hash. Existing unsigned Beta 13 artifacts will not be silently replaced.

The release process is documented in [docs/RELEASE.md](docs/RELEASE.md). SignPath
onboarding and application details are in
[docs/SIGNPATH-ONBOARDING.md](docs/SIGNPATH-ONBOARDING.md).

## Linux/Wine

The executable is a Windows application. Running it under Wine is experimental;
see [Linux.md](Linux.md) for the current boundary and setup guidance.

## Relationship to the addon

This repository contains only the MIT-licensed Companion. The WoW addon has its own
repository, release process, and license. Keeping the native application separate
makes the signed artifact's source, review history, and build pipeline unambiguous.
