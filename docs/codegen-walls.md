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

## Recorded negative probes

- **`GOLDTL.0x004c9e20` (`cm_ExAllocCutscene`, `src/Develop/DieGildeAddOn/command/command_c/GOLDTL.cm_ExAllocCutscene.c`)**:
  - **Baseline (`20261119-102725-rebrew-5a6e`)**: `if (entry != 0) { ... } else { ret = 1; }` emits `je 0x70; ...; jmp 0x75; 0x70: mov ebx, 1; 0x75: cmp ...` (`58/58` insns, `26` exact, `5` reloc-only, `27` structural, `similarity: 0.9310`), whereas the target puts `mov ebx, 1; jmp 0x6e` out-of-line after `ret` (`je 0xb7` -> `0xb7: mov ebx, 1; jmp 0x6e`).
  - **Variants tried**:
    1. `if (entry == 0) goto fail;` with `fail: ret = 1; goto check;` (`20261119-103554-rebrew-6648`): regressed (`similarity: 0.9138`, `17` exact, `4` reloc-only, `37` structural; MSVC6 inverted to `jne` + inline `mov ebx, 1; jmp`).
    2. `if (entry == 0) { ret = 1; } else { ... }` (`20261119-103758-rebrew-b760`): same regression (`similarity: 0.9138`).
    3. `if (entry != 0) { ... } else { goto fail; }` (`20261119-104017-rebrew-d4f8`): identical to baseline (`similarity: 0.9310`).
    4. `rebrew match run` GA (`20261119-103929-rebrew-7fb1`, 100 gens, pop 64, seed `6924179594772501782`): `exact: false`, `best_score: 84506.0`.
  - **Limit**: Only branch/label placement around `entry == 0` was probed under current TU/globals; do not repeat these three `if/else`/`goto` permutations without a new structural or TU-context hypothesis.
