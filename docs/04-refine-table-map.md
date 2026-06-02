# 04. Refine Table Map

| Table | Entries | Main role |
|---|---:|---|
| `data_equip_Refine` | 9007 | Regular rate, material, zeny, luck fields, safe/relegation fields |
| `data_equip_RefineHighLevel` | 76 | Pity/bless gauge progress levels |
| `data_equip_RefineTicket` | 56 | Ticket/voucher refine path |
| `data_equip_RefineProtect` | 144 | Pray/protection path |
| `data_equip_RefineSlotInherit` | 21 | Slot inheritance mapping |

## Important convention note

The refine tables do not all use `refine_lv` in the same way.

| Table | `refine_lv` reading |
|---|---|
| `data_equip_Refine` | Target refine level |
| `data_equip_RefineProtect` | Target refine level |
| `data_equip_RefineHighLevel` | Current refine level for progress toward the next level |

This matters because `refine_lv = 15` in the regular rate table reads as `+14 → +15`, while `data_equip_RefineHighLevel` uses rows differently for progress stages.
