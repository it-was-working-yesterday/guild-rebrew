@AGENTS.md

## Codebase idioms

Before writing or debugging a function in a subsystem (command handlers, game
logic, server networking, load/save, or client utilities), check
[docs/code-idioms.md](docs/code-idioms.md) and inspect 1–2 sibling `EXACT`
functions in the same translation unit or subsystem for recurring C89 and MSVC6
patterns. Treat documented idioms as starting hypotheses; `rebrew test` /
`rebrew verify` remain ground truth.

When a non-obvious C shape unlocks `EXACT` (e.g., declaration order, `goto fail`,
stack homing, or a named constant to prevent tail-merging), add a brief `/* ... */`
comment in the `.c` file explaining *why* so future edits do not break it, and
promote reusable patterns to [docs/code-idioms.md](docs/code-idioms.md) rather
than keeping per-edit prose logs.

## Batching on the PC worker

Each `worker run rebrew` job serializes on `lane main`, and `build_name_to_va(cfg)`
takes ~24s per CLI invocation. For multi-variant `src/.sweep/v*.c` sweeps (strip
`/* ADDRESS: ... */` and remove `src/.sweep` in `finally`), call
`rebrew.test.compile_and_compare` in-process via `.venv/bin/python`
`ThreadPoolExecutor(max_workers=14)` (`python3` is not in `PATH`) with
`name_to_va=None` (or a small dict of the function's own symbols): 12 variants
run in ~2.5s (~9s total round-trip). Confirm any winner with
`worker run rebrew -- test <file> --json` + `worker fetch <id>`.
