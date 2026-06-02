# Refine Full Client-Side Static RE - Phase 1

## Scope
Static analysis only. No game execution, patching, bypassing, or server-side inference. This pass uses the uploaded `GameAssembly.dll`, `global-metadata.dat`, and six Lua/data bundles.

## Input files
| File | Size | SHA-256 |
|---|---:|---|
| `GameAssembly.dll` | 71,603,200 | `c7dd11c6e9e90fca24375db3e4c32c871b6bdf3a4756eb0eede4077ef2c15971` |
| `global-metadata.dat` | 18,870,148 | `b06db84324bd8212d4638e715510ebd76df336cce012b61224a50e3ede473e8c` |
| `lua_lua.bundle` | 13,850,066 | `54924674a992b24a70302d4b170b76a13e503c39e562c4be1ab0bc77026cf37f` |
| `lua_data_data_0.bundle` | 4,714,209 | `028f032387c784a0f0bf63976e871694d3e96dab3108bc2ec685211d514e134d` |
| `lua_data_data_1.bundle` | 10,485,682 | `3e030cab7f67a9141f7412421531753d8049ad1d825d52434e40ba3e23967de0` |
| `lua_data_data_2.bundle` | 6,825,607 | `5071d02423db04cdf60d023551cd7d484d709a7d26f5692a049804457b80b206` |
| `lua_data_data_3.bundle` | 1,018,626 | `00861382a1da4c5c0fec400ac5b2fa9aeef9f3642d8b6b5a9452ace6b3560819` |
| `lua_data_data_4.bundle` | 4,104,887 | `eed1ce254f50625ac24b637d25bbc739e1d850446e0ba28040516c65bf5d5287` |

## What changed after uploading GameAssembly.dll

| Area | Result |
|---|---|
| IL2CPP pair | `GameAssembly.dll` can now be paired with `global-metadata.dat` for metadata/native surface analysis. |
| Metadata surface | `global-metadata.dat` exposes refine request/response names, lucky point fields, validation strings, and refine level identifiers. |
| Native surface | `GameAssembly.dll` contains supporting refine/protection/lua/runtime strings, but numeric mechanic tables still live in Lua/data bundles. |
| Bundle surface | `lua_data_data_4.bundle` is the main source for refine tables; `lua_lua.bundle` is the main source for Lua model/UI/request references. |

## Keyword surface counts
| Source | Count |
|---|---:|
| `GameAssembly.dll` strings | 100 |
| `global-metadata.dat` strings | 383 |
| `lua_data_data_0.bundle` (bundle_raw) | 36 |
| `lua_data_data_0.bundle` (unpacked_stream) | 280 |
| `lua_data_data_1.bundle` (bundle_raw) | 85 |
| `lua_data_data_1.bundle` (unpacked_stream) | 363 |
| `lua_data_data_2.bundle` (bundle_raw) | 14 |
| `lua_data_data_2.bundle` (unpacked_stream) | 29 |
| `lua_data_data_3.bundle` (bundle_raw) | 9 |
| `lua_data_data_3.bundle` (unpacked_stream) | 63 |
| `lua_data_data_4.bundle` (bundle_raw) | 260 |
| `lua_data_data_4.bundle` (unpacked_stream) | 4840 |
| `lua_lua.bundle` (bundle_raw) | 166 |
| `lua_lua.bundle` (unpacked_stream) | 1093 |

## Important terms found

### `data_equip_Refine`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refine.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refinehighlevel.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineprotect.bytes?` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineslotinherit.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineticket.bytes` |
| `lua_data_data_4.bundle` | `data_equip_Refine` |
| `lua_data_data_4.bundle` | `data_equip_RefineHighLevel` |
| `lua_data_data_4.bundle` | `data_equip_RefineProtect` |

### `data_equip_RefineProtect`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineprotect.bytes?` |
| `lua_data_data_4.bundle` | `data_equip_RefineProtect` |

### `data_equip_RefineHighLevel`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refinehighlevel.bytes` |
| `lua_data_data_4.bundle` | `data_equip_RefineHighLevel` |

### `data_equip_RefineTicket`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineticket.bytes` |
| `lua_data_data_4.bundle` | `data_equip_RefineTicket` |

### `data_equip_RefineSlotInherit`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineslotinherit.bytes` |
| `lua_data_data_4.bundle` | `data_equip_RefineSlotInherit#` |

### `assets/resources/lua/data/data_equip_refine`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refine.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refinehighlevel.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineprotect.bytes?` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineslotinherit.bytes` |
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineticket.bytes` |

### `RefineModel`

| Source | Example string |
|---|---|
| `lua_lua.bundle` | `RefineModel` |
| `lua_lua.bundle` | `\@D:/jenkins_hw/workspace/sea_1/ro_client_Windows_normal/SourceRes/Lua/model/RefineModel.lua` |
| `lua_lua.bundle` | `assets/resources/lua/lua/model_refinemodel.bytes` |
| `lua_lua.bundle` | `mRefineModel` |
| `lua_lua.bundle` | `model_RefineModel` |
| `lua_lua.bundle` | `refineModel` |

### `RefineTicket`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineticket.bytes` |
| `lua_data_data_4.bundle` | `data_equip_RefineTicket` |
| `lua_data_data_4.bundle` | `_RefineTicket` |
| `lua_data_data_3.bundle` | `["IsRefineTicketCan"]= 1,` |
| `lua_lua.bundle` | `GetRefineTicketConfig` |
| `lua_lua.bundle` | `GetRefineTicketConfigByItemId` |
| `lua_lua.bundle` | `GetRefineTicketConfigList` |
| `lua_lua.bundle` | `GetRefineTicketEquipType` |

### `RefineProtect`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refineprotect.bytes?` |
| `lua_data_data_4.bundle` | `data_equip_RefineProtect` |
| `lua_data_data_4.bundle` | `quip_RefineProtect` |
| `lua_lua.bundle` | `GetRefineProtectConfig` |
| `lua_lua.bundle` | `data.equip.RefineProtect` |
| `lua_lua.bundle` | `refineProtectCfgList` |

### `RefineHighLevel`

| Source | Example string |
|---|---|
| `lua_data_data_4.bundle` | `assets/resources/lua/data/data_equip_refinehighlevel.bytes` |
| `lua_data_data_4.bundle` | `data_equip_RefineHighLevel` |
| `lua_lua.bundle` | `GetRefineHighLevelCfg` |
| `lua_lua.bundle` | `HandleRefineHighLevelCfg` |
| `lua_lua.bundle` | `data.equip.RefineHighLevel` |
| `lua_lua.bundle` | `refineHighLevelCfg` |
| `lua_lua.bundle` | `refineHighLevelCfg6` |

### `ClientEquipmentRefine`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `ClientEquipmentRefineLevelSwapRequest` |
| `global-metadata.dat` | `ClientEquipmentRefineRequest` |
| `global-metadata.dat` | `ToClientEquipmentRefineResponse` |

### `ToClientEquipmentRefine`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `ToClientEquipmentRefineResponse` |

### `EquipmentRefine`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `ClientEquipmentRefineLevelSwapRequest` |
| `global-metadata.dat` | `ClientEquipmentRefineRequest` |
| `global-metadata.dat` | `ClientPinnacleRaceEquipmentRefineRequest` |
| `global-metadata.dat` | `EquipmentRefineAOINotify` |
| `global-metadata.dat` | `EquipmentRefineAllreadyMaxLevel` |
| `global-metadata.dat` | `EquipmentRefineCostNotEnough` |
| `global-metadata.dat` | `EquipmentRefineInvalidEquipmentToRefine` |
| `global-metadata.dat` | `EquipmentRefineLuckyPointNotEnough` |

### `WeaponLuckyPoint`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `WeaponLuckyPoint` |
| `lua_lua.bundle` | `AddWeaponLuckyPoint` |
| `lua_lua.bundle` | `WeaponLuckyPoint` |
| `lua_lua.bundle` | `weaponLuckyPoint` |
| `lua_data_data_0.bundle` | `weaponLuckyPoint` |

### `ArmorLuckyPoint`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `ArmorLuckyPoint` |
| `lua_lua.bundle` | `AddArmorLuckyPoint` |
| `lua_lua.bundle` | `ArmorLuckyPoint` |
| `lua_lua.bundle` | `armorLuckyPoint` |
| `lua_data_data_0.bundle` | `armorLuckyPoint` |

### `JeweleryLuckyPoint`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `JeweleryLuckyPoint` |
| `lua_lua.bundle` | `AddJeweleryLuckyPoint` |
| `lua_lua.bundle` | `JeweleryLuckyPoint` |
| `lua_lua.bundle` | `jeweleryLuckyPoint` |
| `lua_data_data_0.bundle` | `jeweleryLuckyPoint` |

### `MaxEquipRefineLevel`

| Source | Example string |
|---|---|
| `global-metadata.dat` | `MaxEquipRefineLevel` |
| `global-metadata.dat` | `MaxEquipRefineLevelFieldNumber` |
| `global-metadata.dat` | `get_MaxEquipRefineLevel` |
| `global-metadata.dat` | `maxEquipRefineLevel_` |
| `global-metadata.dat` | `set_MaxEquipRefineLevel` |
| `lua_lua.bundle` | `ConditionCurMaxEquipRefineLevel` |
| `lua_lua.bundle` | `#OnHistoryMaxEquipRefineLevelChange` |
| `lua_lua.bundle` | `$ConditionHistoryMaxEquipRefineLevel` |

### `EQUIPMENT_REFINE`

| Source | Example string |
|---|---|
| `GameAssembly.dll` | `EQUIPMENT_REFINE_ALLREADY_MAX_LEVEL` |
| `GameAssembly.dll` | `EQUIPMENT_REFINE_COST_NOT_ENOUGH` |
| `GameAssembly.dll` | `EQUIPMENT_REFINE_INVALID_EQUIPMENT_TO_REFINE` |
| `GameAssembly.dll` | `EQUIPMENT_REFINE_LUCKY_POINT_NOT_ENOUGH` |
| `GameAssembly.dll` | `EQUIPMENT_REFINE_NOT_SUIT_TO_SWAP` |
| `GameAssembly.dll` | `EQUIPMENT_REFINE_RANGE_LIMIT` |
| `GameAssembly.dll` | `MESSAGE_ID_2_CLIENT_PINNACLE_RACE_EQUIPMENT_REFINE_REQUEST` |
| `GameAssembly.dll` | `MESSAGE_ID_2_TO_CLIENT_PINNACLE_RACE_EQUIPMENT_REFINE_RESPONSE` |

## Current assessment

| Mechanic layer | Best source | Status |
|---|---|---|
| Regular refine rate | `lua_data_data_4.bundle` -> `data_equip_Refine` | Found and already used in locked Refine Rate article. |
| Protection/pray rate | `lua_data_data_4.bundle` -> `data_equip_RefineProtect` | Found, coverage still needs full export audit. |
| Pity progress | `lua_data_data_4.bundle` -> `data_equip_RefineHighLevel` | Found and already used in locked Pity Refine article. |
| Ticket/lucky mechanic | `data_equip_RefineTicket` + metadata lucky point fields | Found as candidate, needs deep analysis. |
| Inheritance/transfer | `data_equip_RefineSlotInherit` | Found as candidate, needs deep analysis. |
| Script/model flow | `lua_lua.bundle` -> refine model/UI/request strings | Found as surface, needs full script extraction. |
| Native IL2CPP methods | `global-metadata.dat` + `GameAssembly.dll` | Pair available, deeper method-body mapping would need an IL2CPP dumper/parser workflow. |

## Hidden mechanic candidates to inspect next

| Candidate | Why it matters |
|---|---|
| `RefineTicket` | May separate ticket/voucher/lucky refine behavior from core pity progress. |
| `WeaponLuckyPoint`, `ArmorLuckyPoint`, `JeweleryLuckyPoint` | Metadata shows slot-specific lucky point fields; this may explain storage and UI display. |
| `lock_upgrade_rate` / `lock_downgrade_rate` / `relegation_*` | These fields appear in data bundle strings and may relate to protected/safe/special refine paths. Need table-level extraction before making claims. |
| `extraupgrade_rate` / `extra_upgrade_rate` | Candidate modifier fields; must be tied to table and script usage before interpretation. |
| `data_InternationalChampion_ICRefine` or event refine tables | Earlier scan showed possible event/special refine references outside core refine table. |

## Generated files
- `refine_il2cpp_native_metadata_surface.csv`
- `refine_full_bundle_keyword_index.csv`
- `refine_full_client_static_re_phase1_report.md`


## Next phase
Extract actual table blocks from `lua_data_data_4.bundle.bin`, especially `data_equip_RefineTicket`, `RefineProtect`, `RefineHighLevel`, `RefineSlotInherit`, and suspicious fields such as `lock_upgrade_rate`, `lock_downgrade_rate`, and `relegation_*`.
