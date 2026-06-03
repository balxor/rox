# IL2CPP Dump Refine / RNG Validation Report

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

## Input

Uploaded file:

- `GameAssembly_il2cppdump_20260603_0840.zip`

The ZIP contains Il2CppDumper-style output:

| Artifact | Purpose |
|---|---|
| `DummyDll/` | Reconstructed dummy managed assemblies for browsing type/method surfaces |
| `dump.cs` | C#-style method/type dump generated from IL2CPP metadata and binary pairing |
| `script.json` | Method/address metadata for IDA/Ghidra workflows |
| `stringliteral.json` | Extracted string literal table |
| `ida*.py`, `ghidra*.py` | Helper scripts for loading names/types into reverse engineering tools |
| `il2cpp.h` | Generated IL2CPP type/header reference |

## Important Result

This upload improves the analysis from simple string scanning into **IL2CPP surface mapping**.

It does not automatically reveal server-side RNG implementation.

The refine-related items visible in this dump are mostly:

- protocol message IDs;
- protobuf/data message classes;
- response/notify surfaces;
- error IDs;
- result enum values;
- visual FX metadata;
- standard library RNG classes.

## Refine Protocol Surface

Message ID lines found in `dump.cs`:

```text
public class ToClientEquipRefineAoiResultNotify : BaseMessageAction // TypeDefIndex: 12442
public const MessageId ClientEquipmentRefineRequest = 131;
public const MessageId ClientEquipmentRefineLevelSwapRequest = 132;
public const MessageId ToClientEquipmentRefineResponse = 2092;
public const MessageId ToClientRefineLvSwapResponse = 2105;
public const MessageId ToClientEquipRefineAoiResultNotify = 2487;
|-MessageActionPool<ToClientEquipRefineAoiResultNotify>.Get
|-MessageActionPool<ToClientEquipRefineAoiResultNotify>.Release
```

Error / validation lines found in `dump.cs`:

```text
public const ErrorId EquipmentRefineCostNotEnough = 1094;
public const ErrorId EquipmentRefineLuckyPointNotEnough = 1095;
public const ErrorId EquipmentRefineInvalidEquipmentToRefine = 1096;
public const ErrorId EquipmentRefineAllreadyMaxLevel = 1097;
public const ErrorId EquipmentRefineNotSuitToSwap = 1098;
public const ErrorId EquipmentRefineRangeLimit = 3379;
public const ErrorId WeaponRefineLevelNotEnough = 1467;
public const ErrorId ArmorRefineLevelNotEnough = 1468;
public const ErrorId JeweleryRefineLevelNotEnough = 1469;
```

## Refine Result Enum

`EquipmentRefineResult` is visible in the IL2CPP dump:

```csharp
x1800FED20
	public const EquipSlot MarkShadowWeapon = 99;
}

// Namespace: Cc.Thedream.Mmo.Protocal
public enum EquipmentRefineResult // TypeDefIndex: 13071
{
	// Fields
	public int value__; // 0x0
	[OriginalNameAttribute] // RVA: 0xFEEA0 Offset: 0xFE2A0 VA: 0x1800FEEA0
	public const EquipmentRefineResult Break = 0;
	[OriginalNameAttribute] // RVA: 0xFF290 Offset: 0xFE690 VA: 0x1800FF290
	public const EquipmentRefineResult Success = 1;
	[OriginalNameAttribute] // RVA: 0xFF7F0 Offset: 0xFEBF0 VA: 0x1800FF7F0
	public const EquipmentRefineResult Failed = 2;
}

// Namespace: Cc.Thedream.Mmo.Protocal
public enum ErrorId // TypeDefIndex: 13072
{
	// Fields
	public int value__; // 0xF570
	[OriginalNameAttribute] // RVA: 0xFFC00 Offset: 0xFF000 VA: 0x1800FFC00
	public const ErrorId Success = 0;
	[OriginalNameAttribute] // RVA: 0xFFE60 Offset: 0xFF260 VA: 0x1800FFE60
	public const ErrorId ServerMaxConnection = 1;
	[OriginalNameAttribute] // RVA: 0x1002D0 Offset: 0xFF6D0 VA: 0x1801002D0
	public const ErrorId TooLowClientVersion = 2;
	[OriginalNameAttribute] // RVA: 0x1006D0 Offset: 0xFFAD0 VA:
```

The client-side protocol result enum exposes three coarse result values:

| Value | Meaning |
|---:|---|
| `0` | `Break` |
| `1` | `Success` |
| `2` | `Failed` |

This supports the reading that the client receives a result surface. It does not, by itself, show the RNG algorithm used to decide the result.

## RNG Surface

Keyword scan summary from `script.json`:

| Category | Count |
|---|---:|
| Refine-related methods | 156 |
| Luck/Pray/Bless-related methods | 74 |
| Random/RNG-related methods | 260 |
| Refine-related string literals | 7 |
| Random/RNG-related string literals | 13 |

RNG method groups:

| Group | Count |
|---|---:|
| `Mono.Security/Mono.Math` | 22 |
| `System.Random` | 10 |
| `Other` | 217 |
| `RNGCryptoServiceProvider` | 11 |

## RNG Finding

No direct method or string in this dump identifies a refine-specific RNG algorithm such as:

```text
mt19937
xorshift
pcg
lcg
xoroshiro
mersenne
```

The visible RNG-related methods are standard library surfaces such as:

- `System.Random`
- `System.Security.Cryptography.RNGCryptoServiceProvider`
- `Mono.Security` / `Mono.Math` random utilities

These are present as standard runtime/library surfaces. This does not establish that refine uses any of them.

## Interpretation

The IL2CPP dump supports this interpretation:

```text
Client refine data provides tables, request/response surfaces, result enums,
metadata symbols, and UI/model references.

The actual authoritative refine roll decision is not visible as a client-side
RNG implementation in this dump.
```

This is consistent with the previous client-side data analysis:

| Layer | Finding |
|---|---|
| `data_equip_Refine` | Regular and relegation/safe rate fields |
| `data_equip_RefineProtect` | Pray/protection path fields |
| `data_equip_RefineHighLevel` | Progress/pity table |
| `data_equip_RefineTicket` | Ticket/voucher path |
| IL2CPP dump | Protocol/result/error surface, not refine RNG implementation |

## What This Dump Adds

This dump adds stronger source material for:

- documenting refine protocol message IDs;
- documenting `EquipmentRefineResult`;
- mapping errors such as `EquipmentRefineCostNotEnough` and `EquipmentRefineLuckyPointNotEnough`;
- feeding Ghidra/IDA with method names and type information.

## What This Dump Does Not Prove

This dump does not prove:

- server-side RNG algorithm;
- server-side roll implementation;
- runtime state transition logic on live server;
- whether refine roll uses `System.Random`, crypto RNG, or another server-side generator;
- exploitability or client-side control over outcomes.

## Recommended Repository Placement

Suggested folder placement:

```text
outputs/reports/il2cppdump_refine_rng_validation_report.md
outputs/tables/il2cppdump_refine_rng_method_surface.csv
outputs/tables/il2cppdump_refine_rng_metadata_surface.csv
outputs/tables/il2cppdump_refine_rng_string_surface.csv
original-files/il2cppdump/GameAssembly_il2cppdump_20260603_0840.zip
```

## Safety Note

This report is for client-side static analysis documentation only.
It does not include patching, bypassing, runtime manipulation, cheat logic, exploit instructions, or server-side claims.
