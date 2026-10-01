# Code signing policy

## Roles

- Committer and reviewer: [N4UX-GIT](https://github.com/N4UX-GIT)
- Signing approver: [N4UX-GIT](https://github.com/N4UX-GIT)

The project is currently maintained by one person. Signing remains a separate,
explicit release step performed only after the GitHub-hosted build has completed.

## Policy

1. Only artifacts built from this public repository by GitHub-hosted Actions runners
   may be submitted for release signing.
2. The unsigned artifact must be downloaded from the successful GitHub Actions run
   for the reviewed commit. It must not be rebuilt locally before signing.
3. Local builds, manually uploaded binaries, pull-request builds from forks, and
   unreviewed workflow changes must not use the release-signing policy.
4. The signed executable must identify its product as **Offhand Companion** and use a
   version matching the release tag.
5. Every release-signing operation requires manual approval by the signing approver
   and authentication through the certificate provider's protected key service.
6. The returned artifact must pass Authenticode verification before packaging.
7. SHA-256 checksums and GitHub build provenance must be published with the release.
8. A released artifact is immutable. Corrections require a new version and hash.
9. A credible malware or compromise report pauses signing and release activity until
   it is investigated.

See [PRIVACY.md](PRIVACY.md) and [SECURITY.md](SECURITY.md) for the project's privacy
commitment and complete behavior disclosure.
