# 02. Bundle Hash Resolution

The files in `StreamingAssets/Bundle` are stored with physical hash filenames, for example:

```text
9415f8a18d187b120ecd7ceec91ec38e.bundle
68fcb27656aacf5e2ae6ed6d8b6b0473.bundle
```

These names are not human-readable asset names. They are resolved by reading `BundleList.txt`.

## Resolution model

```text
physical hash filename
→ hash value without .bundle
→ match against BundleList.txt column 2
→ read logical bundle name from BundleList.txt column 1
```

## Example

| Physical hash filename | Resolved logical name |
|---|---|
| `9415f8a18d187b120ecd7ceec91ec38e.bundle` | `lua_lua.bundle` |
| `68fcb27656aacf5e2ae6ed6d8b6b0473.bundle` | `lua_data_data_4.bundle` |

## Why this matters

Without this step, analysis starts from opaque hash names. With `BundleList.txt`, the data chain becomes readable:

```text
hash bundle
→ logical Lua/data bundle
→ extracted tables/scripts
→ refine mechanic source
```

The full mapping is available in:

```text
original-files/indexes/bundle-hash-to-original-mapping.csv
```
