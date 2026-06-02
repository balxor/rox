# Original Files

This folder contains the original client-side files used as source material for the static analysis workflow.

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

The `/original-files` folder stores the raw input files used during the research process.

These files are kept separately from generated reports, extracted tables, and written documentation so the source chain stays clear:

```text
original files
→ analysis scripts
→ extracted outputs
→ documentation
→ article / findings
```

This folder is intended for traceability. It helps readers understand which files were analyzed and how the reverse engineering outputs were produced.

---

## Folder Structure

Recommended structure:

```text
original-files/
├─ binary/
├─ bundles/
├─ indexes/
└─ metadata/
```

---

## 1. `/binary`

This folder stores native binary files used for application-level static analysis.

Expected files:

| File               | Purpose                                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------------------- |
| `GameAssembly.dll` | Unity IL2CPP native binary used for runtime, metadata surface, string, import/export, and protocol surface analysis |

### Notes

`GameAssembly.dll` is used to identify:

* Unity IL2CPP runtime structure;
* exported IL2CPP API surface;
* game-related protocol strings;
* refine/enchant/equipment request and response names;
* error strings;
* runtime architecture hints;
* HybridCLR / XLua indicators.

This file does not directly expose all numeric refine tables as plain text. It is used as an application-level map before moving into metadata, Lua, and data bundles.

---

## 2. `/metadata`

This folder stores IL2CPP metadata files.

Expected files:

| File                  | Purpose                                                                                                  |
| --------------------- | -------------------------------------------------------------------------------------------------------- |
| `global-metadata.dat` | IL2CPP metadata used to map managed symbols, type names, method names, field names, and metadata strings |

### Notes

`global-metadata.dat` is paired with `GameAssembly.dll`.

It helps identify:

* managed type names;
* method names;
* field names;
* request / response types;
* error code symbols;
* lucky point fields;
* refine level fields;
* metadata strings related to equipment refine.

This file improves symbol-level visibility, but server-authoritative behavior still cannot be concluded from metadata alone.

---

## 3. `/bundles`

This folder stores selected Unity AssetBundle files after resolving physical hash filenames into logical bundle names.

Expected core bundles:

| Logical Bundle Name      | Physical Hash Filename                    | Purpose                                          |
| ------------------------ | ----------------------------------------- | ------------------------------------------------ |
| `lua_lua.bundle`         | `9415f8a18d187b120ecd7ceec91ec38e.bundle` | Lua model, UI, controller, and script references |
| `lua_data_data_0.bundle` | `a3db360b407f1ef2281c8ad534f2a5e7.bundle` | Lua data table bundle                            |
| `lua_data_data_1.bundle` | `efced4fa27e8fd903d46e111c9eb7136.bundle` | Lua data table bundle                            |
| `lua_data_data_2.bundle` | `17dc68a7b7b5f9dd8ecaa089c5df99f4.bundle` | Lua data table bundle                            |
| `lua_data_data_3.bundle` | `78c72862cba7f77b516d4d2bc311a9f5.bundle` | Lua data table bundle                            |
| `lua_data_data_4.bundle` | `68fcb27656aacf5e2ae6ed6d8b6b0473.bundle` | Core refine-related data table bundle            |

Optional UI / visual bundles:

| Logical Bundle Name                                           | Physical Hash Filename                    | Purpose                     |
| ------------------------------------------------------------- | ----------------------------------------- | --------------------------- |
| `fx_roleeffect_refine.bundle`                                 | `9e513b5ff76fb847ffac3504394e5082.bundle` | Refine visual effect bundle |
| `shared_assets__ui_unityuitexture_equipment_refinenew.bundle` | `5c48ed0c319706163abeabddfb8e9451.bundle` | Refine UI texture bundle    |

---

## 4. `/indexes`

This folder stores bundle index and mapping files.

Expected files:

| File                                  | Purpose                                                             |
| ------------------------------------- | ------------------------------------------------------------------- |
| `BundleList-main.txt`                 | Main bundle list from `StreamingAssets\Bundle\BundleList.txt`       |
| `BundleList-windows.txt`              | Secondary bundle list from `StreamingAssets\Windows\BundleList.txt` |
| `manifest.txt`                        | StreamingAssets manifest file                                       |
| `bundle-list-detail.csv`              | Physical bundle inventory exported from the client folder           |
| `bundle-hash-to-original-mapping.csv` | Resolved mapping from hash filename to logical/original bundle name |
| `bundle-hash-to-original-mapping.txt` | Text version of the resolved mapping                                |

---

## Bundle Name Resolution

The client stores bundle files on disk using physical hash filenames.

Example:

```text
68fcb27656aacf5e2ae6ed6d8b6b0473.bundle
```

This filename is resolved through `BundleList.txt` into:

```text
lua_data_data_4.bundle
```

The mapping process is:

```text
physical hash filename
→ BundleList.txt hash column
→ logical/original bundle name
→ selected bundle for analysis
```

`BundleList.txt` uses this general row format:

```text
logical_bundle_name,hash,size,flag
```

Example:

```text
lua_data_data_4.bundle,68fcb27656aacf5e2ae6ed6d8b6b0473,...
```

---

## Source Chain

The original file chain used by this repository is:

```text
GameAssembly.dll
→ global-metadata.dat
→ BundleList.txt
→ lua_lua.bundle
→ lua_data_data_*.bundle
→ refine-related tables and Lua references
```

For refine analysis, the key data path is:

```text
lua_lua.bundle
→ RefineModel / refine UI / refine controller references

lua_data_data_4.bundle
→ data_equip_Refine
→ data_equip_RefineProtect
→ data_equip_RefineHighLevel
→ data_equip_RefineTicket
→ data_equip_RefineSlotInherit
```

---

## Main Refine-Related Sources

| Source                         | Role                                                          |
| ------------------------------ | ------------------------------------------------------------- |
| `data_equip_Refine`            | Regular rate, material, cost, and relegation/safe path fields |
| `data_equip_RefineProtect`     | Pray / protection refinement path                             |
| `data_equip_RefineHighLevel`   | Pity / progress gauge data                                    |
| `data_equip_RefineTicket`      | Refine ticket / voucher path                                  |
| `data_equip_RefineSlotInherit` | Refine inheritance / transfer-related data                    |
| `RefineModel` references       | Client model reference layer for refine data usage            |

---

## File Integrity

When possible, keep file hashes in a manifest.

Recommended fields:

| Field                  | Meaning                                          |
| ---------------------- | ------------------------------------------------ |
| `FileName`             | Stored filename in this repository               |
| `OriginalPath`         | Original local path from the client installation |
| `LogicalName`          | Resolved logical/original bundle name            |
| `PhysicalHashFilename` | Hash filename from the client Bundle folder      |
| `SizeBytes`            | File size                                        |
| `SHA256`               | File integrity hash                              |
| `Notes`                | Purpose or analysis role                         |

If files are replaced with newer client versions, update the manifest and document the source version clearly.

---

## Limitations

These original files support client-side static analysis only.

They can expose:

* binary metadata surface;
* protocol and error symbols;
* Lua model references;
* UI/controller references;
* bundle mappings;
* data tables;
* table fields;
* client-side configuration structures.

They do not prove:

* server-side roll logic;
* server-authoritative behavior;
* runtime state changes;
* network validation behavior;
* exploitability;
* bypass feasibility.

Any claim about server-side behavior requires separate evidence and is outside the scope of this folder.

---

## Safety Notice

These files are provided for documentation, educational review, and client-side static analysis.

This folder does not include instructions for:

* client patching;
* runtime manipulation;
* bypassing protections;
* cheating;
* exploit development;
* credential extraction;
* server interaction manipulation.

Do not use these files to manipulate game behavior or harm other players.

---

## Disclaimer

The maintainer is not responsible for misuse of these files, extracted data, scripts, or analysis outputs.

Any attempt to use this material for cheating, exploitation, runtime manipulation, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Use these files only to understand static file structure, bundle mapping, and client-side data documentation.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
