# Bounded negative results

A failed set of C variants is evidence about those variants under those inputs.
It is not proof that C cannot reproduce the reference, that the residue is a floor,
or that the original used assembly. [Assembly evidence](assembly-audit.md) has a
separate acceptance rule.

## Before reopening a probe

Check the archived experiments, current source, native body and original TU context.
A new attempt needs a specific new fact: corrected call/field/stack evidence,
a different original compilation context, a missing definition, or a controlled
compiler result. Renaming locals or repeating exhausted permutations is not one.

## Record a useful negative result

State the target/VA, exact inputs, variants tried, observed effect, limits and replay
receipt. Keep one record per experiment family. Do not repeat whole-project status
or label a byte delta as its own cause.

Use [C shapes](msvc6-c-shapes.md) for expression hypotheses and
[register allocation](msvc6-allocator.md) for value/slot analysis. Preserve canonical
whole-TU game flags; diagnostic overrides do not become production policy.

Older write-ups are in the [archive](goal-history.md#full-notebooks) under this filename.

## Near-miss hand-diff, 2026-11-19

Inputs: GA `rebrew match batch --near-miss --threshold 5 --resume` (0 of 3 matched,
best scores 2900/7400/7500), then hand variants checked with
`rebrew test <file> --json --no-promote`. All variants reverted; sources unchanged.

- **0x00495180** (`fcn_00495180.c`, 623/625). One structural diff: after the
  `plan->rate(...)` call the target has `cmp eax, esi` (esi = shared zero), we emit
  `test eax, eax`. The `plan->rate == 0` and `plan->pick == 0` compares already
  match as `cmp esi`. Tried: assignment split from the compare; `rate` returning
  `void*`; `!plan->rate(...)`. No change (623/625). Untried: compare against a
  zero-valued local; GA with a new seed/more generations.
- **0x00490c10** (`fcn_00490c10.c`, 113/118). Target `mov esi, eax; cmp esi, 1`,
  ours `cmp eax, 1; mov esi, eax` in the `t = v < 4 ? v : 4; t = t < 1 ? 1 : t;`
  clamp. Tried: `if (t < 1) t = 1;` (113/118); `t = v; if (t > 4)...; if (t < 1)...`
  (STUB, 55/118); nested `if (v < 4) {...} else t = 4;` (STUB, 66/118).
- **0x0040fb80** (`CreateParticle.c`, 323/328). Target orders `fsubr [0x662a10]`
  before `lea eax, [esi+ecx]` for `x08 = -0.5 - v`; ours emits the `lea` first.
  Tried: inline `s->items[i].x04` without `v` (SIZE_MISMATCH, 258/329);
  `-0.5 - (v = s->items[i].x04)` (323/328, no gain).

Not yet tried for any of the three: `--algorithm flags-then-ga`, a different `--seed`.
