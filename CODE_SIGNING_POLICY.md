# Code signing policy

Free code signing provided by SignPath.io, certificate by SignPath Foundation.

## Roles

- Committer and reviewer: [N4UX-GIT](https://github.com/N4UX-GIT)
- Signing approver: [N4UX-GIT](https://github.com/N4UX-GIT)

The project is currently maintained by one person. A signing request still requires
a separate, explicit approval step in SignPath after the GitHub-hosted build has
completed.

## Policy

1. Only artifacts built from this public repository by GitHub-hosted Actions runners
   may be submitted for release signing.
2. The SignPath GitHub integration must verify the repository, commit, workflow run,
   and uploaded GitHub artifact that produced the signing request.
3. Local builds, manually uploaded binaries, pull-request builds from forks, and
   unreviewed workflow changes must not use the release-signing policy.
4. The signed executable must identify its product as **Offhand Companion** and use a
   version matching the release tag.
5. Every release-signing request requires manual approval by the signing approver.
6. The returned artifact must pass Authenticode verification before packaging.
7. SHA-256 checksums and GitHub build provenance must be published with the release.
8. A released artifact is immutable. Corrections require a new version and hash.
9. A credible malware or compromise report pauses signing and release activity until
   it is investigated.

See [PRIVACY.md](PRIVACY.md) and [SECURITY.md](SECURITY.md) for the project's privacy
commitment and complete behavior disclosure.
