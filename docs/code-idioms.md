# Codebase idioms from EXACT functions

Recurring C89 and MSVC6 patterns observed in `EXACT` functions across `src/Develop/`.
Use these as starting hypotheses when reconstructing sibling functions in the same
subsystem; [C shapes](msvc6-c-shapes.md) and [register allocation](msvc6-allocator.md)
cover general compiler mechanics, and `rebrew test` / `rebrew verify` remain the
ground truth.

## 1. Command handlers (`DieGildeAddOn/command/command.c`)

- **Check (`cm_Chk*`) and execute (`cm_Ex*`) pairs**:
  - `cm_Chk*` handlers return `0` on success and `1` on validation failure, logging
    a `LogMessageInternal("D:\\Develop\\DieGildeAddOn\\command\\command.c", <line>, "<fn>() ...", 8)`
    message right before each `return 1;` (example: `cm_ChkSellObjekt`, `SERVER.0x1000cbd0`).
  - `cm_Ex*` handlers take `(int cmd, char* result)` (or `char* cmd`), log failures
    with severity `1`, and write status bytes into `result` when non-null before
    returning `2` on allocation/execution failure (example: `cm_ExEmployWorker`,
    `SERVER.0x1000f730`).
- **Entity resolution and `-1` sentinels**:
  - IDs in command payloads use `-1` for "none / unset", resolved via
    `gm_GetFieldByType` and `gm_ResolveEntityById((void**)&t_a, (void**)&t_b, (void**)&t_c, id)`
    or `gm_StartFilteredEntitySearch(1, 1, id)`.
  - Three-way entity dispatch (`t_b` / `t_d` / `t_a` or `t_c` / `t_d` / `t_a`) selects
    different inventory/slot offsets (e.g., `+0x5d`, `+0x14`, `+0x178`) or slot-table
    indexing (`g_slot_table + slot_index * 0x21c` with `0xffff` as invalid).

## 2. Game logic & entity iteration (`DieGildeAddOn/game/`)

- **Query cursor loops**:
  - Entity queries start with `gm_ff_Objekt(...)` and advance with `gm_NextEntityQueryMatch()`
    in `for` or `do { ... } while` loops (seen across `spiel.c`, e.g., `gm_NextEntityQueryMatch`,
    `SERVER.0x10016290`).
- **Shared failure epilogues (`goto fail`)**:
  - When multiple guard checks and an allocation-failure path share a single epilogue
    and return value, MSVC6 often matches `goto fail;` rather than repeated `return`
    statements (example: `gv_UpgradeField`, `SERVER.0x10010d10` in `friedhof_logic.c`).
- **Hoisted reads & named constants**:
  - Reading a field before a guard (e.g., `old_alloc = *(void**)(field + 0x65);`
    before checking `entry[0] != 0x1d`) can change callee-save register selection.
  - Naming a shared constant in a local (e.g., `last_n = 0x88;`) can prevent
    MSVC6 from tail-merging two `memcpy` arms too deeply (observed in `gv_UpgradeField`).
- **Range-check ladders**:
  - Sequential `if (x >= A && x <= B) return ...;` blocks with an initialized `result = 0;`
    fallback at the end (example: `gm_GetOppositeStatIndex`, `GOLDTL.0x00507d10` in `spiel.c`,
    and `d2_GetValueStep`, `GOLDTL.0x004722c0` in `d2_GetValueStep.c`).

## 3. Server & networking (`DieGildeAddOnServer/server.c`)

- **Fixed-stride connection slots**:
  - Connection arrays are walked both by byte-offset pointer (`slot_walk += 0x264264`)
    and index (`i++`), with `goto` to shared `no_slots` / `do_accept` / `ret_neg1`
    blocks (example: `srv_AcceptConnections`, `SERVER.0x1000a080`).
- **Scoped block locals & function-pointer calls**:
  - Local block scopes `{ ... }` with a local `setsockopt` function pointer or
    explicit `dst` pointer arithmetic preserve register/stack-slot allocation without
    changing outer live ranges (`srv_AcceptConnections`).

## 4. Load/save & pointer fixup (`DieGildeAddOn/loadsave/loadsave.c`)

- **Linked-list tail append**:
  - Appending to singly-linked record lists uses a null check on the head, followed
    by `if (*(void**)((char*)node + off) != 0) { nxt = node; do { ... } while (...); node = nxt; }`
    (example: `ls_ID2Ptr`, `SERVER.0x10014070`).
- **Table stride indexing**:
  - Non-power-of-two table strides appear as explicit multiplies (`i * 0x43`,
    `idx * 64 + idx`, `type + type * 588`) rather than struct array indexing when
    the original code used raw byte buffers or matching stride math.

## 5. Client utilities & COM wrappers (`src/Develop/Unassigned/`, `Units/`)

- **COM interface release sequences**:
  - Repeated `if (*(T**)(obj + off) != 0) { (*(T**)(obj + off))->vtbl->Release(*(T**)(obj + off)); *(T**)(obj + off) = 0; }`
    without caching the pointer in a local preserves exact load/null-check order
    (example: `ReleaseVideoInterfaces`, `GOLDTL.0x0041f7f0`).
- **Grid / bounds clamping**:
  - Ternary clamping `(a < b) ? a : b` inside nested `while` loops with block-top
    C89 locals (example: `fcn_0045b7e0`, `GOLDTL.0x0045b7e0`).
- **Hand-written `__asm` routines**:
  - Tight blitters (e.g., `fcn_0047a320`, `GOLDTL.0x0047a320`) may be inline `__asm`
    with a compiler-generated frame; check [assembly audit](assembly-audit.md) before
    assuming a function is inline assembly.

## 6. Preventing tail-merging (`fcn_0051e080`, `fcn_004fb7a0`)

- **Inline cleanup per failing check**: when the target repeats an identical cleanup+`return 0`
  epilogue after every check (no shared tail), write the checks as `if (x == 0) {cleanup; return 0;} else { next... }`
  nesting. Flat `if (x == 0) {cleanup; return 0;}` runs get merged into one shared tail
  (`fcn_0051e080`: SIZE_MISMATCH 925/1035 B -> RELOC 1035/1035). A call-count deficit
  (candidate has fewer `call`s than the target) with an otherwise matching tail is the sign.
- **Duplicate a block instead of `goto`**: a `goto stateN` into a shared block makes MSVC6 emit it once;
  if the target contains the block twice, write it twice (`fcn_004fb7a0`: 1011 -> 1253 B of 1252 B).
  Likewise a value computed in each arm of an if/else (e.g. `sel[gm_RandomMod(0x10)]`) appears once per arm
  in the target when the original wrote it inside each arm.
