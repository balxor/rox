# Refine Full Client-Side Static RE, Phase 2

## Scope

Phase 2 extracts the readable Lua data tables from the uploaded UnityFS bundles and correlates them with the Lua/model and IL2CPP metadata surface found in Phase 1. This is still client-side static analysis. It does not claim server-side roll implementation.

## Source set

| Layer | Source | Result |
|---|---|---|
| Lua script/model bundle | `lua_lua.bundle` | refine script/model/UI references found |
| Data table bundle | `lua_data_data_4.bundle` | core refine tables extracted |
| IL2CPP metadata | `global-metadata.dat` | refine request/response, lucky point, refine level metadata strings |
| Native binary | `GameAssembly.dll` | confirms IL2CPP surface and runtime pairing |

## Extracted core tables

| Table | Entries | Key role |
|---|---:|---|
| `data_equip_Refine` | 9007 | regular rate, material, cost, inheritance values, special/relegation fields |
| `data_equip_RefineProtect` | 144 | pray/protection path, refine_lv 4-11 |
| `data_equip_RefineHighLevel` | 76 | pity/progress accumulator |
| `data_equip_RefineTicket` | 56 | ticket/voucher refine relation |
| `data_equip_RefineSlotInherit` | 21 | refine slot inheritance mapping |

## Main new findings

### 1. Safe/Relegation Rate is present in reverse data

Earlier we treated the community Safe Refinement Rate table as not traceable to `data_equip_RefineProtect`. Phase 2 changes that reading. The Safe-like rate pattern is not in `data_equip_RefineProtect`; it appears in `data_equip_Refine` under the `relegation_*` field family.

Relevant fields:

```text
relegation_upgrade_rate
relegation_keepgrade_rate
relegation_break_rate
relegation_downgrade_rate
relegation_material
relegation_num
relegation_special_num
```

For the severe material-backed family, target `refine_lv=15` (+14 → +15) reads:

| Outcome | Rate |
|---|---:|
| Success | 0.625% |
| Keep / Fail | 29.375% |
| Break | 70% |
| Downgrade | 0% |

This matches the Safe Refinement Rate pattern that was previously only available from community screenshots. The better source label is now `data_equip_Refine.relegation_*`, not `data_equip_RefineProtect`.

### 2. `data_equip_RefineProtect` is still a separate pray/protection path

`data_equip_RefineProtect` remains separate from the safe/relegation family. It has `pray_*` fields, not `relegation_*` fields. It covers only target `refine_lv=4` to `11`, equivalent to +3 → +4 through +10 → +11.

### 3. Pity progress uses carry-over across progress levels

`data_equip_RefineHighLevel` does not store one simple `Required Points = 5000` row. It stores five progress rows for most levels:

```text
RefineProgress = 1000
RefineProgressLevel = 0..4
```

The normalized total remains 5000, but the raw mechanic is 5 rows × 1000 progress. Fails-until-pity only matches observed values when overflow progress carries into the next progress level.

Example, +14 → +15 uses `data_equip_RefineHighLevel.refine_lv = 14`:

```text
NoProtect values: 1000 / 500 / 334 / 250 / 200
Fails with carry-over: 15
ProtectValue2 values: 100 / 50 / 34 / 25 / 20
Fails with carry-over: 149
```

### 4. Convention warning

`data_equip_Refine` uses target-level convention:

```text
refine_lv = 15 means +14 → +15
```

`data_equip_RefineHighLevel` reads as current-level transition convention:

```text
refine_lv = 14 means +14 → +15
refine_lv = 15 is the cap/zero row
```

This means the Pity Refine article needs a technical correction if it says `data_equip_RefineHighLevel.refine_lv=15` is +14 → +15. The rate table convention and high-level progress convention are not identical.

### 5. RefineTicket source found

`data_equip_RefineTicket` has 56 entries. Its visible scalar pattern is:

```text
upgrade_rate = 5.0
break_rate = 0.0
downgrade_rate = 0.0
upgrade_lv = 5..15
ticket_type = 1
```

This is a real source for ticket/voucher refine behavior, but item-name mapping is still needed before writing player-facing item labels.

## Files produced

- `refine_table_inventory.csv`
- `refine_regular_relegation_rate_summary.csv`
- `refine_relegation_safe_rate_candidates.csv`
- `refine_relegation_all_rate_families.csv`
- `refine_highlevel_pity_carryover_summary.csv`
- `refine_ticket_summary.csv`
- `refine_protect_pray_summary.csv`
- `refine_hidden_mechanic_findings.csv`
- `refine_extracted_tables.zip`

## Recommendation

Before rewriting the public article, update the internal model:

1. Refine Rate article should add a note that Safe/Relegation Rate exists in `data_equip_Refine.relegation_*`, separate from `data_equip_RefineProtect`.
2. Pity Refine article should change raw explanation to 5 progress rows × 1000, with carry-over.
3. Refine Reverse Engineering should show how Phase 2 found these fields from `lua_data_data_4.bundle`.
