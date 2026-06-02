# XOR Refine Reverse Engineering Notes

This repository documents a client-side static reverse engineering pass focused on the refine system in ROX.

The goal is to preserve the research trail in a readable form:

1. Start from application-level triage (`GameAssembly.dll` + `global-metadata.dat`).
2. Explain why the search moved to `StreamingAssets/Bundle`.
3. Resolve hashed bundle filenames to logical/original bundle names using `BundleList.txt`.
4. Extract and inspect Lua/data bundles.
5. Map refine tables to readable mechanics: regular rate, pray/protection, safe/relegation, ticket path, and pity progress.

## Repository Layout

| Path | Contents |
|---|---|
| `original-files/binary/` | Original binary inputs: `GameAssembly.dll`, `global-metadata.dat` |
| `original-files/bundles/` | Uploaded Lua/data bundles renamed to their logical bundle names |
| `original-files/indexes/` | Bundle inventory, `BundleList.txt`, and hash-to-name mapping |
| `outputs/reports/` | Static RE phase reports and supporting markdown notes |
| `outputs/tables/` | CSV outputs from the refine RE pass |
| `outputs/strings/` | Focused string/context extracts |
| `outputs/extracted/` | Extracted refine tables archive |
| `outputs/articles/` | ROXLab article drafts and packages |
| `docs/` | Human-readable documentation |
| `scripts/` | Reproducible helper scripts |

## Primary Findings

| Mechanic | Source |
|---|---|
| Regular refine rate | `data_equip_Refine` |
| Safe / relegation refinement path | `data_equip_Refine.relegation_*` |
| Pray / protection path | `data_equip_RefineProtect.pray_*` |
| Pity / bless gauge progress | `data_equip_RefineHighLevel` |
| Ticket / voucher refine path | `data_equip_RefineTicket` |
| Refine slot inheritance | `data_equip_RefineSlotInherit` |

## Important and Boundary

This repository contains client-side static analysis notes and extracted data references for documentation and research purposes.

It does not include runtime manipulation, client patching, bypass instructions, cheat logic, exploit instructions, credential extraction, or server-side claims. Client-side data can expose tables, UI/model references, metadata, protocol surfaces, and configuration structures. Server-authoritative behavior is outside the scope of this repository.

All materials are provided for educational and analytical purposes only.

The maintainer of this repository is not responsible for any misuse of these files, notes, scripts, extracted data, or analysis results. Any attempt to use this material for cheating, exploiting game systems, manipulating client behavior, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Do not use this repository as a guide for exploitation. Use it only to understand client-side data structure, table mapping, and static analysis methodology.

## Quick Start

1. Open `docs/00-overview.md`.
2. Review `docs/02-bundle-hash-resolution.md` to understand how hashed bundle names were resolved.
3. Review `docs/05-refine-mechanic-findings.md` for the refined mechanic summary.
4. Use `outputs/tables/` for machine-readable data.

## Reverser

June 2026. Kenshin | Darkside TH | Odin Valhalla | ROXLab.org
