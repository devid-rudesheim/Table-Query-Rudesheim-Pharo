# TODO

## Provide an OS-specific in-memory optimizer table

Implemented. The in-memory backend now selects its optimizer table per OS, mirroring
`Rudesheim-OpenCL`'s `Smalltalk os rudesheim openCL` dispatch pattern:

- `Rudesheim-Kernel` gained a `WinPlatform >> rudesheim` override (`WinRudesheim`), alongside
  the existing `MacOSPlatform` one, covering `Win32Platform`/`Win64Platform` via inheritance.
- `Rudesheim-Table-Query-InMemory` contributes `OSRudesheim class >> tableQuery` (default,
  POSIX-like: `OSTableQueryRudesheim`) and `WinRudesheim class >> tableQuery` (Windows:
  `WinOSTableQueryRudesheim`). Each holds the OS's `optimizers` list.
- `PreparedQueryInMemoryBackendTableQueryRudesheim class >> optimizers` now delegates to
  `Smalltalk os rudesheim tableQuery optimizers` instead of hardcoding the list.
- On Windows, the DMirror-backed plans are dropped; `SmallInputSequential`/`EqualityIntersection`
  remain, falling back to plain sequential iteration if neither applies.
- The DMirror-backed plan classes moved to their own packages
  (`Rudesheim-Table-Query-InMemory-DMirror(-Private)`) behind a new optional `dmirror` baseline
  group, so the `default`/`core` groups no longer pull in `DMirror`'s POSIX-only `OSSubprocess`
  dependency and can load on Windows. See [README.md](README.md#groups).
