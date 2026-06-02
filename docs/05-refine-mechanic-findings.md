# 05. Refine Mechanic Findings

## 1. Regular refine rate

Regular refine outcomes are read from `data_equip_Refine`:

```text
upgrade_rate
downgrade_rate
break_rate
```

Keep/fail rate is derived:

```text
keep_rate = 100 - upgrade_rate - downgrade_rate - break_rate
```

## 2. Safe / relegation refinement path

A safe-like refinement path is stored in `data_equip_Refine.relegation_*` fields:

```text
relegation_upgrade_rate
relegation_keepgrade_rate
relegation_break_rate
relegation_downgrade_rate
relegation_material
relegation_num
relegation_special_num
```

This reproduces the pattern previously seen in community Safe Refinement Rate tables. The source is not `data_equip_RefineProtect`; it is the `relegation_*` family inside `data_equip_Refine`.

## 3. Pray / protection path

`data_equip_RefineProtect` stores the pray/protection path:

```text
pray_upgrade_rate
pray_keepgrade_rate
pray_break_rate
pray_downgrade_rate
pray_material
pray_num
```

The observed coverage is `refine_lv 4-11`.

## 4. Pity / bless gauge progress

`data_equip_RefineHighLevel` stores progress as 5 progress levels. Each progress row uses:

```text
RefineProgress = 1000
RefineProgressLevel = 0..4
```

The practical reading is a progress accumulator with carry-over between progress levels.

## 5. Ticket / voucher path

`data_equip_RefineTicket` is a separate ticket/voucher path. The player-facing item names need item/localization mapping before final naming.

## 6. No visible fail streak counter

Within the client data and script surface inspected here, no consecutive-fail streak counter was found as a rate modifier. This does not prove server internals; it only states what is visible in this client-side static pass.
