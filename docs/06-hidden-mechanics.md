# 06. Hidden Mechanic Candidates

This document uses "hidden" to mean: not obvious from UI or community tables, but visible in client-side tables/scripts.

| Candidate | Source | Assessment |
|---|---|---|
| Safe / relegation rate path | `data_equip_Refine.relegation_*` | Data-backed |
| Pity carry-over | `data_equip_RefineHighLevel` | Data-backed |
| Different `refine_lv` convention per table | `data_equip_Refine` vs `data_equip_RefineHighLevel` | Data-backed |
| Ticket / voucher path | `data_equip_RefineTicket` | Data-backed, player-facing item name pending |
| `extraupgrade_rate = 3` | `data_equip_Refine` | Candidate modifier, final label pending |

## Caution on naming

`extraupgrade_rate = 3` is present in the data. The final user-facing label should not be asserted until it is correlated with Lua logic, item table, and localization data.
