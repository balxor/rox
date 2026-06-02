# 00. Overview

This documentation records the reverse engineering workflow used to inspect ROX refine mechanics from client-side files.

The workflow is intentionally written as a traceable chain:

```text
GameAssembly.dll
→ global-metadata.dat
→ StreamingAssets/Bundle inventory
→ BundleList.txt hash resolution
→ lua_lua.bundle
→ lua_data_data_*.bundle
→ data_equip_Refine* tables
→ refine mechanic interpretation
```

The repository is meant to be readable by people who want to understand how the data was found, not only by people who already know Unity AssetBundle internals.

## What this repository is

- A static client-side research archive.
- A data-map for ROX refine tables.
- A reproducible record of hashed bundle filename resolution.
- A source package for ROXLab articles on refine mechanics.

## What this repository is not

- It is not a client patch.
- It is not a bypass guide.
- It is not a server-side proof of final outcome calculation.
- It does not include runtime manipulation instructions.
