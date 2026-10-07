# ==============================================================================
# Cloud Computing Laboratory - Automated Software Downloader
# Script: TOOLS/download_all.ps1
# Description: Parses TOOLS/download_manifest.csv and downloads all offline software
# packages directly from official archives into their respective experiment folders.
# ==============================================================================

param (
    [switch]$Force = $false
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir
$ManifestPath = Join-Path $ScriptDir "download_manifest.csv"

if (-not (Test-Path $ManifestPath)) {
    Write-Error "[-] download_manifest.csv not found at $ManifestPath"
    exit 1
}

Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host "Cloud Computing Lab - Automated Software Downloader & Verifier" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan

$manifest = Import-Csv $ManifestPath

$total = $manifest.Count
$downloadedCount = 0
$skippedCount = 0
$failedCount = 0

foreach ($row in $manifest) {
    $exp = $row.experiment
    $name = $row.software
    $filename = $row.filename
    $url = $row.source_url
    $relPath = $row.local_path
    $expectedSize = $row.size_bytes
    $expectedHash = $row.sha256
    $status = $row.status

    $destPath = Join-Path $RootDir $relPath
    $destFolder = Split-Path -Parent $destPath

    Write-Host "`n[$exp] $name ($filename)" -ForegroundColor Yellow

    if ($status -eq "UNAVAILABLE_PUBLICLY" -or $status -eq "RETIRED_ONLINE_SERVICE") {
        Write-Host "  -> Notice: $status - $($row.notes)" -ForegroundColor DarkYellow
        continue
    }

    if (-not (Test-Path $destFolder)) {
        New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
    }

    $needsDownload = $true
    if ((Test-Path $destPath) -and (-not $Force)) {
        Write-Host "  -> File already exists locally. Verifying SHA256..." -ForegroundColor Gray
        $currentHash = (Get-FileHash -Path $destPath -Algorithm SHA256).Hash
        if ($currentHash.ToUpper() -eq $expectedHash.ToUpper()) {
            Write-Host "  [PASS] File verified successfully (SHA256 matches)." -ForegroundColor Green
            $skippedCount++
            $needsDownload = $false
        } else {
            Write-Host "  [WARN] Checksum mismatch. Re-downloading file..." -ForegroundColor Magenta
        }
    }

    if ($needsDownload) {
        Write-Host "  -> Downloading from: $url" -ForegroundColor Cyan
        Write-Host "  -> Destination:      $destPath" -ForegroundColor Gray

        $maxRetries = 3
        $attempt = 1
        $success = $false

        while (($attempt -le $maxRetries) -and (-not $success)) {
            try {
                if ($attempt -gt 1) {
                    Write-Host "  -> Retry attempt $attempt of $maxRetries..." -ForegroundColor Magenta
                }
                
                # Use curl.exe if available for robust large file streaming
                if (Get-Command "curl.exe" -ErrorAction SilentlyContinue) {
                    & curl.exe -L --fail --retry 3 -o $destPath $url
                } else {
                    Invoke-WebRequest -Uri $url -OutFile $destPath -TimeoutSec 300
                }

                if (Test-Path $destPath) {
                    $downloadedHash = (Get-FileHash -Path $destPath -Algorithm SHA256).Hash
                    if ($downloadedHash.ToUpper() -eq $expectedHash.ToUpper()) {
                        Write-Host "  [PASS] Download complete and SHA256 verified!" -ForegroundColor Green
                        $downloadedCount++
                        $success = $true
                    } else {
                        Write-Host "  [FAIL] SHA256 mismatch!" -ForegroundColor Red
                        Write-Host "         Expected: $expectedHash" -ForegroundColor Red
                        Write-Host "         Got:      $downloadedHash" -ForegroundColor Red
                        $attempt++
                    }
                } else {
                    Write-Host "  [FAIL] Downloaded file not found on disk." -ForegroundColor Red
                    $attempt++
                }
            } catch {
                Write-Host "  [ERROR] Download exception: $_" -ForegroundColor Red
                $attempt++
            }
        }

        if (-not $success) {
            Write-Host "  [FAILED] Unable to download $filename after $maxRetries attempts." -ForegroundColor Red
            $failedCount++
        }
    }
}

Write-Host "`n==============================================================================" -ForegroundColor Cyan
Write-Host "DOWNLOAD SUMMARY" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host "Verified / Already Present: $skippedCount" -ForegroundColor Green
Write-Host "Newly Downloaded & Verified: $downloadedCount" -ForegroundColor Green
Write-Host "Failed:                     $failedCount" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })
Write-Host "Run '.\TOOLS\verify_all.ps1' anytime to run a full integrity audit." -ForegroundColor Gray
Write-Host "==============================================================================" -ForegroundColor Cyan
