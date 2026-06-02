# Scripts

Utility scripts for client-side static analysis, bundle inventory, and bundle name resolution.

Author: **Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**

---

## Purpose

The `/scripts` folder contains helper scripts used to prepare, map, and organize client-side files for documentation and static analysis.

These scripts are used to:

* export a list of physical `.bundle` files from the client folder;
* resolve hashed bundle filenames into logical/original bundle names;
* copy selected refine-related bundles into readable filenames;
* prepare source files for research documentation.

These scripts do not modify the game client, patch binaries, manipulate runtime behavior, bypass protection, or interact with servers.

---

## Script List

| Script                             | Language   | Purpose                                                                         |
| ---------------------------------- | ---------- | ------------------------------------------------------------------------------- |
| `export_bundle_inventory.ps1`      | PowerShell | Exports all physical `.bundle` files into a CSV inventory                       |
| `resolve_bundle_names.py`          | Python     | Resolves hashed bundle filenames using `BundleList.txt`                         |
| `copy_refine_bundles_resolved.ps1` | PowerShell | Copies selected refine-related bundles and renames them to logical bundle names |

---

## 1. `export_bundle_inventory.ps1`

### Purpose

Exports all `.bundle` files from the client bundle directory into a CSV inventory.

Default source path:

```text
C:\RO_SEA\RO_SEAGame\rox_Data\StreamingAssets\Bundle
```

The generated CSV contains:

| Column          | Meaning                       |
| --------------- | ----------------------------- |
| `Name`          | Physical hash bundle filename |
| `Length`        | File size in bytes            |
| `LastWriteTime` | Last modified timestamp       |
| `FullName`      | Full local file path          |

### Usage

```powershell
.\export_bundle_inventory.ps1
```

### Custom Path

```powershell
.\export_bundle_inventory.ps1 `
  -BundlePath "C:\RO_SEA\RO_SEAGame\rox_Data\StreamingAssets\Bundle" `
  -OutputCsv "$env:USERPROFILE\bundle-list-detail.csv"
```

### Output

```text
bundle-list-detail.csv
```

---

## 2. `resolve_bundle_names.py`

### Purpose

Resolves physical hash bundle filenames into logical/original bundle names using `BundleList.txt`.

Expected `BundleList.txt` row format:

```text
logical_bundle_name,hash,size,flag
```

Example mapping:

```text
68fcb27656aacf5e2ae6ed6d8b6b0473.bundle
→ lua_data_data_4.bundle
```

### Usage

```powershell
python .\resolve_bundle_names.py `
  .\bundle-list-detail.csv `
  .\BundleList.txt `
  .\bundle-hash-to-original-mapping.csv
```

### Output

```text
bundle-hash-to-original-mapping.csv
```

### Output Columns

| Column                   | Meaning                                            |
| ------------------------ | -------------------------------------------------- |
| `Resolved`               | Whether the hash was resolved                      |
| `PhysicalFilename`       | Hash filename from the bundle folder               |
| `OriginalName`           | Logical/original bundle name from `BundleList.txt` |
| `Hash`                   | Normalized bundle hash                             |
| `PhysicalSizeBytes`      | File size from filesystem inventory                |
| `BundleListDeclaredSize` | Size declared by `BundleList.txt`                  |
| `PhysicalLastWriteTime`  | Local modified timestamp                           |
| `BundleListLine`         | Line number in `BundleList.txt`                    |
| `BundleListFlag`         | Flag value from `BundleList.txt`                   |
| `PhysicalFullPath`       | Full path of the physical bundle file              |

---

## 3. `copy_refine_bundles_resolved.ps1`

### Purpose

Copies known refine-related bundles from hashed filenames into readable logical filenames.

This script is useful when preparing source bundles for documentation, review, or upload.

### Core Refine Bundles

| Logical Name             | Physical Hash Filename                    |
| ------------------------ | ----------------------------------------- |
| `lua_lua.bundle`         | `9415f8a18d187b120ecd7ceec91ec38e.bundle` |
| `lua_data_data_0.bundle` | `a3db360b407f1ef2281c8ad534f2a5e7.bundle` |
| `lua_data_data_1.bundle` | `efced4fa27e8fd903d46e111c9eb7136.bundle` |
| `lua_data_data_2.bundle` | `17dc68a7b7b5f9dd8ecaa089c5df99f4.bundle` |
| `lua_data_data_3.bundle` | `78c72862cba7f77b516d4d2bc311a9f5.bundle` |
| `lua_data_data_4.bundle` | `68fcb27656aacf5e2ae6ed6d8b6b0473.bundle` |

### Optional UI / Visual Bundles

| Logical Name                                                  | Physical Hash Filename                    |
| ------------------------------------------------------------- | ----------------------------------------- |
| `fx_roleeffect_refine.bundle`                                 | `9e513b5ff76fb847ffac3504394e5082.bundle` |
| `shared_assets__ui_unityuitexture_equipment_refinenew.bundle` | `5c48ed0c319706163abeabddfb8e9451.bundle` |

### Usage

Copy core refine bundles:

```powershell
.\copy_refine_bundles_resolved.ps1
```

Copy core refine bundles and create ZIP:

```powershell
.\copy_refine_bundles_resolved.ps1 -CreateZip
```

Copy core refine bundles plus UI/visual refine bundles:

```powershell
.\copy_refine_bundles_resolved.ps1 -IncludeUiVisualBundles -CreateZip
```

### Output

Default output folder:

```text
%USERPROFILE%\refine-bundles-resolved
```

Optional ZIP output:

```text
%USERPROFILE%\refine-bundles-resolved.zip
```

Generated manifest:

```text
refine-bundles-copy-manifest.csv
```

The manifest records copied files, missing files, source paths, output paths, size, and role.

---

## Recommended Workflow

Use the scripts in this order.

### Step 1, Export Bundle Inventory

```powershell
.\export_bundle_inventory.ps1
```

Output:

```text
bundle-list-detail.csv
```

### Step 2, Resolve Hash Names

```powershell
python .\resolve_bundle_names.py `
  .\bundle-list-detail.csv `
  .\BundleList.txt `
  .\bundle-hash-to-original-mapping.csv
```

Output:

```text
bundle-hash-to-original-mapping.csv
```

### Step 3, Copy Refine-Related Bundles

```powershell
.\copy_refine_bundles_resolved.ps1 -CreateZip
```

Output:

```text
refine-bundles-resolved.zip
```

---

## Requirements

### PowerShell

Recommended:

```text
PowerShell 7+
```

Windows PowerShell 5.1 should also work for basic file operations.

### Python

Recommended:

```text
Python 3.10+
```

The Python script only uses the standard library. No external Python packages are required.

---

## Default Paths

The default client path used by these scripts is:

```text
C:\RO_SEA\RO_SEAGame\rox_Data\StreamingAssets\Bundle
```

If your client is installed in a different directory, pass a custom path:

```powershell
-BundlePath "D:\Your\Client\Path\rox_Data\StreamingAssets\Bundle"
```

Avoid writing output to protected folders such as:

```text
C:\Windows\System32
```

Use a user-writable folder such as:

```text
%USERPROFILE%
Documents
Desktop
```

---

## Safety and Limitations

These scripts are for static file inventory and documentation only.

They do not:

* execute game code;
* modify game files;
* patch client binaries;
* bypass protections;
* manipulate runtime behavior;
* access servers;
* alter gameplay outcomes.

Client-side files can expose table names, asset mappings, model references, UI references, metadata strings, and configuration structures. Server-authoritative behavior is outside the scope of these scripts.

---

## Disclaimer

This repository is intended for educational, documentation, and client-side static analysis purposes.

The maintainer is not responsible for misuse of these scripts, files, extracted data, or analysis results. Any attempt to use this material for cheating, exploitation, runtime manipulation, bypassing protections, violating terms of service, or harming other players is solely the responsibility of the person performing those actions.

Use these scripts only to understand static file structure, bundle mapping, and data documentation workflow.

---

## Author

**Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher**
