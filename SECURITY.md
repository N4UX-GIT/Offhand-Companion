# Security and behavior disclosure

## Official distribution

Official releases will be published only at:

`https://github.com/N4UX-GIT/Offhand-Companion/releases`

Each release must contain SHA-256 checksums. After SignPath onboarding is complete,
each Windows executable must also carry a valid, timestamped Authenticode signature
issued through SignPath.io using a SignPath Foundation certificate.

Do not run a file whose checksum does not match the release metadata or whose
signature is missing or invalid when the release is described as signed.

## Complete privileged behavior

Offhand Companion is a small .NET Framework Windows Forms application. Its source
is in `Source/Program.cs`.

It performs the following security-relevant operations:

1. Queries only known WoW executable names with `Process.GetProcessesByName`.
2. Reads the executable path and top-level window handle of a detected WoW process.
3. Uses documented Win32 window APIs to inspect and change WoW's border style,
   position, dimensions, focus, and redraw state.
4. Reads Windows monitor identifiers, bounds, work areas, and DPI information.
5. Registers the user-selected Span hotkey and the fixed Restore hotkey for the
   lifetime of the running Companion process.
6. Writes `Core\CompanionTopology.lua` in a detected Offhand addon installation.
7. After WoW has exited, reads Offhand's own account and character SavedVariables
   beneath the detected WoW `WTF` directory and atomically writes the data-only,
   interface-guarded `Core\ForeverState.lua` recovery snapshot.
8. Reads and writes preferences beneath `%LOCALAPPDATA%\Offhand`.
9. Makes one HTTPS request to the official GitHub Releases API only after the user
   clicks **Check for Updates**.

It does **not**:

- inject code or DLLs;
- read or modify WoW process memory;
- install a service, driver, scheduled task, browser extension, or startup entry;
- request elevation or bypass Windows security controls;
- enumerate arbitrary processes;
- inspect access tokens or credentials;
- download or execute code;
- accept inbound connections or remote commands;
- collect or transmit telemetry, chat, gameplay, account, or personal data.

## Why security products may inspect it closely

Window manipulation, process monitoring, global hotkeys, background tray operation,
and file recovery are legitimate requirements of this utility but can overlap with
generic machine-learning features used to identify unwanted software. The project
therefore avoids executable packers and obfuscation, publishes its complete source,
builds releases in a verifiable GitHub workflow, discloses every sensitive behavior,
and submits the resulting artifact for managed code signing.

A signature establishes publisher and artifact integrity. It does not override an
antivirus verdict, and a signed file can still be blocked. Any detected release must
be submitted to the relevant security vendor using its exact hash; the release must
not be rebuilt repeatedly in an attempt to evade detection.

## Reporting a vulnerability

Do not disclose an exploitable vulnerability in a public issue before the maintainer
has had a reasonable opportunity to investigate it. Use GitHub's private security
advisory feature for this repository. Include affected versions, reproduction steps,
impact, and any proposed mitigation.

False-positive reports may be opened publicly if they contain no private data. Include
the exact SHA-256 hash, security product, detection name, definition version, and the
official release URL.

