# Documentation

This folder contains the written documentation for the client-side static analysis project.

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

The `/docs` folder explains the research process, file mapping workflow, table analysis, and refine mechanic findings in a structured way.

The goal is to make the repository readable without forcing readers to inspect raw bundle files, binary files, or extracted CSV outputs first.

This documentation focuses on:

* how the client files were identified;
* how hashed bundle filenames were resolved;
* how Lua/data bundles were selected;
* how refine-related tables were mapped;
* how table fields were interpreted;
* what mechanics are visible from client-side static analysis;
* what remains outside the scope of client-side analysis.

---

## Documentation Index

| File                                 | Description                                                                               |
| ------------------------------------ | ----------------------------------------------------------------------------------------- |
| `00-overview.md`                     | High-level overview of the repository, scope, and research objective                      |
| `01-original-file-inventory.md`      | Inventory of original uploaded files, binary files, metadata, bundles, and indexes        |
| `02-bundle-hash-resolution.md`       | Explanation of how physical hash bundle filenames were resolved into logical bundle names |
| `03-reverse-engineering-workflow.md` | Step-by-step technical workflow from application-level analysis to data table reading     |
| `04-refine-table-map.md`             | Map of refine-related tables and their roles                                              |
| `05-refine-mechanic-findings.md`     | Summary of refine mechanics found from client-side data                                   |
| `06-hidden-mechanics.md`             | Hidden or non-obvious refine mechanics found in client data                               |
| `07-limitations.md`                  | Known limitations, server-side boundaries, and analysis constraints                       |
| `08-github-publishing-notes.md`      | Notes for publishing, organizing, and maintaining the repository on GitHub                |

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
9. `08-github-publishing-notes.md`

This order follows the actual analysis flow:

```text
Client files
→ bundle inventory
→ hash name resolution
→ Lua/data bundle selection
→ table extraction
→ refine mechanic mapping
→ limitation review
```

---

## Analysis Model

The documentation follows a layered reading model:

| Layer             | Purpose                                                                               |
| ----------------- | ------------------------------------------------------------------------------------- |
| Application layer | Reads `GameAssembly.dll`, IL2CPP metadata, runtime architecture, and protocol surface |
| Bundle layer      | Maps hashed `.bundle` filenames to logical bundle names                               |
| Script layer      | Reads Lua model/UI/controller references                                              |
| Data layer        | Reads refine tables from Lua data bundles                                             |
| Mechanic layer    | Converts table fields into refine mechanic interpretation                             |
| Limitation layer  | Separates client-side findings from server-authoritative behavior                     |

---

## Key Terms

| Term                        | Meaning                                                                |
| --------------------------- | ---------------------------------------------------------------------- |
| Physical hash filename      | The `.bundle` filename stored on disk as a hash                        |
| Logical bundle name         | The original bundle name resolved through `BundleList.txt`             |
| Client-side static analysis | Reading files without executing or modifying the client                |
| Protocol surface            | Request, response, error, and metadata strings visible in client files |
| Table map                   | Relationship between data tables and mechanic layers                   |
| Relegation path             | Safe-like refinement path found in `data_equip_Refine.relegation_*`    |
| Pray / protection path      | Protection-related path found in `data_equip_RefineProtect.pray_*`     |
| Pity progress               | Progress system found in `data_equip_RefineHighLevel`                  |
| Carry-over                  | Overflow progress moving into the next progress level                  |

---

## Main Findings Covered in These Docs

The docs explain several refine-related findings:

| Finding                                      | Source                                               |
| -------------------------------------------- | ---------------------------------------------------- |
| Regular refine rate is table-driven          | `data_equip_Refine`                                  |
| Safe / relegation rate exists in client data | `data_equip_Refine.relegation_*`                     |
| Pray / protection rate is a separate path    | `data_equip_RefineProtect`                           |
| Pity progress uses multiple progress levels  | `data_equip_RefineHighLevel`                         |
| Pity progress uses carry-over behavior       | Derived from `RefineHighLevel` progression analysis  |
| Refine ticket path exists as its own table   | `data_equip_RefineTicket`                            |
| Some fields remain candidate mechanics       | Requires deeper script/item/localization correlation |

---

## What This Documentation Does Not Claim

This documentation does not claim:

* server-side roll logic;
* server-authoritative outcome behavior;
* runtime memory behavior;
* exploitability;
* bypass methods;
* patching methods;
* cheat behavior;
* network interception results.

The documentation only describes what is visible from client-side static files and extracted data.

---

## Related Folders

| Folder            | Purpose                                                                                 |
| ----------------- | --------------------------------------------------------------------------------------- |
| `/original-files` | Original binaries, metadata, bundles, and index files used in analysis                  |
| `/outputs`        | Generated reports, CSV tables, extracted contexts, and reverse engineering outputs      |
| `/scripts`        | Utility scripts for inventory export, bundle name resolution, and refine bundle copying |
| `/screenshots`    | Supporting screenshots for documentation or repository explanation                      |

---

## Source Traceability

Each technical claim in the docs should be traceable to one of these sources:

| Source Type       | Example                                              |
| ----------------- | ---------------------------------------------------- |
| Binary / metadata | `GameAssembly.dll`, `global-metadata.dat`            |
| Bundle index      | `BundleList.txt`                                     |
| Lua bundle        | `lua_lua.bundle`                                     |
| Data bundle       | `lua_data_data_0.bundle` to `lua_data_data_4.bundle` |
| Extracted tables  | CSV files in `/outputs/tables`                       |
| Technical reports | Markdown files in `/outputs/reports`                 |

When updating these docs, keep the source chain clear.

---

## Writing Standard

Use direct, source-based wording.

Prefer:

```text
The table contains...
The field appears in...
The client data shows...
The extracted row indicates...
```

Avoid unsupported claims such as:

```text
The server definitely does...
This guarantees...
This proves exploitability...
```

Client-side evidence should stay within client-side boundaries.

---

## Disclaimer

This documentation is provided for educational, documentation, and client-side static analysis purposes.

It does not include runtime manipulation, patching, bypass instructions, cheat logic, exploit instructions, credential extraction, or server-side claims.

The maintainer is not responsible for misuse of this documentation, scripts, files, extracted data, or analysis results. Any attempt to use this material for cheating, exploiting game systems, manipulating client behavior, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
