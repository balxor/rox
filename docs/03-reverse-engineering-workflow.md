# 03. Reverse Engineering Workflow

## Step 1. Application-level triage

`GameAssembly.dll` was inspected first to determine the application architecture. The binary shows a Unity IL2CPP client with references to metadata, HybridCLR, XLua/Lua, and refine/enchant/equipment protocol surfaces.

This step does not directly expose the numeric refine tables. It tells us where to look next.

## Step 2. Metadata surface

`global-metadata.dat` adds managed symbol and string surface. It helps locate request/response types, error names, lucky point fields, and refine level references.

## Step 3. Bundle discovery

Because numeric refine tables were not directly readable from `GameAssembly.dll`, the search moved to:

```text
rox_Data/StreamingAssets/Bundle
```

## Step 4. Hash filename resolution

`BundleList.txt` resolves hash filenames to logical bundle names. This identified `lua_lua.bundle` and `lua_data_data_*.bundle` as the important Lua/data targets.

## Step 5. Lua/data bundle extraction

The analysis then focused on:

```text
lua_lua.bundle
lua_data_data_0.bundle
lua_data_data_1.bundle
lua_data_data_2.bundle
lua_data_data_3.bundle
lua_data_data_4.bundle
```

## Step 6. Refine table extraction

The primary refine data tables were found in `lua_data_data_4.bundle`.

## Step 7. Mechanic mapping

Tables were correlated to mechanics:

```text
data_equip_Refine            → regular rate + safe/relegation fields
data_equip_RefineProtect     → pray/protection path
data_equip_RefineHighLevel   → pity/bless gauge progress
data_equip_RefineTicket      → ticket/voucher path
data_equip_RefineSlotInherit → inherit/transfer mapping
```
