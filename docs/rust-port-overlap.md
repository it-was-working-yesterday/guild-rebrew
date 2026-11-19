# Rebrew todo vs. the Rust port (guild-gold)

Generated 2026-11-19 from `rebrew todo -t Europa1400Gold_TL.exe` (all non-RELOC categories) joined by exact address
against `../guild-gold/docs/re/symbols.tsv` (same binary, key `Europa1400Gold_TL.exe`). Tags there: R = replay-verified,
D = dynamic, S = read from static code, H = hypothesis. Rows whose doc is `docs/re/guild-rebrew.md#import` are names the Rust
port took *from this project*, so they are not independent knowledge and are marked **(ours)**.

Only exact-address matches count; a Rust-port note that covers a function's interior or a range is not found here.

## Summary

| Todo category | Items | Address known to Rust port | Independent (not imported from us) | ...and named |
|---|---:|---:|---:|---:|
| fix-delta | 10 | 4 | 4 | 4 |
| start-function | 13 | 6 | 6 | 6 |
| start-data | 10 | 5 | 5 | 4 |
| improve-match | 908 | 549 | 517 | 473 |
| data-drift | 405 | 170 | 143 | 96 |

## Pick-up list: `start-function` items the Rust port already understands

Six GoldTL functions without source that the Rust port has named from code (S) or runtime (D) evidence. Read the linked doc
before skeletoning; the names are theirs, so apply the project naming rules ([naming_conventions.md](naming_conventions.md))
and mark any inferred name as such.

| VA | Size | Rust-port name | Tag | Where to read |
|---|---:|---|---|---|
| `0x00570870` | 235 | HE_ROUTE_SUPERVISOR_finish | D | `../guild-gold/docs/timed-actions.md` (0xA6 route supervisor, every cart on a route, every 15 min) |
| `0x0049a7b0` | 201 | ai_m1d_start | H | `../guild-gold/docs/master-ai.md`, `docs/re/notes/ai-methods-a.md` and `-b.md` |
| `0x0056e8e0` | 146 | he_night_watchman_a | S | `../guild-gold/docs/addresses.md` (action 0x73, night watchman calls the hours) |
| `0x00566fa0` | 134 | HE_SIM_PERSONAL_start | S | `../guild-gold/docs/timed-actions.md` (action 0x3a START) |
| `0x00579320` | 104 | he_grave_debt_start | S | `../guild-gold/docs/timed-actions.md` (0x8B START; name is H) |
| `0x005666b0` | 73 | HE_PERSONAL_KUENDIGEN_start | S | `../guild-gold/docs/timed-actions.md` (action 0x33 START) |

Start with the timed-action START/FINISH handlers (0x566fa0, 0x5666b0, 0x579320, 0x570870): the Rust port documents them as
one family, so the call shape and argument layout should repeat. The seven other `start-function` items have no Rust-port row.

## fix-delta

Known to the Rust port first (largest first), then the rest.

### Known to the Rust port (4)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x00495180` | 625 | NEAR_MATCHING | ai_select_method | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | per-person best-of-N over the methods: short and long score, writes person +0x131, +0x132, +0x134, +0x14C; no RNG |
| `0x0040fb80` | 328 | NEAR_MATCHING | esc_CreateParticle | S | docs/formats/esc.md#the-machine-s | built-in CreateParticle (also named CreateParticle, H, docs/re/guild-rebrew.md#import) |
| `0x004c6e20` | 123 | NEAR_MATCHING | cm_request_0x68_route | S | docs/route-window.md | player dialog |
| `0x00509570` | 65 | NEAR_MATCHING | dynasty_record | S | docs/timed-actions.md#4-legend-for-the-table | FUN_00509570 -> 0x85A0A0 + i0x56 (right after the person array). Building = FUN_00503fe0/FUN_00504e70 objects. (+1 docs); guild-rebrew: gm_G |

### Not in `symbols.tsv` (6)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x00416d50` | 1065 | NEAR_MATCHING |  |  |  |  |
| `0x004bd1e0` | 758 | NEAR_MATCHING |  |  |  |  |
| `0x00420db0` | 667 | NEAR_MATCHING |  |  |  |  |
| `0x0050b840` | 136 | NEAR_MATCHING |  |  |  |  |
| `0x004f0f60` | 133 | NEAR_MATCHING |  |  |  |  |
| `0x00490c10` | 118 | NEAR_MATCHING |  |  |  |  |

## start-function

Known to the Rust port first (largest first), then the rest.

### Known to the Rust port (6)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x00570870` | 235 |  | HE_ROUTE_SUPERVISOR_finish | D | docs/timed-actions.md#0xa6-route-supervisor-cratesguild-simsrctrade_routesrs-s-d-where-marked | timed action 0xA6 FINISH: every cart on a route, every 15 min |
| `0x0049a7b0` | 201 |  | ai_m1d_start | H | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x0056e8e0` | 146 |  | he_night_watchman_a | S | docs/addresses.md#saveload-module-found-2026-11-01 | action 0x73 = night watchman Calls the hours; one of ~56 action handler pairs registered in 0x005709 |
| `0x00566fa0` | 134 |  | HE_SIM_PERSONAL_start | S | docs/timed-actions.md#5-table | timed action 0x3a START handler |
| `0x00579320` | 104 |  | he_grave_debt_start | S | docs/timed-actions.md | 0x8B START; name H (also he HE_FRIEDHOF_OFFER_start, S, docs/quirks.md#pact-with-death-what-it-does-who-gets-it-who-it-protects-code-429: ti |
| `0x005666b0` | 73 |  | HE_PERSONAL_KUENDIGEN_start | S | docs/timed-actions.md#5-table | timed action 0x33 START handler |

### Not in `symbols.tsv` (7)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x004092d0` | 485 |  |  |  |  |  |
| `0x004d4430` | 391 |  |  |  |  |  |
| `0x004d4d80` | 170 |  |  |  |  |  |
| `0x0049fa80` | 67 |  |  |  |  |  |
| `0x005fc0c8` | 44 |  |  |  |  |  |
| `0x005fc0f4` | 24 |  |  |  |  |  |
| `0x0064d217` | 16 |  |  |  |  |  |

## start-data

Known to the Rust port first (largest first), then the rest.

### Known to the Rust port (5)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x006791c8` | 4 | UNCHECKED | current_location | S | docs/building-dialog.md#p1-click-path-top-down | ng handle for the scene (handles, not pointers), `DAT_006791c8` building handle; |
| `0x006b5cc0` | 4 | UNCHECKED | active_camera_flight | S | docs/re/notes/436-contact-camera.md | bounded contact flight survey; static evidence only |
| `0x00664168` | 0 | UNCHECKED | const_f32_one_over_42 | S | docs/timed-actions-live.md | f32 1/42: 0x61's skill factor s = trunc(skill / 42 + 1) |
| `0x0066416c` | 0 | UNCHECKED |  | H | docs/timed-actions.md#callees-what-they-read-and-return | kill 1, H name): v = (byte p+0x81) * (1/252 float 0x66416C); for index 1 no effect list is |
| `0x01015ec0` | 0 | UNCHECKED | fade_slots | D | docs/quirks.md#fade-pool-exhaustion-crash | 32 pointers to fade objects (flags +0, 1 out / 2 in / 4 done / 8 auto-free); not saved, empty after a load |

### Not in `symbols.tsv` (5)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x0061871f` | 171 | UNCHECKED |  |  |  |  |
| `0x00675170` | 4 | UNCHECKED |  |  |  |  |
| `0x006791d0` | 4 | UNCHECKED |  |  |  |  |
| `0x0066234c` | 0 | UNCHECKED |  |  |  |  |
| `0x00664174` | 0 | UNCHECKED |  |  |  |  |

## improve-match

Known to the Rust port first (largest first), then the rest.

### Known to the Rust port (549)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x005ba910` | 11948 | SIZE_MISMATCH | transport_window | S | docs/ui.md#building-dialog-d-window-and-render-2026-11-04-workshop-save-optionsdialog-in-cratesguild-appsrcpanelrs | not read; commands 0x11, 0x0f, 0x17, 0x1c |
| `0x004dcf50` | 8798 | STUB | meeting_scene_trial | S | docs/meetings.md |  |
| `0x00519190` | 7527 | STUB | box_text_builder | S | docs/timed-actions-live.md#fragen-boxen | text into the selected window; draws rand() % N only at a code {rG,N} (0x51A7F9), consumes args in text order (also named io_AppendText, S,  |
| `0x004da690` | 7057 | STUB | meeting_scene | R | docs/elections.md#6-the-meeting-when-a-player-has-a-say | scene of the 0x27 type 1 |
| `0x0051af00` | 6455 | STUB | format_text | R | docs/ui.md#building-dialog-d-window-and-render-2026-11-04-workshop-save-optionsdialog-in-cratesguild-appsrcpanelrs | the game texts filled: %T, %E %3G, %1N3, %i R on recorded messages; %r draws. 10. RNG? If clock DAT_007f4c00 > 0 and pl exists: FUN_0051af00 |
| `0x0046c5a0` | 6080 | SIZE_MISMATCH |  | S | docs/ui.md#3-drawing | - Rich text (FUN_0046c5a0, window flag 0x10) markup in .res texts: $A/$nA newline(s), $N paragraph; headline ornaments do not advance the wo |
| `0x00489a70` | 6055 | SIZE_MISMATCH | ai_MeisterTrade | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  |
| `0x0042bf20` | 5840 | SIZE_MISMATCH | txt_OpenText | S | docs/person-creation.md#10-external-tables | name from guild-rebrew (H); absolute slot numbers 679/876/1006 come from the load order of txt_OpenText (FUN_0042bf20) and were not checke |
| `0x00547770` | 5595 | SIZE_MISMATCH | round_host_immigrants | R | docs/runtime.md#round-change-in-detail-single-player-s-unless-marked | new owners by the group of round % 5: job and money R, the rest S; top-up first |
| `0x005b6300` | 5499 | SIZE_MISMATCH | ui_staff_book | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked |  |
| `0x0048b220` | 4993 | SIZE_MISMATCH | ai_MeisterTrade_store116 | H | docs/master-ai.md | see the doc (also named ai_MeisterTradeAllgemein, H, docs/re/guild-rebrew.md#import) |
| `0x004d6170` | 4923 | SIZE_MISMATCH | combat_end_loot | S | docs/structs/buildings.md#per-round-accounts-0x4d-0x51-0x55 | end of a fight (string cutscenes\combat_end, H name): adds loot to building +0x4D of the person's +0x10C building and dynasty +0x1C (3 sites |
| `0x00432480` | 4850 | SIZE_MISMATCH | scene_anim_update_cb | S | docs/movement.md | see the doc |
| `0x00467920` | 4699 | STUB |  | S | docs/ui.md#main-menu-background-and-sliders-second-pass | - Sliders (FUN_004677e0 create, FUN_00467920 draw): bank graphics g0 left cap, g1 track, g2 fill, g3 knob, |
| `0x0043db70` | 4544 | SIZE_MISMATCH | PrepareFloorWater | S | docs/addresses.md#saveload-module-found-2026-11-01 | PrepareFloorWater Water mask, heights, regions (flood fill 0x0043bf60), strips and index buffers |
| `0x00540020` | 4393 | SIZE_MISMATCH | start_of_round | H | docs/structs/buildings.md#budget-0x39-at-the-round-start-r-cratesguild-simsrcround_startrs | day / start-of-round / end-of-round Called from the session loop (+2 docs); at its end every figure goes to its FUN_00567170 place by a loca |
| `0x005d0660` | 4389 | STUB |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x005b88b0` | 4297 | SIZE_MISMATCH | ui_staff_book_small | H | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked |  |
| `0x00527f60` | 4198 | SIZE_MISMATCH | floor_plan_ui_frame | S | docs/re/notes/436-room-controls.md | calls floor plan frame/input setup |
| `0x004813b0` | 4100 | SIZE_MISMATCH | ai_CalcMeisterDiebe | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  |
| `0x005744c0` | 3976 | SIZE_MISMATCH | HE_GEBAEUDE_BAUEN_finish | R | docs/timed-actions.md#5-table | timed action 0x0d FINISH handler; last stage writes the house owner's +0x170 inside the step, then sends 0x19 (R: london-1408/-1411, docs/re |
| `0x0050a7e0` | 3872 | STUB | person_create | S | docs/commands.md#command-types | 11 (0x0b) 0x004c7790 create a person (FUN_0050a7e0) of type +0x14 (newcomers, office candidates, immigrants; 0 (+2 docs) |
| `0x00571870` | 3816 | SIZE_MISMATCH | he_produktion_finish | R | docs/timed-actions.md#0x04-he_produktion-in-detail-finish-r-read-2026-11-04-cratesguild-simsrcproductionrs | timed action 0x04 FINISH handler (also he HE_PRODUKTION_finish, S, docs/timed-actions.md#5-table: timed action 0x04 FINISH handler; guild-re |
| `0x005b7880` | 3794 | SIZE_MISMATCH | ui_mercenary_book | H | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked |  |
| `0x00569ff0` | 3772 | STUB | HE_EINBRUCH_finish | R | docs/timed-actions.md#0x3f-he_einbruch-burglary-in-detail-s-read-2026-11-03-h-where-marked | timed action 0x3F FINISH; dynasty +0x14 R on years, 1408; loot formula D; see doc |
| `0x0053b6b0` | 3759 | SIZE_MISMATCH | figure_portrait_pick | S | docs/new-game.md#charakter-wählen-s-d-alle-schritte-unter-xvfb-durchgeklickt |  |
| `0x005438c0` | 3724 | SIZE_MISMATCH | host_tick | S | docs/addresses.md#saveload-module-found-2026-11-01 | host tick (registered via 0x005356b0) Issues the time commands (+2 docs) |
| `0x0044e1e0` | 3632 | SIZE_MISMATCH | d3_LoadBinaryAnimStream | S | docs/formats/baf.md#baf-animations-animationsbin | name from guild-rebrew (H); Read by the 3D engine's FUN_0044e1e0 ("d3_LoadAnimStream"), reached through FUN_0044c620, which builds the pat |
| `0x00512ee0` | 3610 | SIZE_MISMATCH |  | S | docs/building-dialog.md#p3-hiring-command-0x62 | <- `FUN_00512ee0` <- `FUN_00514b50` <- `FUN_005145a0` / `host_tick`). **No UI dialog i |
| `0x00561380` | 3588 | SIZE_MISMATCH | HE_SABOTAGE_finish | S | docs/timed-actions.md#5-table | timed action 0x19 FINISH handler |
| `0x0056ee80` | 3556 | SIZE_MISMATCH | robbers_step | S | docs/timed-actions.md | 0x75 |
| `0x005422c0` | 3510 | SIZE_MISMATCH | round_end_buildings | R | docs/structs/buildings.md#per-round-accounts-0x4d-0x51-0x55 | per owner at round end: zero building +0x4D/+0x51/+0x55 by a plain walk over the 256 slots (R: all 22 resets on london-1411; S: the walk), t |
| `0x0054ca10` | 3480 | SIZE_MISMATCH | HE_WERBUNG_finish | S | docs/timed-actions.md#5-table | timed action 0x41 FINISH handler |
| `0x00568060` | 3459 | SIZE_MISMATCH | market_ai_step | S | docs/timed-actions.md#5-table | AI market trade: rng, 0x11, 0x40 (also he HE_MARKT_SUPERVISOR_finish, S, docs/timed-actions.md#5-table: timed action 0x3b FINISH handler; gu |
| `0x00447110` | 3348 | NEAR_MATCHING | rd_object | S | docs/formats/ed3.md#top-level-layout-from-the-reader | name from guild-rebrew (H); u32 object_count then object_count object trees (FUN_00447110, recursive: each object can have children) (+1 doc |
| `0x004e0620` | 3335 | SIZE_MISMATCH | meeting_scene_duel | S | docs/meetings.md | (also named cut_MainDuell, H, docs/re/guild-rebrew.md#import) |
| `0x0052ea30` | 3289 | SIZE_MISMATCH |  | S | docs/building-dialog.md#1-click-routing-s | redrawn after (`FUN_0052ea30`). |
| `0x00585910` | 3288 | NEAR_MATCHING | ui_alchemist_contract | S | docs/alchemy.md | form Locations\Domizil\Alchemistry3; attribute buttons, bonus, dismiss |
| `0x004849b0` | 3226 | SIZE_MISMATCH | ai_master_build_plan_lists | R | docs/master-ai.md | locally processed) attaches workers to production entries. Per run: build the plan list (FUN_004849b0), choose |
| `0x0047f6b0` | 3193 | SIZE_MISMATCH | ai_master_production_farm | S | docs/master-ai.md | Category-2 buildings (FUN_0047f6b0, mines/farms) also attach the master to the 0x09 entry; farms use more rand |
| `0x0044b480` | 3131 | SIZE_MISMATCH | bgf_load | S | docs/formats/bgf.md#texture-slots-and-txs-sets-s-from-the-loader-d-over-objectsbin-2026-11-04 | mesh loader: texture entries (0xE0), identical-entry merge, slot numbering by first use, .txs accepted only if slot count matches |
| `0x0044fc70` | 3117 | SIZE_MISMATCH | d3_AddFLChunk | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.fcn_0044fc70.c); confirm in Ghidra |
| `0x005373e0` | 3071 | SIZE_MISMATCH | ui_pump | R | docs/runtime.md#real-time-to-game-time | Per-frame loop; its time part requests steps from the host clock (guild_sim::host_clock); the rest S |
| `0x005b0230` | 2962 | SIZE_MISMATCH | map_picker_place_markers | S | docs/city-map.md#3-markers-s | building/spot markers, emblems, initial scroll |
| `0x00485970` | 2953 | SIZE_MISMATCH | ai_fern_build_lists | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | class 9: candidate lists of long-distance trade (notes long-trade.md until merged) |
| `0x004a3530` | 2951 | SIZE_MISMATCH |  | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 5b FUN_0047da10 Round-robin scheduler over the 768 person slots, 06:00-22:00, slots per step proportional to e |
| `0x0046a110` | 2848 | SIZE_MISMATCH |  | S | docs/ui.md#main-menu-background-and-sliders-second-pass | - The main menu shows no 3D scene: FUN_0046a110 clears to black and draws the 2D picture _MENUE_BACKGROUND |
| `0x00595330` | 2795 | SIZE_MISMATCH | ui_production_product_rows | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked |  |
| `0x0047ebc0` | 2788 | SIZE_MISMATCH | ai_master_production_tools | S | docs/master-ai.md | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  (+1 docs) |
| `0x004ca970` | 2779 | SIZE_MISMATCH | cm_ExChrGotoBuilding | S | docs/commands.md#command-types | handler of command 0x35: cm_ExChrGotoBuilding: character walks to a building/room |
| `0x00408540` | 2776 | STUB | ch_get_new_path | S | docs/movement.md | see the doc |
| `0x005c3f10` | 2768 | SIZE_MISMATCH | building_options_dialog | D | docs/ui.md#building-dialog-d-window-and-render-2026-11-04-workshop-save-optionsdialog-in-cratesguild-appsrcpanelrs | form Panel\gebaeude_optionen_pergament |
| `0x005186c0` | 2756 | SIZE_MISMATCH | person_name | D | docs/ui.md#building-panel-in-the-running-game-d-window-screenshot-2026-11-04-the-workshop-save-cratesguild-appsrcpanelrs | mode 2: possessive of first name |
| `0x005c18e0` | 2753 | SIZE_MISMATCH | ui_feast_dialog | S | docs/room-actions.md | player dialog |
| `0x00517c00` | 2752 | SIZE_MISMATCH | person_name_text | S | docs/building-dialog.md#a2-who-fills-table-0x7e30d0-the-real-worker-table | 3. Row content: label text via FUN_00517c00(person,1,1,buf) (full name), static text 0x5dc, text id taken from pe |
| `0x005988b0` | 2718 | SIZE_MISMATCH | ui_gebaeude_ausrichten_dialog | S | docs/ui.md#build-window-s-ui_geb_bauen_screen-0x599350-ui_gebaeude_ausrichten_dialog-0x5988b0-d-render-of-the-thief2-save-vs-2026-11-17-tourgilde0021-dialogsbuildrs-guild_simbuild_screen | build screen plot placement (type, out model name) -> plot object or 0: free_plots 0x598150 -> map_spot_objects, the map at once (flag 8; sc |
| `0x00483480` | 2711 | SIZE_MISMATCH | ai_master_production_cart_maker | H | docs/master-ai.md | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  (+1 docs) |
| `0x00483f20` | 2694 | SIZE_MISMATCH | ai_master_production_1f | S | docs/master-ai.md | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  (+1 docs) |
| `0x0054e390` | 2676 | STUB | HE_RAZZIA_finish | S | docs/timed-actions.md#5-table | timed action 0x44 FINISH handler |
| `0x005be140` | 2676 | SIZE_MISMATCH | ui_warehouse_options | R | docs/storage-dialog.md | warehouse dialog: posts 0x12 at 8000, 0x13 at 12800, dynasty +0x50 for the player (28800 on years) |
| `0x00567590` | 2648 | SIZE_MISMATCH | HE_SIM_PERSONAL_finish | S | docs/timed-actions.md#5-table | timed action 0x3a FINISH handler |
| `0x004c16c0` | 2621 | SIZE_MISMATCH | ambience_animals | S | docs/audio.md | birds, locusts, dog, horses, chickens by season; market crowd; indoor Athmos; called from the frame ui_pump, see the doc |
| `0x004e33a0` | 2616 | SIZE_MISMATCH | lease_auction_scene | R | docs/meetings.md | scene of meeting type 10: rounds, winner, commands |
| `0x005a76b0` | 2592 | SIZE_MISMATCH | enter_building_rooms | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | room-id switch interior loop (b, room id b+0x29) |
| `0x00572ff0` | 2583 | SIZE_MISMATCH | HE_AI_WATCH_TRANSPORT_finish | R | docs/timed-actions.md#0x0b-he_ai_watch_transport-finish-r-cratesguild-simsrctransport_watchrs-read-2026-11-04-from-the-disassembly-ghidra-cant-decompile-0x572ff0 | GUILD_ACTIONS, workshop and thief2; timed action 0x0b FINISH handler |
| `0x00511c60` | 2577 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00576c90` | 2576 | SIZE_MISMATCH | assassin_step | S | docs/timed-actions.md | 0x99 |
| `0x004c0cd0` | 2542 | STUB | ambience_weather | S | docs/audio.md | rain loops by amount and camera height, Tropfen_s, gusts; called from the frame ui_pump, see the doc |
| `0x00557460` | 2532 | SIZE_MISMATCH | dark_corner_step | S | docs/timed-actions.md | 0x74 |
| `0x00541620` | 2511 | SIZE_MISMATCH | end_of_round | R | docs/runtime.md#end_of_round-0x541620 | report and bankruptcy test; R for wages, interest and the test, S for the other lines |
| `0x00586c10` | 2476 | SIZE_MISMATCH | ui_cannon_window | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | contact_KANONE window loop, registers the cannon (0x66) |
| `0x0047e270` | 2372 | SIZE_MISMATCH | ai_master_production_base | S | docs/master-ai.md | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  (+1 docs) |
| `0x0052b720` | 2367 | SIZE_MISMATCH |  | S | docs/viewer.md#checked-so-far | controls FUN_0052c9b0/FUN_0052b720; picking = screen-space bounding spheres, nearest projected centre wins, no |
| `0x00531d20` | 2348 | NEAR_MATCHING |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00480330` | 2340 | SIZE_MISMATCH | ai_CalcMeisterWache | S | docs/master-ai.md | S: guard master; 0x43/0x65 crews select idle staff whose figure is inside the workplace before applying quota; port free_guards (no-figure f |
| `0x0056bfd0` | 2324 | SIZE_MISMATCH | HE_ANGRIFF_finish | S | docs/timed-actions.md#5-table | S: 0x49 FINISH state 2 with either fight side empty adds fight_spoils_buildings result to hideout+0x4D; meeting branch has no account write  |
| `0x005944d0` | 2311 | SIZE_MISMATCH | ui_production_dialog | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | Handel_PRODUKTION dialog; calls he_set_person_action directly (H: the UI attach, no command) |
| `0x00487f90` | 2309 | SIZE_MISMATCH | ai_master_assign_workers | R | docs/master-ai.md | FUN_00487f90 per chosen plan: quota n / k (+ n % k first), attach employees with no current entry in slot orde; the room it passes to he_set |
| `0x00419990` | 2307 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00470820` | 2307 | SIZE_MISMATCH |  | S | docs/ui.md#2-the-three-forms-and-how-they-open | FUN_00470820(x, y, "DIR\\NAME") builds forms\DIR\NAME.form (case-insensitive, from forms.bin), creates the (+1 docs) |
| `0x0056cfc0` | 2300 | STUB | HE_EVT_BRAND_finish | S | docs/timed-actions.md#5-table | timed action 0x4f FINISH handler |
| `0x00588aa0` | 2286 | SIZE_MISMATCH | ui_cannon_fire | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | contact_KANONE fire |
| `0x0050ee80` | 2251 | SIZE_MISMATCH | techtree_refresh_items | S | docs/building-dialog.md#6-extend-fun_0059aa10b-focus-tech-tree-and-install-s-r-on-the-water-butts-record-price-and-ticks | item states |
| `0x0054da10` | 2230 | SIZE_MISMATCH | HE_STREIFE_finish | S | docs/timed-actions.md#5-table | timed action 0x43 FINISH handler |
| `0x00556170` | 2224 | SIZE_MISMATCH | HE_SIM_EINWANDERUNG_finish | S | docs/timed-actions.md#5-table | timed action 0x6d FINISH handler |
| `0x0056b700` | 2188 | STUB | HE_UEBERFALL_finish | S | docs/timed-actions-live.md | timed action 0x48 FINISH handler; state 1: spot by name in the city scene, members within 25000 per axis, carts in the level range or within |
| `0x0051f480` | 2167 | SIZE_MISMATCH | ls_SaveEntities | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/loadsave); confirm in Ghidra |
| `0x004fe5f0` | 2138 | SIZE_MISMATCH | person_round_update | R | docs/population.md#fun004fe5f0p-h-name-person_round_update-only-reached-from-the-loop-above-s-one-caller | a person's year: status word, hp curve, birth check, age +1 (also named person_age_death, S, docs/quirks.md#master-deaths-share-the-workers- |
| `0x005ac2d0` | 2137 | SIZE_MISMATCH |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x0048cdb0` | 2131 | SIZE_MISMATCH | ai_fern_dispatch_recipe_led | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | class 9: cart loads, recipe first |
| `0x00562ba0` | 2104 | SIZE_MISMATCH | HE_PRUEGEL_finish | R | docs/timed-actions.md#5-table | timed action 0x1a FINISH handler |
| `0x00529890` | 2095 | SIZE_MISMATCH | ui_worker_table_update | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked | (also named ui_workers_panel_update, H, docs/quirks.md#reported-by-players-for-version-206-h-not-yet-checked) |
| `0x00568ed0` | 2088 | STUB | HE_ENTFUEHREN_finish | S | docs/timed-actions.md#5-table | timed action 0x3c FINISH handler |
| `0x004d5940` | 2087 | NEAR_MATCHING | fight_offer_dialog | S | docs/meetings.md | fight scene of meeting type 3 |
| `0x004c7c50` | 2061 | NEAR_MATCHING | cm_ExSellObjekt | R | docs/commands.md#command-types | handler of command 0x11: cm_ExSellObjekt: move a stack of items, optionally against money (R: result matches the original in scripts/regress |
| `0x0048c5b0` | 2046 | SIZE_MISMATCH | ai_fern_dispatch_item_led | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | class 9: cart loads, item first |
| `0x0045a9d0` | 2040 | SIZE_MISMATCH | nav_grid_add_object | S | docs/movement.md | an object's triangles into the grid: mode, stamp reach, walls |
| `0x004e5a00` | 2033 | STUB | cutscene_run | S | docs/runtime.md#endofround-0x541620 | 114-byte command, type 9, byte 0x60, the person; `FUN_004E5A00` runs it as a cutscene and can end the |
| `0x0053a400` | 2014 | SIZE_MISMATCH | main_Menue | S | docs/ui.md#2-the-three-forms-and-how-they-open | name from guild-rebrew (H); - Main menu: Menu/MAIN_MENU.form, opened by FUN_0053a400. One window (232,160) 352x407, flags 0x10, _FONT, |
| `0x0053c560` | 2012 | SIZE_MISMATCH | parent_skill_pick | S | docs/ui.md#main-menu-background-and-sliders-second-pass | - Player selection (FUN_0053c560) renders Spielerauswahl.ed3 from its camera object "MegaCam": eye |
| `0x0059b260` | 2006 | SIZE_MISMATCH | ui_search_ore_dialog | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | Handel_PRODUKTION dialog; calls he_set_person_action directly (H: the UI attach, no command) |
| `0x00502fe0` | 2003 | NEAR_MATCHING | gm_AllocObjekt | S | docs/person-creation.md#8-types-0x15--0x16-fun004adcd0type-p2-age--p4-p-after-section-2 | name from guild-rebrew (H); This could reach rand only through FUN_00502fe0 creating a new object of prototype 0x134/0x135 (cart:; carts 0x1 |
| `0x00553490` | 1992 | STUB | HE_SCHUTZGELD_finish | S | docs/timed-actions.md#0x62-he_schutzgeld-protection-money-in-detail-s-read-2026-11-03-h-where-marked | timed action 0x62 FINISH handler |
| `0x0055ea30` | 1972 | STUB | HE_TRANSPORT_finish | S | docs/timed-actions.md#5-table | timed action 0x0f FINISH handler; guild-rebrew: he_RunTransport |
| `0x00599350` | 1955 | SIZE_MISMATCH | ui_geb_bauen_screen | S | docs/ui.md#build-window-s-ui_geb_bauen_screen-0x599350-ui_gebaeude_ausrichten_dialog-0x5988b0-d-render-of-the-thief2-save-vs-2026-11-17-tourgilde0021-dialogsbuildrs-guild_simbuild_screen | build screen: a type button (0x427..0x47F) the player affords -> 0x5988B0, then 0xD he_gebaeude_bauen with type, price, plot position and ya |
| `0x004e51d0` | 1953 | SIZE_MISMATCH | cutscene_vote_round | S | docs/elections.md#6-the-meeting-when-a-player-has-a-say | asks the participants in order |
| `0x004823c0` | 1937 | SIZE_MISMATCH | ai_CalcMeisterRaeuber | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | name from guild-rebrew (H); 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  / |
| `0x0053d490` | 1936 | SIZE_MISMATCH | name_dialog | S | docs/new-game.md#charakter-wählen-s-d-alle-schritte-unter-xvfb-durchgeklickt |  |
| `0x0056aef0` | 1932 | SIZE_MISMATCH | HE_GEB_SPIONAGE_finish | R | docs/timed-actions.md#5-table | timed action 0x40 FINISH handler; R on state 0 attach and the free, states 1-2 S (World::spying_step) |
| `0x005238c0` | 1915 | SIZE_MISMATCH | ld_LoadUnitsAndActionQueue | S | docs/formats/save-sections.md#save-file-section-order-from-the-games-loader | 20 0x005238C0 8 + 242/entry (calls 0x00523710, 319 flat) H; reads units and the action records, relinks them; head (prev -1) becomes figure  |
| `0x00596d70` | 1891 | SIZE_MISMATCH | ui_stock_cell_draw | S | docs/storage-dialog.md | xtures from text ids 0x741+kind, 0x44-pixel grid, FUN_00596d70 per row). No person state. |
| `0x0059c000` | 1886 | SIZE_MISMATCH | ui_production_outdoor_dialog | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | Handel_PRODUKTION dialog; calls he_set_person_action directly (H: the UI attach, no command) |
| `0x0046dff0` | 1876 | SIZE_MISMATCH |  | S | docs/ui.md#3-drawing | - Window draw FUN_0046dff0: flag 0x400 black, flag 1 BLACK texture with alpha, or bg texture with alpha |
| `0x00509fc0` | 1870 | SIZE_MISMATCH | person_bankrupt_seize_nonhost | H | docs/runtime.md#what-ends-the-day-s | bankruptcy scene without mode bit 8: sends 0x0F/0x16/0x17/0x19/0x1A/0x1C/0x2B/0x38 (not read) |
| `0x00480c60` | 1861 | SIZE_MISMATCH | ai_CalcAngriff | D | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest |  |
| `0x00544c50` | 1845 | SIZE_MISMATCH | win_main | S | docs/building-dialog.md#p1-click-path-top-down | 1. `host_tick` 0x5438c0 (<- 0x544c50) calls `day` 0x59a340 (S, caller list). `day` is the in-city loop: it (also named WinMain, H, docs/re/g |
| `0x004bf1b0` | 1840 | SIZE_MISMATCH | route_edit_point_window | S | docs/route-window.md | player dialog |
| `0x00585030` | 1839 | SIZE_MISMATCH | ui_alchemist_formula_book | S | docs/alchemy.md | form Locations\Domizil\Alchemistry2; buttons: invent (0x585850), improve selected (0x585760) |
| `0x0052fde0` | 1830 | SIZE_MISMATCH | room_portal_hover | S | docs/re/notes/436-room-controls.md | contact_gate_ suffix resolves installed room; tp_TUER is separate; called from the frame ui_pump |
| `0x004700a0` | 1828 | SIZE_MISMATCH | d2_Open | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/m_alloc); confirm in Ghidra |
| `0x0043ef20` | 1814 | SIZE_MISMATCH |  | S | docs/viewer.md#checked-so-far | outdoor ambient table 0x6a2a18, sun pLicht, terrain as FUN_0043ef20, fog record 0 x (1 - fog_plane/100). |
| `0x0057d0d0` | 1802 | NEAR_MATCHING | circus_troupe_step | S | docs/timed-actions.md | 0xA1 |
| `0x0055f5c0` | 1800 | SIZE_MISMATCH | HE_MESSAGEBOX_finish | S | docs/timed-actions.md#5-table | timed action 0x11 FINISH handler |
| `0x004f01c0` | 1799 | SIZE_MISMATCH | cannon_explode | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | buildings within the blast: fire 0x4F or condition 0x16 |
| `0x00533090` | 1798 | SIZE_MISMATCH |  | S | docs/building-dialog.md#1-click-routing-s |  |
| `0x00440870` | 1789 | SIZE_MISMATCH | water_draw | S | docs/addresses.md#saveload-module-found-2026-11-01 | water draw (per chunk) Fills vertices (FVF 0x142), one DrawIndexedPrimitive per region (+1 docs) |
| `0x0053ed60` | 1778 | SIZE_MISMATCH | city_map_pick | S | docs/new-game.md#charakter-wählen-s-d-alle-schritte-unter-xvfb-durchgeklickt |  |
| `0x00506380` | 1776 | SIZE_MISMATCH | player_building_item_rights | S | docs/re/notes/436-room-access.md | ct +0x218, not read further); rights bit 0x10 of `FUN_00506380` and `0x7746C8` (H: hides |
| `0x005522d0` | 1740 | SIZE_MISMATCH | HE_EVT_PEST_finish | S | docs/timed-actions.md#5-table | timed action 0x59 FINISH handler |
| `0x005b11f0` | 1734 | SIZE_MISMATCH | scene_person_controls_refresh | S | docs/city-map.md#3-markers-s | map dots of dynasty workers and carts (emblem - 0x53), owner card on a held right button; port World::map_dots |
| `0x00489250` | 1731 | STUB | ai_MeisterCollectTrans | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 5 FUN_0047de50 per person (switch 3430) Workshop-master AI (from 06:30; persons of type 1/2 with a workplace,  |
| `0x00494820` | 1700 | SIZE_MISMATCH | ai_methods_load | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | loads ai_data_2.dfn and ai_method_addon.ini into the method table; called once from FUN_0047CE90 |
| `0x00560290` | 1700 | SIZE_MISMATCH | HE_KRAEUTER_SAMMELN_finish | S | docs/timed-actions.md#5-table | timed action 0x14 FINISH handler |
| `0x0043fa10` | 1695 | SIZE_MISMATCH | floor_constructor | S | docs/addresses.md#saveload-module-found-2026-11-01 | floor constructor Copies the scene's terrain record; loads missing maps from files |
| `0x005c2a40` | 1683 | SIZE_MISMATCH | ui_building_new_rooms_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x005c5310` | 1664 | SIZE_MISMATCH | ob_HandleBepflanzung | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00530c60` | 1646 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00552a60` | 1646 | SIZE_MISMATCH | HE_TASCHENDIEB_finish | R | docs/timed-actions.md#0x61-he_taschendieb-pickpocketing-in-detail-r-2026-11-03 | timed action 0x61 FINISH handler; state 1 (thieves come home): loot = sum over thieves of 3-6 x 2*(rand((s+1)*s)+2s), FUN_0050B750, building |
| `0x005ceef0` | 1640 | STUB | ui_master_certificate_management | S | docs/master-certificate.md | bounded original-code survey; Editable policies/products, budget on close; General/Production text buttons0xF60/0x4155 via0x533A60. |
| `0x00415710` | 1627 | SIZE_MISMATCH | rain_update | S | docs/viewer.md#weather-particles | see docs/re/notes/particles.md |
| `0x0050e830` | 1609 | SIZE_MISMATCH | techtree_build_list | S | docs/building-dialog.md#6-extend-fun_0059aa10b-focus-tech-tree-and-install-s-r-on-the-water-butts-record-price-and-ticks | list and layout |
| `0x005848b0` | 1601 | SIZE_MISMATCH | ui_alchemist_hire_list | S | docs/alchemy.md | form Locations\Domizil\Alchemistry1; 3 candidate slots |
| `0x0059aa10` | 1593 | SIZE_MISMATCH | ui_techtree_dialog | S | docs/building-dialog.md#6-extend-fun_0059aa10b-focus-tech-tree-and-install-s-r-on-the-water-butts-record-price-and-ticks | tech tree dialog of a room |
| `0x0042ff50` | 1584 | SIZE_MISMATCH | fopen | S | docs/addresses.md#saveload-module-found-2026-11-01 | vfs fread, fseek, fopen, fclose The engine's virtual file system (plain files and zip archives); guild-rebrew: vfs_Tfopen |
| `0x0052f7b0` | 1574 | SIZE_MISMATCH | panel_buttons_poll | S | docs/ui.md#building-dialog-d-window-and-render-2026-11-04-workshop-save-optionsdialog-in-cratesguild-appsrcpanelrs | compares the clicked control id every frame |
| `0x00565ab0` | 1560 | NEAR_MATCHING | HE_ERNTEN_finish | S | docs/timed-actions.md#5-table | timed action 0x28 FINISH handler |
| `0x00498670` | 1558 | SIZE_MISMATCH | ai_pre_build_workshop | H | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x00590b80` | 1550 | SIZE_MISMATCH | tooltip_item_trade_weapon | S | docs/ui.md#right-button-info-popups-s-tooltip_pump-0x590670-d-renders-of-the-workshop-save | ToolTip_Objekte_Handelsgut/_Waffen |
| `0x00554170` | 1524 | SIZE_MISMATCH | HE_UMLAND_PATROL_finish | R | docs/timed-actions.md#5-table | timed action 0x65 FINISH handler; R on state 0 attach, later states S (World::country_patrol_step) |
| `0x0046bd20` | 1518 | SIZE_MISMATCH |  | S | docs/ui.md#3-drawing | Text box FUN_0046bd20: word wrap at width, flags 8 centre, 0x10 right, 2 white, 1 grey, 0x40 custom colour, |
| `0x005099e0` | 1498 | SIZE_MISMATCH | death_inherit_commands | R | docs/timed-actions.md#death-and-inheritance-cratesguild-simsrcdeathrs | grave, buildings, cash, wealth, texts of a death |
| `0x0046b5f0` | 1488 | SIZE_MISMATCH |  | S | docs/formats/form.md#record--one-window-frm2-0x101c-bytes | (FUN_0046b5f0); 0x200 scroll (hypothesis); 0x400 opaque black fill; 0x1000/0x10000 render surfaces; headline ornaments contribute to centeri |
| `0x005043d0` | 1488 | SIZE_MISMATCH | building_create | S | docs/commands.md#command-types | 10 (0x0a) 0x004c76c0 create a building (FUN_005043d0): type +0x14 for the owner person +0x16; takes the buildi (+1 docs); guild-rebrew: gm_A |
| `0x005a80d0` | 1488 | SIZE_MISMATCH | enter_building_scene | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | building-type switch interior (0x1e/1f/20/27/47/48-4a/4e-50) |
| `0x00595e20` | 1484 | SIZE_MISMATCH | ui_production_stock_tables_fill | S | docs/storage-dialog.md#purchased-slot-packing-and-coordinates | Persistent A/B prototype cells; purchased slots index separate 0..8 header-packing tables. |
| `0x005d3120` | 1479 | SIZE_MISMATCH | privilege_court_dialog | S | docs/ui.md#privileges | see the table of entries |
| `0x0042e740` | 1472 | SIZE_MISMATCH | vfs_AddFile | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/vfs); confirm in Ghidra |
| `0x00549c50` | 1468 | SIZE_MISMATCH | regulars_table_messages | S | docs/commands.md | texts 0x1893..0x189D of command 0x54; not ported |
| `0x004ed240` | 1467 | SIZE_MISMATCH | alchemy_load_ini | S | docs/alchemy.md | alchemy_data.ini: PLR_i (12-byte prototypes at 0x772FDC) and RCP_i (12-byte recipes at 0x772FE4) |
| `0x0059ba40` | 1462 | SIZE_MISMATCH | ui_mining_dialog | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | Handel_PRODUKTION dialog; calls he_set_person_action directly (H: the UI attach, no command) |
| `0x005624a0` | 1460 | SIZE_MISMATCH | HE_SPIONAGE_finish | S | docs/timed-actions-live.md#late-kinds-0x60-live-0x6a-0x14-0x15-0x18-live-0x88-0x89-0x8d-0x8f-late_kindsrs-s-1111 | timed action 0x18 FINISH handler: 0 agent from the 0x49 ticket, pay, attach; 1 next building (classes 0xA7FCC3A6 or 0x20); 2 at the door; 3  |
| `0x0054bc90` | 1456 | SIZE_MISMATCH | HE_FEST_MSG_finish | S | docs/timed-actions.md#5-table | timed action 0x36 FINISH handler |
| `0x0059a340` | 1443 | SIZE_MISMATCH | day | H | docs/addresses.md#saveload-module-found-2026-11-01 | day / start-of-round / end-of-round Called from the session loop (+1 docs) |
| `0x005156a0` | 1432 | SIZE_MISMATCH | room_bind_object_visibility_cb | S | docs/re/notes/436-room-visibility.md | "under construction" bits are cleared by the interior-view callback FUN_005156a0 (UI, not compared); person ty |
| `0x00521920` | 1421 | SIZE_MISMATCH | load_savegame | S | docs/addresses.md#saveload-module-found-2026-11-01 | load_savegame Master loader: header, globals, then ~25 section loaders in order (docs/formats/save-s (+3 docs) |
| `0x005a86a0` | 1418 | STUB | enter_scene_room | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | room id switch for scene interior |
| `0x005017a0` | 1407 | SIZE_MISMATCH | market_availability_refresh | R | docs/market.md#5-single-player-only-tail-0x14cbca0--1 | single player: rec+4, commands 0x11, 0x3F, 0x16; RNG for other cities |
| `0x0059e740` | 1405 | SIZE_MISMATCH | ui_gather_herbs_dialog | S | docs/timed-actions-live.md#late-kinds-0x60-live-0x6a-0x14-0x15-0x18-live-0x88-0x89-0x8d-0x8f-late_kindsrs-s-1111 | contact_SAMMELN (rooms 0xCF, 0x118, 0x29E): player picks a herb, posts 0x14 (+0xAE item, +0xAC/+0x8C the selected persons, +0xB0 contact+8); |
| `0x005d4a20` | 1400 | NEAR_MATCHING | privileges_panel | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x0045a3a0` | 1388 | SIZE_MISMATCH | nav_grid_read_terrain | S | docs/movement.md | the terrain into cell types and heights; the image of London shows it right (D) |
| `0x00564460` | 1388 | STUB | HE_GEB_KAUFANGEBOT_finish | S | docs/timed-actions.md#5-table | timed action 0x21 FINISH handler |
| `0x00531620` | 1363 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00428800` | 1360 | SIZE_MISMATCH | script_eval | S | docs/formats/esc.md#the-machine-s | strictly left to right, no precedence; && and // bitwise on both sides |
| `0x0041a380` | 1359 | SIZE_MISMATCH | d3d8_init | H | docs/addresses.md#runtime--platform | d3d8_init Calls Direct3DCreate8, device in 0x006b5ddc |
| `0x005797a0` | 1351 | SIZE_MISMATCH |  | S | docs/replay.md#where-the-replay-stands-and-how-to-continue-2026-11-01-evening | - 0x8C resource search modelled (FUN_00579690 / FUN_005797a0): exact in both format-5/6 recordings (11 + 9 |
| `0x00589d00` | 1350 | NEAR_MATCHING |  | S | docs/runtime.md#endofround-0x541620 | as 00589930 |
| `0x00543080` | 1349 | SIZE_MISMATCH | round_host | S | docs/runtime.md#round-change-in-detail-single-player-s-unless-marked | round host work: all persons, RNG, commands; - FUN_00546de0 (called from FUN_00543080): entries with e[+0x78] & 0x10. (V) (+1 docs) |
| `0x00520310` | 1346 | SIZE_MISMATCH | load_market_tables | S | docs/market.md#market-tables-at-a-round-change | hdr and records per city |
| `0x0051e490` | 1340 | SIZE_MISMATCH | save_header_write | S | docs/building-dialog.md#hiring-in-a-live-game | writes header, screenshot, 0x7747B4, 0x60 name at 0x7E2480 |
| `0x00554f00` | 1335 | SIZE_MISMATCH | HE_TITEL_VERGABE_finish | S | docs/timed-actions.md#5-table | timed action 0x69 FINISH handler |
| `0x00447e30` | 1319 | SIZE_MISMATCH |  | S | docs/formats/ed3.md#water-regions-terrain-layers | Each terrain layer is one water region: the engine's 0x158-byte record (FUN_00447e30 fills it, table at floor |
| `0x005e9da0` | 1318 | SIZE_MISMATCH | cannon_shot_step_slow | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | as 0x5E9870, half the step |
| `0x00555510` | 1317 | SIZE_MISMATCH | HE_SIM_WIRTSHAUS_finish | S | docs/timed-actions.md#5-table | timed action 0x68 FINISH handler |
| `0x0056e3c0` | 1312 | SIZE_MISMATCH | HE_KILL_PLAYER_finish | S | docs/timed-actions.md#5-table | timed action 0x72 FINISH handler |
| `0x005279f0` | 1305 | SIZE_MISMATCH | floor_plan_frame_input_and_draw | S | docs/re/notes/436-room-controls.md | RGB mask selection and visible plan draw with distinct origins |
| `0x0055df80` | 1304 | SIZE_MISMATCH | HE_TRANSPORT_leg_type3 | S | docs/timed-actions.md#0x03-he_abbau-and-0x0f-he_transport-in-detail-read-2026-11-02-h-where-marked | 0x0F state-1 leg, route type 3: idle within 300 of +0xD8.. or after 8 calls; guild-rebrew: he_TransportStadtStadt |
| `0x00529160` | 1296 | SIZE_MISMATCH | he_set_person_action | S | docs/commands.md#command-types | 71 (0x47) 0x004cc4c0 cm_ExChangePlayerHe: person +0x10 changes its current action (FUN_00529160); with +0x14 = (+2 docs); also queues figure |
| `0x00516040` | 1288 | NEAR_MATCHING |  | S | docs/viewer.md#checked-so-far | - Seasons: .txs row = season (FUN_00442a30); ground suffix _fruehling/_herbst/_snow + _high (FUN_00516040). |
| `0x0055d0d0` | 1281 | SIZE_MISMATCH | HE_TRANSPORT_start | S | docs/timed-actions.md#5-table | timed action 0x0f START handler (+1 docs); guild-rebrew: he_AllocTransport |
| `0x0053b1b0` | 1280 | SIZE_MISMATCH | talent_points | S | docs/new-game.md#charakter-wählen-s-d-alle-schritte-unter-xvfb-durchgeklickt |  |
| `0x0045c5b0` | 1276 | SIZE_MISMATCH | texture_load | S | docs/addresses.md#saveload-module-found-2026-11-01 | texture load, _AN<n> frame chain Frame count at texture +0x5c, frame index +0x5d, period index +0x5e (+1 docs) |
| `0x004e99e0` | 1275 | SIZE_MISMATCH | office_election_resolve | R | docs/elections.md | contests R on thief2, races S |
| `0x0055c740` | 1272 | SIZE_MISMATCH | HE_ARBEITER_EINSTELLEN_finish | R | docs/timed-actions.md#5-table | 0x06 FINISH; 0x30 through dummy_EINGANG, first wage 0x10, dynasty +0x4C R on 1411/years; S: state 1 queues hire ticket tail+0x38, state 2 wa |
| `0x00487470` | 1266 | SIZE_MISMATCH | ai_master_upgrade_human | S | docs/master-ai.md | ftol(line + v) into dynasty +0x40, see doc |
| `0x005c30e0` | 1260 | SIZE_MISMATCH | ui_building_enhance_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x005bebe0` | 1253 | SIZE_MISMATCH | ui_talent_training | S | docs/room-actions.md | player dialog |
| `0x004fb7a0` | 1252 | SIZE_MISMATCH | disasters_year | R | docs/runtime.md#yearly-disasters-fun004fb7a0-and-the-block-0x99f5a0 | one year; S for the draws |
| `0x00569a90` | 1248 | SIZE_MISMATCH | HE_LOESEGELD_finish | S | docs/timed-actions.md#5-table | S: 0x3E FINISH ransom tail+0 to tail+4; action target is prison building handle; only if it exists: recipient dynasty+0x20 and prison+0x4D + |
| `0x00416540` | 1244 | SIZE_MISMATCH | snow_update | S | docs/viewer.md#weather-particles | see docs/re/notes/particles.md |
| `0x00571240` | 1240 | STUB | HE_ABBAU_finish | S | docs/timed-actions.md#5-table | timed action 0x03 FINISH handler |
| `0x004ef770` | 1234 | SIZE_MISMATCH | cannon_table_load | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | section 18 after the weather |
| `0x00497990` | 1232 | SIZE_MISMATCH | ai_pre_build_residence | H | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x005a4490` | 1225 | SIZE_MISMATCH | credit_window | S | docs/ui.md#taking-out-a-loan-creditdialog-fun_005a4090-s-record-d | the lender's list of running loans, with the button to credit_dialog |
| `0x0059ecc0` | 1224 | SIZE_MISMATCH | ui_catch_vermin_dialog | S | docs/timed-actions-live.md#late-kinds-0x60-live-0x6a-0x14-0x15-0x18-live-0x88-0x89-0x8d-0x8f-late_kindsrs-s-1111 | ob_TEICH (room 0xDD): player picks 0x1C1..0x1C3, posts 0x15; only poster of 0x15 |
| `0x004432d0` | 1223 | SIZE_MISMATCH | scene_switch | S | docs/timed-actions-live.md | (scene, flag) sets 0x6b8010 and swaps per-scene globals; 0 = city |
| `0x00536bb0` | 1220 | SIZE_MISMATCH |  | S | docs/viewer.md#checked-so-far | fog blend record 0 -> 1 and the sky texture group (FUN_00536bb0); snow switches to the ambient table 0x6a2b68. |
| `0x004f3ef0` | 1211 | SIZE_MISMATCH | cemetery_round | R | docs/structs/buildings.md#cemeteries | the round walk over the graves: 0x60 wear and spawn R on thief2 55441, 55442; the rest S |
| `0x0054ac70` | 1209 | SIZE_MISMATCH | HE_PROZESS_finish | S | docs/timed-actions.md#5-table | timed action 0x2c FINISH handler |
| `0x0056e980` | 1208 | SIZE_MISMATCH | he_night_watchman_b | S | docs/addresses.md#saveload-module-found-2026-11-01 | action 0x73 = night watchman Calls the hours; one of ~56 action handler pairs registered in 0x005709 (+1 docs) |
| `0x004e2b70` | 1199 | NEAR_MATCHING | meeting_scene_player_death | S | docs/meetings.md |  |
| `0x00565350` | 1196 | SIZE_MISMATCH | HE_MEISTER_BESTANDEN_finish | S | docs/timed-actions.md#5-table | timed action 0x26 FINISH handler |
| `0x0049e900` | 1191 | STUB | ai_loan_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartKreditNehmen, H, docs/re/guild-rebrew.md#import) |
| `0x00538850` | 1190 | SIZE_MISMATCH | video_init | S | docs/viewer.md#compared-with-the-game-user-screenshots-2026-11-02-1024x768-kept-in-gamefilesscreenshots2026-11-02 | window + D3D8 init; sets the 3D viewport RECT 0x6a3764 = (0, 0, screen width - 0x6A, height) (D: 918 at 1024, shots line up) |
| `0x00527540` | 1187 | STUB | floor_plan_load_assets_and_regions | S | docs/re/notes/436-room-controls.md | bitmap/mask, exact class fallbacks, authored vs residence region order |
| `0x005c3820` | 1181 | SIZE_MISMATCH | ui_techtree_effects_dialog | S | docs/ui.md#tech-tree-extend-row-s-d-renders-of-the-workshop-save-vs-2026-11-17-tourgilde0003 | techtree\auswirkungen: one bar per category 1..0x24 (`dialogs/effects.rs`) |
| `0x005110d0` | 1180 | NEAR_MATCHING | init_LoadGebaeudeScene | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x004ff8f0` | 1179 | SIZE_MISMATCH | population_balance | H | docs/runtime.md#population-balance-fun004ff8f0-s-partly-read-not-ported-164 | y get replaced (`FUN_004c6150`, stall boy/maid); `FUN_004ff8f0`. |
| `0x004cb7f0` | 1175 | NEAR_MATCHING | cm_handler_0x3a | R | docs/commands.md#command-types | handler of command 0x3a: cm_ExGebUpgrade, cm_ExSetGebUpgrade: upgrade building +0x10 to type +1 (fails if level +0x (+1 docs) (R: result mat |
| `0x004eab40` | 1173 | SIZE_MISMATCH | guild_seat | R | docs/offices.md#9-stage-h-of-the-round-change-fun_004eafe0-r | offices 0x1E..0x21; no hall: plot draw and 0x0D (S) (also named amt_calc_zuenfte, S, docs/offices.md#8-all-writers-of-the-table--person-offi |
| `0x0055c270` | 1168 | NEAR_MATCHING | HE_UPGRADE_DUMMY_finish | R | docs/building-dialog.md#6-extend-fun_0059aa10b-focus-tech-tree-and-install-s-r-on-the-water-butts-record-price-and-ticks | timed action 0x02 FINISH handler |
| `0x004ef2e0` | 1157 | SIZE_MISMATCH | cannon_table_save | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | section 18 after the weather |
| `0x00474300` | 1152 | SIZE_MISMATCH | ui_input_key | S | docs/ui.md#not-done-h-or-open | key into the focused input: append, Backspace 0x0E, Tab 0x0F focus cycle, Enter 0x1C drops focus |
| `0x005145a0` | 1149 | SIZE_MISMATCH |  | S | docs/building-dialog.md#p3-hiring-command-0x62 | <- `FUN_00512ee0` <- `FUN_00514b50` <- `FUN_005145a0` / `host_tick`). **No UI dialog is a caller**: no form, no click path |
| `0x0045b290` | 1136 | SIZE_MISMATCH | height_grid_fill | S | docs/crime.md#danger-grid-dangerrs-0x99ef80-section-12-at-762-9-bytes-per-cell | origin and step of the height grid: extent over points - 1.75 |
| `0x00524b50` | 1127 | SIZE_MISMATCH | load_s14_actions | S | docs/addresses.md#saveload-module-found-2026-11-01 | loaders 0x00522510, 0x00522ac0, 0x00524040, 0x005246e0, 0x00524b50, 0x00524fc0, 0x004ef770, 0x004f3bb0, 0x004f (+2 docs) |
| `0x005974e0` | 1113 | SIZE_MISMATCH | ui_goods_store_stock_fill | S | docs/storage-dialog.md#purchased-slot-packing-and-coordinates | Special0x116 uses store+0x1C slots0..16 for four A headers; all goods use A, B unused. |
| `0x00578ed0` | 1104 | NEAR_MATCHING | death_pact_step | S | docs/timed-actions.md | 0x8A |
| `0x0054f910` | 1095 | NEAR_MATCHING | HE_BELEIDIGUNG_start | S | docs/timed-actions.md#5-table | timed action 0x47 START handler |
| `0x005c4ec0` | 1095 | SIZE_MISMATCH | credit_collect_debt | R | docs/timed-actions.md#0x23-he_kredit-finish-0x564b90-start-0x5649d0-r | a debtor pays: 0x0F cash, then 0x11 forced sales at half the price before the round's update, 0x10 debt if nothing sold, else 0x0F(bank,-1,s |
| `0x0055cc80` | 1092 | NEAR_MATCHING | HE_MEISTER_EINSTELLEN_finish | D | docs/building-dialog.md#c-staff-book-ob_personalbuch---fun_005b6300b-name-s-structure-stack-locals-are-garbled-in-the-decompile-offsets-of-locals-h | timed action 0x07 FINISH handler: state 2 sets the 0x3D person +0x165 = 0, +0x164 = profession (D: prince/ransom regress, replay in World::e |
| `0x0043ad20` | 1089 | SIZE_MISMATCH | render_scene_opaque_then_deferred | S | docs/re/notes/436-additive-materials.md | bounded original-code survey |
| `0x004bfe00` | 1088 | SIZE_MISMATCH | route_window | S | docs/building-dialog.md#3-buttons-s-for-idsflow-h-for-names | small second button opens `FUN_004bfe00(cart)` (cart info, not read). |
| `0x004045c0` | 1085 | SIZE_MISMATCH | ch_CheckAniMorph | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00426680` | 1084 | SIZE_MISMATCH | script_next_token | S | docs/formats/esc.md#the-machine-s | % is no delimiter; a lone ! gives an empty token |
| `0x004ee290` | 1082 | NEAR_MATCHING | alchemist_create | S | docs/alchemy.md | 0x63 handler body: person in the residence, record +4 mood=(vern01+1)*0.5, starting recipe slot, flag 4 (also named ahm_ExAllocAlchemist, S, |
| `0x005305d0` | 1069 | SIZE_MISMATCH | scene_click_pick | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | sets DAT_007746a0 (clicked object), 7e431c, 7e2aa0 (also named sv_HandleObjects, H, docs/re/guild-rebrew.md#import) |
| `0x005ab3e0` | 1063 | SIZE_MISMATCH | ui_church_buy_indulgence | S | docs/indulgence.md | bounded original-code survey |
| `0x00499090` | 1060 | SIZE_MISMATCH | ai_pre_sabotage | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x004c9550` | 1060 | SIZE_MISMATCH | cm_ExSysMessage | S | docs/commands.md#command-types | handler of command 0x20: cm_ExSysMessage; system message; sub-type 0x0E at +0x10 is a sync marker |
| `0x0058a6b0` | 1047 | SIZE_MISMATCH |  | S | docs/runtime.md#endofround-0x541620 | as 00589930 |
| `0x004094c0` | 1044 | SIZE_MISMATCH | ch_walk_find_path | S | docs/movement.md | see the doc |
| `0x005963f0` | 1043 | SIZE_MISMATCH | ui_production_stock_tables_draw | S | docs/storage-dialog.md#purchased-slot-packing-and-coordinates | Centered headers0x741+kind; cell pitch68, row pitch header-height+22, B offset0xB6. |
| `0x00504f30` | 1040 | SIZE_MISMATCH | type_permission | S | may a person own a building type: 0/1/2 (World::type_permission, S, D: owners of thief2 = 1) | e town-owned payer of `FUN_00507A10` is missing; the plot refusal of Enhance isn't read; the follow-up event of |
| `0x0051e080` | 1035 | SIZE_MISMATCH | save_game | S | docs/quirks.md#fade-pool-exhaustion-crash | save_game(path, name, flag): fopen, header (0x51e490), globals, then one writer per section in the loader's order; called by host_tick for t |
| `0x0053dc20` | 1016 | SIZE_MISMATCH | new_game_flow | S | docs/new-game.md#charakter-wählen-s-d-alle-schritte-unter-xvfb-durchgeklickt |  |
| `0x00564b90` | 1013 | SIZE_MISMATCH | HE_KREDIT_finish | R | docs/timed-actions.md#0x23-he_kredit-finish-0x564b90-start-0x5649d0-r | timed action 0x23 FINISH handler: the year's interest; the end of the loan S |
| `0x00578a10` | 1012 | SIZE_MISMATCH | HE_HAUCH_DES_VERFALLS_finish | S | docs/timed-actions-live.md#late-kinds-0x60-live-0x6a-0x14-0x15-0x88-0x8f-late_kindsrs-s-1111 | timed action 0x89 FINISH handler; read, not ported |
| `0x0040a200` | 1011 | SIZE_MISMATCH | ch_walk_rotation | S | docs/movement.md | see the doc (also named ch_WalkOnPathRotation, H, docs/re/guild-rebrew.md#import) |
| `0x004c2860` | 1008 | SIZE_MISMATCH | music_tick | S | docs/audio.md | pause, end of track, season change, change of place; called from the frame ui_pump, see the doc |
| `0x0059fe60` | 1007 | SIZE_MISMATCH | ui_lover_list | S | docs/room-actions.md | player dialog |
| `0x00407e30` | 1006 | SIZE_MISMATCH | ch_goal_cell | S | docs/movement.md | first free cell in diamond rings up to 8 |
| `0x0050d6d0` | 1003 | SIZE_MISMATCH | credit_offers | D | docs/structs/buildings.md#a-moneylenders-offers | offers of a moneylender to a person, S for the amounts, D for terms and rates |
| `0x004faed0` | 1002 | SIZE_MISMATCH | city_rating_compute | R | docs/market.md#the-citys-rating-fun_004fb390-command-0x41 | ten fields, see the doc |
| `0x00559aa0` | 1001 | STUB | politician_move_on | S | docs/timed-actions.md | 0x7A: R(6), unit; next building by the step of the visit or back to the same (tavern pick dropped, quirk) |
| `0x005c8c40` | 998 | NEAR_MATCHING | player_stats_panel | S | docs/ui.md#1-window-patterns-look-here-before-building-a-window | HUD book: Panel\player_stats, radio tabs Money/Buildings/Masters (texts 0x3FDD.. H), last tab DAT_0077533C (crates/guild-app/src/dialogs/boo |
| `0x005d42e0` | 998 | SIZE_MISMATCH |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x004a04b0` | 996 | SIZE_MISMATCH | ai_upgrade_guild_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartUpgradeZunft, H, docs/re/guild-rebrew.md#import) |
| `0x0057b390` | 992 | SIZE_MISMATCH | idle_hands_step | S | docs/timed-actions.md | 0x93 |
| `0x004f3310` | 990 | SIZE_MISMATCH | person_hire_candidate | S | docs/person-creation.md#12-hiring-a-candidate-command-0x62-cm_handler_0x62-0x4cda90---fun_004f3310-person_hire_candidate | (cmd+0x10): fills a type-0x14 person inline from candidate record of building +0x65 list; 1 rng_rand_unit (+0x14) + 768x2 R(64)-32 into the  |
| `0x005aeab0` | 990 | SIZE_MISMATCH | ui_ransom | S | docs/room-actions.md | player dialog |
| `0x0059fa80` | 989 | SIZE_MISMATCH | ui_lover_end_affair | S | docs/room-actions.md | player dialog |
| `0x004efde0` | 988 | SIZE_MISMATCH | cannon_tick | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | per frame: charge regeneration, shot flight, explosion trigger |
| `0x005cf720` | 982 | SIZE_MISMATCH | person_filter | S | docs/timed-actions.md#0x2b-he_gottesdienst | filter record +4 flags; ported for 0xC00 only (service.rs may_be_sought) |
| `0x0058dbe0` | 975 | SIZE_MISMATCH | ui_cemetery_fog | S | docs/city-map.md#5-callers-of-pickbuildingdialog-s-purpose-h-unless-the-contact-name-says-it | fog of horror: map pick without callback, form Locations\Friedhof\Fog with two sliders, posts 0x90 (+0x58 target, +0x5C radius, +0x60 intens |
| `0x00589930` | 974 | SIZE_MISMATCH |  | S | docs/runtime.md#endofround-0x541620 | player-only dialog: dynasty +0x28, 0x10 to nobody, posts 0x99; ported in dynasty_lines, no recording |
| `0x004ff490` | 971 | SIZE_MISMATCH | person_birth_check | R | docs/population.md | pregnancy and birth; R thief2, D London years |
| `0x005c02a0` | 969 | NEAR_MATCHING | ui_bribery_confirm | S | docs/room-actions.md | player dialog |
| `0x0054a6a0` | 965 | SIZE_MISMATCH | HE_GOTTESDIENST_finish | S | docs/timed-actions.md#5-table | timed action 0x2b FINISH handler |
| `0x005cd440` | 964 | SIZE_MISMATCH | ui_pick_office_holder | S | docs/ui.md#privileges | see the table of entries |
| `0x004214c0` | 962 | SIZE_MISMATCH | nav_astar_bidirectional | D | docs/movement.md | 27 of 28 carts under way in saves within 2 cells of the ported path (cart_on_path.py) |
| `0x00411fe0` | 960 | SIZE_MISMATCH | input_poll_device | H | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | from the frame call tree |
| `0x00486c40` | 955 | SIZE_MISMATCH | ai_guild_weapon_demand | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | what the staff lacks: unarmed want ladder[0], armed the next rung; sellers; budget +0x39 (guild_trade.rs) |
| `0x00509620` | 953 | SIZE_MISMATCH | person_succession | R | docs/offices.md#7-fun00509620oldh-heirh-command-0x0d-succession-heir-takes-over-the-old-persons-slot | command 0x0d: heir takes over old slot/handle; World::succession (R on 2026-11-03-heir) |
| `0x004b2a10` | 952 | SIZE_MISMATCH | hst_ParseText_Fake_2nd_Pass | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.hst_ParseText_Fake_2nd_Pass.c); confirm in Ghidra |
| `0x0046e940` | 950 | SIZE_MISMATCH | ui_window_create | S | docs/formats/form.md#record--one-window-frm2-0x101c-bytes | 0x000 i16 x, i16 y, i16 w, i16 h window rect, absolute 800x600 screen coords (child windows too) FUN_0046e940( |
| `0x00429920` | 948 | SIZE_MISMATCH | scripts_init | S | docs/formats/esc.md#the-machine-s | allocates the tables; keywords and operators |
| `0x00482b60` | 948 | SIZE_MISMATCH | ai_CalcMeisterBank | R | docs/master-ai.md#the-banks-master-class-5-bank_masterrs-r-for-the-money-s-for-the-interest | bank master: interest, foreign coins, home coin |
| `0x0055b020` | 948 | SIZE_MISMATCH | HE_SEAT_LETTER_finish | S | docs/timed-actions.md | FINISH of 0xA5: the letter of a seat, local player only |
| `0x0049f6d0` | 944 | SIZE_MISMATCH | ai_guild_riot_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartZunftPreismanipulation, H, docs/re/guild-rebrew.md#impor |
| `0x004b3010` | 943 | SIZE_MISMATCH | hst_ParseDate | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.fcn_004b3010.c); confirm in Ghidra |
| `0x00510c90` | 940 | NEAR_MATCHING | init_LoadObjektScene | S (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra; S: reloads a room's object scene (ob_*.ed3) when its byte +0 |
| `0x005dc5e0` | 938 | SIZE_MISMATCH |  | S | docs/city-map.md#5-callers-of-pickbuildingdialog-s-purpose-h-unless-the-contact-name-says-it | map pick, text 0x9B, no callers |
| `0x005167c0` | 934 | SIZE_MISMATCH | scene_switch_apply_season | S | docs/viewer.md#checked-so-far | scene switch: sets 0x773dd4, re-applies the sets (mask 0xC0) if FUN_00505370 |
| `0x004f6d60` | 922 | SIZE_MISMATCH | title_rise | R | docs/runtime.md#stage-j-fun_004f6d60-cratesguild-simsrctitlesrs | one slot; patrician draws S |
| `0x004e1b00` | 920 | SIZE_MISMATCH | meeting_scene_execution | S | docs/meetings.md |  |
| `0x004b2670` | 918 | SIZE_MISMATCH | hst_ParseCommandline_2nd_Pass | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.hst_ParseCommandline_2nd_Pass.c); confirm in Ghidra |
| `0x00474e80` | 917 | SIZE_MISMATCH | ui_mouse_controls | S | docs/audio.md | left/right click of any active control plays MausclickLinks_s_01 / MausclickRechts_s_01; called from the frame ui_pump, see the doc |
| `0x004e8360` | 916 | SIZE_MISMATCH | office_set | S | docs/offices.md#1-command-0x45--fun004e8360c--0x10-set-office-record | ## 1. Command 0x45 → FUN_004e8360(c + 0x10) (set office record) |
| `0x00560eb0` | 916 | SIZE_MISMATCH | HE_SPIELER_TRAINIEREN_finish | S | docs/timed-actions.md#5-table | timed action 0x16 FINISH handler |
| `0x00576750` | 908 | SIZE_MISMATCH | residence_mishap | S | docs/timed-actions.md | trap, damage, sickness, worn slot |
| `0x005784d0` | 904 | SIZE_MISMATCH | HE_HEIMSUCHUNG_finish | S | docs/timed-actions-live.md#late-kinds-0x60-live-0x6a-0x14-0x15-0x88-0x8f-late_kindsrs-s-1111 | timed action 0x88 FINISH handler |
| `0x005bdc30` | 904 | SIZE_MISMATCH | pick_building_dialog | S | docs/city-map.md#5-callers-of-pick_building_dialog-s-purpose-h | the city map: flags 1 building, 2 sub-pick 0x5D0460, 4 ambush spots, 8 spot objects, 0x10 window 2 |
| `0x005c2580` | 902 | SIZE_MISMATCH | ui_building_renovate_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x0054a210` | 897 | SIZE_MISMATCH | HE_STAMMTISCH_finish | S | docs/timed-actions.md#5-table | timed action 0x2a FINISH handler |
| `0x00525670` | 893 | SIZE_MISMATCH | load_fixup | S | docs/timed-actions.md#1-dispatch-fun00546d10-simulation-step-subsystem-1-called-from-cmexsettime-0x4c9440 | load fix-up (S 09.11.): resolves handles, then for kinds 5,0xA,0x11,0x25,0x26,0x29,0x2D,0x2F and bit-8 entries with state != 0 runs FINISH w |
| `0x0056caf0` | 892 | STUB | HE_EVT_GROSS_BRAND_finish | S | docs/timed-actions.md#5-table | timed action 0x4e FINISH handler |
| `0x004ea620` | 891 | SIZE_MISMATCH | outlaw_seats | R | docs/offices.md#9-stage-h-of-the-round-change-fun_004eafe0-r | offices 0x1C, 0x1D |
| `0x00456080` | 889 | SIZE_MISMATCH | nav_fill_triangle | S | docs/movement.md | 16.16 rasteriser of a triangle |
| `0x004c8de0` | 889 | SIZE_MISMATCH | cm_handler_0x1b | R | docs/commands.md#command-types | handler of command 0x1b: change favour between two persons (matrices of save section 11; World::favour_command: mod (R: result matches the o |
| `0x00421ba0` | 873 | SIZE_MISMATCH | nav_expand_node | S | docs/movement.md | see the doc |
| `0x004868d0` | 870 | SIZE_MISMATCH | ai_plan_mark_inputs | S | docs/master-ai.md | see the doc |
| `0x00497030` | 869 | SIZE_MISMATCH | ai_pre_buy_object | H | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x005020e0` | 866 | SIZE_MISMATCH | city_economy_round | R | docs/market.md#market-tables-at-a-round-change | curves, then all 85 records |
| `0x00590670` | 862 | SIZE_MISMATCH | tooltip_pump | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x00487000` | 861 | NEAR_MATCHING | ai_master_post_hire | H | docs/timed-actions.md#worker-attachment-svchangeplayerhe-read-2026-11-02-h-where-marked | Start of each production AI; posting body only for non-human owners or +0x1B4 bit 1 |
| `0x004d06d0` | 848 | SIZE_MISMATCH | city_hover_pick | S | docs/ui.md | every frame in the town: hover_object 0x7746A4 = pick_scene_object(mouse, mask 0x40, 1); then the cursor kind 0x7725C4 from the selected fig |
| `0x00566360` | 848 | SIZE_MISMATCH | HE_BEFOERDERN_finish | S | docs/timed-actions.md#5-table | timed action 0x32 FINISH handler |
| `0x00558680` | 845 | NEAR_MATCHING | sensenmann_fly | S | docs/timed-actions.md#0x78-seuchenzug--sensenmann-plague-reaper-in-detail-read-2026-11-04-s-unless-marked | moves the reaper straight toward target building +0xB4; returns 1 flying, 2 arrived (skimmed) |
| `0x005c06e0` | 844 | SIZE_MISMATCH | ui_threat_letter_confirm | S | docs/room-actions.md | player dialog |
| `0x005c5e70` | 844 | SIZE_MISMATCH | inventory_panel_refresh | H | docs/building-dialog.md#transport-window-fun005ba910-s-h-where-marked |  |
| `0x0051ffc0` | 843 | SIZE_MISMATCH | sv_SaveFigureQueues | S | docs/formats/save-sections.md | writes the 2,000 action records of 242 B: owner -> unit id, prev/next -> record index (also named save_characters, S, docs/quirks.md#fade-po |
| `0x004cc820` | 838 | NEAR_MATCHING | cm_ExCreateGeb | S | docs/commands.md#command-types | handler of command 0x4c: cm_ExCreateGeb |
| `0x00573e10` | 829 | NEAR_MATCHING | geb_bauen_apply_stage | S | docs/viewer.md#buildings-orientation-textures-construction-sites | shows construction parts whose name suffix _NN / _NN_MM holds the stage; past max shows the gb_ object |
| `0x00554b90` | 826 | SIZE_MISMATCH | HE_PACHT_finish | R | docs/timed-actions.md#0x67-he_pacht-in-detail-r-on-times-and-meeting-cratesguild-simsrcleasers | timed action 0x67 FINISH handler |
| `0x0049d300` | 820 | SIZE_MISMATCH | ai_mayor_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartBuergermeister, H, docs/re/guild-rebrew.md#import) |
| `0x0054fd60` | 820 | STUB | HE_BELEIDIGUNG_finish | S | docs/timed-actions.md#5-table | timed action 0x47 FINISH handler |
| `0x0049dd90` | 813 | SIZE_MISMATCH | ai_StartBuergermeisterKerker | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0049f290` | 812 | NEAR_MATCHING | ai_stammtisch_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartStammtisch, H, docs/re/guild-rebrew.md#import) |
| `0x005b9980` | 809 | NEAR_MATCHING | transport_new_cart_dialog | R | docs/building-dialog.md#transport-window-fun005ba910-s-h-where-marked |  |
| `0x00549580` | 808 | NEAR_MATCHING | accident_result | S | docs/timed-actions.md | FUN_00549580(entry, person, owner, building, health_left, silent): dead: 0x71 and text 0x1BB0; below half: home, 0x1BAF; else 0x1BAE (also n |
| `0x004d74b0` | 801 | SIZE_MISMATCH | meeting_pre_fight | S | docs/meetings.md | fight scene of meeting type 3 |
| `0x004aa240` | 784 | SIZE_MISMATCH | ai_private_action_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x00499640` | 782 | SIZE_MISMATCH | ai_pre_beat_up | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x00558370` | 781 | SIZE_MISMATCH | sensenmann_spawn | S | docs/timed-actions.md#0x78-seuchenzug--sensenmann-plague-reaper-in-detail-read-2026-11-04-s-unless-marked | creates the plague reaper object `Sensenmann` + `_sensenmann.baf` at entry +0xD0 (if +0xC4) or the from-building; writes +0xC4/+0xC8/+0xD0/+ |
| `0x0052df40` | 780 | SIZE_MISMATCH | building_panel_open | D | docs/ui.md#building-panel-in-the-running-game-d-window-screenshot-2026-11-04-the-workshop-save-cratesguild-appsrcpanelrs | content read and shown; compare with the original open |
| `0x00422150` | 777 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x005ad640` | 777 | SIZE_MISMATCH | ui_scout_confirm | S | docs/room-actions.md | player dialog |
| `0x00521530` | 774 | SIZE_MISMATCH | save_command_queues | S | docs/quirks.md#fade-pool-exhaustion-crash | section 17 writer (cmd1-3): copies the static command arrays, pointers turned into indices |
| `0x0057e880` | 763 | NEAR_MATCHING |  | S | docs/building-dialog.md#1-click-routing-s | `DAT_007746d8`, `FUN_0057e880(0x12,b,0,0)`, `FUN_005ba910(b, 1)`, `FUN_0057e880(0x12,b,1,0)`, `DAT_ |
| `0x0059d6b0` | 759 | SIZE_MISMATCH | ui_robber_scout_confirm | S | docs/city-map.md#5-callers-of-pickbuildingdialog-s-purpose-h-unless-the-contact-name-says-it | callback of 0x59D9B0: shielded 0x1A92; reports (room items 0xCA) + own running 0x40 >= 2 * level -> 0x19FA; box 0x19F7 (misc\Bestechung); 0x |
| `0x00422ad0` | 751 | SIZE_MISMATCH | sb_LoadEntry | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/m_alloc); confirm in Ghidra |
| `0x005d2a40` | 742 | SIZE_MISMATCH | courtship_needed | S | docs/timed-actions.md | 0x41 |
| `0x00534c40` | 741 | SIZE_MISMATCH | book_open | S | docs/building-dialog.md#c-staff-book-obpersonalbuch---fun005b6300b-name-s-structure-stack-locals-are-garbled-in-the-decompile-offsets-of-locals-h | Form: opens book `FUN_00534c40` (f3_sv OpenBook, pages Buch_Seite%i_oben/unten), forms Buch\Personal |
| `0x0050c1b0` | 736 | SIZE_MISMATCH | building_accounts | S | docs/runtime.md#end_of_round-0x541620 | out[3] wages R on thief2 (`World::building_wages`); full out map S in `World::building_accounts` (out[0..3], [8], [9] never written) |
| `0x005252d0` | 735 | STUB | load_command_queues | S | docs/formats/save-sections.md#save-file-section-order-from-the-games-loader | section 17 loader: the command arrays, then command_last_seq, 10-byte status table, batch first/end seq, then last_created_person/building/s |
| `0x00569760` | 723 | SIZE_MISMATCH | HE_SPIELER_ENTFUEHRT_finish | R | docs/timed-actions.md#5-table | timed action 0x3d FINISH handler; release: 0x16 adds -(victim+1) to prison +0x65 (R chancellor 1447/1448/1449) |
| `0x004ab500` | 720 | SIZE_MISMATCH | ai_blutrache_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | needs 4+ helpers, class 0x1F building with item 0x27C (also named ai_StartBlutrache, H, docs/re/guild-rebrew.md#import) |
| `0x005705a0` | 718 | SIZE_MISMATCH | route_check_cart | D | docs/timed-actions.md#0xa6-route-supervisor-cratesguild-simsrctrade_routesrs-s-d-where-marked | one cart: repair, next stop or transport; D on london-1408 |
| `0x0055a0b0` | 715 | NEAR_MATCHING | he_office_strife_finish | S | docs/timed-actions.md | 0x7D FINISH; name H |
| `0x00430cb0` | 704 | SIZE_MISMATCH | vfs_OpenStream | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/vfs); confirm in Ghidra |
| `0x00427c40` | 700 | SIZE_MISMATCH | evt_EnterFunction | S | docs/formats/esc.md#the-machine-s | 16 frames |
| `0x005ae6a0` | 698 | SIZE_MISMATCH | ui_kidnap_confirm | S | docs/room-actions.md | player dialog |
| `0x0048fe70` | 694 | NEAR_MATCHING | ai_m3e_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | Handle Grave plan (also named ai_StartHandleGrave, S, docs/quirks.md#ai-master-never-tends-graves-wrong-filter-key-for-the-compost-heap) |
| `0x00493200` | 694 | SIZE_MISMATCH | computer_fills_service_box | R | docs/timed-actions.md#0x2b-he_gottesdienst | a computer owner, by its need +0x130: 7 a seat holder of its rank it dislikes, 10 seek_person, 3/4 always without a target; else with chance |
| `0x0050c830` | 671 | SIZE_MISMATCH | season_work_hours | R | docs/timed-actions.md#0x04-he_produktion-in-detail-finish-r-read-2026-11-04-cratesguild-simsrcproductionrs | work_minutes; m = FUN_0050c830(+0x60, min(now, end), b) (elapsed working time, H); if now >= end -> state 1. (+1 docs) |
| `0x00503a70` | 665 | SIZE_MISMATCH | sellers_of_item | S | docs/master-ai.md | seller list 0x868C40 (stride 0x18: building ptr, ?, stack ptr, spare); World::sellers_of |
| `0x00486640` | 641 | SIZE_MISMATCH | ai_plan_feasible | S | docs/master-ai.md | see the doc |
| `0x004fd4f0` | 641 | SIZE_MISMATCH | service_collection | R | docs/timed-actions.md#0x2b-he_gottesdienst | every computer person may give: R thief2 all rows, London 1411 all 194 amounts |
| `0x00494470` | 640 | NEAR_MATCHING | party_guests_mood | S | docs/timed-actions.md | moods, 0x1B per guest, cost 0x0F |
| `0x005b5eb0` | 640 | SIZE_MISMATCH | ui_staff_book_fleet_build | S | docs/building-dialog.md#c-staff-book-obpersonalbuch---fun005b6300b-name-s-structure-stack-locals-are-garbled-in-the-decompile-offsets-of-locals-h | page 4 of the staff book: up to 3 carts, text 0x1A1F; not ported |
| `0x005513d0` | 639 | NEAR_MATCHING | HE_NACHWUCHS_finish | S | docs/timed-actions.md#5-table | timed action 0x5d FINISH handler |
| `0x00407390` | 632 | SIZE_MISMATCH | ch_Move2Universe | S | docs/movement.md#the-figure-model-figuresrs | action 0x33: +0x2C = +0x34, +0x30 = +0x38 |
| `0x00507540` | 632 | SIZE_MISMATCH | exam_progress | R | docs/population.md#the-master-exam-r | duration of the master exam, its progress as a float |
| `0x004699c0` | 624 | SIZE_MISMATCH | ui_create_resource_control | S | docs/re/notes/436-floor-plan-icons.md | bounded room/HUD static evidence; Resolve graphics definition, bank/type, size and frame; definition2 is type8/frame2 for inline checkbox. |
| `0x00501040` | 623 | SIZE_MISMATCH |  | S | docs/market.md#1-fun005020e0city-clock--s | hdr+0xC are the persistent factors (init 1000 in `FUN_00501040`; the only static |
| `0x005d2ec0` | 603 | SIZE_MISMATCH | privilege_court_list | S | docs/ui.md#privileges | see the table of entries |
| `0x004385e0` | 600 | SIZE_MISMATCH | render_mesh_subsets_or_defer | S | docs/re/notes/436-additive-materials.md | flags. Mesh drawing (FUN_004385e0) then binds that null texture, so the surface is drawn untextured in the ori |
| `0x005ad000` | 599 | SIZE_MISMATCH | ui_warden_bribe | S | docs/room-actions.md | player dialog |
| `0x004f0a30` | 594 | SIZE_MISMATCH | cannon_fire_request | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | rule 8, AP, money, one 0x67 per shot |
| `0x005c3cc0` | 591 | SIZE_MISMATCH | ui_building_extinguish_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x004c2de0` | 590 | SIZE_MISMATCH | voice_find | S | docs/audio.md | speaker -7: plain name; else name + voice suffix |
| `0x00469630` | 587 | SIZE_MISMATCH | d2_UpdateRadioGroup | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.d2_UpdateRadioGroup.c); confirm in Ghidra |
| `0x004dc3a0` | 587 | SIZE_MISMATCH | meeting_dialog_elect | S | docs/elections.md#6-the-meeting-when-a-player-has-a-say | one button per candidate |
| `0x005c35d0` | 586 | SIZE_MISMATCH | ui_building_bid_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x00526920` | 585 | SIZE_MISMATCH | building_info_message | S | docs/city-map.md#1-opening-it-s | enter building B in room R (room 0xFD for a gate): sets 0x7E2704/0x7E2708 and asks for the jump; name kept |
| `0x0048d6c0` | 584 | SIZE_MISMATCH | ai_StartDomizil | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.fcn_0048d6c0.c); confirm in Ghidra |
| `0x0048e850` | 584 | SIZE_MISMATCH | ai_StartSculpture | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.fcn_0048e850.c); confirm in Ghidra |
| `0x0047c560` | 582 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x004e9ee0` | 581 | SIZE_MISMATCH | office_election_tiers | R | docs/elections.md | tier driver before round_host |
| `0x0047cf60` | 580 | SIZE_MISMATCH |  | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 3 FUN_0047cf30 -> 0047cf60 (switch 3430) Person needs (utility AI; modelled: World::person_needs): 13 needs pe |
| `0x004fd780` | 579 | SIZE_MISMATCH | faith_law | R | docs/crime.md#live-worldoffence_roll-cratesguild-simsrcactionsrs | every fourth year: rule 2 for persons of the other faith, or conversions without a law |
| `0x0042d880` | 575 | SIZE_MISMATCH | txt_loadTextFile | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/vfs); confirm in Ghidra |
| `0x00551d50` | 575 | NEAR_MATCHING | HE_TALENT_SPIELER_finish | D | docs/timed-actions.md#5-table | timed action 0x60 FINISH handler; port talent_points.rs (D: the nine 0x5D of thief2 at 1401 fit 21 - rand()%range; S: the level post 0x6A) |
| `0x00416300` | 572 | SIZE_MISMATCH | snow_cmd | S | docs/viewer.md#weather-particles | see docs/re/notes/particles.md |
| `0x0046b2b0` | 572 | NEAR_MATCHING | ui_ctrl_free | S | docs/quirks.md#reported-by-players-for-version-206-h-not-yet-checked | frees a control and zeroes its slot (+0x88 -> 0) (#421) |
| `0x00577e70` | 567 | SIZE_MISMATCH | assassin_finds_spy | S | docs/timed-actions.md | 0x99 |
| `0x0050bc10` | 566 | SIZE_MISMATCH | money_text | D | docs/ui.md#building-dialog-d-window-and-render-2026-11-04-workshop-save-optionsdialog-in-cratesguild-appsrcpanelrs | digits grouped by dots, glyph 0x11 |
| `0x00489010` | 562 | SIZE_MISMATCH | ai_master_arm_staff | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest |  |
| `0x0049f000` | 557 | STUB | ai_change_profession_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartChangeProfession, H, docs/re/guild-rebrew.md#import) |
| `0x005c6310` | 554 | SIZE_MISMATCH | sim_item_effects | S | docs/addresses.md#saveload-module-found-2026-11-01 | 0x004c9440 cm_ExSetTime (type 30) = simulation step Sets the clock, then runs 0x00546d10, 0x004fc180 (+ 0x0050 (+3 docs) |
| `0x004c4b00` | 551 | SIZE_MISMATCH | cm_ExecCommand | S | docs/addresses.md#saveload-module-found-2026-11-01 | cm_ExecCommand (dispatcher) Runs queued commands; handler = table 0x0068a9e0[command byte 0] (types  (+2 docs) |
| `0x004bcf20` | 546 | SIZE_MISMATCH | plant_scene_object | S | docs/structs/buildings.md#forest-plots | loads the picture of a stage (scene only, not modelled) (also named init_SetPflanzenMap, H, docs/re/guild-rebrew.md#import) |
| `0x004a4d90` | 543 | SIZE_MISMATCH | amt_ExecGebaeudeBauen | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00479110` | 541 | NEAR_MATCHING | shp_Convert8To16 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/m_alloc); confirm in Ghidra |
| `0x0057a890` | 541 | SIZE_MISMATCH | person_catch_sickness | S | docs/timed-actions.md | unit() test, sets bits of +0x2C, hp delta; not ported |
| `0x0057ceb0` | 541 | SIZE_MISMATCH | circus_troupe_pays | S | docs/timed-actions.md | 0xA1 |
| `0x00506ab0` | 540 | NEAR_MATCHING | person_remove | S | docs/commands.md#command-types | 33 (0x21) 0x004c9980 remove a person (FUN_00506ab0): type 0x0F, inventory unlinked (items stay as orphans); +0 (+2 docs); guild-rebrew: gm_K |
| `0x0055a920` | 538 | SIZE_MISMATCH | he_group_flip_finish | S | docs/timed-actions.md | 0x81 FINISH, person byte +0x0C; name H |
| `0x00437ee0` | 537 | SIZE_MISMATCH | mesh_bounds_frustum_clip_mask | S | docs/re/notes/436-room-visibility.md | bounded room/HUD static evidence |
| `0x004c9a10` | 533 | SIZE_MISMATCH | cm_ExAddStraftat | R | docs/crime.md#offences-save-section-10 | new offence; pairs from timed actions 0x18 |
| `0x004ad6a0` | 532 | NEAR_MATCHING | seat_filled | R | docs/timed-actions.md#0xa2-rulers-and-seats | rows R; the 0xA5 letters S |
| `0x00472c30` | 531 | SIZE_MISMATCH | ui_line_create | H | docs/ui.md#1-window-patterns-look-here-before-building-a-window | (x1, y1, x2, y2, r, g, b): a line control (tech tree, colour 0x58,0x1F,0x14); rasteriser not read (`Image::line`) |
| `0x005cfd00` | 528 | STUB | building_filter_match | S | docs/city-map.md#3-markers-s | picker filter: +8/+0xC class mask (0xC bit 30 refuses classes 0x666030, bit 31 +0x5A bit 0), +0x10 owner mode 0..7, +0x14 bit 0 with 4 exclu |
| `0x00418000` | 527 | SIZE_MISMATCH | fx_smoke_particles | S | docs/quirks.md | 7 CRT draws per particle |
| `0x004c35f0` | 526 | SIZE_MISMATCH |  | S | docs/building-dialog.md#p2-fun005944d0byte-building---undefined4-always-returns-0--handelproduktion-class-workshops | always after the HE is known, also when reused): `FUN_004c35f0()`; for each worker row with flag +0x10 set: |
| `0x004ba9f0` | 524 | SIZE_MISMATCH | random_event_31 | S | docs/random-events.md#handlers | event 0x31 of the table 0x6811B8 |
| `0x004230e0` | 521 | STUB | sb_UnloadSampleBank | S | docs/audio.md | string in the function |
| `0x00508280` | 521 | SIZE_MISMATCH | person_catch_illness | D | docs/timed-actions.md#0x9d-the-gypsys-curse-0x9e-0x9f-cursesrs |  |
| `0x004fda30` | 518 | SIZE_MISMATCH | person_look | S | docs/ui.md#person-panel-in-the-running-game-d-window-screenshot | For a new person +0x184 == 0, so the code takes branch A and calls e = FUN_004fda30(slot): |
| `0x005a74a0` | 517 | SIZE_MISMATCH | building_enter_allowed | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet |  |
| `0x005ce800` | 513 | NEAR_MATCHING | ui_master_certificate_settings_page | S | docs/master-certificate.md | bounded original-code survey; Four inline image checkboxes, budget control and optional price slider; starts body with $C$A. |
| `0x005cfb00` | 512 | SIZE_MISMATCH | building_filter | R | docs/timed-actions.md | class mask, bit 31 = finished with a scene object, owner mode |
| `0x00427280` | 511 | NEAR_MATCHING | script_if | S | docs/formats/esc.md#the-machine-s | the level opens also for a false condition |
| `0x00415510` | 509 | NEAR_MATCHING | rain_cmd | S | docs/viewer.md#weather-particles | see docs/re/notes/particles.md |
| `0x00417d00` | 509 | NEAR_MATCHING | fx_explosion_particles | S | docs/quirks.md | 4 CRT draws per particle |
| `0x00440670` | 508 | SIZE_MISMATCH | water_update | S | docs/addresses.md#saveload-module-found-2026-11-01 | water update Per frame: scroll, wave phases, 4x4 wave table, _AN frame selection (+1 docs) |
| `0x00500e40` | 508 | SIZE_MISMATCH | build_producer_table | S | docs/structs/buildings.md#item-value-fun_0050b980proto-pct-s-economyrs | fills 0x99E0A0: building type producing each prototype (category base type + level in its run) |
| `0x0055ffe0` | 504 | SIZE_MISMATCH | HE_LAGER_ERWEITERN_finish | S | docs/timed-actions.md#5-table | timed action 0x13 FINISH handler; guild-rebrew: he_RunLagerErweitern |
| `0x00488e10` | 503 | SIZE_MISMATCH | ai_master_1d_post_8f | H | docs/master-ai.md | see the doc |
| `0x00495690` | 497 | SIZE_MISMATCH | ai_start_method | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | starts the chosen method (+0x2C callback), shifts desires by -0.5 * change, sets desire 13 to 500 or 250 |
| `0x0050cad0` | 497 | NEAR_MATCHING | time_work_minutes | R | docs/timed-actions.md#0x0d-he_gebaeude_bauen-in-detail-read-2026-11-03-s-unless-marked | working minutes between two clocks, 06:00..23:00, 1020 a day |
| `0x0043ed30` | 495 | SIZE_MISMATCH |  | S | docs/viewer.md#checked-so-far | (1 - 2/pi acos(-L.n))) (table 0x01040d00), plus colour B flat inside lamp discs (FUN_0043ed30). |
| `0x004a0bb0` | 492 | NEAR_MATCHING | ai_training_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartBerufsausbildung, H, docs/re/guild-rebrew.md#import) |
| `0x004ad2e0` | 492 | SIZE_MISMATCH | seat_proposals | R | docs/timed-actions.md#0xa2-rulers-and-seats |  |
| `0x004b2e20` | 490 | SIZE_MISMATCH | hst_ParseText_Real | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.hst_ParseText_Real.c); confirm in Ghidra |
| `0x004210a0` | 488 | SIZE_MISMATCH | nt_Recv | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/net); confirm in Ghidra |
| `0x004f2350` | 487 | SIZE_MISMATCH | cemetery_burial | R | docs/structs/buildings.md#cemeteries | 0x60 sub 0: first empty place of the grave, else the oldest dead (R: london-years, london-1408) |
| `0x004ffff0` | 484 | STUB | find_housing_for_job | R | docs/structs/buildings.md#port-recipe-of-round_end_buildings-0x5422c0-s-unless-marked-r-where-docsruntimemd-says | port World::housing_for: nearest house of workers (class 1) with room, R on 7 recorded 0x3D (tests the_hire_of_a_master_asks_for_the_recorde |
| `0x00412b10` | 474 | SIZE_MISMATCH | object_start_two_key_pose_flight | S | docs/re/notes/436-contact-camera.md | bounded contact flight survey; static evidence only |
| `0x0049c880` | 474 | SIZE_MISMATCH | ai_drohen_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartDrohen, H, docs/re/guild-rebrew.md#import) |
| `0x004a55c0` | 471 | SIZE_MISMATCH | seek_person | R | docs/timed-actions.md#0x2b-he_gottesdienst | picks persons through the filter FUN_005CF720, from a drawn slot by a drawn stride: R on thief2 one call (0x2B, filter 0xC00); 0x77261C is s |
| `0x005b0f00` | 471 | SIZE_MISMATCH | map_picker_drag_scroll | S | docs/city-map.md#4-scrolling-and-picking-s | right-button drag |
| `0x005025a0` | 470 | SIZE_MISMATCH | market_price_target | R | docs/market.md#market-tables-at-a-round-change | price 40 % towards value times factor 0.25..5 |
| `0x004e7990` | 469 | SIZE_MISMATCH | person_rank_opinion | R | docs/timed-actions.md#0x04-he_produktion-in-detail-finish-r-read-2026-11-04-cratesguild-simsrcproductionrs | through +0xCC |
| `0x004fd0a0` | 469 | SIZE_MISMATCH | person_yearly_update | S | docs/replay.md#where-the-replay-stands-and-how-to-continue-2026-11-01-evening | building): the yearly update FUN_004fd0a0 (round start) sends them, e.g. +0x1e4 += a value from the person's (+1 docs) |
| `0x004e7d40` | 465 | NEAR_MATCHING | office_application | R | docs/timed-actions.md#0x86-applicants-for-the-council-candidatesrs-319 | builds the 0x44 of a person for an office, the second seat when it has two |
| `0x0057c9f0` | 464 | SIZE_MISMATCH | circus_takings | S | docs/timed-actions.md | 0xA0 |
| `0x004b6830` | 463 | SIZE_MISMATCH | random_event_02 | S | docs/random-events.md#handlers | event 0x02 of the table 0x6811B8 |
| `0x00563cc0` | 463 | SIZE_MISMATCH | HE_GEB_UPGRADEN_finish | S | docs/timed-actions.md#5-table | timed action 0x1e FINISH handler |
| `0x0049c590` | 462 | SIZE_MISMATCH | ai_ablass_start | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_RunAblassKaufen, H, docs/re/guild-rebrew.md#import) |
| `0x0052db70` | 460 | SIZE_MISMATCH | building_smoke | S | docs/timed-actions.md#rng | chimney smoke of a producing building, no state |
| `0x005c23b0` | 460 | SIZE_MISMATCH | ui_building_sell_dialog | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x005b6130` | 459 | SIZE_MISMATCH | ui_staff_book_fleet_update | S | docs/building-dialog.md#c-staff-book-obpersonalbuch---fun005b6300b-name-s-structure-stack-locals-are-garbled-in-the-decompile-offsets-of-locals-h | captions 0x1A3E/0x1A3F of the fleet page |
| `0x0048e5b0` | 456 | SIZE_MISMATCH | ai_StartCannonTower | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x004b7f70` | 448 | NEAR_MATCHING | random_event_18 | S | docs/random-events.md#handlers | event 0x18 of the table 0x6811B8 |
| `0x005505b0` | 447 | SIZE_MISMATCH | HE_EVT_STADTFEST_finish | S | docs/timed-actions.md#5-table | timed action 0x53 FINISH handler |
| `0x004306b0` | 446 | SIZE_MISMATCH | vfs_fread | S | docs/addresses.md#saveload-module-found-2026-11-01 | vfs fread, fseek, fopen, fclose The engine's virtual file system (plain files and zip archives); guild-rebrew: vfs_ReadData |
| `0x004fad10` | 446 | SIZE_MISMATCH | danger_grid_rebuild | R | docs/market.md#the-citys-rating-fun_004fb390-command-0x41 | 0x99EF8C through the rating rows |
| `0x00401ed0` | 439 | NEAR_MATCHING | SaveBMP24 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (NEAR_MATCHING match, Units/vfs); confirm in Ghidra |
| `0x004b2300` | 435 | SIZE_MISMATCH | hst_ParseContext | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Unassigned/GOLDTL.hst_ParseContext.c); confirm in Ghidra |
| `0x00493a30` | 429 | NEAR_MATCHING | trial_vote | R | docs/meetings.md | 1 acquits; the acquittal and the two lost votes of the recordings |
| `0x004831f0` | 426 | SIZE_MISMATCH | ai_master_grave_care | S | docs/quirks.md#ai-master-never-tends-graves-wrong-filter-key-for-the-compost-heap | master AI step (from FUN_00483480): at 7, 12, 18 h once (person +0x1b4 bit 0x800), if the workplace has no 0x8d action: grave = FUN_004f43b0 |
| `0x004e7ff0` | 425 | SIZE_MISMATCH | office_apply | S | docs/offices.md#office-definitions-def40-at-0x68da68-stride-0x18-indexed-by-office-id | +0x00 i32 id (== index; FUN_004e7ff0 checks DEF[id].id == id) |
| `0x0043b170` | 424 | NEAR_MATCHING | scene_update_anims | S | docs/movement.md | see the doc |
| `0x004f4f60` | 424 | STUB | rule_roll | R | docs/timed-actions.md#2-registration | rule roll (crime, value, person, target, place): comparator +0x14 / threshold +0x18 of rule 0x68FF68+0x24k, unit draw vs chance FUN_004f4ed0 |
| `0x0042a120` | 423 | SIZE_MISMATCH | sfx_OpenDigOutput | S | docs/audio.md | string in the function |
| `0x00572e40` | 423 | SIZE_MISMATCH | HE_AI_WATCH_TRANSPORT_start | S | docs/timed-actions.md#5-table | timed action 0x0b START handler |
| `0x00508540` | 419 | SIZE_MISMATCH | random_event_quack_illness | S | docs/random-events.md#handlers | 0x3E |
| `0x005af140` | 418 | STUB | ui_room_diebesgilde_gefaengnis | S | docs/room-actions.md | player dialog |
| `0x004c3800` | 417 | SIZE_MISMATCH | esc_callback_shop_talk | S | docs/formats/esc.md#the-machine-s | given to Einkauf_*.esc by FUN_00515C60: seller speech by favour, one rng_rand_mod(3) |
| `0x005086f0` | 413 | SIZE_MISMATCH | random_event_new_illness | S | docs/random-events.md#handlers | 0x3F |
| `0x00558b70` | 410 | NEAR_MATCHING |  | H | docs/timed-actions.md#0x78-seuchenzug--sensenmann-plague-reaper-in-detail-read-2026-11-04-s-unless-marked | via the slot walk, `FUN_00558b70`, state 2, +15 min); state 2 runs `FUN_005589d0` (H: the infection at |
| `0x005d6030` | 406 | SIZE_MISMATCH | privilege_insult | S | docs/ui.md#privileges | see the table of entries |
| `0x00404dc0` | 404 | STUB | ch_AttachAni | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (STUB match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00507130` | 400 | NEAR_MATCHING | trained_talents | R | docs/timed-actions.md#0x5e-he_berufsausbildung-finish-0x5516e0-start-fun_00551650-r | the two talents of a profession group; R for the groups in 1411, S for the rest |
| `0x0040ed40` | 398 | NEAR_MATCHING | esc_AttachAnim | S | docs/formats/esc.md#the-machine-s | built-in AttachAnim (also named AttachAnim, H, docs/re/guild-rebrew.md#import) |
| `0x005049a0` | 397 | SIZE_MISMATCH | building_key_stack | H | docs/timed-actions.md#0x04-he_produktion-in-detail-finish-r-read-2026-11-04-cratesguild-simsrcproductionrs |  |
| `0x00428340` | 396 | SIZE_MISMATCH | evt_RunScript | S | docs/formats/esc.md#the-machine-s | variadic: script, count, args; a wrong count ends the script before it runs |
| `0x004fe2e0` | 395 | SIZE_MISMATCH | person_create_figure | H | docs/person-creation.md#9-portrait-fun004fdfe0-common-tail-deterministic-for-recorded-types | creates a person's scene figure at a dummy; calls FUN_004fda30 (model entry; R(3) for type 0x11, R: 0x49 draw count), copies the model name  |
| `0x004b62e0` | 394 | SIZE_MISMATCH | mission_done_sp | S | docs/new-game.md#aufträge-s-d-im-laufenden-spiel-erfüllt-save-lädt |  |
| `0x00566110` | 392 | NEAR_MATCHING | HE_ENTLASSEN_finish | S | docs/timed-actions.md#5-table | timed action 0x31 FINISH handler |
| `0x0049cb20` | 390 | SIZE_MISMATCH | ai_StartPamphlete | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0049bfa0` | 389 | NEAR_MATCHING | ai_spionage_plan | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md (also named ai_StartSpionage, H, docs/re/guild-rebrew.md#import) |
| `0x0049cd00` | 388 | NEAR_MATCHING | ai_StartAnschwaerzen | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x004a5e60` | 375 | SIZE_MISMATCH | pick_random_building | S | docs/timed-actions.md#2-registration | (person, ..., out handle): R(16) step from table 0x6643d8, R(256) start, walks the building table 0x90e094 (stride 0xa9) for a reachable bui |
| `0x004ea130` | 373 | SIZE_MISMATCH | office_tier_needs_human | R | docs/elections.md#6-the-meeting-when-a-player-has-a-say | bit 1 of the flags as in FUN_004E9EE0 |
| `0x00423670` | 371 | SIZE_MISMATCH | sound_entry_start | S | docs/timed-actions-live.md | only _rand() site of the effect chain: _rand() % variants when flag bit 4 clear; also the start of every sample, docs/audio.md |
| `0x004fcc20` | 371 | NEAR_MATCHING | round_host_rent | R | docs/runtime.md#what-the-port-does-at-a-round-change | negative building wealth |
| `0x004fd280` | 371 | SIZE_MISMATCH | person_yearly_report | S | docs/replay.md#where-the-replay-stands-and-how-to-continue-2026-11-01-evening | save in every recording. The yearly report FUN_004fd280 (day-end host code, not a command) resets +0x198/+0x19 / also zeroes building +0x4D  |
| `0x0050cf50` | 360 | SIZE_MISMATCH | building_protection_value | S | docs/offices.md#7-fun00509620oldh-heirh-command-0x0d-succession-heir-takes-over-the-old-persons-slot | (building, condition): trunc(cond*0.01f*acc), acc = type +0x249*0xF00 + item_value of the type list's rooms and their listed contents (count |
| `0x00558d10` | 357 | SIZE_MISMATCH | HE_SENSENMANN_start | S | docs/timed-actions.md#0x78-seuchenzug--sensenmann-plague-reaper-in-detail-read-2026-11-04-s-unless-marked | timed action 0x78 START: next target slot, spawn, +15 min |
| `0x004c0840` | 354 | SIZE_MISMATCH | load_route_nodes | S | docs/formats/save-sections.md#save-file-section-order-from-the-games-loader | 26 0x004C0840 v>0x10052 4 + 56/entry H; save section 26 loader: the cart route stops (route_node_append) |
| `0x00500a40` | 354 | SIZE_MISMATCH | sim_population_stats | S | docs/addresses.md#saveload-module-found-2026-11-01 | 0x004c9440 cm_ExSetTime (type 30) = simulation step Sets the clock, then runs 0x00546d10, 0x004fc180 (+ 0x0050 (+1 docs) |
| `0x0054f4a0` | 346 | NEAR_MATCHING | insult_goes_unanswered | S | docs/timed-actions.md | 0x46 timeout or apology path: talks of offices, -20 standing |
| `0x005109f0` | 336 | SIZE_MISMATCH | create_scene_buildings_and_inherit_entity_link | S | docs/re/notes/436-room-door-exit.md | bounded source survey |
| `0x00451380` | 334 | NEAR_MATCHING | angle_about_y | S | docs/offices.md#9-stage-h-of-the-round-change-fun_004eafe0-r | signed angle of two directions, acos |
| `0x004fb4e0` | 333 | SIZE_MISMATCH | economy_snapshot_apply | D | docs/market.md#market-tables-at-a-round-change | command 0x41; section 12 fields written |
| `0x00558220` | 332 | STUB | HE_UNKENDUNK_finish | S | docs/timed-actions.md | 0x77 FINISH: workers leave for home, unit() > 0.5 |
| `0x0056ce70` | 332 | SIZE_MISMATCH | HE_EVT_BRAND_start | S | docs/timed-actions.md#5-table | timed action 0x4f START handler |
| `0x004aa550` | 328 | NEAR_MATCHING | ai_private_action_check | H | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x00533a60` | 328 | SIZE_MISMATCH | ui_button_row_create | S | docs/building-dialog.md#3-buttons-s-for-idsflow-h-for-names | stored in local "iVar8", the first of the 3 from `FUN_00533a60`, shown for mode bit0 with the player's own building)** = *Send selec; Equal- |
| `0x004fb390` | 327 | SIZE_MISMATCH | city_rating_year | R | docs/market.md#the-citys-rating-fun_004fb390-command-0x41 | every 0x41 row of five recordings |
| `0x00489920` | 322 | NEAR_MATCHING |  | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 5b FUN_0047da10 Round-robin scheduler over the 768 person slots, 06:00-22:00, slots per step proportional to e |
| `0x0045b990` | 314 | NEAR_MATCHING | height_grid_cell | R | docs/crime.md#danger-grid-dangerrs-0x99ef80-section-12-at-762-9-bytes-per-cell | grid point of a position |
| `0x0057d9e0` | 311 | SIZE_MISMATCH | he_points_drain_finish | S | docs/timed-actions.md | 0xA3 FINISH; name H |
| `0x00427600` | 306 | SIZE_MISMATCH | script_read_params | S | docs/formats/esc.md#the-machine-s | void or a typeless name adds no parameter |
| `0x005b1ce0` | 306 | SIZE_MISMATCH | product_list_set_share | S | docs/master-ai.md | the dialog's change of a share, the others take up the rest |
| `0x00584f00` | 301 | SIZE_MISMATCH | ui_alchemist_hire | S | docs/alchemy.md | afford check, confirm 0x4044, command 0x63, clear slot, pay via 0x0f |
| `0x004c4090` | 299 | SIZE_MISMATCH | cm_push_chunks | S | docs/formats/save-sections.md#save-file-section-order-from-the-games-loader | appends DAT_00aed330 type-7 chunk records from 0xaece00 to cmd_ring and command_unsent_head; links +0xc to next chunk seq |
| `0x00565980` | 299 | SIZE_MISMATCH | HE_ERNTEN_start | S | docs/timed-actions.md#5-table | timed action 0x28 START handler |
| `0x00545780` | 295 | NEAR_MATCHING | ui_close_message_window | S | docs/timed-actions-live.md#fragen-boxen | ported as World::close_question (also named popup_window_close, H, docs/quirks.md#fixed-size-pools-inventory-and-measured-fill-code--measure |
| `0x00456400` | 294 | STUB | nav_edge_setup | S | docs/movement.md | slope of an edge, wrapped with dy under 1.0 |
| `0x004e04f0` | 294 | SIZE_MISMATCH | meeting_duel_headless | S | docs/meetings.md |  |
| `0x005c2910` | 291 | NEAR_MATCHING | ui_building_withdraw_sale | S | docs/building-dialog.md#building-panel-buttons-and-the-building-dialog |  |
| `0x00455d30` | 290 | SIZE_MISMATCH | nav_fill_rows | S | docs/movement.md | the rows of a triangle part, picks the span function by mode |
| `0x004488e0` | 288 | SIZE_MISMATCH | ogr_load | S | docs/formats/ogr.md#ogr-object-groups-groupsbin | loads an .ogr object group (name, file, ...) |
| `0x00505d00` | 283 | SIZE_MISMATCH | building_staff_lists | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked |  |
| `0x004ff0f0` | 282 | SIZE_MISMATCH | persons_age_all | S | docs/quirks.md#pact-with-death-what-it-does-who-gets-it-who-it-protects-code-429 | yearly loop over persons of kind < 10 or 0x14, calls person_age_year (#429) (also named round_host_age_replace, H, docs/runtime.md#round-cha |
| `0x00406b50` | 275 | SIZE_MISMATCH | ch_DroppingObject | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (RELOC match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0040eed0` | 275 | SIZE_MISMATCH | esc_PreloadAnim | S | docs/formats/esc.md#the-machine-s | built-in PreloadAnim (also named PreloadAnim, H, docs/re/guild-rebrew.md#import) |
| `0x004bcda0` | 268 | SIZE_MISMATCH | plant_set | R | docs/structs/buildings.md#forest-plots | set a place; new id from 0x7728F8 |
| `0x0042dcd0` | 262 | SIZE_MISMATCH | timer_callback | S | docs/addresses.md#saveload-module-found-2026-11-01 | timer callback Every 14 ms: engine clock 0x006b7fac++, runs job table 0x01052c60 (32 x {fn, period,  (+1 docs) |
| `0x004ea350` | 259 | NEAR_MATCHING |  | S | docs/offices.md#8-all-writers-of-the-table--person-office-fields-in-0x4e78000x4ecfff | - If FUN_004e9ee0 returned 0: FUN_004ea350(): for records 0..29: Q = person(holder); if Q == null or Q byte +8 |
| `0x005462a0` | 252 | SIZE_MISMATCH | he_fn_Handlung | S | docs/timed-actions.md#0x3f-he_einbruch-burglary-in-detail-s-read-2026-11-03-h-where-marked | name from guild-rebrew (H); called by 0x3F START; not read |
| `0x004b6af0` | 251 | NEAR_MATCHING | random_event_04 | S | docs/random-events.md#handlers | event 0x04 of the table 0x6811B8 |
| `0x00499950` | 250 | NEAR_MATCHING | ai_start_beat_up | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | AI method callback, see docs/re/notes/ai-methods-a.md and -b.md |
| `0x00532650` | 250 | SIZE_MISMATCH |  | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | called from the frame ui_pump, see the doc |
| `0x00493be0` | 249 | NEAR_MATCHING | trial_sentence_base | R | docs/meetings.md | round(F) - 1 over a table |
| `0x00455f80` | 246 | SIZE_MISMATCH | nav_span_stamp | S | docs/movement.md | span stamping without heights |
| `0x004e9180` | 234 | SIZE_MISMATCH | office_voter_may_vote | S | docs/elections.md | rank classes |
| `0x004fd400` | 232 | SIZE_MISMATCH | richest_person | R | docs/runtime.md#what-the-port-does-at-a-round-change |  |
| `0x00427740` | 231 | SIZE_MISMATCH | script_add_global | S | docs/formats/esc.md#the-machine-s | evt_var, 0x30 header |
| `0x0057a180` | 224 | SIZE_MISMATCH | he_child_ransom_finish | S | docs/timed-actions.md | 0x8E FINISH; name H |
| `0x004f0ff0` | 223 | NEAR_MATCHING | cannon_cost | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | AP A+2, money trunc((2B+500)(1+A/4) shots 32) |
| `0x004e97f0` | 221 | SIZE_MISMATCH | make_applicant | R | docs/timed-actions.md#0x86-applicants-for-the-council-candidatesrs-319 | money, standing, kind 3, +0x167, then the 0x44 |
| `0x004ecd50` | 221 | SIZE_MISMATCH | refine_plan | S | docs/alchemy.md | T = ftol(D*(1-0.5*knowledge)*(1-skill)); b = min(budget,T); gain = (1-skill)*b/T |
| `0x004eea30` | 209 | NEAR_MATCHING | residence_slot_set | S | docs/timed-actions.md | command 0x64 cRSa |
| `0x005b00f0` | 207 | SIZE_MISMATCH | map_cell_to_pixel | S | docs/city-map.md#3-markers-s | height-grid point -> map bitmap pixel (scale, city offset, stretch 51) |
| `0x004cdda0` | 199 | NEAR_MATCHING | cm_handler_0x68 | R | docs/commands.md#command-types | handler of command 0x68: set a cart's transport route: +0x10 cart, +0x14 number of stops (the stops come from the U (R: result matches the o |
| `0x00421f10` | 196 | SIZE_MISMATCH | nav_open_insert | S | docs/movement.md | open list insert, doesn't compare the last entry |
| `0x0057de80` | 196 | NEAR_MATCHING | msg_is_filtered | S | docs/replay.md#where-the-replay-stands-and-how-to-continue-2026-11-01-evening | player filters (FUN_0057de80: messages 0x605..0x60D, bits of 0x7749F4 = game.ini message_filter_mask, a |
| `0x0046b520` | 195 | SIZE_MISMATCH |  | S | docs/ui.md#3-drawing | 0x20/0x80 BLACK box at 0.7 behind. Width measure FUN_0046b520. |
| `0x004c9e20` | 190 | STUB | cm_handler_0x27 | S | docs/commands.md#command-types | handler of command 0x27; guild-rebrew: cm_ExAllocCutscene |
| `0x004ee160` | 190 | SIZE_MISMATCH | residence_upkeep | H | docs/structs/buildings.md#port-recipe-of-round_end_buildings-0x5422c0-s-unless-marked-r-where-docsruntimemd-says |  |
| `0x004c6090` | 188 | NEAR_MATCHING | cm_request_0x3d | S | docs/timed-actions.md#4-legend-for-the-table | 0x4c5ba0=0x2f, 0x4c5c00=0x30, 0x4c5c80=0x31, 0x4c5da0=0x35, 0x4c5ed0=0x37, 0x4c5fd0=0x3b, 0x4c6090=0x3d, |
| `0x004e9730` | 188 | SIZE_MISMATCH | applicant_request | S | docs/timed-actions.md#0x86-applicants-for-the-council-candidatesrs-319 | request of a new person of kind 0x13 |
| `0x005473a0` | 188 | NEAR_MATCHING | residence_actions | S | docs/runtime.md#stage-i-fun_005490a0-cratesguild-simsrctown_roundrs | posts 0x98 |
| `0x00472680` | 184 | NEAR_MATCHING | ui_control_set_scale | S | docs/building-dialog.md#a2-who-fills-table-0x7e30d0-the-real-worker-table | scale > 1 multiplies, < -1 divides control w/h by /scale/ |
| `0x005155e0` | 182 | SIZE_MISMATCH | scene_cache_index | S | docs/master-ai.md | scene cache slot of a building type |
| `0x00578e10` | 181 | SIZE_MISMATCH | death_pact_start | S | docs/timed-actions.md | 0x8A |
| `0x004c0a80` | 174 | NEAR_MATCHING | voice_enqueue | S | docs/audio.md | (sample, delay ms) |
| `0x004ee0b0` | 173 | SIZE_MISMATCH | candidate_price | S | docs/alchemy.md | ftol(500 * (sum (a_i/252)^2 + recipe.attr0 + recipe.attr1)) << 5 |
| `0x00471e30` | 169 | SIZE_MISMATCH |  | S | docs/building-dialog.md#2-what-options-opens-s | ended/ paused-by-network). Then `FUN_00471e30(form)` destroys it; own building: tutorial notify `FUN_0057e880(0x10, |
| `0x004c49f0` | 166 | NEAR_MATCHING | cm_queue_push | H | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | from the frame call tree |
| `0x004f0eb0` | 164 | SIZE_MISMATCH | cannon_charge | S | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | (A+1)(B/4+25)0.002+0.1 |
| `0x00407760` | 159 | SIZE_MISMATCH | ch_decimate_path | S | docs/movement.md | keeps every k-th cell, drops the first |
| `0x0046ed00` | 149 | SIZE_MISMATCH | ui_window_scroll_by | S | docs/building-dialog.md#p2-fun005944d0byte-building---undefined4-always-returns-0--handelproduktion-class-workshops | scroll mover of a window (offset/step tables 0x1015f40+win*0x3cc) |
| `0x00500bb0` | 145 | SIZE_MISMATCH | time_add | S | docs/addresses.md#saveload-module-found-2026-11-01 | time_add(t, h, m, s) Normalises 60 s / 60 min / 24 h into rounds (+2 docs) |
| `0x0041e350` | 131 | SIZE_MISMATCH | m_pool_next | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, Units/m_alloc); confirm in Ghidra |
| `0x005b5660` | 127 | SIZE_MISMATCH | circus_gift | S | docs/timed-actions.md | 0xA1 |
| `0x0042b2f0` | 125 | SIZE_MISMATCH | text_variant | S | docs/random-events.md | a form of a NUL-separated text; flag 4 forms 1..4, flag 8 forms 5..8 |
| `0x0042bcb0` | 107 | SIZE_MISMATCH | text_parse_random_label | S | docs/timed-actions-live.md#fragen-boxen | label of a text line into 0x11BB000: a line of a {rG,N} group has G + 8 (also named txt_ParseRandomText, H, docs/re/guild-rebrew.md#import) |
| `0x00469890` | 99 | SIZE_MISMATCH | ui_ctrl_alloc | S | docs/quirks.md#reported-by-players-for-version-206-h-not-yet-checked | ui_ctrl_find_free, registers the slot in 0x772540, sets +4 = 1; -1 when full (#421) |
| `0x004b3ce0` | 92 | SIZE_MISMATCH | mission_row_iter_by_category | S | docs/new-game.md#aufträge-s-d-im-laufenden-spiel-erfüllt-save-lädt |  |
| `0x004eebb0` | 91 | NEAR_MATCHING | apply_add_mood | S | docs/alchemy.md | mood += delta, clamp [0,1] |
| `0x00406560` | 87 | SIZE_MISMATCH | ch_ClearSitting | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (SIZE_MISMATCH match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0047d240` | 86 | SIZE_MISMATCH | ai_acts_here | S | docs/runtime.md#not-ported-yet-s-tickets-under-the-round-change | kind 2..5 and a machine count |
| `0x005d0460` | 75 | SIZE_MISMATCH |  | S | docs/city-map.md#city-map | map flag 2: nested pick instead of returning the building (not read) |
| `0x004186d0` | 31 | SIZE_MISMATCH | StopSonnenstrahlen | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (RELOC match, DieGildeAddOn/game); confirm in Ghidra |

### Not in `symbols.tsv` (359)

VA (size): `0x0051c840` (6048), `0x0043c640` (5419), `0x00581e20` (5386), `0x004d8d00` (4632), `0x00435910` (4127), `0x0040aa00` (3370), `0x005d1790` (3295), `0x005a59d0` (2962), `0x00433be0` (2824), `0x004d1ff0` (2671), `0x005926f0` (2584), `0x005a1430` (2567), `0x0052c060` (2376), `0x004582d0` (2324), `0x00453470` (2308), `0x005b3b60` (2293), `0x005936f0` (2289), `0x0047acf0` (2268), `0x004eba60` (2148), `0x00452c60` (2060), `0x00434ba0` (2053), `0x0057e0a0` (1976), `0x005ccca0` (1952), `0x00444860` (1923), `0x00466550` (1876), `0x00535ec0` (1808), `0x004bd4e0` (1792), `0x005c79a0` (1772), `0x00539930` (1771), `0x005d9000` (1738), `0x00401650` (1718), `0x004316c0` (1697), `0x005e53b0` (1685), `0x005cadc0` (1655), `0x004a6550` (1629), `0x0041ec50` (1628), `0x005c9f10` (1610), `0x005a6880` (1546), `0x005c72f0` (1533), `0x0058d5f0` (1510), `0x00457630` (1504), `0x0041e680` (1481), `0x00497ec0` (1446), `0x00471490` (1440), `0x004a9b20` (1440), `0x0041c470` (1427), `0x0044f250` (1409), `0x0058b440` (1395), `0x005cd810` (1394), `0x005c99a0` (1384), `0x0047d2a0` (1382), `0x00444ff0` (1379), `0x005ab810` (1360), `0x00594de0` (1353), `0x005d3d90` (1353), `0x00477590` (1349), `0x004248a0` (1342), `0x004441c0` (1340), `0x005cff20` (1340), `0x00441f90` (1324), `0x00424de0` (1317), `0x00520d90` (1313), `0x005893d0` (1311), `0x00495a80` (1270), `0x0052b230` (1259), `0x00587a50` (1253), `0x00459050` (1246), `0x0044a9f0` (1227), `0x00449130` (1219), `0x0058bb10` (1205), `0x005d97f0` (1200), `0x00478400` (1185), `0x00495fe0` (1184), `0x0042b810` (1173), `0x004be560` (1173), `0x00446540` (1172), `0x0049b1f0` (1168), `0x005875c0` (1161), `0x00496810` (1157), `0x00599b00` (1153), `0x005a2080` (1152), `0x004143b0` (1141), `0x005aaf60` (1141), `0x00452740` (1139), `0x005c6a10` (1137), `0x005d2470` (1133), `0x00449630` (1131), `0x0053d020` (1124), `0x005a0cd0` (1120), `0x00441ab0` (1116), `0x004d3800` (1115), `0x00448cc0` (1111), `0x0058a250` (1110), `0x005bf580` (1110), `0x005e5a50` (1103), `0x004b5630` (1095), `0x0058bfd0` (1077), `0x004748b0` (1076), `0x00591ea0` (1073), `0x004d4950` (1070), `0x005d6540` (1036), `0x00440260` (1034), `0x0041a970` (1031), `0x004424c0` (1031), `0x00411b80` (1026), `0x0041adc0` (1012), `0x0053e020` (1009), `0x005a2580` (1007), `0x005a2970` (1007), `0x00513d40` (991), `0x0044a390` (985), `0x005dd5a0` (984), `0x004bec20` (977), `0x00413870` (974), `0x00584160` (968), `0x005a31b0` (963), `0x00456750` (960), `0x004d8200` (949), `0x005a4e00` (948), `0x0047ba20` (944), `0x004fbdd0` (941), `0x00454850` (940), `0x0052ae80` (933), `0x00441050` (931), `0x004eb3e0` (928), `0x004079f0` (915), `0x00457290` (914), `0x00477ae0` (911), `0x004a82b0` (908), `0x00457f40` (906), `0x00418210` (904), `0x00588710` (904), `0x00441720` (902), `0x0058f310` (902), `0x005a02b0` (896), `0x0058f6a0` (894), `0x00455910` (892), `0x004929e0` (890), `0x005c1110` (890), `0x0043c2c0` (889), `0x0049adb0` (880), `0x004d0070` (877), `0x005dc270` (869), `0x00477e70` (865), `0x005ca740` (850), `0x00445f50` (849), `0x00419640` (845), `0x00431dd0` (836), `0x004d89c0` (831), `0x004a6210` (830), `0x004cf6b0` (827), `0x00451a40` (816), `0x00457c10` (809), `0x004964e0` (806), `0x00493f80` (798), `0x00437bc0` (796), `0x00420210` (791), `0x00421890` (779), `0x005a6e90` (768), `0x00451f80` (760), `0x004c3a50` (760), `0x00531320` (757), `0x00479330` (746), `0x005e6360` (745), `0x00402d00` (744), `0x00441400` (725), `0x00417870` (723), `0x0052d1f0` (719), `0x0045bad0` (711), `0x004cf180` (710), `0x004789e0` (707), `0x005da560` (701), `0x00476120` (690), `0x004dff50` (689), `0x004b5b40` (684), `0x005091d0` (683), `0x00502a20` (678), `0x00425550` (672), `0x00450e90` (652), `0x00414d20` (651), `0x004754b0` (647), `0x0058e220` (638), `0x005db8e0` (637), `0x005a51c0` (634), `0x00418860` (626), `0x0047c1f0` (607), `0x00445aa0` (599), `0x004d7fa0` (597), `0x00417570` (593), `0x005bd970` (593), `0x004a7d40` (592), `0x005d6c50` (590), `0x005a4bb0` (588), `0x005a4960` (585), `0x004172e0` (584), `0x0058b1f0` (584), `0x00458e00` (580), `0x004d0a20` (577), `0x0043b990` (567), `0x00476d50` (566), `0x004770a0` (565), `0x004a8070` (565), `0x0047a990` (563), `0x004cecf0` (562), `0x005a1e40` (562), `0x00515010` (561), `0x00492590` (560), `0x004d1020` (560), `0x004d3c60` (560), `0x00434970` (553), `0x00443e10` (553), `0x005cb440` (551), `0x005b5290` (544), `0x004781e0` (536), `0x00499dc0` (536), `0x004337c0` (535), `0x00408320` (534), `0x004a4fb0` (533), `0x00451500` (530), `0x004a4680` (529), `0x00473400` (525), `0x004f61c0` (523), `0x00475a00` (521), `0x004090d0` (511), `0x00413480` (504), `0x005cb860` (501), `0x00465c60` (500), `0x0042bd20` (498), `0x004a7900` (496), `0x00469c40` (489), `0x0046acf0` (487), `0x0058fbd0` (485), `0x005dd2f0` (484), `0x004d4250` (480), `0x004d2c80` (473), `0x0042f240` (471), `0x00490e20` (470), `0x00479660` (464), `0x00407800` (455), `0x004d15c0` (454), `0x004d87f0` (454), `0x0046c310` (452), `0x0042dac0` (451), `0x004339e0` (446), `0x004a57a0` (444), `0x0050bff0` (436), `0x00539600` (436), `0x00492e50` (432), `0x00515c60` (432), `0x0040f9d0` (430), `0x0058cae0` (427), `0x00532750` (426), `0x00413e00` (425), `0x00448b10` (425), `0x0047bdd0` (423), `0x004400b0` (422), `0x005448e0` (420), `0x0058ee70` (419), `0x00405a50` (418), `0x00424270` (418), `0x00414fb0` (416), `0x0047a570` (410), `0x00496e60` (406), `0x004f65a0` (406), `0x00510260` (406), `0x00493000` (405), `0x005b39c0` (404), `0x00490c90` (395), `0x00474cf0` (392), `0x00438450` (391), `0x00546590` (390), `0x00424420` (389), `0x004974e0` (387), `0x004d1790` (377), `0x004f6040` (373), `0x004d3330` (369), `0x00593360` (368), `0x0048f8f0` (366), `0x004232f0` (364), `0x00405760` (362), `0x0048f4f0` (361), `0x0047a090` (360), `0x004382e0` (355), `0x004d31d0` (352), `0x00444700` (347), `0x00478d50` (347), `0x004a7be0` (345), `0x00593200` (345), `0x004d3070` (342), `0x0058d020` (339), `0x004bdbe0` (338), `0x004758b0` (325), `0x004d3e90` (324), `0x004fdd70` (324), `0x004cfab0` (323), `0x00533bb0` (319), `0x00404b60` (305), `0x00414ab0` (299), `0x00414830` (296), `0x004d36e0` (285), `0x00498e20` (282), `0x004123a0` (270), `0x0042f010` (270), `0x004f14c0` (270), `0x004124b0` (266), `0x00423e10` (265), `0x0045d0d0` (257), `0x004f7210` (251), `0x004315c0` (250), `0x004227c0` (249), `0x00509480` (240), `0x004b3720` (239), `0x00424040` (237), `0x00478eb0` (236), `0x00516de0` (230), `0x00413d10` (229), `0x004f7120` (229), `0x005aceb0` (219), `0x00515e10` (218), `0x00500580` (212), `0x004c4250` (210), `0x00436930` (207), `0x00459870` (207), `0x00413c40` (205), `0x0041e530` (205), `0x004f7310` (201), `0x0045c110` (199), `0x004b33c0` (199), `0x004fb2c0` (197), `0x005cba60` (195), `0x00476a50` (192), `0x004b1d10` (187), `0x004c6940` (186), `0x004131e0` (183), `0x00409020` (170), `0x00509120` (161), `0x0046f060` (157), `0x00473360` (156), `0x004c5580` (156), `0x00536b10` (156), `0x00435630` (141), `0x00530510` (135), `0x004127a0` (130), `0x0052a320` (128), `0x0050e170` (121), `0x004fdcf0` (119), `0x00506e70` (103), `0x004cf000` (102), `0x0050be50` (102), `0x005365d0` (100), `0x00497e60` (95), `0x00405540` (94), `0x004042b0` (80), `0x004321a0` (65), `0x004ac2c0` (63), `0x004013b0` (60), `0x004bcab0` (42), `0x0065a20a` (29), `0x004da170` (28)

## data-drift

Known to the Rust port first (largest first), then the rest.

### Known to the Rust port (170)

| VA | Size | Rebrew status | Rust-port name | Tag | Rust-port doc | Rust-port note |
|---|---:|---|---|---|---|---|
| `0x00869480` | 589824 | DISPLACED | favour_matrix | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 11 00524610 two 768 x 768 byte grids -> 0x869480, 0x90e0a0 (row stride 0x300) favour matrices, row = person slot (R, s11 (+1 docs) |
| `0x0090e0a0` | 589824 | DISPLACED | favour_matrix2 | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 11 00524610 two 768 x 768 byte grids -> 0x869480, 0x90e0a0 (row stride 0x300) favour matrices, row = person slot (R, s11 (+1 docs) |
| `0x00677948` | 384 | DISPLACED | g_log_format_table | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, Units/Error); confirm in Ghidra |
| `0x006814a8` | 280 | DISPLACED | plant_table | R | docs/structs/buildings.md#forest-plots | 0x46 bytes per plant (also global plt_PlantInfo, H, docs/re/guild-rebrew.md#import: guild-rebrew name (DISPLACED match, DieGildeAddOn/auxill |
| `0x0068d9a0` | 196 | DISPLACED | office_applicant_bonus_matrix | S | docs/elections.md | 7x7 f32 by tiers |
| `0x0068d870` | 54 | DISPLACED | str_begin_statistic_dump_round | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOnServer/server.c); confirm in Ghidra |
| `0x0068d968` | 52 | DISPLACED | str_end_statistic_dump_round | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOnServer/server.c); confirm in Ghidra |
| `0x00677918` | 48 | DISPLACED | g_log_level_table | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, Units/Error); confirm in Ghidra |
| `0x0068d8a8` | 37 | DISPLACED | str_stat_identity_columns | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOnServer/server_stats.c); confirm in Ghidra |
| `0x00678200` | 27 | DRIFT | str_D_develop_units_Msx_msx_c | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DRIFT match, Units/Msx); confirm in Ghidra |
| `0x0067eaf8` | 21 | DRIFT | str_upgr_arbeiter_unterk | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DRIFT match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0067eae4` | 20 | DRIFT | str_bau_arbeiter_unterk | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DRIFT match, DieGildeAddOn/game); confirm in Ghidra |
| `0x006781ec` | 17 | DRIFT | str_hTrack_bAmbient | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DRIFT match, Units/Msx); confirm in Ghidra |
| `0x0068d924` | 16 | DISPLACED | str_i_tab_i_tab_i_tab_i_tab_i_tab | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOnServer/server.c); confirm in Ghidra |
| `0x00677664` | 15 | DISPLACED | str_sonnenstrahlen | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0068d934` | 13 | DISPLACED | str_s_tab_s_tab_s_tab_s_tab | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOnServer/server_stats.c); confirm in Ghidra |
| `0x00677acc` | 12 | DISPLACED | g_log_default_name | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, Units/Error); confirm in Ghidra |
| `0x00662950` | 8 | DISPLACED |  | S | docs/population.md#fun004fe5f0p-h-name-personroundupdate-only-reached-from-the-lo | double 0.0 |
| `0x006629c8` | 8 | DISPLACED |  | S | docs/person-creation.md#conventions | f64: 0x665bd0 = 900.0, 0x662a20 = 0.001, 0x662a48 = 2.0, 0x665bc8 = 8.0, 0x6629c8 = 1.0, 0x6628f0 = 0.2. |
| `0x00662a08` | 8 | DISPLACED |  | H | docs/market.md#fun00501fe0--s---always-for-dat00773d75 | od(1)` (always 0 -> first branch; the 1.5 branch @0x662A08 is dead, H on rand%1 == 0): |
| `0x00662a48` | 8 | DISPLACED |  | S | docs/person-creation.md#conventions | f64: 0x665bd0 = 900.0, 0x662a20 = 0.001, 0x662a48 = 2.0, 0x665bc8 = 8.0, 0x6629c8 = 1.0, 0x6628f0 = 0.2. |
| `0x006640e8` | 8 | DISPLACED | const_percent_0_01 | S | docs/runtime.md#end_of_round-0x541620 | 0.01 |
| `0x00664e78` | 8 | DISPLACED |  | S | docs/market.md#4-fun005025a0city-i---x87-value--s-disassembly | 5.0 double @0x664E78; 512.0f @0x662D14. |
| `0x00677674` | 7 | DISPLACED | str_pLicht | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x006628a0` | 4 | DISPLACED |  | S | docs/person-creation.md#conventions | 0x662a3c = 0.1f, 0x6628a0 = 1.0, 0x662d34 = 0.6f, 0x664e44 = 210.0, 0x665368 = 42.0. |
| `0x006628a8` | 4 | DISPLACED | bankrupt_cash_limit | R | docs/runtime.md#end_of_round-0x541620 | 0.0 (f32 limit of the cash; R through thief2's bankruptcy) (the same 0.0 constant serves as zero in the particle updates FUN_00415710 and FU |
| `0x00662910` | 4 | DISPLACED | const_f32_0_01 | S | docs/timed-actions-live.md | f32 0.01: equipment bonus percent (0x61 loot, 0x8C progress) |
| `0x00662ac8` | 4 | DISPLACED |  | H | docs/person-creation.md#123-body-in-program-order-s | P+0x14 float = 1000.0 / (r * 4.0 + 8.0) (consts 0x662ac8 = 4.0, 0x662924 = 8.0, 0x6640b4 = 1000.0). (H: walking speed.) |
| `0x0066414c` | 4 | DISPLACED | flt_0_3 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00665f08` | 4 | DISPLACED |  | S | docs/building-dialog.md#p1-click-path-top-down | or mask bit set in `*(PTR_DAT_00665f08+0x18)+0x6c`; e.g. production 0x20, storage 0x10, transport 0x100, sta |
| `0x00675318` | 4 | DISPLACED | gv_00675318 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0067754c` | 4 | DISPLACED | SonnenstrahlenStartZeit | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x0067db50` | 4 | DISPLACED |  | S | docs/timed-actions.md#worker-block-worker-block-when-0xd0--60 | ur change; +0x20/+0x24 come from globals 0x67DB54/0x67DB50). (S) |
| `0x0067db54` | 4 | DISPLACED |  | S | docs/timed-actions.md#worker-block-worker-block-when-0xd0--60 | 0x1b favour change; +0x20/+0x24 come from globals 0x67DB54/0x67DB50). (S) |
| `0x00699368` | 4 | DISPLACED |  | S | docs/structs/memory-map.md#sections-1-9 | 2 inline in 00521920 0x699364, 0x7749D0, clock 14 B -> 0x7F4C00 (then copied to the host clock 0x7E1F70), 0x77 (+1 docs) |
| `0x00699380` | 4 | DISPLACED | g_query_filter_extra1 | S | docs/market.md#3-fun005024e0city-i---i32--s----only-called-for-city--dat00773d75 | obal building iterator state (0x773D80..0x773DA0, 0x699380..) is clobbered (S). (name g_query_filter_extra1 from the other row, H, docs/re/g |
| `0x006abb00` | 4 | DISPLACED |  | S | docs/building-dialog.md#1-forms-and-controls-s-unless-h | (id, item ptr), `DAT_00775318` = person record, `DAT_006abb00` = its panel control. |
| `0x006b5cbc` | 4 | DISPLACED | camera_flight_busy | S | docs/re/notes/436-contact-camera.md | bounded contact flight survey; static evidence only |
| `0x006b5cfc` | 4 | DISPLACED | SonnenstrahlenAktiv | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x006b5d00` | 4 | DISPLACED | SonnenstrahlenPhase | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x006b5de0` | 4 | DISPLACED |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x006b6f64` | 4 | DISPLACED | m_reg_capacity | S | docs/quirks.md#fade-pool-exhaustion-crash | m_alloc registry capacity, m_init(0xbb80) = 48,000; hook raises it to 0x40000 (#417) |
| `0x006b6f80` | 4 | DISPLACED | m_registry | S | docs/quirks.md#fade-pool-exhaustion-crash | pointer to 16-byte entries {group, tag, block, size} |
| `0x006b7e94` | 4 | DISPLACED | script_slots | D | docs/formats/esc.md#the-machine-s | table of 128 slots of 0xC98 bytes, on the heap (D: burglary memory.bin holds a heap pointer, S: slot arithmetic) (also named evt_script_slot |
| `0x006b7e98` | 4 | DISPLACED | script_current | D | docs/formats/esc.md#the-machine-s | the running script, 0 between frames (D) |
| `0x006b7fac` | 4 | DISPLACED | engine_clock | S | docs/addresses.md#saveload-module-found-2026-11-01 | 0x0042dde0 timer setup timeSetEvent(14 ms); tick callback 0x0042dcd0 increments the engine clock 0x006b7fac C (+2 docs) |
| `0x006b7fc0` | 4 | DISPLACED | global_pause | S | docs/ui.md#modal-layers-and-flag-words-cratesguild-appsrcmodalrs-435 | set to 1 by the in-game menu FUN_005e43f0 (0x5e455d) for its whole loop and back to 0 (0x5e47b1); also FUN_005e4c50, FUN_00545aa0/00545c50,  |
| `0x006b8010` | 4 | DISPLACED | active_scene_slot | S | docs/timed-actions.md#0x0d-he_gebaeude_bauen-in-detail-read-2026-11-03-s-unless-marked | set by 0x4432D0; 0 is the main scene; the stage-2 refresh of 0x0D needs 0 |
| `0x006b8300` | 4 | DISPLACED |  | S | docs/structs/memory-map.md#sections-1-9 | 9 005222a0 3D-engine scene: node list head 0x1043254, lights/cameras table 0x1041D80 (H), terrain 0x6B8300; he |
| `0x00772500` | 4 | DISPLACED |  | S | docs/building-dialog.md#1-forms-and-controls-s-unless-h | ), y = 0x16 + row*(pitch+0x16) with pitch = `word[0x772500 + 0x1EE7A]`; |
| `0x007725d0` | 4 | DISPLACED |  | H | docs/building-dialog.md#2-what-options-opens-s | sh confirmation, ...). Also `DAT_014ce8e0 != 0 && DAT_007725d0 == 0` (H: game |
| `0x00772908` | 4 | DISPLACED | route_window_list | S | docs/route-window.md | player dialog |
| `0x00772e9c` | 4 | DISPLACED | fight_attacker_person | S | docs/meetings.md |  |
| `0x00772ea8` | 4 | DISPLACED | fight_settled_flag | S | docs/meetings.md |  |
| `0x00772eac` | 4 | DISPLACED | fight_ransom_result | S | docs/meetings.md |  |
| `0x00772f3c` | 4 | DISPLACED | scene_headless | S | docs/meetings.md | fight scene of meeting type 3 |
| `0x00772fdc` | 4 | DISPLACED | alchemy_players | S | docs/alchemy.md | 12-byte prototypes |
| `0x00772fe4` | 4 | DISPLACED | alchemy_recipes | S | docs/alchemy.md | 12-byte recipes {item, f32 share, f32 start skill} |
| `0x00773d48` | 4 | DISPLACED | command_pump_counter | S | docs/population.md | queue runs when above 0x40 at a slot's start |
| `0x00773d4c` | 4 | DISPLACED | global_accumulator | R | docs/market.md#market-tables-at-a-round-change | city 0 demand follows it; section 12 +58 |
| `0x00773d50` | 4 | DISPLACED | global_accumulator_ceiling | R | docs/market.md#market-tables-at-a-round-change | section 12 +62; floor = a quarter |
| `0x00773d78` | 4 | DISPLACED | class10_market_building | S | docs/market.md#market-tables-at-a-round-change |  |
| `0x00773d80` | 4 | DISPLACED | g_dynasty_name | S | docs/market.md#3-fun005024e0city-i---i32--s----only-called-for-city--dat00773d75 | (by caller). The global building iterator state (0x773D80..0x773DA0, 0x699380..) is clobbered (S). (name g_dynasty_name from the other row,  |
| `0x00773d88` | 4 | DISPLACED | g_dynasty_scan_count | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00773da0` | 4 | DISPLACED | g_query_filter_base | S | docs/market.md#3-fun005024e0city-i---i32--s----only-called-for-city--dat00773d75 | r). The global building iterator state (0x773D80..0x773DA0, 0x699380..) is clobbered (S). (name g_query_filter_base from the other row, H, d |
| `0x00773da8` | 4 | DISPLACED | town_person_ptr | S | docs/ui.md#building-panel-in-the-running-game-d-window-screenshot-2026-11-04-the-workshop-save-cratesguild-appsrcpanelrs | slot 0 |
| `0x00773dac` | 4 | DISPLACED | gm_RichterKatholisch | D | docs/population.md#person-kinds-person-2 | the Catholic (+0x0C = 0) judge, a kind-12 person made by the new game (FUN_00511580); the trial post takes the judge of the person's religio |
| `0x00773db0` | 4 | DISPLACED | gm_RichterEvangelisch | D | docs/population.md#person-kinds-person-2 | the Protestant (+0x0C = 1) judge, a kind-12 person made by the new game (FUN_00511580); the trial post takes the judge of the person's relig |
| `0x007746a0` | 4 | DISPLACED | clicked_object | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet |  |
| `0x007746a4` | 4 | DISPLACED | hover_object | H | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet |  |
| `0x007746b0` | 4 | DISPLACED |  | S | docs/building-dialog.md#p1-click-path-top-down | ): if `DAT_007e2aa0` (selected building b) != 0, `DAT_007746b0 == b` (building under |
| `0x007746c4` | 4 | DISPLACED | cur_building_rooms | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet | 0x11 HE_MESSAGEBOX 55f590 55f5c0 (300) cmd 0x2a; RNG via 00519190; frees - writes +4 = 1 on an object from DAT |
| `0x007746c8` | 4 | DISPLACED | cur_building_scene | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet |  |
| `0x007746cc` | 4 | DISPLACED | cur_room_record | S | docs/building-dialog.md#where-production-is-and-how-the-player-gets-there-s-h-where-marked-no-recording-yet |  |
| `0x007746d8` | 4 | DISPLACED |  | S | docs/building-dialog.md#1-click-routing-s | `DAT_007746d8`, `FUN_0057e880(0x12,b,0,0)`, `FUN_005ba910(b, 1)`, `FUN_0057e880(0x1 |
| `0x007747b4` | 4 | DISPLACED | game_difficulty | D | docs/building-dialog.md#hiring-in-a-live-game | save header dword after the screenshot; 0 London easy, 2 Nuernberg |
| `0x00774800` | 4 | DISPLACED |  | S | docs/person-creation.md#3-common-head-types-other-than-0x150x16-and-0x10-when-no-template-is-free | 6. +0x54 = 0x59a. If DAT_00774800 != 0 (unknown global flag): +0x194 = 10 and +0x190 = 10. (+1 docs) |
| `0x0077494c` | 4 | DISPLACED |  | S | docs/offices.md#8-all-writers-of-the-table--person-office-fields-in-0x4e78000x4ecfff | → 06:00 (only if 0x77494c & 8 or 0x14cbca0 == -1): |
| `0x00774a14` | 4 | DISPLACED |  | S | docs/building-dialog.md#p1-click-path-top-down | al/permission mask `FUN_0057ec70(mask)` (true if `DAT_00774a14==0` |
| `0x00774a78` | 4 | DISPLACED |  | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 23 005b1ff0 linked list of 0x4C-byte nodes, head 0x774a78 unknown (C) |
| `0x00775318` | 4 | DISPLACED |  | S | docs/building-dialog.md#1-forms-and-controls-s-unless-h | me. Globals: slot table 0x776C60 (id, item ptr), `DAT_00775318` = person record, `DAT_006abb00` = its panel control. |
| `0x00776664` | 4 | DISPLACED | opt_details | S | docs/re/notes/436-room-binding.md | room binding/finder/options contract |
| `0x007766a0` | 4 | DISPLACED | sound_volumes | S | docs/audio.md | bytes master, sfx, msx, speech; 0x7766A4 byte msx_freq |
| `0x007e2700` | 4 | DISPLACED |  | S | docs/runtime.md#what-ends-the-day-s | host_tick before `day()`), with `0x774654 == 0`, `0x7E2700 == 0`. |
| `0x007e2aa0` | 4 | DISPLACED |  | H | docs/building-dialog.md#1-click-routing-s | d), `DAT_0100f1dc` != -1 (H: input event valid), `DAT_007e2aa0` = selected building, |
| `0x007e4538` | 4 | DISPLACED | rain_list | S | docs/audio.md | *list = number of drops; 0x0f HE_TRANSPORT 55d0d0 55ea30 (239) cmd 0x1d,0x20,0x4a; RNG; resched; frees cmd 0x10,0x19; RNG; resched; fre |
| `0x007e453c` | 4 | DISPLACED | snow_list | S | docs/viewer.md#weather-particles | see docs/re/notes/particles.md |
| `0x007e46ac` | 4 | DISPLACED | ui_pump_flags | S | docs/runtime.md#what-ends-the-day-s | 60 = 1`; clock job disabled (`0x42df30(job,1)`); `0x7E46AC /= 0x100000`; message box `FUN_00526660(DAT_014a5524, 0xC4)` (nested |
| `0x00868050` | 4 | DISPLACED | building_types | S | docs/addresses.md#saveload-module-found-2026-11-01 | building_types Pointer to the building-type table: Data/A_Geb.dat loaded as-is, 192 records x 589 by (+2 docs); guild-rebrew: lpGebaeudePROT |
| `0x00868054` | 4 | DISPLACED | lpObjekteINST | S | docs/structs/memory-map.md#sections-1-9 | name from guild-rebrew (H); 3 00522390 heap table 0x868054, stride 0x43, capacity 20,488 (0x5008; allocation 0x14F218 bytes in FUN_00501040) |
| `0x0090e094` | 4 | DISPLACED | lpGebaeudeINST | S | docs/structs/memory-map.md#sections-1-9 | name from guild-rebrew (H); 4 00522510 heap table 0x90E094, stride 0xA9, capacity 256; +0 u8 type (index into A_Geb.dat 0x868050), +5 name |
| `0x0099ec10` | 4 | DISPLACED | object_types | S | docs/addresses.md#saveload-module-found-2026-11-01 | object_types Pointer to the object-type table: Data/A_Obj.dat, 732 records x 65 bytes (S: FUN_00501040 allocates 0xB9DC) (category byt (+2 d |
| `0x009b0820` | 4 | DISPLACED | cut_rng_seed | R | docs/elections.md#6-the-meeting-when-a-player-has-a-say | state of cut_rand_mod (also named cut_RandomSeed, H, docs/re/guild-rebrew.md#import) |
| `0x00aed32c` | 4 | DISPLACED | field_delta_entity | S | docs/population.md | entity of the field-delta buffer |
| `0x0100dc20` | 4 | DISPLACED | ai_scratch | S | docs/runtime.md#the-simulation-step-cmexsettime-fun004c9440 | 4 clear 0x0100DC20 AI scratch block (watched building, person, owner, budget) - every step (C) |
| `0x0100f1dc` | 4 | DISPLACED | ui_clicked_control | S | docs/timed-actions-live.md#fragen-boxen | control clicked this frame, -1 none; a %ia button reports 2, a %in button 1 |
| `0x01015ea0` | 4 | DISPLACED | ui_controls | H | docs/addresses.md#saveload-module-found-2026-11-01 | ui_controls Base of a UI-control array, stride 0x2F4 (used when creating message boxes) |
| `0x0104336c` | 4 | DISPLACED | scene_cache_ptrs_0x3dc | S | docs/master-ai.md | scene cache pointers |
| `0x00677ac8` | 2 | DISPLACED | g_log_newline | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, Units/Error); confirm in Ghidra |
| `0x00699384` | 2 | DISPLACED | g_query_filter_extra2 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00699386` | 2 | DISPLACED | g_query_filter_extra3 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x007725c4` | 2 | DISPLACED |  | S | docs/building-dialog.md#p1-click-path-top-down | , a click (`DAT_014ce8dc` or `DAT_014ce8cc` with `DAT_007725c4 == 0xb`), `FUN_00506380(player, b)` rights bit 0x1, |
| `0x00774970` | 2 | DISPLACED | player_person | H | docs/ui.md#building-panel-in-the-running-game-d-window-screenshot-2026-11-04-the-workshop-save-cratesguild-appsrcpanelrs | owner checks in the building panel; name from that use |
| `0x007f4c04` | 2 | DISPLACED |  | S | docs/offices.md#helpers | - hour = u16 at 0x7f4c04 (game clock hour). vacate_state = (hour > 11) ? 4 : 3. |
| `0x014ce8c0` | 2 | DISPLACED |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x0069937c` | 1 | DISPLACED | g_filter_extra5 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00699388` | 1 | DISPLACED | g_query_filter_extra4 | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x006a3440` | 1 | DISPLACED | mission | D | docs/runtime.md#ported-worldround_start_commands-cratesguild-simsrcround_startrs | first byte of section 21; -1 or 5: no action 0x4C |
| `0x006a375c` | 1 | DISPLACED | machine_count | H | docs/timed-actions.md#worker-attachment-svchangeplayerhe-read-2026-11-02-h-where-marked | Divisor in ai_master_is_local; written by cm_ExSysMessage 0x4C9550 |
| `0x007728d4` | 1 | DISPLACED | history_mode_byte | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 16 005251c0 u8 0x7728d4; 0x67fca8, 0x67fcb4; 16 B -> 0x1007ba0; 4 x 0x44 -> 0x1007bc0 unknown (C) (also named history_mode, S, docs/structs/ |
| `0x00772d10` | 1 | DISPLACED | ambience_allowed | S | docs/audio.md | byte: set by day and scene entry, cleared in the round host and movies |
| `0x00773d75` | 1 | DISPLACED | current_account | S | docs/structs/buildings.md#port-recipe-of-round_end_buildings-0x5422c0-s-unless-marked-r-where-docsruntimemd-says | 0x00773d75, 0x00774970, 0x00774654 350-430 functions Widely used flags/pointers (engine/UI state) H (+4 docs) |
| `0x00773d84` | 1 | DISPLACED | g_dynasty_name_ready | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00773d85` | 1 | DISPLACED | g_dynasty_scan_flag | H (ours) | docs/re/guild-rebrew.md#import | guild-rebrew name (DISPLACED match, DieGildeAddOn/game); confirm in Ghidra |
| `0x00773dd4` | 1 | DISPLACED | season_set_row | S | docs/viewer.md#checked-so-far | .txs row applied to scene objects (= time_season) |
| `0x00773de8` | 1 | DISPLACED |  | S | docs/runtime.md#autosave-s | 80("Gamedata/Saves/Autosave.SAV","Autosave",1)`; `0x773de8 = 0`. Network host: SysMessage type 0xF "AUTOSAVE". So the save holds |
| `0x007747b0` | 1 | DISPLACED |  | S | docs/runtime.md#the-session-and-the-day-fun005438c0 | FUN_005438c0 is the whole game session (new game, loaded save or network game; mode bits in 0x007747b0), then  (+1 docs) |
| `0x00774964` | 1 | DISPLACED | day_running | D | docs/runtime.md#the-session-and-the-day-fun_005438c0 | day() sets 1, clears it at its end: off in the step into a new round; FINISH 0x11, 0x26, 0x69, 0x6A, 0xA6 do nothing then (D: 0xA6 on london |
| `0x014cf950` | 1 | DISPLACED |  | S | docs/runtime.md#the-frame-uipumpself-flags-0x5373e0-s | from the frame call tree, see the doc |
| `0x006811b0` | 0 | DISPLACED |  | S | docs/building-dialog.md#1-forms-and-controls-s-unless-h | hen the cart is en route (+0x13 & 0x20), a label `0x6811B0`. |
| `0x006918e8` | 0 | DISPLACED |  | S | docs/person-creation.md#9-portrait-fun004fdfe0-common-tail-deterministic-for-recorded-types | - Else if +0x164 != 0: search table 0x6918e8 (gender 0) or 0x693228 (gender 1) for key == +0x164. Up to 95 |
| `0x00693228` | 0 | DISPLACED |  | S | docs/person-creation.md#9-portrait-fun004fdfe0-common-tail-deterministic-for-recorded-types | - Else if +0x164 != 0: search table 0x6918e8 (gender 0) or 0x693228 (gender 1) for key == +0x164. Up to 95 |
| `0x00696178` | 0 | DISPLACED | home_rooms_table | R | docs/commands.md#command-types | 8 bytes per type: first word = rooms, 8, 12, 20 for types 1, 2, 3 |
| `0x006b5c60` | 0 | DISPLACED | empty_string | S | docs/meetings.md |  |
| `0x00772f90` | 0 | DISPLACED | alchemy_candidates | S | docs/alchemy.md | 3 x 0x18-byte slots |
| `0x007731b8` | 0 | DISPLACED | cannon_table | R | docs/timed-actions.md#residence-cannon-commands-0x66-0x67-cratesguild-simsrccannonrs | 8 x 0x170, R on 2026-11-16-heap |
| `0x00779160` | 0 | DISPLACED | production_ui_products | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked | 16 x 0x58 |
| `0x00779d00` | 0 | DISPLACED |  | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 22 00592370 n x -> 0x779d00 (stride 12) unknown (C) |
| `0x0077e980` | 0 | DISPLACED | he_list | S | docs/timed-actions.md#1-dispatch-fun00546d10-simulation-step-subsystem-1-called-from-cmexsettime-0x4c9440 | - Loop i = 0..DAT_007749d4 (highest used slot) over list 0x77E980, stride 0x14C, 1024 slots (end 0x7D1980). (+3 docs) |
| `0x007d1d80` | 0 | DISPLACED |  | S | docs/timed-actions.md#2-registration | - FUN_00545580(type, start, finish): type 0..0xA6; START table 0x7D1D80[type] = start, FINISH table 0x7DC440[t |
| `0x007d2020` | 0 | DISPLACED | he_list2 | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 14 00524b50 n x -> 0x77e980 (stride 0x14C; count also at 0x7dc424, 0x7749d4; flagged ones listed at 0x7d1980); (+1 docs) |
| `0x007dc440` | 0 | DISPLACED | he_finish_table | S | docs/timed-actions.md#1-dispatch-fun00546d10-simulation-step-subsystem-1-called-from-cmexsettime-0x4c9440 | 2. call FINISH[type](e) where FINISH = table 0x7DC440 (the third argument of the registrar). One argument: e.  (+2 docs) |
| `0x007dcae0` | 0 | DISPLACED | ap_events | R | docs/runtime.md#ported-worldround_start_commands-cratesguild-simsrcround_startrs | countdown, owner, A points, B money, label; third list of section 14 |
| `0x007e1f70` | 0 | DISPLACED | host_clock | S | docs/addresses.md#saveload-module-found-2026-11-01 | host clock Advanced in real time by job 0x00538060 (every 71 timer ticks: +0.625 speed + 50 game s,  (+2 docs) |
| `0x007e35c0` | 0 | DISPLACED | modal_stack | S | docs/runtime.md#one-frame-from-the-entry-to-uipump-s-h-where-marked | from the frame call tree |
| `0x007e43a8` | 0 | DISPLACED | weather_clouds | R | docs/runtime.md | 24 hours, what falls |
| `0x007f3f00` | 0 | DISPLACED | techtree_entries | S | docs/building-dialog.md#6-extend-fun_0059aa10b-focus-tech-tree-and-install-s-r-on-the-water-butts-record-price-and-ticks | 0x34-byte entries |
| `0x007f4c00` | 0 | DISPLACED | game_clock | S | docs/addresses.md#saveload-module-found-2026-11-01 | game clock 14 bytes {i32 round, u16 hour, i32 minute, i32 second}; year = 1400 + round, season = rou (+7 docs) |
| `0x007f4ca0` | 0 | DISPLACED | persons | S | docs/addresses.md#saveload-module-found-2026-11-01 | persons[] 768 x 0x21C person structs (id at +0); 0x7f4c00..9f is the global block with the game cloc (+4 docs) |
| `0x007f4ca2` | 0 | DISPLACED |  | S | docs/building-dialog.md#0x02-heupgradedummy-the-extend-install | - if the owner person's kind byte (`0x7F4CA2 + owner*0x21C`) is 6 (a human player): `FUN_00545E80` posts a message |
| `0x007f4ca4` | 0 | DISPLACED |  | S | docs/addresses.md#globals-in-data-0x6750000x157efff-158-mb---first-inventory | 0x007f4c00..0x007f4cac 600-800 functions each Most-used cluster in the game: central state / global pointers ( |
| `0x007f4cd0` | 0 | DISPLACED |  | S | docs/building-dialog.md#worker-table-product-rows-and-the-staff-book-s-h-where-marked | 007f4ca4`), +8 u8 alive/used, +0x30 name string (`DAT_007f4cd0`), +0x164 u8 (0 = normal; compared ==0 in the worker filters), +0x165 |
| `0x0085ab90` | 0 | DISPLACED | city_market_table | D | docs/timed-actions.md#0x3f-he_einbruch-burglary-in-detail-s-read-2026-11-03-h-where-marked | per city 0x2A90 bytes: 16-byte header, 85 entries of 0x80 (u16 proto +0, f32 price +0x38); FUN_0050BB50 price lookup (D: burglary loot 23025 |
| `0x00868060` | 0 | DISPLACED | cities | S | docs/structs/memory-map.md#layout-of-the-core-state | (5 x 0x2A90) -> cities 0x868060 (4 x 0x2F4). Objects and buildings are heap tables behind pointers. |
| `0x00868080` | 0 | DISPLACED |  | S | docs/market.md#market-tables-at-a-round-change | < 85); hdr = 0x85AB80 + city*0x2A90; city block = 0x868080 + city*0x2F4. |
| `0x0099ef80` | 0 | DISPLACED | danger_grid | R | docs/crime.md#danger-grid-dangerrs-0x99ef80-section-12-at-762-9-bytes-per-cell | 8 x 8 cells of 0x18 bytes: i16 around, i16 here, u8 buildings, i32 protection, 3 floats |
| `0x0099f590` | 0 | DISPLACED |  | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 12 005246e0 globals 0x99f5e0.., 0x99ec14, 0x99f590, 0x773d4c/50; 16 x 20 B -> 0x99ec20; 5 x 68 B -> 0x99f6a0.. |
| `0x0099f5e0` | 0 | DISPLACED |  | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 12 005246e0 globals 0x99f5e0.., 0x99ec14, 0x99f590, 0x773d4c/50; 16 x 20 B -> 0x99ec20; 5 x 68 B -> 0x99f6a0.. |
| `0x0099f800` | 0 | DISPLACED | crime_pair_table | R | docs/crime.md#offences-save-section-10 | 2048 pairs of person, offence |
| `0x009a3800` | 0 | DISPLACED | offence_records | R | docs/crime.md#offences-save-section-10 | 512 x 0x2D, 41 saved |
| `0x009a9220` | 0 | DISPLACED | office_table | S | docs/structs/memory-map.md#sections-1-9 | 8 004ec520 0x9A9220, stride 0x18, exactly 42 offices ("amt_fio_LoadAemter") (C) (+1 docs) |
| `0x009a9660` | 0 | DISPLACED | meeting_table | R | docs/meetings.md | section 15: stride 0x114, 96 slots |
| `0x009b0e20` | 0 | DISPLACED | cutscene_vote_records | S | docs/elections.md#6-the-meeting-when-a-player-has-a-say | 16 of 0x35C, vote +0x94, reason +0x98 |
| `0x00aed220` | 0 | DISPLACED |  | S | docs/population.md#conventions-of-the-builders-s | base of a field_delta_new entry |
| `0x010069a0` | 0 | DISPLACED | active_missions | S | docs/structs/memory-map.md#sections-10-26-after-the-scene | 21 004b6580 u8 0x6a3440; 128 x -> 0x10069a0 (stride 0x24) unknown (C) |
| `0x01008540` | 0 | DISPLACED | ai_method_table | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | 0x49 entries of 0x94 bytes: id, name, evaluate +0x24, precondition +0x28, start +0x2C, short pairs +0x30, long pairs +0x70 |
| `0x0100af80` | 0 | DISPLACED | ai_method_guard_stack | S | docs/master-ai.md#dynasty-ai-methods-and-desires-s | ids of the methods being planned, so none recurses into itself |
| `0x0100b0c0` | 0 | DISPLACED | ai_item_list_0x40 | R | docs/master-ai.md | see the doc |
| `0x0100d0c0` | 0 | DISPLACED | ai_recipe_list_0x58 | R | docs/master-ai.md | see the doc |
| `0x0100e720` | 0 | DISPLACED | ai_weapon_ladder_2 | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | u32[5] 0x174 0x176 0x15E 0x160 0 |
| `0x0100e760` | 0 | DISPLACED | ai_weapon_ladder_1 | S | docs/master-ai.md#guards-thieves-ambush-long-distance-trade-guild_mastersrs-d-the-posts-s-the-rest | u32[6] 0x156 0x154 0x158 0x172 0x16E 0; overwritten by the staff walks (quirk) |
| `0x0100f8c0` | 0 | DISPLACED | ui_hover_text_buffer | S | docs/re/notes/436-floor-plan-icons.md | bounded room/HUD static evidence |
| `0x01015f4c` | 0 | DISPLACED |  | S | docs/building-dialog.md#fun0050f780form-b-t-s | (`0x01015F4C/50` + idx*0x3CC; the numbers are in the form file, not read, open). |
| `0x01038140` | 0 | DISPLACED |  | S | docs/ui.md#2-the-three-forms-and-how-they-open | windows into a form slot (0x1038140 + slot0x2bc: [0]=slot, [1..]=window ids), and moves by (x,y) if nonzero, (+1 docs) |
| `0x010405e0` | 0 | DISPLACED |  | S | docs/viewer.md#checked-so-far | (0x010405e0), fog clamp((d.y + 0.2) 600 / 255). Textures _DYNAMIC/Himmel/sky_{schoen,mittel,schwer}_01, |
| `0x010432c0` | 0 | DISPLACED | scene_slots | S | docs/replay.md | 64 x 0x3DC scene slot structs: +0x80 node list head (stale for the active slot, see 0x1043254), +0xB0 navigation grid; hook regions 10, 11 |
| `0x01043370` | 0 | DISPLACED |  | S | docs/structs/memory-map.md#sections-1-9 | 9 005222a0 3D-engine scene: node list head 0x1043254, lights/cameras table 0x1041D80 (H), terrain 0x6B8300; he |
| `0x014a5320` | 0 | DISPLACED | text_table | D | docs/ui.md#building-panel-in-the-running-game-d-window-screenshot-2026-11-04-the-workshop-save-cratesguild-appsrcpanelrs | text number * 4; one number per .res key in .def order |
| `0x014a79c0` | 0 | DISPLACED | object_name_help_text_pairs | S | docs/re/notes/436-floor-plan-icons.md | der `004677e0`; text "%s~ %li %s" with item name `0x14A79C0[item*8]` and amount; max per slot `FUN_0050DFD0(cart, item)` (store_c |
| `0x014d0020` | 0 | DISPLACED | ch_table | S | docs/quirks.md#fade-pool-exhaustion-crash | 768 character pointers (ch_Create writes, 0x4030e0 and 0x40c070 clear) (also table figure_slots, S, docs/movement.md: 0x300 figure pointers, |

### Not in `symbols.tsv` (235)

VA (size): `0x006b6008` (768), `0x007e4260` (128), `0x006b7ed0` (64), `0x006b7f10` (64), `0x006b7f50` (64), `0x007e4540` (24), `0x00662d70` (16), `0x00662d40` (12), `0x006777b0` (12), `0x006777bc` (12), `0x006b5df8` (12), `0x007e3a40` (12), `0x007e3a50` (12), `0x014ce880` (12), `0x00662930` (8), `0x00662aa0` (8), `0x00662ad0` (8), `0x00662b20` (8), `0x006640f8` (8), `0x00666018` (8), `0x0077257c` (8), `0x01052c48` (8), `0x00662cf8` (4), `0x00662d60` (4), `0x00662d64` (4), `0x00662d68` (4), `0x00664164` (4), `0x0067a370` (4), `0x0067fca0` (4), `0x006a2598` (4), `0x006a2bf8` (4), `0x006a2bfc` (4), `0x006a2c00` (4), `0x006a2c1c` (4), `0x006a9b9c` (4), `0x006b5cf8` (4), `0x006b5d10` (4), `0x006b5d14` (4), `0x006b7d78` (4), `0x006b7d7c` (4), `0x006b7e88` (4), `0x006b7ebc` (4), `0x006b7ec0` (4), `0x006b7f90` (4), `0x006b7f94` (4), `0x006b7fa8` (4), `0x006b7fc4` (4), `0x006b7fdc` (4), `0x006b8014` (4), `0x006b8478` (4), `0x006b847c` (4), `0x006b8480` (4), `0x006b8484` (4), `0x006b86e4` (4), `0x006b86e8` (4), `0x006b86fc` (4), `0x006b8700` (4), `0x006b8704` (4), `0x006b8708` (4), `0x006b870c` (4), `0x006b89e4` (4), `0x0077250c` (4), `0x00772514` (4), `0x00772524` (4), `0x0077253c` (4), `0x00772540` (4), `0x0077255c` (4), `0x0077256c` (4), `0x00772580` (4), `0x00772584` (4), `0x00772588` (4), `0x007725ac` (4), `0x00772614` (4), `0x0077261c` (4), `0x007728bc` (4), `0x00772d14` (4), `0x00772ea4` (4), `0x00772ec4` (4), `0x00772f18` (4), `0x00772f1c` (4), `0x00772f20` (4), `0x00772f24` (4), `0x00774680` (4), `0x00774684` (4), `0x007746ac` (4), `0x007746b4` (4), `0x007746bc` (4), `0x007746c0` (4), `0x007749e4` (4), `0x00774a34` (4), `0x00779cb8` (4), `0x00779ce4` (4), `0x007dc420` (4), `0x007e2704` (4), `0x007e2708` (4), `0x007e2a9c` (4), `0x007e3a44` (4), `0x007e3a48` (4), `0x007e3a54` (4), `0x007e3a58` (4), `0x007ea360` (4), `0x009afde4` (4), `0x009badd0` (4), `0x00fb5740` (4), `0x01005820` (4), `0x01008524` (4), `0x0100dc04` (4), `0x0100dc14` (4), `0x0100f1e4` (4), `0x0104049c` (4), `0x01041d04` (4), `0x010421a0` (4), `0x01042a04` (4), `0x01042a08` (4), `0x010432a4` (4), `0x010432a8` (4), `0x010529c8` (4), `0x01052bac` (4), `0x01052c50` (4), `0x014a558c` (4), `0x014a5774` (4), `0x014a579c` (4), `0x014abc28` (4), `0x014b52fc` (4), `0x014b5798` (4), `0x014cb8f0` (4), `0x014ce728` (4), `0x014ce8a0` (4), `0x007e2510` (2), `0x014ce8c2` (2), `0x014ce922` (2), `0x014cf902` (2), `0x0067a2ac` (1), `0x006b5c28` (1), `0x006b7ffa` (1), `0x00772f5a` (1), `0x00772f5b` (1), `0x00772f5c` (1), `0x00772f5d` (1), `0x014cf736` (1), `0x00662008` (0), `0x00662318` (0), `0x0066231c` (0), `0x00662320` (0), `0x00662324` (0), `0x00662398` (0), `0x006623b0` (0), `0x006623bc` (0), `0x00662408` (0), `0x00662428` (0), `0x0066244c` (0), `0x00662450` (0), `0x00662454` (0), `0x006624a0` (0), `0x006628c8` (0), `0x006628f8` (0), `0x00662d18` (0), `0x006640c0` (0), `0x006641a4` (0), `0x00665b88` (0), `0x00665f78` (0), `0x0067534c` (0), `0x0067536c` (0), `0x006761a4` (0), `0x006761c8` (0), `0x006766f0` (0), `0x006772b4` (0), `0x00679060` (0), `0x0067a470` (0), `0x0067b608` (0), `0x0067b624` (0), `0x0067b63c` (0), `0x0067bbdc` (0), `0x0067dac4` (0), `0x0067dad4` (0), `0x0067dae0` (0), `0x0067eab0` (0), `0x0068149c` (0), `0x0068ae64` (0), `0x0068aec4` (0), `0x0068bef4` (0), `0x0068cb58` (0), `0x0068cfc0` (0), `0x0068cfec` (0), `0x0068d538` (0), `0x0068d6bc` (0), `0x0068deb8` (0), `0x0069037c` (0), `0x006a56d0` (0), `0x006a5708` (0), `0x006ab41c` (0), `0x006ab4d4` (0), `0x006ab4f0` (0), `0x006ab50c` (0), `0x006ab558` (0), `0x006ab570` (0), `0x006b6108` (0), `0x006b6208` (0), `0x006b86c4` (0), `0x00774a80` (0), `0x007774a0` (0), `0x0077dda0` (0), `0x007e2520` (0), `0x007e2760` (0), `0x007e43a4` (0), `0x007e6068` (0), `0x007f3b00` (0), `0x007f3b40` (0), `0x007f4caa` (0), `0x007f4cc0` (0), `0x007f4e51` (0), `0x009b9e40` (0), `0x009ba1c0` (0), `0x009baae0` (0), `0x00aed2a0` (0), `0x010058a0` (0), `0x01008420` (0), `0x0100dc40` (0), `0x0100df20` (0), `0x01015f40` (0), `0x01015f50` (0), `0x010161bc` (0), `0x010161d0` (0), `0x0102cbc0` (0), `0x0102cbc8` (0), `0x01038144` (0), `0x01052bd0` (0), `0x0149d188` (0), `0x014cc5a0` (0), `0x014ce820` (0), `0x014ce89c` (0), `0x014ce920` (0), `0x014cf72a` (0), `0x014cf900` (0), `0x01552020` (0)
