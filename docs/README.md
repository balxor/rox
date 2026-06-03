# Documentation

This folder contains the written documentation for the client-side static analysis project.

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

The `/docs` folder explains the research process, file mapping workflow, table analysis, IL2CPP surface validation, and refine mechanic findings in a structured way.

The goal is to make the repository readable without forcing readers to inspect raw bundle files, binary files, extracted Lua tables, CSV outputs, or IL2CPP dump artifacts first.

This documentation focuses on:

* how the client files were identified;
* how application-level triage was performed;
* why the search moved from `GameAssembly.dll` into `StreamingAssets/Bundle`;
* how hashed bundle filenames were resolved;
* how Lua/data bundles were selected;
* how refine-related tables were extracted and mapped;
* how table fields were interpreted;
* what mechanics are visible from client-side static analysis;
* what the Il2CppDumper output can and cannot show;
* what remains outside the scope of client-side analysis.

---

## Documentation Index

| File                                 | Description                                                                                               |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------- |
| `00-overview.md`                     | High-level overview of the repository, scope, and research objective                                      |
| `01-original-file-inventory.md`      | Inventory of original uploaded files, binary files, metadata, bundles, indexes, and IL2CPP dump artifacts |
| `02-bundle-hash-resolution.md`       | Explanation of how physical hash bundle filenames were resolved into logical bundle names                 |
| `03-reverse-engineering-workflow.md` | Step-by-step technical workflow from application-level analysis to data table reading                     |
| `04-refine-table-map.md`             | Map of refine-related tables and their roles                                                              |
| `05-refine-mechanic-findings.md`     | Summary of refine mechanics found from client-side data                                                   |
| `06-hidden-mechanics.md`             | Hidden or non-obvious refine mechanics found in client data                                               |
| `07-limitations.md`                  | Known limitations, server-side boundaries, and analysis constraints                                       |
| `08-il2cppdump-validation.md`        | IL2CPP dump validation notes for refine protocol, result enum, metadata, and RNG surface                  |

If some documents are not included in the repository yet, keep this index as the target structure.

---

## Recommended Reading Order

Read the documents in this order:

1. `00-overview.md`
2. `01-original-file-inventory.md`
3. `02-bundle-hash-resolution.md`
4. `03-reverse-engineering-workflow.md`
5. `04-refine-table-map.md`
6. `05-refine-mechanic-findings.md`
7. `06-hidden-mechanics.md`
8. `07-limitations.md`
9. `08-il2cppdump-validation.md`

This order follows the actual analysis flow:

```text
Client files
→ application-level triage
→ bundle inventory
→ hash name resolution
→ Lua/data bundle selection
→ extracted Lua table reading
→ table summary generation
→ refine mechanic mapping
→ IL2CPP dump validation
→ limitation review
```

---

## Analysis Model

The documentation follows a layered reading model:

| Layer             | Purpose                                                                                    |
| ----------------- | ------------------------------------------------------------------------------------------ |
| Application layer | Reads `GameAssembly.dll`, IL2CPP metadata, runtime architecture, and protocol surface      |
| Metadata layer    | Reads `global-metadata.dat` and IL2CPP symbols, fields, enums, and strings                 |
| IL2CPP dump layer | Uses Il2CppDumper output to validate method, metadata, enum, string, and protocol surfaces |
| Bundle layer      | Maps hashed `.bundle` filenames to logical bundle names                                    |
| Script layer      | Reads Lua model/UI/controller references                                                   |
| Data layer        | Reads refine tables from Lua data bundles                                                  |
| Extraction layer  | Stores extracted refine `.lua` table files in `/outputs/extracted`                         |
| Mechanic layer    | Converts table fields into refine mechanic interpretation                                  |
| Limitation layer  | Separates client-side findings from server-authoritative behavior                          |

---

## Key Terms

| Term                        | Meaning                                                                                                         |
| --------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Physical hash filename      | The `.bundle` filename stored on disk as a hash                                                                 |
| Logical bundle name         | The original bundle name resolved through `BundleList.txt`                                                      |
| Client-side static analysis | Reading files without executing or modifying the client                                                         |
| Protocol surface            | Request, response, error, enum, and metadata strings visible in client files                                    |
| IL2CPP dump surface         | Method, metadata, string, enum, and address surface generated from `GameAssembly.dll` and `global-metadata.dat` |
| Extracted Lua table         | A readable `.lua` table file extracted from a Lua data bundle                                                   |
| Table map                   | Relationship between data tables and mechanic layers                                                            |
| Relegation path             | Safe-like refinement path found in `data_equip_Refine.relegation_*`                                             |
| Pray / protection path      | Protection-related path found in `data_equip_RefineProtect.pray_*`                                              |
| Pity progress               | Progress system found in `data_equip_RefineHighLevel`                                                           |
| Carry-over                  | Overflow progress moving into the next progress level                                                           |
| Server-side boundary        | Behavior that cannot be concluded from client-side static files alone                                           |

---

## Main Findings Covered in These Docs

The docs explain several refine-related findings:

| Finding                                                                           | Source                                                             |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Regular refine rate is table-driven                                               | `data_equip_Refine`                                                |
| Safe / relegation rate exists in client data                                      | `data_equip_Refine.relegation_*`                                   |
| Pray / protection rate is a separate path                                         | `data_equip_RefineProtect`                                         |
| Pity progress uses multiple progress levels                                       | `data_equip_RefineHighLevel`                                       |
| Pity progress uses carry-over behavior                                            | Derived from `RefineHighLevel` progression analysis                |
| Refine ticket path exists as its own table                                        | `data_equip_RefineTicket`                                          |
| Refine slot inheritance has its own data source                                   | `data_equip_RefineSlotInherit`                                     |
| Refine model/UI references are visible in Lua script surface                      | `lua_lua.bundle`                                                   |
| Refine protocol and result enum surfaces are visible in IL2CPP dump output        | Il2CppDumper output                                                |
| Refine-specific RNG algorithm is not visible from client-side IL2CPP dump surface | IL2CPP dump validation report                                      |
| Some fields remain candidate mechanics                                            | Requires deeper script, item, localization, or runtime correlation |

---

## What This Documentation Does Not Claim

This documentation does not claim:

* server-side roll logic;
* server-side RNG algorithm;
* server-authoritative outcome behavior;
* runtime memory behavior;
* exploitability;
* bypass methods;
* patching methods;
* cheat behavior;
* network interception results.

The documentation only describes what is visible from client-side static files, extracted data, IL2CPP dump output, and generated analysis artifacts.

---

## Related Folders

| Folder                | Purpose                                                                                  |
| --------------------- | ---------------------------------------------------------------------------------------- |
| `/original-files`     | Original binaries, metadata, bundles, indexes, and IL2CPP dump archives used in analysis |
| `/outputs/reports`    | Generated technical reports                                                              |
| `/outputs/tables`     | Generated CSV summaries and table analysis outputs                                       |
| `/outputs/strings`    | Extracted string/context files                                                           |
| `/outputs/extracted`  | Extracted refine-related `.lua` table files                                              |
| `/outputs/il2cppdump` | Il2CppDumper validation outputs                                                          |
| `/outputs/articles`   | Article drafts or rendered documentation outputs, if included                            |
| `/scripts`            | Utility scripts for inventory export, bundle name resolution, and refine bundle copying  |

---

## Source Traceability

Each technical claim in the docs should be traceable to one of these sources:

| Source Type              | Example                                                                               |
| ------------------------ | ------------------------------------------------------------------------------------- |
| Binary / metadata        | `GameAssembly.dll`, `global-metadata.dat`                                             |
| IL2CPP dump output       | `dump.cs`, `script.json`, `stringliteral.json`, generated IL2CPP validation CSV files |
| Bundle index             | `BundleList.txt`                                                                      |
| Lua bundle               | `lua_lua.bundle`                                                                      |
| Data bundle              | `lua_data_data_0.bundle` to `lua_data_data_4.bundle`                                  |
| Extracted Lua tables     | `.lua` files in `/outputs/extracted`                                                  |
| CSV summaries            | CSV files in `/outputs/tables`                                                        |
| Technical reports        | Markdown files in `/outputs/reports`                                                  |
| IL2CPP validation report | Markdown and CSV files in `/outputs/il2cppdump`                                       |

When updating these docs, keep the source chain clear.

Recommended trace chain:

```text
GameAssembly.dll
→ global-metadata.dat
→ Il2CppDumper output
→ /outputs/il2cppdump

BundleList.txt
→ lua_lua.bundle
→ lua_data_data_4.bundle
→ /outputs/extracted/*.lua
→ /outputs/tables/*.csv
→ /docs/*.md
```

---

## Documentation Maintenance Notes

When updating documentation:

1. Keep raw extracted `.lua` files in `/outputs/extracted`.
2. Keep derived CSV summaries in `/outputs/tables`.
3. Keep IL2CPP dump validation output in `/outputs/il2cppdump`.
4. Keep technical narrative reports in `/outputs/reports`.
5. Do not mix raw extracted data with interpretation.
6. Use `DATA_BACKED`, `DERIVED`, `CANDIDATE`, `UNRESOLVED`, or `OUT_OF_SCOPE` when classifying findings.
7. Keep server-authoritative behavior clearly separated from client-side findings.

---

## Disclaimer

This documentation is provided for educational, documentation, and client-side static analysis purposes.

It does not include runtime manipulation, patching, bypass instructions, cheat logic, exploit instructions, credential extraction, server-side RNG reconstruction, or server-side claims.

The maintainer is not responsible for misuse of this documentation, scripts, files, extracted data, or analysis results. Any attempt to use this material for cheating, exploiting game systems, manipulating client behavior, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Use this documentation only to understand static file structure, bundle mapping, IL2CPP surface mapping, table mapping, and client-side data documentation workflow.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
