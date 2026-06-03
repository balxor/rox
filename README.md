# XOR Refine Reverse Engineering Notes

This repository documents a client-side static reverse engineering pass focused on the refine system in ROX.

The goal is to preserve the research trail in a readable form:

1. Start from application-level triage using `GameAssembly.dll` and `global-metadata.dat`.
2. Explain why the search moved to `StreamingAssets/Bundle`.
3. Resolve hashed bundle filenames to logical/original bundle names using `BundleList.txt`.
4. Extract and inspect Lua/data bundles.
5. Map refine tables into readable mechanics: regular rate, pray/protection, safe/relegation, ticket path, slot inheritance, and pity progress.
6. Validate the IL2CPP metadata surface using Il2CppDumper output without making server-side RNG claims.

---

## Repository Layout

| Path                         | Contents                                                                     |
| ---------------------------- | ---------------------------------------------------------------------------- |
| `original-files/binary/`     | Original binary inputs: `GameAssembly.dll`, `global-metadata.dat`            |
| `original-files/bundles/`    | Uploaded Lua/data bundles renamed to their logical bundle names              |
| `original-files/indexes/`    | Bundle inventory, `BundleList.txt`, manifest files, and hash-to-name mapping |
| `original-files/il2cppdump/` | Original Il2CppDumper output archive, if stored in the repository            |
| `outputs/reports/`           | Static RE phase reports and supporting markdown notes                        |
| `outputs/tables/`            | CSV outputs from the refine RE pass                                          |
| `outputs/strings/`           | Focused string/context extracts                                              |
| `outputs/extracted/`         | Extracted refine-related Lua table files                                     |
| `outputs/il2cppdump/`        | Il2CppDumper validation outputs for refine/RNG protocol surface              |
| `outputs/articles/`          | ROXLab article drafts and article packages, if included                      |
| `docs/`                      | Human-readable documentation                                                 |
| `scripts/`                   | Reproducible helper scripts                                                  |

---

## Primary Findings

| Mechanic                                | Source                                                              |
| --------------------------------------- | ------------------------------------------------------------------- |
| Regular refine rate                     | `data_equip_Refine`                                                 |
| Safe / relegation refinement path       | `data_equip_Refine.relegation_*`                                    |
| Pray / protection path                  | `data_equip_RefineProtect.pray_*`                                   |
| Pity / bless gauge progress             | `data_equip_RefineHighLevel`                                        |
| Ticket / voucher refine path            | `data_equip_RefineTicket`                                           |
| Refine slot inheritance                 | `data_equip_RefineSlotInherit`                                      |
| Refine model and UI references          | `lua_lua.bundle`                                                    |
| Refine protocol and result enum surface | Il2CppDumper output from `GameAssembly.dll` + `global-metadata.dat` |

---

## Key Technical Notes

### Bundle Hash Resolution

The client stores many AssetBundle files using physical hash filenames.

Example:

```text
68fcb27656aacf5e2ae6ed6d8b6b0473.bundle
```

Using `BundleList.txt`, the hash can be resolved into its logical/original bundle name:

```text
lua_data_data_4.bundle
```

The mapping flow is:

```text
physical hash filename
→ BundleList.txt
→ logical/original bundle name
→ selected bundle for extraction
→ readable table/script output
```

---

### Refine Data Source Chain

The core refine analysis follows this source chain:

```text
GameAssembly.dll
→ global-metadata.dat
→ BundleList.txt
→ lua_lua.bundle
→ lua_data_data_4.bundle
→ extracted refine Lua tables
→ CSV summaries
→ documentation
```

For table-level refine mechanics:

```text
lua_data_data_4.bundle
→ data_equip_Refine.lua
→ data_equip_RefineProtect.lua
→ data_equip_RefineHighLevel.lua
→ data_equip_RefineTicket.lua
→ data_equip_RefineSlotInherit.lua
```

---

### IL2CPP Dump Validation

The Il2CppDumper output is used to validate the client-side metadata and protocol surface.

It helps identify:

* refine request and response identifiers;
* refine-related error IDs;
* refine result enums;
* metadata/type/method/string surfaces;
* standard runtime RNG library symbols.

It does not expose a refine-specific RNG algorithm.

The correct boundary is:

```text
Client-side IL2CPP dump output can validate protocol and metadata surfaces.
It does not prove server-side RNG algorithm or server-authoritative roll behavior.
```

---

## Quick Start

1. Open `docs/00-overview.md`.
2. Review `docs/02-bundle-hash-resolution.md` to understand how hashed bundle names were resolved.
3. Review `docs/03-reverse-engineering-workflow.md` to follow the technical process.
4. Review `docs/05-refine-mechanic-findings.md` for the refine mechanic summary.
5. Review `docs/06-hidden-mechanics.md` for non-obvious client-side mechanics.
6. Use `outputs/tables/` for machine-readable data.
7. Use `outputs/extracted/` for raw extracted refine Lua tables.
8. Use `outputs/il2cppdump/` for IL2CPP protocol/RNG surface validation.

---

## Important Boundaries

This repository contains client-side static analysis notes and extracted data references for documentation and research purposes.

It does not include:

* runtime manipulation;
* client patching;
* bypass instructions;
* cheat logic;
* exploit instructions;
* credential extraction;
* server-side claims;
* server-side RNG reconstruction;
* instructions to manipulate game outcomes.

Client-side data can expose tables, UI/model references, metadata, protocol surfaces, and configuration structures. Server-authoritative behavior is outside the scope of this repository.

All materials are provided for educational and analytical purposes only.

The maintainer of this repository is not responsible for any misuse of these files, notes, scripts, extracted data, or analysis results. Any attempt to use this material for cheating, exploiting game systems, manipulating client behavior, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Do not use this repository as a guide for exploitation. Use it only to understand client-side data structure, table mapping, static analysis methodology, and documentation workflow.

---

## Reverser

June 2026
**Kenshin | Darkside TH | Odin Valhalla | ROXLab.org**
