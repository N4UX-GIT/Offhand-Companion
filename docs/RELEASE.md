# Signed release procedure

This procedure applies after SignPath Foundation accepts the project and the GitHub
and SignPath settings in `SIGNPATH-ONBOARDING.md` are complete.

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
8. GitHub Actions builds and uploads the unsigned executable as a GitHub artifact.
9. Review the SignPath request, source commit, workflow origin, artifact configuration,
   and declared version; then explicitly approve it.
10. The workflow downloads the signed artifact, validates Authenticode and the signer,
    packages the release, creates checksums and provenance, and publishes the GitHub
    release.
11. Download the published artifacts and verify their checksums and signatures on a
    separate Windows system.
12. Submit the exact signed executable and ZIP/MSIX to Microsoft Security Intelligence
    and relevant browser security channels. Record their submission IDs.
13. After security determinations are clean, update the addon-facing Companion link and
    optionally submit the immutable signed package to WinGet and Microsoft Store.

Never rebuild a release under the same version. A correction requires a new tag,
binary, hash, signing request, and security-vendor submission.
