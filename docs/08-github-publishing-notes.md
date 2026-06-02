# 08. GitHub Publishing Notes

## Suggested repository style

A modern repository should separate:

1. Original inputs.
2. Derived outputs.
3. Human-readable documentation.
4. Reproducible scripts.

This prevents a flat dump of thousands of files and makes the research easier to audit.

## Recommended README path

Start readers here:

```text
README.md
→ docs/00-overview.md
→ docs/02-bundle-hash-resolution.md
→ docs/05-refine-mechanic-findings.md
```

## Large files

Some binary inputs may be large for GitHub browser upload. If upload fails:

- Use Git CLI instead of browser drag-and-drop.
- Use Git LFS for large binaries.
- Or publish docs/output first, then attach binaries as a release artifact.

## Legal/ethical note

Publish only files you are allowed to distribute. If in doubt, publish the documentation and derived CSV summaries, and keep large proprietary binaries private.
