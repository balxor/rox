# 01. Original File Inventory

The uploaded files are stored under `original-files/` using readable names where possible.

## Binary inputs

| File | Role |
|---|---|
| `original-files/binary/GameAssembly.dll` | Unity IL2CPP native binary |
| `original-files/binary/global-metadata.dat` | IL2CPP metadata paired with the client build |

## Lua/data bundles

The physical files in the client folder use 32-character hash filenames. They are copied here using their resolved logical names.

| Logical name | Original physical hash filename |
|---|---|
| `lua_lua.bundle` | `9415f8a18d187b120ecd7ceec91ec38e.bundle` |
| `lua_data_data_0.bundle` | `a3db360b407f1ef2281c8ad534f2a5e7.bundle` |
| `lua_data_data_1.bundle` | `efced4fa27e8fd903d46e111c9eb7136.bundle` |
| `lua_data_data_2.bundle` | `17dc68a7b7b5f9dd8ecaa089c5df99f4.bundle` |
| `lua_data_data_3.bundle` | `78c72862cba7f77b516d4d2bc311a9f5.bundle` |
| `lua_data_data_4.bundle` | `68fcb27656aacf5e2ae6ed6d8b6b0473.bundle` |

## Index files

| File | Role |
|---|---|
| `BundleList-main.txt` | Main mapping source for physical hash filename to logical bundle name |
| `BundleList-windows.txt` | Secondary Windows bundle list |
| `manifest.txt` | Small StreamingAssets manifest |
| `bundle-hash-to-original-mapping.csv` | Resolved 23,002 bundle filename mappings |
