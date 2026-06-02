<#
.SYNOPSIS
  Copy selected refine-related bundles from physical hash filenames into readable logical names.

.DESCRIPTION
  The client Bundle folder stores AssetBundle files using physical hash filenames.
  This script copies known refine-related Lua/data/UI bundles and renames them
  into their logical/original bundle names for documentation and analysis.

.AUTHOR
  Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher

.NOTES
  This script copies files only.
  It does not modify the original client files.
  It does not execute, patch, bypass, or manipulate game behavior.
#>

param(
  [string]$BundlePath = "C:\RO_SEA\RO_SEAGame\rox_Data\StreamingAssets\Bundle",
  [string]$OutputDir = (Join-Path $env:USERPROFILE "refine-bundles-resolved"),
  [switch]$IncludeUiVisualBundles,
  [switch]$CreateZip
)

Write-Host "ROX Refine Bundle Resolver"
Write-Host "Author: Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher"
Write-Host ""

if (-not (Test-Path $BundlePath)) {
  Write-Error "Bundle path not found: $BundlePath"
  exit 1
}

New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

$coreBundles = @(
  @{
    Hash = "9415f8a18d187b120ecd7ceec91ec38e.bundle"
    Name = "lua_lua.bundle"
    Role = "Lua model/script bundle"
  },
  @{
    Hash = "a3db360b407f1ef2281c8ad534f2a5e7.bundle"
    Name = "lua_data_data_0.bundle"
    Role = "Lua data table bundle"
  },
  @{
    Hash = "efced4fa27e8fd903d46e111c9eb7136.bundle"
    Name = "lua_data_data_1.bundle"
    Role = "Lua data table bundle"
  },
  @{
    Hash = "17dc68a7b7b5f9dd8ecaa089c5df99f4.bundle"
    Name = "lua_data_data_2.bundle"
    Role = "Lua data table bundle"
  },
  @{
    Hash = "78c72862cba7f77b516d4d2bc311a9f5.bundle"
    Name = "lua_data_data_3.bundle"
    Role = "Lua data table bundle"
  },
  @{
    Hash = "68fcb27656aacf5e2ae6ed6d8b6b0473.bundle"
    Name = "lua_data_data_4.bundle"
    Role = "Core refine data table bundle"
  }
)

$uiVisualBundles = @(
  @{
    Hash = "9e513b5ff76fb847ffac3504394e5082.bundle"
    Name = "fx_roleeffect_refine.bundle"
    Role = "Refine visual effect bundle"
  },
  @{
    Hash = "5c48ed0c319706163abeabddfb8e9451.bundle"
    Name = "shared_assets__ui_unityuitexture_equipment_refinenew.bundle"
    Role = "Refine UI texture bundle"
  }
)

$files = @()
$files += $coreBundles

if ($IncludeUiVisualBundles) {
  $files += $uiVisualBundles
}

$manifestRows = @()
$copied = 0
$missing = 0

foreach ($f in $files) {
  $src = Join-Path $BundlePath $f.Hash
  $dst = Join-Path $OutputDir $f.Name

  if (Test-Path $src) {
    Copy-Item $src $dst -Force

    $fileInfo = Get-Item $dst
    $copied++

    Write-Host "Copied: $($f.Hash) => $($f.Name)"

    $manifestRows += [PSCustomObject]@{
      Status = "COPIED"
      PhysicalHashFilename = $f.Hash
      LogicalName = $f.Name
      Role = $f.Role
      SizeBytes = $fileInfo.Length
      SourcePath = $src
      OutputPath = $dst
    }
  } else {
    $missing++

    Write-Warning "Missing: $($f.Hash) => $($f.Name)"

    $manifestRows += [PSCustomObject]@{
      Status = "MISSING"
      PhysicalHashFilename = $f.Hash
      LogicalName = $f.Name
      Role = $f.Role
      SizeBytes = ""
      SourcePath = $src
      OutputPath = $dst
    }
  }
}

$manifestCsv = Join-Path $OutputDir "refine-bundles-copy-manifest.csv"
$manifestRows | Export-Csv $manifestCsv -NoTypeInformation -Encoding UTF8

Write-Host ""
Write-Host "Copied files: $copied"
Write-Host "Missing files: $missing"
Write-Host "Manifest saved to: $manifestCsv"

if ($CreateZip) {
  $zipPath = Join-Path $env:USERPROFILE "refine-bundles-resolved.zip"

  if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
  }

  Compress-Archive -Path (Join-Path $OutputDir "*") -DestinationPath $zipPath -Force
  Write-Host "ZIP saved to: $zipPath"
}

Write-Host ""
Write-Host "Done."
