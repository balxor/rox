# Outputs

This folder contains generated outputs from the client-side static analysis workflow.

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

The `/outputs` folder stores analysis results generated from the original client-side files.

These outputs are separated from raw input files so the repository remains easy to audit:

```text
original-files
→ scripts
→ outputs
→ docs
```

The files in this folder are not original client files. They are generated reports, extracted tables, string contexts, inventories, summaries, and intermediate analysis artifacts.

---

## Folder Structure

Recommended structure:

```text
outputs/
├─ articles/ ** hidden **
├─ extracted/
├─ reports/
├─ strings/
└─ tables/
```

---

## 1. `/reports`

This folder contains human-readable technical reports.

Expected files:

| File                                                | Description                                                            |
| --------------------------------------------------- | ---------------------------------------------------------------------- |
| `GameAssembly_static_reverse_engineering_report.md` | Static triage report for `GameAssembly.dll`                            |
| `bundle-hash-resolution-report-resolved.md`         | Report for resolving hashed bundle filenames into logical bundle names |
| `refine_full_client_static_re_phase1_report.md`     | Phase 1 report, surface mapping across binary, metadata, and bundles   |
| `refine_full_client_static_re_phase2_report.md`     | Phase 2 report, table extraction and mechanic correlation              |

---

## 2. `/tables`

This folder contains CSV outputs generated from bundle mapping, table extraction, and refine mechanic analysis.

Expected files:

| File                                          | Description                                                                       |
| --------------------------------------------- | --------------------------------------------------------------------------------- |
| `bundle-hash-to-original-mapping.csv`         | Full mapping from physical hash bundle filenames to logical/original bundle names |
| `bundle-data-lua-candidates.csv`              | Candidate Lua/data bundles selected from resolved bundle names                    |
| `bundle-key-candidates.csv`                   | Key bundle candidates relevant to script, data, localization, or refine analysis  |
| `refine_table_inventory.csv`                  | Inventory of refine-related tables and fields                                     |
| `refine_regular_relegation_rate_summary.csv`  | Regular refine and safe/relegation rate summary                                   |
| `refine_relegation_safe_rate_candidates.csv`  | Safe/relegation rate candidates from `relegation_*` fields                        |
| `refine_relegation_all_rate_families.csv`     | Full extracted family of relegation-related rate fields                           |
| `refine_highlevel_pity_carryover_summary.csv` | Pity progress carry-over summary from `data_equip_RefineHighLevel`                |
| `refine_ticket_summary.csv`                   | Summary of refine ticket / voucher path data                                      |
| `refine_protect_pray_summary.csv`             | Summary of pray/protection path data                                              |
| `refine_hidden_mechanic_findings.csv`         | Hidden or non-obvious mechanic candidates found from client data                  |
| `refine_full_bundle_keyword_index.csv`        | Keyword index across uploaded Lua/data bundles                                    |
| `refine_il2cpp_native_metadata_surface.csv`   | Metadata and binary refine-related symbol surface                                 |
| `refine_bundle_keyword_hits.csv`              | Initial keyword hit summary from refine-related bundles                           |

---

## 3. `/strings`

This folder contains extracted string contexts and keyword scan results.

Expected files:

| File                             | Description                                                  |
| -------------------------------- | ------------------------------------------------------------ |
| `lua_lua_refine_strings.txt`     | Refine-related strings extracted from `lua_lua.bundle`       |
| `refine_data_table_contexts.txt` | Context snippets around refine-related data table names      |
| Additional `*_strings.txt` files | Focused string output from binary, metadata, or bundle scans |

---

## 4. `/extracted`

This folder contains extracted refine-related Lua table files.

These files are extracted from client-side data bundles and stored in readable `.lua` format. They are direct extracted table sources, not compressed archives.

Expected files:

| File                               | Description                                                                                             |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `data_equip_Refine.lua`            | Main refine table containing regular rate, material, cost, luck fields, and relegation/safe path fields |
| `data_equip_RefineProtect.lua`     | Pray / protection refine table containing `pray_*` fields                                               |
| `data_equip_RefineHighLevel.lua`   | Pity / progress table used to read progress levels and carry-over behavior                              |
| `data_equip_RefineTicket.lua`      | Ticket / voucher refine table                                                                           |
| `data_equip_RefineSlotInherit.lua` | Refine slot inheritance / transfer-related table                                                        |

These files should be treated as raw extracted table outputs.

Derived summaries from these extracted Lua tables should be stored in `/outputs/tables`.

Recommended trace chain:

```text
/outputs/extracted/data_equip_Refine.lua
→ /outputs/tables/refine_regular_relegation_rate_summary.csv

/outputs/extracted/data_equip_RefineProtect.lua
→ /outputs/tables/refine_protect_pray_summary.csv

/outputs/extracted/data_equip_RefineHighLevel.lua
→ /outputs/tables/refine_highlevel_pity_carryover_summary.csv

/outputs/extracted/data_equip_RefineTicket.lua
→ /outputs/tables/refine_ticket_summary.csv
```

### Important Notes

`/outputs/extracted` contains raw extracted `.lua` table files.

Do not overwrite these files with interpreted or normalized values.

Keep derived values, summaries, and mechanic interpretation in:

```text
/outputs/tables
/docs
/articles
```

---

## 5. `/articles`

This folder may contain generated HTML article drafts or rendered documentation.

Article drafts should be treated as presentation outputs, not raw source evidence.

If an article makes a technical claim, the claim should be traceable back to `/outputs/extracted`, `/outputs/tables`, `/outputs/reports`, or `/original-files`.

---

## Output Categories

The generated files can be grouped into five analysis layers.

| Layer            | Output Type                                               | Example                                     |
| ---------------- | --------------------------------------------------------- | ------------------------------------------- |
| Bundle mapping   | Hash to logical name resolution                           | `bundle-hash-to-original-mapping.csv`       |
| Surface mapping  | Binary, metadata, script, and keyword surface             | `refine_il2cpp_native_metadata_surface.csv` |
| Raw extraction   | Extracted Lua table files                                 | `data_equip_Refine.lua`                     |
| Table summaries  | Refine table inventory and field summaries                | `refine_table_inventory.csv`                |
| Mechanic mapping | Rate, pity, ticket, protection, hidden mechanic summaries | `refine_hidden_mechanic_findings.csv`       |

---

## Main Findings Captured in Outputs

The output files document several refine-related findings.

| Finding                                                     | Main Output                                           |
| ----------------------------------------------------------- | ----------------------------------------------------- |
| Bundle hash names can be resolved through `BundleList.txt`  | `bundle-hash-resolution-report-resolved.md`           |
| `lua_lua.bundle` contains refine model/script references    | `refine_full_bundle_keyword_index.csv`                |
| `lua_data_data_4.bundle` contains core refine data tables   | `data_equip_Refine.lua`, `refine_table_inventory.csv` |
| Regular refine rate is table-driven                         | `refine_regular_relegation_rate_summary.csv`          |
| Safe/relegation refinement exists as a separate rate family | `refine_relegation_safe_rate_candidates.csv`          |
| Pray/protection refinement is a separate path               | `refine_protect_pray_summary.csv`                     |
| Pity progress uses multiple progress levels and carry-over  | `refine_highlevel_pity_carryover_summary.csv`         |
| Refine ticket path exists as its own table                  | `refine_ticket_summary.csv`                           |
| Some fields remain candidate mechanics                      | `refine_hidden_mechanic_findings.csv`                 |

---

## Traceability Model

Every generated output should be traceable back to source files.

Recommended trace chain:

```text
GameAssembly.dll
→ global-metadata.dat
→ BundleList.txt
→ lua_lua.bundle
→ lua_data_data_*.bundle
→ extracted Lua tables
→ CSV summaries
→ Markdown reports
→ documentation
```

For refine-specific analysis:

```text
lua_data_data_4.bundle
→ data_equip_Refine.lua
→ data_equip_RefineProtect.lua
→ data_equip_RefineHighLevel.lua
→ data_equip_RefineTicket.lua
→ data_equip_RefineSlotInherit.lua
→ mechanic summaries
```

---

## Updating Output Files

When regenerating outputs:

1. Keep original source files unchanged in `/original-files`.
2. Run the relevant script from `/scripts`.
3. Save raw extracted Lua tables into `/outputs/extracted`.
4. Save derived CSV summaries into `/outputs/tables`.
5. Save narrative technical reports into `/outputs/reports`.
6. Update documentation if the interpretation changes.
7. Note any version or source file changes in the repository changelog or commit message.

---

## Recommended CSV Rules

For CSV outputs:

* use UTF-8 encoding;
* keep headers clear and stable;
* avoid mixing raw and derived values without labels;
* include source table or source file where possible;
* include unresolved values explicitly as `UNRESOLVED`, not blank;
* keep numeric fields as numeric values when possible;
* keep player-facing interpretation separate from raw field names.

Recommended columns for extracted table summaries:

| Column           | Purpose                                             |
| ---------------- | --------------------------------------------------- |
| `SourceFile`     | Source bundle or extracted file                     |
| `SourceTable`    | Table name                                          |
| `FieldName`      | Field being analyzed                                |
| `RawValue`       | Raw extracted value                                 |
| `DerivedValue`   | Derived or normalized value                         |
| `Interpretation` | Human-readable interpretation                       |
| `Status`         | Data-backed, candidate, unresolved, or out-of-scope |

---

## Interpretation Status Labels

Use consistent status labels when documenting outputs.

| Label          | Meaning                                                       |
| -------------- | ------------------------------------------------------------- |
| `RAW`          | Direct value from extracted Lua table                         |
| `DATA_BACKED`  | Directly visible from extracted client data                   |
| `DERIVED`      | Calculated from visible data using documented logic           |
| `CANDIDATE`    | Visible in data, but interpretation requires more correlation |
| `UNRESOLVED`   | Not enough evidence to interpret                              |
| `OUT_OF_SCOPE` | Requires runtime, network, or server-side evidence            |

---

## Limitations

Outputs in this folder are generated from client-side static analysis.

They can support claims about:

* visible table fields;
* client-side data structures;
* bundle mappings;
* Lua/model references;
* UI/controller references;
* metadata symbol surfaces;
* extracted rate/progress values.

They do not prove:

* server-side roll logic;
* server-authoritative behavior;
* runtime memory behavior;
* live network validation;
* exploitability;
* bypass feasibility;
* cheating capability.

Server-authoritative behavior is outside the scope of these outputs.

---

## Safety Notice

This folder does not contain instructions for:

* client patching;
* runtime manipulation;
* bypassing protections;
* cheat development;
* exploit development;
* credential extraction;
* server interaction manipulation.

The outputs are intended for documentation, education, and static data analysis.

---

## Disclaimer

The maintainer is not responsible for misuse of these outputs, extracted data, reports, scripts, or analysis results.

Any attempt to use this material for cheating, exploitation, runtime manipulation, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Use these outputs only to understand static file structure, table mapping, and client-side data documentation.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
