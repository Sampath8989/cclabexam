# Tools & Automation Suite

This folder contains the master download manifest, automated downloader, and integrity verification scripts for the entire Cloud Computing Laboratory software bundle.

---

## Files in this Directory

| File | Purpose |
| :--- | :--- |
| **`download_manifest.csv`** | Master CSV table cataloging every software package, version, filename, official download URL, local folder path, file size in bytes, SHA256 checksum, and status. |
| **`download_bundle.ps1`** | Direct PowerShell downloader to fetch packages for all experiments or a specific experiment (`EXP01` to `EXP08`) directly into its target folder with progress bar and SHA256 verification. |
| **`download_bundle.bat`** | Windows Command Prompt / Double-click launcher for `download_bundle.ps1`. |
| **`download_all.ps1`** | Automated manifest-driven downloader with retry logic and integrity checking. |
| **`verify_all.ps1`** | PowerShell script to compute SHA256 checksums of all local files, compare them against the manifest, and produce an integrity audit report. |
| **`README.md`** | Usage documentation for the tools suite. |

---

## How to Use the Automation Scripts

### 1. Verify What Files are Present / Missing
Run the integrity audit script at any time:
```powershell
.\TOOLS\verify_all.ps1
```
This outputs a table with columns:
- `Experiment`: Experiment identifier (`EXP01` to `EXP08`)
- `Software`: Package name
- `Filename`: Exact file name
- `Status`: `PASS`, `FAIL (HASH_MISMATCH)`, `MISSING`, or `SPECIAL`
- `ActualSize`: File size on disk
- `ActualHash`: Calculated SHA256

### 2. Download Missing Files Automatically
To download all missing files directly on your lab PC:
```powershell
.\TOOLS\download_all.ps1
```
The script will:
1. Inspect the local destination folder.
2. If the file already exists, verify its SHA256 checksum. If it matches, the download is safely skipped.
3. If the file is missing or corrupted, stream the download from the verified official archive using `curl.exe` with retry logic.
4. Verify the SHA256 hash immediately after download and report success.

To force re-downloading all files (even if present):
```powershell
.\TOOLS\download_all.ps1 -Force
```

---

## Large Files & GitHub Storage Policy
- **GitHub Single-File Limit**: Normal GitHub repositories reject commits containing files exceeding **100 MB** (`GH001: Large files detected`).
- **Files < 100 MB in this Repository**:
  - `GoogleAppEngine-1.8.9.msi` (45.5 MB) - Included
  - `python-2.7.18.amd64.msi` (20.5 MB) - Included
  - `cloudsim-3.0.3.tar.gz` (10.3 MB) - Included
  - `Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931a.vbox-extpack` (16.4 MB) - Included
  - `VBoxGuestAdditions_5.0.20.iso` (55.7 MB) - Included
- **Files > 100 MB**:
  - `VirtualBox-5.0.20-106931-Win.exe` (108 MB)
  - `appengine-java-sdk-1.8.9.zip` (151 MB)
  - `eclipse-jee-kepler-SR2-win32-x86_64.zip` (262 MB)
  - `hadoop-2.7.3.tar.gz` (214 MB)
  - `OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz` (104 MB)
  - Multi-Gigabyte OVA Appliances (`OpenNebula-Sandbox-5.0.ova`, `ubuntu_gt6.ova`)
- Running `download_all.ps1` downloads these packages directly to your local PC upon repository cloning, ensuring the GitHub repository remains lightweight, reliable to clone, and permanently protected from Git LFS quota errors!
