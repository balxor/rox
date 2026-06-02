# 07. Limitations

## Static client-side boundary

This repository documents static client-side analysis. It can identify client tables, scripts, UI/model references, and protocol/error surfaces.

It cannot, by itself, prove server-side state ownership or final authoritative outcome logic.

## Not concluded from this repository alone

- Whether the server stores pity progress per UID, per account, or per category.
- Whether a client table value is used exactly as-is by the server.
- Whether a hidden server-side modifier exists outside client data.
- Any runtime bypass, patch, or manipulation behavior.

## Recommended phrasing

Use:

```text
The client data shows...
The table stores...
The Lua/model surface references...
The data is consistent with...
```

Avoid:

```text
The server definitely...
This guarantees...
This proves every live outcome...
```
