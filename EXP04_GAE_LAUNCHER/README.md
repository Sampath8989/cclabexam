# Experiment 04: Google App Engine Launcher (Python) - Web Application Deployment

## 1. Experiment Overview
- **Title**: Use GAE launcher to launch the web applications.
- **Primary Source**: Lab Manual Section *EX.NO.: 5* (Pages 26–34).
- **Aim**: To install the legacy Google App Engine Python SDK (featuring `GoogleAppEngineLauncher.exe`), create a manual web application directory structure (`apps/ae-01-trivial`) with `app.yaml` and `index.py`, add the application to the GUI launcher, boot the local server on `http://localhost:8080/`, verify output in a web browser, and inspect server logs.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Google App Engine SDK** | 1.8.9 (Python SDK) | `GoogleAppEngine-1.8.9.msi` | [Google Code Archive](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/googleappengine/GoogleAppEngine-1.8.9.msi) | 45,588,992 | `8A1141DC06812F5ACE6BB44E822B2F3BB3055687F44BEEF665CB6CF1EF742F91` |
| **Python Runtime** | 2.7.18 (x64) | `python-2.7.18.amd64.msi` | [Python Software Foundation](https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi) | 20,598,784 | `B74A3AFA1E0BF2A6FC566A7B70D15C9BFABBA3756FB077797D16FFFA27800C05` |
| **Sample Application** | 1.0 | `apps/ae-01-trivial/` | Included in repository | - | `app.yaml`, `index.py`, `run_local_server.bat` |

*Both installer files are directly downloaded, verified, and present in this directory.*

---

## 3. Discontinuation Status & Analysis
- **Google App Engine Launcher GUI (`GoogleAppEngineLauncher.exe`)**: Discontinued by Google on **July 30, 2020** when the entire standalone Python 2.7 SDK was replaced by the modern `gcloud` CLI.
- **Python 2.7**: Reached end-of-life on January 1, 2020. However, the standalone Python 2.7.18 final installer and GAE 1.8.9 installer run completely self-contained offline.
- **Offline Server**: The local development server (`dev_appserver.py`) does **NOT** require any connection to Google servers or the internet. All emulation happens on `localhost:8080`.

---

## 4. Installation Order
1. **Install Python 2.7.18**:
   - Run `python-2.7.18.amd64.msi`.
   - Choose "Install for all users".
   - Under feature selection, make sure "Add python.exe to Path" is enabled.
   - Complete installation.
2. **Install Google App Engine SDK**:
   - Run `GoogleAppEngine-1.8.9.msi`.
   - Accept default settings to install into `C:\Program Files (x86)\Google\google_appengine\`.
   - The installer places `GoogleAppEngineLauncher.exe` on your desktop/start menu.

---

## 5. Step-by-Step Execution Workflow (From Lab Manual)

### Step 1: Directory Structure & File Verification
The application files from the manual are located at:
```
apps/
└── ae-01-trivial/
    ├── app.yaml
    └── index.py
```
- `app.yaml`:
  ```yaml
  application: ae-01-trivial
  version: 1
  runtime: python27
  api_version: 1
  threadsafe: false

  handlers:
  - url: /.*
    script: index.py
  ```
- `index.py`:
  ```python
  print 'Content-Type: text/plain'
  print ''
  print 'Hello there Chuck'
  ```

### Step 2: Launch with GoogleAppEngineLauncher GUI
1. Launch **Google App Engine Launcher** from Desktop or Start Menu.
2. Click **File** > **Add Existing Application...** (`Ctrl + Shift + A`).
3. Click **Browse...**, navigate to `EXP04_GAE_LAUNCHER\apps\ae-01-trivial`, and select the folder.
4. Set the Port to `8080` (or leave default).
5. Click **Add**.
6. Select `ae-01-trivial` in the application list and click **Run** (green arrow button).
7. Wait until the status icon turns **green** (indicating the web server is running).
8. Click **Browse** (or manually navigate in your browser to `http://localhost:8080/`).
9. Verify browser displays:
   ```
   Hello there Chuck
   ```

### Step 3: Inspect Logs & Handling Errors
1. In the Launcher, select the running application and click the **Logs** button.
2. A log window opens displaying incoming `GET / HTTP/1.1 200` requests.
3. **App.yaml Indentation Errors**: If `app.yaml` is misindented, the launcher icon will show a **yellow icon** and the log will display configuration parsing errors.
4. **Python Syntax Errors**: If `index.py` contains a typo, the browser will display a Python stack trace. Simply fix `index.py` and refresh the browser (no server restart needed).
5. To shut down the server, click the **Stop** button in the launcher.

---

## 6. Modern Windows 10/11 Compatibility Notes
- **WxPython GUI Font Rendering**: On some Windows 11 high-DPI displays, the legacy wxWidgets GUI may display small fonts. You can right-click `GoogleAppEngineLauncher.exe` > **Properties** > **Compatibility** > **Change high DPI settings** > Check "Override high DPI scaling behavior" > Application.
- **Alternative Headless Execution**: If you prefer command-line execution without GUI, simply double-click `apps\ae-01-trivial\run_local_server.bat` or run:
  ```powershell
  python "C:\Program Files (x86)\Google\google_appengine\dev_appserver.py" --port=8080 .\apps\ae-01-trivial
  ```
- **Internet Required During Experiment**: **NO** (100% offline).
