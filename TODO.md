# TODO

## Provide an OS-specific in-memory optimizer table

The in-memory backend's optimizer (`EqualityIntersection` plan, built on `DMirror`) only
works on a POSIX-like operating system, because `DMirror` declares its own `OSSubprocess`
dependency and `OSSubprocess` is POSIX-only (see [README.md](README.md#requirements)).

On Windows there is currently no equivalent optimizer: the in-memory backend has no
platform-conditional optimizer table, so loading/using it on Windows either fails outright
or silently falls back to a fully multiplied nested iteration with no optimization path at
all, depending on where the DMirror-backed code is first touched.

To support Windows, the in-memory backend needs an OS-specific table of optimizers instead
of a single hardcoded `EqualityIntersection`/`DMirror` plan:

- Keep the existing `DMirror`-backed `EqualityIntersection` plan for POSIX-like systems.
- Add a Windows-compatible optimizer (or an explicit "no optimizer, plain nested iteration"
  plan) as its counterpart.
- Select between them per-OS at plan-build time, rather than assuming DMirror is always
  available.

Not yet implemented.
