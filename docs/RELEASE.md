# Signed release procedure

This procedure applies after Certum has validated the maintainer and issued the
open-source code-signing certificate described in `CERTUM-ONBOARDING.md`.

1. Make only intentional Companion changes. Addon-only releases do not require a new
   Companion build.
2. Update the assembly file/informational versions and manifest identity. Keep the
   informational version identical to the intended Git tag without the leading `v`.
3. Update tests and behavior disclosures for any security-relevant change.
4. Run `tests\run.ps1` and `build.bat` locally. Local output is for testing only and
   must never be promoted into a signed release.
5. Open and review the complete source/workflow diff.
6. Push the reviewed commit to `main` and confirm CI succeeds.
7. Create and push the matching annotated `v*` tag.
8. The **Prepare unsigned signing candidate** workflow builds, hashes, attests, and
   uploads the unsigned executable as a GitHub artifact retained for 90 days. It
   deliberately does not publish a GitHub release.
9. Download that exact artifact to the dedicated release-signing workstation. Record
   its SHA-256 hash and the source workflow URL before making any change.
10. Sign `Offhand.exe` with Certum SimplySign and an RFC 3161 timestamp. Do not rebuild,
    edit resources, or otherwise modify the executable before or after signing.
11. Verify the Authenticode status, timestamp, certificate chain, product name, product
    version, and source workflow. Run `scripts\New-Release.ps1` against the directory
    containing the signed executable to create the release ZIP and checksums.
12. Publish the signed executable, ZIP, checksums, source tag, signing certificate
    details, and GitHub build provenance in one immutable GitHub release.
13. Download the published artifacts and verify their checksums and signatures on a
    separate Windows system.
14. Submit the exact signed executable and ZIP/MSIX to Microsoft Security Intelligence
    and relevant browser security channels. Record their submission IDs.
15. After security determinations are clean, update the addon-facing Companion link and
    optionally submit the immutable signed package to WinGet and Microsoft Store.

Never rebuild a release under the same version. A correction requires a new tag,
binary, hash, signing request, and security-vendor submission.
