# ==============================================================================
# Cloud Computing Laboratory - Automated Software Verifier
# Script: TOOLS/verify_all.ps1
# Description: Verifies the existence, exact file size, and SHA256 checksum of every
# software artifact declared in TOOLS/download_manifest.csv.
# ==============================================================================

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir
$ManifestPath = Join-Path $ScriptDir "download_manifest.csv"

if (-not (Test-Path $ManifestPath)) {
    Write-Error "[-] download_manifest.csv not found at $ManifestPath"
    exit 1
}

Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host "Cloud Computing Lab - Software Bundle Integrity Audit" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan

$manifest = Import-Csv $ManifestPath

$results = @()
$passCount = 0
$failCount = 0
$missingCount = 0
$specialCount = 0

foreach ($row in $manifest) {
    $exp = $row.experiment
    $name = $row.software
    $filename = $row.filename
    $relPath = $row.local_path
    $expectedSize = $row.size_bytes
    $expectedHash = $row.sha256
    $statusType = $row.status

    $fullPath = Join-Path $RootDir $relPath

    if ($statusType -eq "UNAVAILABLE_PUBLICLY" -or $statusType -eq "RETIRED_ONLINE_SERVICE") {
        $checkStatus = "SPECIAL ($statusType)"
        $currentSize = "N/A"
        $currentHash = "N/A"
        $specialCount++
    } elseif (-not (Test-Path $fullPath)) {
        $checkStatus = "MISSING"
        $currentSize = 0
        $currentHash = "NONE"
        $missingCount++
    } else {
        $item = Get-Item $fullPath
        $currentSize = $item.Length
        $currentHash = (Get-FileHash -Path $fullPath -Algorithm SHA256).Hash

        if ($currentHash.ToUpper() -eq $expectedHash.ToUpper()) {
            $checkStatus = "PASS"
            $passCount++
        } else {
            $checkStatus = "FAIL (HASH_MISMATCH)"
            $failCount++
        }
    }

    $results += [PSCustomObject]@{
        Experiment   = $exp
        Software     = $name
        Filename     = $filename
        Status       = $checkStatus
        ActualSize   = $currentSize
        ExpectedHash = if ($expectedHash.Length -gt 16) { $expectedHash.Substring(0, 16) + "..." } else { $expectedHash }
        ActualHash   = if ($currentHash.Length -gt 16) { $currentHash.Substring(0, 16) + "..." } else { $currentHash }
    }
}

$results | Format-Table -Property Experiment, Software, Filename, Status, ActualSize, ActualHash -AutoSize

Write-Host "`n==============================================================================" -ForegroundColor Cyan
Write-Host "AUDIT RESULTS" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host "PASS (Verified Integrity):      $passCount" -ForegroundColor Green
Write-Host "FAIL (Hash Mismatch):           $failCount" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })
Write-Host "MISSING (Needs Download):       $missingCount" -ForegroundColor $(if ($missingCount -eq 0) { "Green" } else { "Yellow" })
Write-Host "SPECIAL (College/Service Only): $specialCount" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan

if ($missingCount -gt 0) {
    Write-Host "[!] Run '.\TOOLS\download_all.ps1' to automatically download missing files." -ForegroundColor Yellow
}
