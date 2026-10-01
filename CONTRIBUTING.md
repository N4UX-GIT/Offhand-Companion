# Contributing

Keep changes narrowly scoped and explain any new Windows API, filesystem, process,
network, persistence, or privilege behavior in the pull request and `SECURITY.md`.

Before submitting a change:

1. Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\run.ps1`.
2. Build with `build.bat` on Windows.
3. Confirm the application still runs as the ordinary user without elevation.
4. Confirm update checks remain user initiated.
5. Do not commit generated executables, archives, credentials, SignPath tokens, or
   local configuration files.

Release-signing workflow changes deserve the same review as application source code.

