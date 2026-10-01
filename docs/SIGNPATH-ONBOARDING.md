# SignPath Foundation onboarding

This file records the project information and the remaining external setup. Do not
store API tokens or certificate material in the repository.

## Application information

- Project: Offhand Companion
- Intended repository: `https://github.com/N4UX-GIT/Offhand-Companion`
- Existing release evidence:
  `https://github.com/N4UX-GIT/Offhand-DualMonitor/releases/tag/v2.1.2-beta.13`
- License: MIT
- Maintainer: `N4UX-GIT`
- Artifact: Windows .NET Framework Win32 executable and ZIP distribution
- Commercial status: free, non-commercial, no paid edition or dual licensing
- Privacy: no telemetry; network access occurs only after the user clicks Check for
  Updates
- Signing purpose: authenticate the publisher and bind release binaries to this
  public source repository and its GitHub-hosted build

## Security-sensitive behavior to disclose

The application monitors only allowlisted WoW process names, changes the selected
WoW window's style and geometry, registers user-configured global hotkeys, and reads
and writes Offhand-specific files in the user's WoW installation. It performs no
injection, memory access, driver installation, elevation, persistence, token access,
remote control, downloaded code execution, telemetry, or credential handling.

See `SECURITY.md` for the complete disclosure.

## Application and configuration checklist

1. Create the public `N4UX-GIT/Offhand-Companion` GitHub repository.
2. Push `main` and the imported `v2.1.2-beta.13` source tag.
3. Confirm CI succeeds on a GitHub-hosted Windows runner.
4. Enable two-factor authentication for the maintainer's GitHub account.
5. Apply at `https://signpath.org/apply` and reference this repository, its MIT
   license, privacy statement, security disclosure, and code signing policy.
6. After acceptance, install the SignPath GitHub App for this repository.
7. In SignPath, create or confirm:
   - project slug: `offhand-companion`
   - release policy slug: `release-signing`
   - GitHub.com trusted build system with origin verification
   - an artifact configuration whose root is the GitHub artifact ZIP and which
     signs its root-level `Offhand.exe` with Authenticode
   - manual approval for every release-signing request
8. Create a SignPath CI user limited to submitting that policy.
9. Store its API token as the GitHub Actions secret `SIGNPATH_API_TOKEN`.
10. Store the SignPath organization ID as the GitHub Actions repository variable
    `SIGNPATH_ORGANIZATION_ID`.
11. Submit a non-release test artifact first and inspect its signature.
12. Submit the exact signed release candidate to Microsoft Security Intelligence as
    a software developer before publishing it broadly.

## Suggested application summary

> Offhand Companion is a free MIT-licensed Windows utility for the open-source
> Offhand World of Warcraft multi-monitor addon. It uses documented Win32 window
> APIs to make the user-selected WoW window borderless across selected displays and
> writes display geometry and guarded recovery data only to the installed Offhand
> addon. It contains no telemetry, advertising, downloaded code, injection,
> persistence, driver, service, or privilege escalation. Releases are built on
> GitHub-hosted Windows runners from public source. We seek SignPath Foundation
> signing so users can authenticate the publisher and verify that distributed
> binaries originate from the reviewed repository and workflow.
