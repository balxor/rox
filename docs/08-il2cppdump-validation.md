# IL2CPP Dump Validation

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

This document explains how the Il2CppDumper output was used to validate the client-side IL2CPP surface related to the refine system.

The purpose of this validation is not to reconstruct server-side logic. The purpose is to document what the client-side binary and metadata expose after being paired through Il2CppDumper.

This document focuses on:

* refine request and response identifiers;
* refine-related result enums;
* refine-related error IDs;
* metadata and method surfaces;
* string surfaces related to refine and RNG;
* what can be concluded from the client dump;
* what remains outside the scope of client-side static analysis.

---

## Input Files

The Il2CppDumper validation was based on these files:

| File                  | Role                                                |
| --------------------- | --------------------------------------------------- |
| `GameAssembly.dll`    | Unity IL2CPP native binary                          |
| `global-metadata.dat` | IL2CPP metadata file paired with `GameAssembly.dll` |

These two files are required together. `GameAssembly.dll` contains native IL2CPP code, while `global-metadata.dat` provides managed metadata names, type information, method names, field names, and string references.

---

## Il2CppDumper Output

The dump process produced several useful artifacts:

| Artifact             | Purpose                                                   |
| -------------------- | --------------------------------------------------------- |
| `DummyDll/`          | Dummy managed assemblies generated from IL2CPP metadata   |
| `dump.cs`            | C#-style dump of metadata and type surfaces               |
| `script.json`        | Method and address metadata for reverse engineering tools |
| `stringliteral.json` | Extracted string literal table                            |
| `il2cpp.h`           | Header/type reference output                              |
| `ida*.py`            | IDA helper scripts                                        |
| `ghidra*.py`         | Ghidra helper scripts                                     |

The repository stores validation outputs in:

```text
/outputs/il2cppdump
```

---

## Generated Validation Files

Expected files:

| File                                         | Description                                                                   |
| -------------------------------------------- | ----------------------------------------------------------------------------- |
| `il2cppdump_refine_rng_validation_report.md` | Human-readable validation report for refine/RNG-related IL2CPP dump surface   |
| `il2cppdump_refine_rng_method_surface.csv`   | Method-level surface extracted from Il2CppDumper output                       |
| `il2cppdump_refine_rng_metadata_surface.csv` | Metadata/type/field surface related to refine and RNG keywords                |
| `il2cppdump_refine_rng_string_surface.csv`   | String literal surface related to refine, RNG, protocol, and runtime keywords |

---

## Refine Protocol Surface

The IL2CPP dump surface exposes refine-related protocol identifiers.

Examples include:

| Surface                              | Meaning                                                |
| ------------------------------------ | ------------------------------------------------------ |
| `ClientEquipmentRefineRequest`       | Client request surface for equipment refine            |
| `ToClientEquipmentRefineResponse`    | Server-to-client response surface for equipment refine |
| `ToClientEquipRefineAoiResultNotify` | AOI notification surface for refine result             |
| `ToClientRefineLvSwapResponse`       | Response surface related to refine level swap          |

These symbols show that refine has visible client-side request and response surfaces.

They do not prove where the final roll is calculated.

---

## Refine Result Surface

The IL2CPP dump surface exposes refine result symbols.

Example result values:

| Result    | Value |
| --------- | ----: |
| `Break`   |   `0` |
| `Success` |   `1` |
| `Failed`  |   `2` |

This supports the client-side result display model:

```text
request refine
→ receive response
→ read result value
→ update UI / equipment state
```

The result enum helps explain how the client classifies refine outcomes. It does not reveal the server-side RNG algorithm.

---

## Refine Error Surface

The IL2CPP dump surface includes refine-related error identifiers.

Examples:

| Error Surface                             | Meaning                               |
| ----------------------------------------- | ------------------------------------- |
| `EquipmentRefineCostNotEnough`            | Not enough refine cost                |
| `EquipmentRefineLuckyPointNotEnough`      | Not enough lucky point                |
| `EquipmentRefineInvalidEquipmentToRefine` | Invalid equipment for refine          |
| `EquipmentRefineAllreadyMaxLevel`         | Equipment already at max refine level |
| `EquipmentRefineRangeLimit`               | Refine range limit error              |

These symbols show validation and error states known by the client.

They should be read as protocol and UI-facing surfaces, not as proof of server-side implementation details.

---

## RNG Surface Review

The IL2CPP dump output contains standard runtime RNG-related symbols.

Examples may include:

| Surface                                | Classification                         |
| -------------------------------------- | -------------------------------------- |
| `System.Random`                        | Standard runtime library               |
| `RandomNumberGenerator`                | Standard cryptographic RNG API surface |
| `RNGCryptoServiceProvider`             | Standard cryptographic RNG API surface |
| `Mono.Security` RNG-related references | Standard runtime or library surface    |

These symbols are not enough to conclude that refine uses any of those RNG mechanisms.

A standard RNG class appearing in metadata or strings does not mean that the refine roll uses that class.

---

## Refine-Specific RNG Finding

No refine-specific RNG algorithm was identified from the client-side IL2CPP dump surface.

No direct refine-linked symbol was found for common RNG algorithms such as:

```text
mt19937
xorshift
PCG
LCG
xoroshiro
xoshiro
Mersenne Twister
```

The correct interpretation is:

```text
The client-side IL2CPP dump exposes refine protocol, result, and metadata surfaces.
It does not expose a refine-specific RNG algorithm.
```

---

## Relationship to Lua/Data Tables

The refine rate and mechanic data are not reconstructed from the IL2CPP dump.

They are read from Lua/data bundle outputs, especially:

| Table                          | Role                                         |
| ------------------------------ | -------------------------------------------- |
| `data_equip_Refine`            | Regular refine rate and relegation/safe path |
| `data_equip_RefineProtect`     | Pray / protection path                       |
| `data_equip_RefineHighLevel`   | Pity / progress gauge                        |
| `data_equip_RefineTicket`      | Ticket / voucher path                        |
| `data_equip_RefineSlotInherit` | Refine slot inheritance                      |

The IL2CPP dump validates the protocol and metadata surface. The Lua/data tables provide the client-side table values.

---

## What Can Be Concluded

The Il2CppDumper validation supports these client-side conclusions:

| Conclusion                                                    | Status       |
| ------------------------------------------------------------- | ------------ |
| Refine request and response surfaces exist in client metadata | Data-backed  |
| Refine result enum is visible in client dump output           | Data-backed  |
| Refine-related error IDs are visible in client metadata       | Data-backed  |
| Standard RNG library symbols exist in the dump surface        | Data-backed  |
| A refine-specific RNG algorithm is visible in the client dump | Not found    |
| Server-side RNG algorithm can be reconstructed from this dump | Out of scope |

---

## What Cannot Be Concluded

This validation does not prove:

* server-side roll logic;
* server-side RNG algorithm;
* server-authoritative outcome behavior;
* runtime memory behavior;
* live network validation behavior;
* exploitability;
* bypass feasibility;
* cheat behavior.

Server-authoritative behavior remains outside the scope of this repository.

---

## Recommended Interpretation Labels

Use these labels for Il2CppDumper-related findings:

| Label                  | Meaning                                                                         |
| ---------------------- | ------------------------------------------------------------------------------- |
| `SURFACE_VISIBLE`      | Symbol, method, enum, string, or metadata surface is visible in dump output     |
| `STANDARD_LIBRARY`     | Symbol belongs to standard runtime library, not necessarily game-specific logic |
| `NO_DIRECT_LINK`       | Symbol exists, but no direct link to refine mechanic was found                  |
| `NOT_FOUND`            | Expected refine/RNG-specific symbol was not found in dump output                |
| `CLIENT_SURFACE_ONLY`  | Evidence describes client-side visibility only                                  |
| `SERVER_SIDE_BOUNDARY` | Behavior cannot be concluded from client-side dump output                       |

---

## Traceability

Recommended trace chain:

```text
GameAssembly.dll
→ global-metadata.dat
→ Il2CppDumper output
→ /outputs/il2cppdump/*.csv
→ /outputs/il2cppdump/il2cppdump_refine_rng_validation_report.md
→ /docs/08-il2cppdump-validation.md
```

For refine mechanic data, use the Lua/data table chain instead:

```text
lua_data_data_4.bundle
→ /outputs/extracted/*.lua
→ /outputs/tables/*.csv
→ /docs/*.md
```

---

## Safety Notice

This document is for static analysis documentation only.

It does not include instructions for:

* client patching;
* runtime manipulation;
* bypassing protections;
* cheat development;
* exploit development;
* credential extraction;
* server interaction manipulation.

---

## Summary

The Il2CppDumper output is useful for validating the refine protocol and metadata surface.

It shows request, response, error, enum, method, metadata, and string surfaces related to refine.

It does not reveal a refine-specific RNG algorithm.

The refine mechanic values remain sourced from client-side Lua/data tables. Server-authoritative behavior remains outside the scope of this repository.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
