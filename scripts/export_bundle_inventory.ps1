<#
.SYNOPSIS
  Export Unity AssetBundle physical hash inventory from the ROX client Bundle folder.

.DESCRIPTION
  This script scans the StreamingAssets\Bundle directory, lists all .bundle files,
  and exports their physical filename, size, modified time, and full path into CSV.

.AUTHOR
  Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher

.NOTES
  This script performs file listing only.
  It does not modify, patch, execute, or manipulate game files.
#>

param(
  [string]$BundlePath = "C:\RO_SEA\RO_SEAGame\rox_Data\StreamingAssets\Bundle",
  [string]$OutputCsv = (Join-Path $env:USERPROFILE "bundle-list-detail.csv")
)

Write-Host "ROX Bundle Inventory Export"
Write-Host "Author: Kenshin | Darkside TH | Odin Valhalla | ROXLab Researcher"
Write-Host ""

if (-not (Test-Path $BundlePath)) {
  Write-Error "Bundle path not found: $BundlePath"
  exit 1
}

$bundleFiles = Get-ChildItem $BundlePath -Filter "*.bundle" -File |
  Select-Object Name, Length, LastWriteTime, FullName |
  Sort-Object Length -Descending

if ($bundleFiles.Count -eq 0) {
  Write-Warning "No .bundle files found in: $BundlePath"
} else {
  $bundleFiles | Export-Csv $OutputCsv -NoTypeInformation -Encoding UTF8
  Write-Host "Bundle files found: $($bundleFiles.Count)"
  Write-Host "Saved to: $OutputCsv"
}

Write-Host ""
Write-Host "Done."
