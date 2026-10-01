# Certum open-source code-signing preparation

This document records the information and release controls for an individual
Certum Open Source Code Signing certificate. Do not store identity documents,
activation codes, passwords, one-time codes, private keys, or SimplySign recovery
material in this repository.

## Product to request

- Certum Open Source Code Signing in Cloud / SimplySign.
- Applicant type: individual open-source developer.
- Project: Offhand Companion.
- Repository: `https://github.com/N4UX-GIT/Offhand-Companion`.
- License: MIT.
- Intended signed files: `Offhand.exe`; the signed executable is then placed in
  `Offhand-Companion.zip` and, if pursued later, the Store MSIX.

On 2026-10-01, Certum's direct store marked all three open-source variants out of
stock: Cloud / SimplySign (€49), the physical card set (€69), and the activation
code for an existing card (€25). Contact Certum before purchasing a more expensive
certificate and ask for a restock date or an authorized reseller able to supply the
same individual open-source product. Also confirm Norwegian individual eligibility,
the exact identity documents, delivery cost if hardware is proposed, and renewal
pricing.

## Certum availability enquiry

Use Certum's official contact form or support address. Do not send identity files
with the initial enquiry.

> Subject: Open Source Code Signing availability for Norwegian individual developer
>
> Hello,
>
> I maintain Offhand Companion, a free MIT-licensed Windows utility published from
> the public repository https://github.com/N4UX-GIT/Offhand-Companion. I am an
> individual developer resident in Norway, not a company. Your store currently
> marks the Open Source Code Signing in the Cloud, card set, and activation-code
> products as out of stock.
>
> Could you confirm whether the individual Open Source Code Signing certificate is
> still available, its expected restock date, and whether an authorized reseller can
> currently supply it? I would prefer the €49 SimplySign cloud option, but I can
> consider the €69 card set if it can be delivered to Norway. Please also confirm
> that a Norwegian individual applicant is eligible and whether the published
> identity, utility-bill, and public-project evidence requirements are complete.
>
> Project website: https://offhand-wow.onrender.com/
> Addon listing: https://www.curseforge.com/wow/addons/offhand
>
> Thank you.

## Information prepared for the application

- Maintainer and applicant: Brad Naus / GitHub account `N4UX-GIT`.
- Project purpose: a free Windows window-management helper for the Offhand World
  of Warcraft multi-monitor addon.
- Commercial status: free, non-commercial, no paid edition, advertising,
  subscriptions, or dual licensing.
- Public source and history: the repository, Git tags, GitHub Actions runs,
  changelog, issues, security policy, privacy statement, and MIT license.
- Existing project release evidence:
  `https://github.com/N4UX-GIT/Offhand-DualMonitor/releases/tag/v2.1.2-beta.13`.
- Public addon listing:
  `https://www.curseforge.com/wow/addons/offhand`.
- Project website: `https://offhand-wow.onrender.com/`.

## Suggested project description

> Offhand Companion is a free, MIT-licensed Windows utility for the Offhand World
> of Warcraft multi-monitor addon. It uses documented Win32 APIs to resize the
> visible WoW window across displays explicitly selected by the user and writes
> display geometry and guarded recovery data only to the installed Offhand addon.
> It contains no telemetry, advertising, downloaded code, injection, persistence,
> driver, service, privilege escalation, remote-control functionality, or gameplay
> automation. Releases are built from public source on GitHub-hosted Windows
> runners. Code signing will let users authenticate the publisher and verify that
> distributed binaries originate from the reviewed project and release process.

## Evidence checklist

Prepare these locally for Certum validation without committing personal copies:

1. Government-issued photo ID accepted for Norwegian identity validation.
2. A recent proof-of-address document if requested by Certum.
3. The applicant email and phone number used for validation.
4. Public repository and CurseForge links showing the applicant's relationship to
   the project.
5. The repository license, security policy, privacy statement, code-signing policy,
   and successful GitHub Actions build.
6. Any Certum subscriber agreement or verification form presented during ordering.

Names and addresses must match across the order, identity evidence, and certificate
request. If Certum proposes a certificate subject such as `Open Source Developer,
Brad Naus`, record the exact final subject for release-script validation.

## SimplySign workstation setup

1. Install SimplySign Desktop only from Certum's official download page.
2. Enrol the authenticator on the maintainer-controlled phone and preserve recovery
   information offline.
3. Confirm Windows can see the cloud certificate while SimplySign is connected.
4. Install the current Windows SDK signing tools from Microsoft if `signtool.exe`
   is not already available.
5. Perform a test signature on a disposable CI artifact, using Certum's documented
   RFC 3161 timestamp endpoint.
6. Verify with `Get-AuthenticodeSignature` and `signtool verify /pa /all /v`.
7. Record the signer subject, issuer, certificate serial number, validity period,
   SHA-256 certificate thumbprint, timestamp authority, CI workflow URL, source
   commit, unsigned hash, and signed hash in the private release record.

## Controlled release flow

The GitHub Actions artifact is the source of truth. Download it, record its hash,
sign the exact executable through SimplySign, and never rebuild or edit it locally.
Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\New-Release.ps1 `
  -Version '2.1.2-beta.14' `
  -SignedArtifactDirectory '.\signed-artifact' `
  -ExpectedSignerPattern 'Brad Naus|Open Source Developer'
```

Use the actual issued certificate subject rather than relying permanently on the
example pattern. The script requires a valid Authenticode chain and trusted
timestamp before it packages anything.

After signing, submit the exact signed EXE and distribution ZIP to Microsoft
Security Intelligence and any vendor still reporting it. Do not publish until the
signature, checksums, provenance, clean local scan, and vendor submission records
have been reviewed.
