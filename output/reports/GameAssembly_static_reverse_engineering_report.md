# Static Reverse Engineering Report, GameAssembly.dll

## Scope
Static triage only. The DLL was not executed. This report does not include patching, bypass, cheat logic, credential extraction, or runtime manipulation guidance.

## File identity

| Field | Value |
|---|---:|
| File | GameAssembly.dll |
| Size | 71,603,200 bytes |
| Format | PE32+ Windows DLL, x86-64 |
| SHA-256 | c7dd11c6e9e90fca24375db3e4c32c871b6bdf3a4756eb0eede4077ef2c15971 |
| MD5 | 563df57df275ae2645c9601e65aa5514 |
| Link timestamp | 2026-01-14 10:27:51 UTC |
| Image base | 0x180000000 |
| Entry point RVA | 0x660818 |
| Entry point VA | 0x180660818 |
| SizeOfImage | 0x4820000 |
| Overlay bytes | 0 |

## Section map

| Section | RVA | Virtual size | Raw offset | Raw size | Entropy | Interpretation |
|---|---:|---:|---:|---:|---:|---|
| .text | 0x1000 | 0x69a8e4 | 0x400 | 0x69aa00 | 6.360 | Native runtime / launcher code |
| il2cpp | 0x69c000 | 0x271f16d | 0x69ae00 | 0x271f200 | 6.534 | Large compiled IL2CPP code region |
| .rdata | 0x2dbc000 | 0xc09d2e | 0x2dba000 | 0xc09e00 | 5.445 | Read-only data, exports, imports, strings, constants |
| .data | 0x39c6000 | 0x99687c | 0x39c3e00 | 0x5c4000 | 3.066 | Writable runtime data / registration tables |
| .pdata | 0x435d000 | 0x30ef94 | 0x3f87e00 | 0x30f000 | 6.887 | x64 exception unwind table |
| .fptable | 0x466c000 | 0x100 | 0x4296e00 | 0x200 | -0.000 | Small writable table |
| .reloc | 0x466d000 | 0x1b2234 | 0x4297000 | 0x1b2400 | 5.453 | Relocation table |

## PE and runtime interpretation

1. The binary is a normal 64-bit Windows DLL, not a .NET CLR assembly. The CLR Runtime Header is absent.
2. The export table contains 240 named exports. Most are standard Unity IL2CPP C API exports such as `il2cpp_init`, `il2cpp_runtime_invoke`, `il2cpp_class_from_name`, `il2cpp_method_get_name`, and `il2cpp_string_new`.
3. The dedicated `il2cpp` section is very large, around 39 MB raw. That is consistent with Unity IL2CPP, where managed C# code has been compiled into native code.
4. The string `Unity IL2CPP (Nov 10 2025 00:52:03)` appears in the binary.
5. The binary references `global-metadata.dat`, but that file was not part of the upload. Without it, native addresses cannot be reliably mapped back to original managed types/methods.
6. The binary contains HybridCLR references, including `HybridCLR.Runtime.dll` and `HybridCLR.RuntimeApi::*`. This indicates AOT plus hot-update/runtime metadata behavior. Some gameplay logic may live outside this DLL.
7. The binary contains XLua/Lua-related strings. This suggests part of game logic may also be scripted or data-driven through Lua or asset bundles.

## Import summary

| Imported DLL | Imported function count |
|---|---:|
| KERNEL32.dll | 167 |
| USER32.dll | 1 |
| ADVAPI32.dll | 4 |
| ole32.dll | 7 |
| OLEAUT32.dll | 11 |
| SHELL32.dll | 2 |
| WS2_32.dll | 37 |
| IPHLPAPI.DLL | 3 |

Notable imports:

- Memory/runtime: `VirtualAlloc`, `VirtualProtect`, `VirtualQuery`, `CreateThread`, `GetProcAddress`, `LoadLibraryW`, `LoadLibraryExW`.
- Debug/exception: `IsDebuggerPresent`, `OutputDebugStringW`, `SetUnhandledExceptionFilter`, `RaiseException`.
- File I/O: `CreateFileW`, `ReadFile`, `WriteFile`, `MapViewOfFile`, `CreateFileMappingW`.
- Network: Winsock imports through `WS2_32.dll`, including `WSARecv`, `WSASend`, `WSAPoll`, `getaddrinfo`, `freeaddrinfo`, `inet_ntop`, `inet_pton`, `getnameinfo`.
- Crypto/random: `CryptAcquireContextW`, `CryptGenRandom`, `CryptReleaseContext`.

These imports are normal for Unity IL2CPP games. `IsDebuggerPresent` is present, but static import alone does not prove aggressive anti-debugging. It only proves the binary can query debugger presence.

## Game-specific string findings

### Equipment/refine/enchant/appraisal

The DLL contains protocol/message and error identifiers for equipment systems, including:

```text
EQUIPMENT_REFINE_COST_NOT_ENOUGH
EQUIPMENT_REFINE_LUCKY_POINT_NOT_ENOUGH
EQUIPMENT_REFINE_INVALID_EQUIPMENT_TO_REFINE
EQUIPMENT_REFINE_ALLREADY_MAX_LEVEL
EQUIPMENT_REFINE_NOT_SUIT_TO_SWAP
EQUIPMENT_REFINE_RANGE_LIMIT
WEAPON_REFINE_LEVEL_NOT_ENOUGH
ARMOR_REFINE_LEVEL_NOT_ENOUGH
JEWELERY_REFINE_LEVEL_NOT_ENOUGH
MESSAGE_ID_CLIENT_EQUIPMENT_REFINE_REQUEST
MESSAGE_ID_CLIENT_EQUIPMENT_REFINE_LEVEL_SWAP_REQUEST
MESSAGE_ID_TO_CLIENT_EQUIPMENT_REFINE_RESPONSE
MESSAGE_ID_TO_CLIENT_REFINE_LV_SWAP_RESPONSE
MESSAGE_ID_TO_CLIENT_EQUIP_REFINE_AOI_RESULT_NOTIFY
MESSAGE_ID_2_CLIENT_PINNACLE_RACE_EQUIPMENT_REFINE_REQUEST
MESSAGE_ID_2_TO_CLIENT_PINNACLE_RACE_EQUIPMENT_REFINE_RESPONSE
```

Enchant-related strings:

```text
EXTRACT_ENCHANTMENT_FIRST
WEAPON_ENCHANT_LEVEL_NOT_ENOUGH
ARMOR_ENCHANT_LEVEL_NOT_ENOUGH
JEWELERY_ENCHANT_LEVEL_NOT_ENOUGH
MESSAGE_ID_CLIENT_ENCHANT_REQUEST
MESSAGE_ID_CLIENT_ENCHANTMENT_LEVEL_UP_REQUEST
MESSAGE_ID_CLIENT_ENCHANTMENT_EXCHANGE_REQUEST
MESSAGE_ID_CLIENT_USE_BACKUP_ENCHANTMENT_REQUEST
MESSAGE_ID_CLIENT_EXTRACT_ENCHANTMENT_REQUEST
MESSAGE_ID_CLIENT_ADD_ENCHANTMENT_REQUEST
MESSAGE_ID_CLIENT_ENCHANTMENT_TRANSFORM_REQUEST
MESSAGE_ID_TO_CLIENT_EXTRACT_ENCHANTMENT_RESPONSE
MESSAGE_ID_TO_CLIENT_ADD_ENCHANTMENT_RESPONSE
MESSAGE_ID_TO_CLIENT_ENCHANT_RESPONSE
MESSAGE_ID_TO_CLIENT_ENCHANTMENT_LEVEL_UP_RESPONSE
MESSAGE_ID_TO_CLIENT_ENCHANTMENT_EXCHANGE_RESPONSE
MESSAGE_ID_TO_CLIENT_USE_BACKUP_ENCHANTMENT_RESPONSE
MESSAGE_ID_2_CLIENT_PINNACLE_RACE_EQUIPMENT_ENCHANTMENT_REQUEST
MESSAGE_ID_2_CLIENT_TEST_EQUIPMENT_ENCHANT_LV_REQUEST
MESSAGE_ID_2_TO_CLIENT_PINNACLE_RACE_EQUIPMENT_ENCHANTMENT_RESPONSE
MESSAGE_ID_2_TO_CLIENT_EQUIPMENT_ENCHANT_SCORE_NOTIFY
```

Appraisal-related strings:

```text
ALREADY_HAVE_SPECIAL_APPRAISAL
APPRAISAL_CAN_NOT_REMOVE
EQUIPMENT_INHERIT_NONE_APPRAISAL
MESSAGE_ID_CLIENT_EQUIPMENT_ADD_APPRAISAL_REQUEST
MESSAGE_ID_CLIENT_EQUIPMENT_REMOVE_APPRAISAL_REQUEST
MESSAGE_ID_CLIENT_EQUIPMENT_INHERIT_APPRAISAL_REQUEST
MESSAGE_ID_TO_CLIENT_EQUIPMENT_ADD_APPRAISAL_RESPONSE
MESSAGE_ID_TO_CLIENT_EQUIPMENT_REMOVE_APPRAISAL_RESPONSE
MESSAGE_ID_TO_CLIENT_EQUIPMENT_INHERIT_APPRAISAL_RESPONSE
```

Interpretation: the DLL knows the request/response surfaces for refine, enchantment, appraisal, card, and equipment operations. It does not expose the numeric refine/enchant tables directly through plain strings.

### Terms not found as direct strings

The following expected table/config identifiers were not found as plain strings in this DLL:

```text
data_equip
EnchantmentAttr
EnchantmentAttrLib
EnchantmentRandom
RefineLv
SuccessRate
pity
BattleFormula
formula
```

Interpretation: the numeric mechanics are likely held in metadata, data tables, asset bundles, Lua/hot-update assemblies, or compressed/encrypted resources outside `GameAssembly.dll`. This aligns with a Unity IL2CPP + HybridCLR + XLua architecture.

## Message ID scale

The file contains 2,953 strings beginning with `MESSAGE_ID_`. Approximate topical counts:

| Topic substring | Count |
|---|---:|
| QUEST | 1517 |
| TEAM | 247 |
| AUCTION | 162 |
| FRIEND | 146 |
| GUILD | 138 |
| ROLE | 100 |
| BATTLE | 90 |
| PVP | 71 |
| PET | 67 |
| SCENE | 66 |
| ITEM | 58 |
| EQUIPMENT | 56 |
| MAIL | 56 |
| SKILL | 54 |
| KVM | 52 |
| CARD | 31 |
| MVP | 31 |
| CHAT | 28 |
| ENCHANT | 17 |
| LOGIN | 12 |
| REFINE | 7 |
| DAMAGE | 5 |

This is useful for protocol surface mapping, but it is not enough to reconstruct server-side formulas.

## Build path leakage

Notable path/debug strings:

```text
D:\jenkins_hw\workspace\sea_2\ro_client_Windows_normal\HybridCLRData\LocalIl2CppData-WindowsEditor\il2cpp\...
D:\jenkins_hw\workspace\sea_2\ro_client_Windows_normal\Library\il2cpp_cache\linkresult_66BF37EDB0A34C350E586CE9AC2FA036\GameAssembly.pdb
global-metadata.dat
```

Interpretation: the Windows client appears to have been built from a Jenkins workspace named `sea_2/ro_client_Windows_normal`. The PDB path is present as a string, but the PDB itself is not embedded in the DLL.

## What can and cannot be concluded

### Can be concluded

- This is a Unity IL2CPP Windows x64 `GameAssembly.dll`.
- It exports the standard IL2CPP runtime API.
- It includes evidence of HybridCLR and XLua integration.
- It contains many game-specific protocol/message identifiers.
- It references refine, enchant, equipment, appraisal, PVP, damage, and many other systems at the message/error-string level.
- Plain-string analysis does not reveal the actual numeric refine/enchant/damage formulas.

### Cannot be concluded from this DLL alone

- Exact native addresses for gameplay methods.
- Full managed class/method mapping.
- Actual refine/enchant success-rate tables.
- Actual damage formula implementation.
- Server-side validation behavior.
- Whether a client-side value can change final server-authoritative outcomes.

## Files generated

- `imports.txt`: imported DLL/function list.
- `exports.txt`: exported IL2CPP/runtime function names.
- `*_strings.txt`: focused string extracts by topic.

## Recommended next evidence for deeper lawful analysis

For deeper formula reconstruction, provide the matching files from the same client build:

1. `global-metadata.dat` from the Unity data folder.
2. Hot-update assemblies or HybridCLR payloads, often under `HybridCLRData`, `StreamingAssets`, or asset bundle directories.
3. Lua script bundles if the client ships Lua logic.
4. Relevant table/config assets, especially equipment, refine, enchantment, random, appraisal, stat, battle, and formula tables.
5. The full client directory tree listing, so version and file pairing can be validated.

With those files, a proper IL2CPP workflow can map metadata tokens to native code, locate data loaders, and determine whether formulas are client-side display logic, server-authoritative logic, or a mix of both.
