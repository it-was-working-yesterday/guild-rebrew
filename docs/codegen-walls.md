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

## Near-miss hand-diff, round 2, 2026-11-19

Same method as above (`rebrew test ... --no-promote`; every variant reverted).

- **0x004c6e20** (`fcn_004c6e20.c`, 113/123). Target sets `ecx = 0x10` before `esi = ebx` and the next-pointer load in
  the copy loop; ours loads `ecx` last. Tried: `memcpy(dst, p, 0x40)` before advancing `p` (107/123);
  a 0x40-byte struct assignment with `src = p; p = next` (113/123, no change); struct assignment from `p`
  before advancing (107/123).
- **0x0050b840** (`fcn_0050b840.c`, 125/136). Target pops `esi`/`edi` before loading `r->cap`/`r->div`. Tried:
  `r = (Rec*) (lpObjektePROT + id * 0x40)` (SIZE_MISMATCH, 132 bytes); three operand orders / casts in the return
  expression (115/136 each).
- **0x00509570** (`gm_GetEntityTableEntry`, `spiel.c`, 54/65; test with `--va 0x00509570 --symbol
  _gm_GetEntityTableEntry`, since `spiel.c` holds many functions). Target keeps the index in `eax`
  (`and eax,0xf; test eax,eax`); ours copies it to `ecx`. Tried: a `v` temp for the halfword at `+0x50`;
  `(short*) g_entity_base + index * 0x56`; a 0xac-byte record type indexed from `g_entity_base`. All 54/65.
- **0x004f0f60**. Fresh-seed GA (seed 20261119, 100 generations, 6 minute budget): no match, best score 42226.83 after
  8 generations. The machine was loaded by another agent's regression run, so the GA got too few generations to say anything.
- A larger fresh-seed batch (`--threshold 20`, 12 functions, 200 generations, 10 minute budget) was killed after 35 minutes
  with no function finished; hand edits made while it ran touched the same files, so it is not evidence either way.

## Handler pass, 2026-11-19 (guild-gold overlap)

Same method (`rebrew test ... --no-promote`, every variant reverted). Handlers chosen from the Rust port's `he`/`cmd` rows
that are STUB or NEAR_MATCHING in the GoldTL todo.

- **0x004c9e20** (`cm_ExAllocCutscene`, STUB 109/190; guild-gold `docs/commands.md` calls command 0x27 "a meeting from the
  prepared buffer 0xAED340 through FUN_004E6AE0 into the table 0x9A9660", tag R). Target keeps the `entry == 0` arm
  (`mov ebx, 1; jmp`) out of line at the end of the function; ours emits it inline. Tried an explicit
  `if (!entry) goto fail; ... fail: ret = 1; goto done;` layout (71/190) and `if (entry == 0) ret = 1; else {...}` (71/190);
  the original `if (entry != 0) {...} else ret = 1` stays best at 109/190. **Name conflict, not acted on:** the Rust port's
  replay-verified role (meeting creation) does not agree with the current `cm_ExAllocCutscene` / `cut_AllocCutscene` names;
  needs a naming-ledger review before any rename.
- **0x004cdda0** (`fcn_004cdda0`, command 0x68 set-route handler, NEAR 193/199). The only difference is `lea eax, [esp+0x4c]`
  vs `mov ecx, edx` ordering at the loop entry. Tried `node = buf` moved inside the `if`, both orders of `i = n` / `node = buf`
  (193/199, no change; the compiler ignores the order), and counting with `i` while keeping `n` for the tail store
  (SIZE_MISMATCH 15/206).
- **0x00566110** (`fcn_00566110`, `HE_ENTLASSEN_finish`, NEAR 390/392, 129/129 aligned instructions). Only two jump
  displacements differ: the target's `state < -2` and `state != 0` exits land on the first epilogue (after the tail call),
  ours on the last (after the `fail:` store). Routing the two `return`s through a `done:` label placed after the tail call:
  no change.
- Measured, not attempted (match/total): 0x551d50 553/575, 0x5513d0 631/639, 0x55c270 1153/1168, 0x55cc80 1066/1092,
  0x4cc820 803/838, 0x4cb7f0 1103/1175, 0x565ab0 1335/1560.

## Handler pass, part 2, 2026-11-19

- **0x005513d0** (`fcn_005513d0`, `HE_NACHWUCHS_finish`, NEAR 631/639). The target interleaves the `g_7f4c00` record loads and
  the `msg+0x38` store differently from ours (our store of `msg+0x18` comes before the `rec_id` store; the target's
  comes after). Tried: the four field copies as one packed `pos14_7f4c00` assignment (580/639); `msg+0x38` stored
  before `msg+0x18` (SIZE_MISMATCH 253/640); `msg+0x20` stored first (580/639); `msg+0x24` stored first (569/639).
- **0x0055c270** (`fcn_0055c270`, NEAR 1153/1168). One scheduling difference near the end: the target loads `[esi+1]`, stores
  the id, then loads `[ebx+2]`; ours loads both first. Tried swapping `m.id` / `m.x4` (1150/1168).
- **0x00566110**. GA (`--improve`, fresh seed 5661, 150 generations, 8 minute budget, machine idle): no match, best score
  2900.00, the same floor as the earlier 2-byte near-misses. A score that low means the search only has the early-exit jump
  target left, and the mutation operators do not reach it.
