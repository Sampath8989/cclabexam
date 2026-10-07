# ==============================================================================
# Cloud Computing Laboratory - Direct Package Downloader
# Script: TOOLS/download_bundle.ps1
# Description: Downloads all or selected missing lab software packages directly
# into their exact target experiment directories with SHA256 verification.
# ==============================================================================

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet("ALL", "EXP01", "EXP03", "EXP04", "EXP05", "EXP06", "EXP08")]
    [string]$Target = "ALL",

    [switch]$Force = $false
)

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName

# Target directory map and download list
$Downloads = @(
    @{
        Exp = "EXP01"
        Name = "VirtualBox 5.0.20 Installer"
        FileName = "VirtualBox-5.0.20-106931-Win.exe"
        Url = "https://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Win.exe"
        Dest = Join-Path $RootDir "EXP01_VIRTUALBOX_OPENNEBULA\VirtualBox-5.0.20-106931-Win.exe"
        SHA256 = "4F167B0967E3C2283EEF986B8FFA3FEC82390CD79038568EAE3CA65C6AB4C294"
        Size = "107.87 MB"
    },
    @{
        Exp = "EXP01"
        Name = "VirtualBox 5.0.20 Extension Pack"
        FileName = "Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack"
        Url = "https://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack"
        Dest = Join-Path $RootDir "EXP01_VIRTUALBOX_OPENNEBULA\Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack"
        SHA256 = "2857AAAB640C906F5B77D88C38A65010B0EA2816239CE3B905433B610A859889"
        Size = "15.67 MB"
    },
    @{
        Exp = "EXP03"
        Name = "Google App Engine Java SDK 1.8.9"
        FileName = "appengine-java-sdk-1.8.9.zip"
        Url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/googleappengine/appengine-java-sdk-1.8.9.zip"
        Dest = Join-Path $RootDir "EXP03_GOOGLE_APP_ENGINE\appengine-java-sdk-1.8.9.zip"
        SHA256 = "FCB353DB6E2FE51DBB1952EB350A9FA1C9EBA58CB15B5C26B05E3ADBD5F4C8A4"
        Size = "151.48 MB"
    },
    @{
        Exp = "EXP03"
        Name = "Eclipse IDE for Java EE (Kepler SR2)"
        FileName = "eclipse-jee-kepler-SR2-win32-x86_64.zip"
        Url = "https://archive.eclipse.org/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-win32-x86_64.zip"
        Dest = Join-Path $RootDir "EXP03_GOOGLE_APP_ENGINE\eclipse-jee-kepler-SR2-win32-x86_64.zip"
        SHA256 = "FC6C9B0E5D71BAE079D8CEE3FECC44A33C14881E9FA47565DF567B54BA6EE4D9"
        Size = "262.43 MB"
    },
    @{
        Exp = "EXP04"
        Name = "Google App Engine Python SDK 1.8.9"
        FileName = "GoogleAppEngine-1.8.9.msi"
        Url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/googleappengine/GoogleAppEngine-1.8.9.msi"
        Dest = Join-Path $RootDir "EXP04_GAE_LAUNCHER\GoogleAppEngine-1.8.9.msi"
        SHA256 = "8A1141DC06812F5ACE6BB44E822B2F3BB3055687F44BEEF665CB6CF1EF742F91"
        Size = "43.48 MB"
    },
    @{
        Exp = "EXP04"
        Name = "Python 2.7.18 64-bit Installer"
        FileName = "python-2.7.18.amd64.msi"
        Url = "https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi"
        Dest = Join-Path $RootDir "EXP04_GAE_LAUNCHER\python-2.7.18.amd64.msi"
        SHA256 = "B74A3AFA1E0BF2A6FC566A7B70D15C9BFABBA3756FB077797D16FFFA27800C05"
        Size = "19.64 MB"
    },
    @{
        Exp = "EXP05"
        Name = "CloudSim 3.0.3 Toolkit Archive"
        FileName = "cloudsim-3.0.3.tar.gz"
        Url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cloudsim/cloudsim-3.0.3.tar.gz"
        Dest = Join-Path $RootDir "EXP05_CLOUDSIM\cloudsim-3.0.3.tar.gz"
        SHA256 = "4467A4B77F1AFA094CC60615078EAAACE04E6E041EA2D6059C23A77B7AE6AD68"
        Size = "9.90 MB"
    },
    @{
        Exp = "EXP06"
        Name = "VirtualBox Guest Additions 5.0.20 ISO"
        FileName = "VBoxGuestAdditions_5.0.20.iso"
        Url = "https://download.virtualbox.org/virtualbox/5.0.20/VBoxGuestAdditions_5.0.20.iso"
        Dest = Join-Path $RootDir "EXP06_VM_FILE_TRANSFER\VBoxGuestAdditions_5.0.20.iso"
        SHA256 = "6FBB59FD22E5F1B287A8A2B623604F0849B702A4AC737B57833F7CEC006F01E6"
        Size = "55.46 MB"
    },
    @{
        Exp = "EXP08"
        Name = "Apache Hadoop 2.7.3 Binary Distribution"
        FileName = "hadoop-2.7.3.tar.gz"
        Url = "https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz"
        Dest = Join-Path $RootDir "EXP08_HADOOP\hadoop-2.7.3.tar.gz"
        SHA256 = "D489DF3808244B906EB38F4D081BA49E50C4603DB03EFD5E594A1E98B09259C2"
        Size = "214.09 MB"
    },
    @{
        Exp = "EXP08"
        Name = "Adoptium Temurin OpenJDK 8 for Linux x64"
        FileName = "OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz"
        Url = "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz"
        Dest = Join-Path $RootDir "EXP08_HADOOP\OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz"
        SHA256 = "40AA7BD56F7275EF3B01168B5B116A86311D7BB805AC2AC747065979F9380F25"
        Size = "104.09 MB"
    }
)

Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host " Cloud Computing Lab - Direct Package Downloader" -ForegroundColor Cyan
Write-Host " Target Filter: $Target" -ForegroundColor Yellow
Write-Host " Destination Base: $RootDir" -ForegroundColor Gray
Write-Host "==============================================================================" -ForegroundColor Cyan

$filtered = $Downloads | Where-Object { ($Target -eq "ALL") -or ($_.Exp -eq $Target) }

foreach ($item in $filtered) {
    $parentDir = Split-Path -Parent $item.Dest
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    Write-Host "`n[$($item.Exp)] $($item.Name)" -ForegroundColor Yellow
    Write-Host "  File:        $($item.FileName) ($($item.Size))" -ForegroundColor Gray
    Write-Host "  Destination: $($item.Dest)" -ForegroundColor Gray

    if ((Test-Path $item.Dest) -and (-not $Force)) {
        $hash = (Get-FileHash -Path $item.Dest -Algorithm SHA256).Hash
        if ($hash.ToUpper() -eq $item.SHA256.ToUpper()) {
            Write-Host "  [PASS] File already exists and SHA256 verified!" -ForegroundColor Green
            continue
        } else {
            Write-Host "  [WARN] File exists but checksum differs. Re-downloading..." -ForegroundColor Magenta
        }
    }

    Write-Host "  -> Downloading from: $($item.Url)" -ForegroundColor Cyan
    $tmpFile = "$($item.Dest).tmp"

    try {
        if (Get-Command "curl.exe" -ErrorAction SilentlyContinue) {
            & curl.exe -L --fail --progress-bar -o $tmpFile $item.Url
        } else {
            Invoke-WebRequest -Uri $item.Url -OutFile $tmpFile
        }

        if (Test-Path $tmpFile) {
            $downloadedHash = (Get-FileHash -Path $tmpFile -Algorithm SHA256).Hash
            if ($downloadedHash.ToUpper() -eq $item.SHA256.ToUpper()) {
                Move-Item -Path $tmpFile -Destination $item.Dest -Force
                Write-Host "  [SUCCESS] Download completed and verified!" -ForegroundColor Green
            } else {
                Write-Host "  [FAIL] SHA256 checksum mismatch!" -ForegroundColor Red
                Write-Host "         Expected: $($item.SHA256)" -ForegroundColor Red
                Write-Host "         Actual:   $downloadedHash" -ForegroundColor Red
                Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
            }
        }
    } catch {
        Write-Host "  [ERROR] Download failed: $_" -ForegroundColor Red
        if (Test-Path $tmpFile) {
            Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "`n==============================================================================" -ForegroundColor Cyan
Write-Host " Run '.\TOOLS\verify_all.ps1' to run complete audit." -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan
