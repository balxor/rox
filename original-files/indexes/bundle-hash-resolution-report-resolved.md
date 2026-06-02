# Bundle Hash Resolution Report

## Source files

- Physical bundle inventory: `bundle-list-detail.csv`
- Mapping source: `StreamingAssets/Bundle/BundleList.txt` from `streamingassets-index-files.zip`
- Secondary mapping source found: `StreamingAssets/Windows/BundleList.txt`
- Minor manifest: `manifest.txt`

## Result

| Metric | Value |
|---|---:|
| Physical `.bundle` files | 23,002 |
| Entries in main BundleList | 23,002 |
| Resolved hashes | 23,002 |
| Unresolved hashes | 0 |
| Entries in secondary Windows BundleList | 963 |

## How the resolution was done

The file names in the Windows folder are physical hash names, for example `672deab62412da5e1fead47d6ffc24ae.bundle`. The main `BundleList.txt` stores the mapping in this format:

```text
logical_bundle_name,hash,size,flag
```

Therefore the conversion is:

```text
physical hash filename -> hash column in BundleList.txt -> logical/original bundle name
```

## Important Lua / data candidates

| PhysicalFilename                        | OriginalName               |   BundleListFlag |   SizeMB |
|:----------------------------------------|:---------------------------|-----------------:|---------:|
| 9415f8a18d187b120ecd7ceec91ec38e.bundle | lua_lua.bundle             |                9 |    13.21 |
| efced4fa27e8fd903d46e111c9eb7136.bundle | lua_data_data_1.bundle     |                2 |    10    |
| 421c11dd66e5d53e7140894896490667.bundle | lua_data_th.bundle         |                4 |     9.69 |
| 86b1738f76b09fd899899f3bf5f372a5.bundle | maps_scenedata_1730.bundle |                2 |     6.79 |
| 17dc68a7b7b5f9dd8ecaa089c5df99f4.bundle | lua_data_data_2.bundle     |                4 |     6.51 |
| 886f59fa7a3a7fcc70f6d0a1661f2fa8.bundle | maps_scenedata_5140.bundle |                2 |     5.13 |
| 3402aa15f5d386919ccb743f3744c87e.bundle | maps_scenedata_1970.bundle |                2 |     4.7  |
| a3db360b407f1ef2281c8ad534f2a5e7.bundle | lua_data_data_0.bundle     |                5 |     4.5  |
| 918a4705e6753fbc35e1d9f2e522b37a.bundle | lua_data_vn.bundle         |                4 |     4.38 |
| b866841c4a58b70467e1b41f3dff437b.bundle | maps_scenedata_1260.bundle |                2 |     4.22 |
| dd638bdaa4a2186afd654008fae7ac15.bundle | lua_data_cn.bundle         |                6 |     4.14 |
| c85e74eac7dc3a8ae424a1e19dcdd712.bundle | lua_data_kr.bundle         |                6 |     4.1  |
| f045cce41f768b77a3ac9dd3f6a251fb.bundle | lua_data_tw.bundle         |                4 |     4.05 |
| 2e9039bb4ab0d91877b9e8f1a5021be1.bundle | lua_data_en.bundle         |                4 |     4    |
| 68fcb27656aacf5e2ae6ed6d8b6b0473.bundle | lua_data_data_4.bundle     |                2 |     3.91 |
| cdf1e3d0178981b624545d6085a8555d.bundle | lua_data_in.bundle         |                4 |     3.91 |
| fecb9fe90671d2c62cebd91a716294f5.bundle | maps_scenedata_2060.bundle |                2 |     3.77 |
| e747ababdcc3534da13ed216db45fa72.bundle | maps_scenedata_1950.bundle |                2 |     3.74 |
| 171bad80373e11deb261cd7a17e7cca9.bundle | maps_scenedata_1270.bundle |                2 |     3.68 |
| 3b0eea4aab42c077c2f05a5029184f61.bundle | maps_scenedata_1050.bundle |                2 |     3.66 |
| af08587ba8d992ed65e2eade80e10b66.bundle | maps_scenedata_1760.bundle |                2 |     3.45 |
| 442f350fc2b94ed6ba9b1bd75fe193c0.bundle | maps_scenedata_1250.bundle |                2 |     3.39 |
| c453b81c8623456f40a5fe876b8b48e4.bundle | maps_scenedata_1230.bundle |                2 |     3.28 |
| 3136bf6a99106f19efa7636f7f323d31.bundle | lua_data_jp.bundle         |                3 |     3.27 |
| d1d0693992a210f93865b8a5f8e3778f.bundle | maps_scenedata_5130.bundle |                2 |     3.27 |
| 777a80940bc0810aee0c3138d08581ac.bundle | maps_scenedata_1920.bundle |                2 |     3.07 |
| 42df3afa667d56207a60a65fae8330ea.bundle | maps_scenedata_1910.bundle |                2 |     3.06 |
| 7f164a573dc8a17fe5eb773e1fbb501a.bundle | maps_scenedata_5110.bundle |                2 |     3.03 |
| fab86fc150c6b15c0b83071ef6589354.bundle | maps_scenedata_3110.bundle |                2 |     2.97 |
| 0ca74c9d311ce396374922a32ee6dc51.bundle | maps_scenedata_1220.bundle |                2 |     2.86 |
| 457b85baa09d06068a65cf269a44835b.bundle | maps_scenedata_1110.bundle |                2 |     2.82 |
| 223be76876fa99bb71f37920ed93e965.bundle | maps_scenedata_1710.bundle |                2 |     2.71 |
| 4674f855139160b19ea9f27d02f9493f.bundle | maps_scenedata_1810.bundle |                2 |     2.63 |
| 079ba031e2f645bf961ba0f477566b0f.bundle | maps_scenedata_1610.bundle |                2 |     2.63 |
| 6cdfd615d7bbefdbb72a3ac7275f1be5.bundle | maps_scenedata_1290.bundle |                2 |     2.6  |
| abbdc3c0d546e8cfb0a0957ff9717419.bundle | maps_scenedata_5120.bundle |                2 |     2.59 |
| 20181da99566b99205fc432f2c073e0f.bundle | maps_scenedata_1930.bundle |                2 |     2.58 |
| 684054358271f44ce943af9151707c11.bundle | maps_scenedata_1150.bundle |                2 |     2.56 |
| c6c862774f7d8d3cbfcd395c8cdde6f6.bundle | maps_scenedata_1020.bundle |                2 |     2.53 |
| b219b299c84f68b8f1b46eea8f751409.bundle | maps_scenedata_1840.bundle |                2 |     2.5  |
| be50e45e38bde7b90b816ab5335232cb.bundle | maps_scenedata_5040.bundle |                2 |     2.28 |
| d772ece98f6f9e6ae33cfd0dd6b40ae4.bundle | maps_scenedata_1830.bundle |                2 |     2.27 |
| f9ffffbbbc2b6288f0280ddd5d802261.bundle | maps_scenedata_5250.bundle |                2 |     2.24 |
| 25c5a61e547315bc2168e59f47608ef6.bundle | maps_scenedata_1860.bundle |                2 |     2.2  |
| 2a68988835159dceae2bace5b1e1fa9e.bundle | maps_scenedata_2040.bundle |                2 |     2.09 |
| 2cb00ae0b58ccdbbb6a4a35ab9357b42.bundle | maps_scenedata_4550.bundle |                2 |     1.97 |
| 5c93adc743a83474ef30d44fe541c11b.bundle | maps_scenedata_1160.bundle |                2 |     1.95 |
| 6892d4753ed2e68c3f3b54706f8349d3.bundle | maps_scenedata_2610.bundle |                2 |     1.94 |
| 3c7c4eb1861b7a7f14318157f5ee6370.bundle | maps_scenedata_1410.bundle |                2 |     1.91 |
| 0848911ce54097391c18b098cb6cb865.bundle | maps_scenedata_4110.bundle |                2 |     1.88 |
| 538de6f9201bcbad071c610c31470caa.bundle | maps_scenedata_1940.bundle |                2 |     1.87 |
| 4a88d6601e0a6fd787bad87ca870b8c9.bundle | maps_scenedata_5700.bundle |                2 |     1.86 |
| a424474a9a58b7359237784ce6054455.bundle | maps_scenedata_8170.bundle |                2 |     1.81 |
| 9f3e19b2f64bba428c7180e3ba72931c.bundle | maps_scenedata_2090.bundle |                2 |     1.77 |
| bc3216f1f85b833e38bf4be52d0aaed1.bundle | maps_scenedata_1120.bundle |                2 |     1.76 |
| 8db0fd063a5edbf88d85e0a74cbcfb9e.bundle | maps_scenedata_5050.bundle |                2 |     1.76 |
| 0ad26cf3459ff8ee799a1fc9a099a95c.bundle | maps_scenedata_1360.bundle |                2 |     1.7  |
| 91e42d243694e586e0e5e25b9cc6f05c.bundle | maps_scenedata_1850.bundle |                2 |     1.65 |
| 773d6fa01524768aa5aba397416f40a5.bundle | maps_scenedata_1130.bundle |                2 |     1.63 |
| 28ad110e2326ffd39ab68634ab5698d5.bundle | maps_scenedata_5030.bundle |                2 |     1.62 |
| 5fee21a5c87e0893806250fc9a14d28e.bundle | maps_scenedata_1340.bundle |                2 |     1.6  |
| d629e3f306291fd8efa793743a2857ec.bundle | maps_scenedata_8965.bundle |                2 |     1.55 |
| ed26154483c95aa78efa918323e0f509.bundle | maps_scenedata_1620.bundle |                2 |     1.54 |
| 54a2ec58e0d30a6664a223f4c7f73868.bundle | maps_scenedata_5020.bundle |                2 |     1.53 |
| 60c8251eef809ae70fc567690dd4a43c.bundle | maps_scenedata_5150.bundle |                2 |     1.52 |
| 2ef5a2a94cfe530cae15e60c6772f663.bundle | maps_scenedata_2010.bundle |                2 |     1.44 |
| bdb042c03d64251b0bc638e4820c3d68.bundle | maps_scenedata_5330.bundle |                1 |     1.41 |
| f05cb66ac45cf9abfcf26195a1f82be0.bundle | maps_scenedata_5260.bundle |                2 |     1.38 |
| 7a28265e0cc92cb15b51d791e0ebb77a.bundle | maps_scenedata_1010.bundle |                2 |     1.36 |
| 5a720d2bed63c3bd25df6c495ec75794.bundle | maps_scenedata_2080.bundle |                2 |     1.36 |
| 5ab8727ae42f93f06a5749b4a3acafd1.bundle | maps_scenedata_5010.bundle |                2 |     1.35 |
| 6d4f3ca04caf31652fcbaa8758f4d8fe.bundle | maps_scenedata_1280.bundle |                2 |     1.35 |
| 4f4ca30bca79206f38f13cdab49e7641.bundle | maps_scenedata_5710.bundle |                2 |     1.35 |
| bdbd316cbf5423f9aa55d49622f1b7ff.bundle | maps_scenedata_2820.bundle |                2 |     1.34 |
| d3074b99e9b249c78ce75c88c60b935f.bundle | maps_scenedata_2070.bundle |                2 |     1.31 |
| 25839b5e07cfd131ac8de801c1837590.bundle | maps_scenedata_1060.bundle |                2 |     1.29 |
| 3fbef3dfc7f61684ae580bf25f225d99.bundle | maps_scenedata_1040.bundle |                2 |     1.21 |
| 687f7781b461bcbfcbcd1acbc5041a36.bundle | maps_scenedata_1960.bundle |                2 |     1.11 |
| aa755badfbe5b88dda2848b5a7b947f4.bundle | maps_scenedata_4120.bundle |                2 |     1.11 |
| cdc6227f9892351db5b3bba6e675c8b2.bundle | maps_scenedata_1630.bundle |                2 |     1.11 |

## Top 30 largest resolved bundles

| PhysicalFilename                        | OriginalName                                      | PhysicalLastWriteTime   |   BundleListFlag |   SizeMB |
|:----------------------------------------|:--------------------------------------------------|:------------------------|-----------------:|---------:|
| 672deab62412da5e1fead47d6ffc24ae.bundle | shared_assets_arts_roles_player_cloth.bundle      | 09/05/2026 18:10:43     |               17 |   552.37 |
| 55d3250aa52a522c89fffd3b6d0e1b2c.bundle | shared_assets_arts_roles_mount_fbx.bundle         | 29/05/2026 13:33:28     |                2 |   227.37 |
| d3bef375135ed004976bc2465a4cea82.bundle | shared_assets_arts_roles_player_decoration.bundle | 09/05/2026 18:14:38     |               17 |   204.3  |
| 502e9825e68cd6f62b79a7c6f052e496.bundle | shared_assets_arts_roles_player_weapon.bundle     | 28/11/2025 18:08:59     |                5 |   199.88 |
| b0291e434a9459a1391931d812329745.bundle | ui_video.bundle                                   | 29/05/2026 13:33:26     |                2 |   153.74 |
| 4a4b66c70ed716c10cb157e6cf4e8adb.bundle | roles_player_animation_skill.bundle               | 03/03/2026 14:29:19     |                6 |   110.14 |
| 8221237e35eb383ce30b4e14f1c241b0.bundle | roles_player_animation_001.bundle                 | 09/05/2026 18:11:30     |                9 |   106.93 |
| 371aeaf2ae0bd9ccf617dc13cf01b6c6.bundle | shared_assets_arts_roles_player_animation.bundle  | 24/11/2025 14:24:50     |                3 |   100.2  |
| cc6b55c0f4fb640f27636c81222d801b.bundle | roles_player_animation_001_mount.bundle           | 29/05/2026 13:33:24     |                2 |    85.29 |
| 24bc56413295b08cc2bab3704f28de8d.bundle | shared_assets__ui_icons_loading.bundle            | 04/03/2026 21:21:11     |                9 |    79.19 |
| 5c722e8605706d30a7cda3a3a308c8c8.bundle | audio_dialogue_tw.bundle                          | 25/11/2025 19:38:17     |                1 |    75    |
| 09185d4e0cbe6f64e4ee8ed4935581d2.bundle | audio_dialogue_en.bundle                          | 31/10/2025 12:58:20     |                2 |    70.41 |
| 32c3f51a60e84639045c97e7e16c6ace.bundle | audio_effect_misc.bundle                          | 09/05/2026 18:10:00     |               16 |    68.52 |
| 510323ee61eac46fde11d7ee278e81ee.bundle | roles_monster_animation_4.bundle                  | 03/03/2026 14:29:31     |                9 |    68.38 |
| c3bf181913bd63f8f97f97769dbb1dc8.bundle | roles_mount_animation.bundle                      | 29/05/2026 13:33:19     |                2 |    66.99 |
| 220f007c6611e1b88bf546246047744d.bundle | audio_effect_skill.bundle                         | 24/03/2026 19:37:38     |                8 |    61.6  |
| 9fd224415f7ea361b582a54be55a8c85.bundle | roles_monster_animation_1.bundle                  | 09/05/2026 18:11:33     |               12 |    54.25 |
| a80f1b7d68a2906d60864ca56f6fd7d0.bundle | shared_assets_arts_roles_boss_textures.bundle     | 31/10/2025 12:59:30     |                2 |    53.69 |
| 45d1e0b07b6f9b8aa894cbdf07660cf7.bundle | roles_player_animation_skill_mount.bundle         | 03/03/2026 14:29:40     |                8 |    46.2  |
| 73adc62dc8194454761eae5663231830.bundle | shared_assets_arts_roles_monster_fbx.bundle       | 09/05/2026 18:11:42     |                9 |    43.7  |
| d506ba95c318791a33d54670058a0153.bundle | audio_dialogue_cn.bundle                          | 31/10/2025 13:00:08     |                2 |    40.22 |
| 76e47c5f2eda651107a3ee7099c2059a.bundle | roles_monster_animation_7.bundle                  | 03/03/2026 14:30:00     |                7 |    39.65 |
| cb01a86bc32d990bb6861e37c2481657.bundle | roles_monster_animation_2.bundle                  | 09/05/2026 18:11:33     |               11 |    34.58 |
| 05addb472b8af7c191f0afa4dec5c462.bundle | roles_monster_animation_5.bundle                  | 03/03/2026 14:30:55     |                6 |    33.56 |
| 0da9f255b8ce0ae15f9d4269d8557a5a.bundle | roles_monster_animation_6.bundle                  | 03/03/2026 14:29:37     |                6 |    32.59 |
| 99c75dd4c581c9240c3b9ed04f94106f.bundle | roles_monster_animation_8.bundle                  | 09/05/2026 18:13:53     |                6 |    32.32 |
| 5b582214ccc30bbb9dd58f15d3255ce6.bundle | shared_assets_arts_fx_fbx.bundle                  | 09/05/2026 18:13:51     |                6 |    32.27 |
| 1defe6ae21b80fbb5c1288c726a10221.bundle | roles_monster_animation_9.bundle                  | 24/11/2025 14:24:32     |                5 |    31.72 |
| c8796a97fcd3fdcd03d4ee514eb865c7.bundle | roles_monster_animation_0.bundle                  | 15/12/2025 13:19:33     |                7 |    31.44 |
| d3cacbe4d86f6d718384e2ac7e7fc5fb.bundle | shared_assets_arts_roles_npc_fbx.bundle           | 31/10/2025 12:58:49     |                2 |    26.84 |

## Notes

- `OriginalName` is the logical bundle name from `BundleList.txt`.
- `PhysicalFilename` is the actual file name on disk.
- This resolves bundle names, not the internal asset names inside each bundle. For internal asset paths, the individual bundle still needs to be inspected or extracted.
