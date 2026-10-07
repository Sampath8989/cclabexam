# Experiment 03: Google App Engine (Java) - Hello World Application

## 1. Experiment Overview
- **Title**: Install Google App Engine. Create Hello World app and other simple web applications using Python / Java.
- **Primary Source**: Lab Manual Section *EX NO.: 3* (Pages 16–25).
- **Aim**: To set up the legacy Google App Engine Java SDK development environment with Eclipse, configure web deployment descriptors (`appengine-web.xml` and `web.xml`), run the local App Engine development server on port 8888, test the servlet at `/helloworld`, and inspect the local administrative console at `/_ah/admin`.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **App Engine Java SDK** | 1.8.9 (or 1.9.76) | `appengine-java-sdk-1.8.9.zip` | [Google Code Archive](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/googleappengine/appengine-java-sdk-1.8.9.zip) | 151,480,816 | `44BCBE248B255FA7DEFA3A1FBEB2C4EBDD826720DCC819598CA25EC8689531CE` |
| **Eclipse IDE for Java EE** | Kepler SR2 (4.3.2) | `eclipse-jee-kepler-SR2-win32-x86_64.zip` | [Eclipse Foundation Archive](https://archive.eclipse.org/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-win32-x86_64.zip) | 262,430,640 | `FC6C9B0E5D71BAE079D8CEE3FECC44A33C14881E9FA47565DF567B54BA6EE4D9` |
| **Google Plugin for Eclipse** | GPE 3.9.x | Decommissioned update site | `dl.google.com/eclipse/plugin/` (Archived) | N/A | Decommissioned by Google (Jan 2018) |
| **Java Development Kit** | JDK 8 (or JDK 7) | `OpenJDK8U-jdk_x64_windows.zip` | [Adoptium Temurin 8](https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u412b08.zip) | ~100 MB | Verified OpenJDK 8 Distribution |
| **Hello World Project** | 1.0 | Directory `HelloWorld/` | Included in repository | Complete | Ready-to-run Java Web App |

---

## 3. Discontinuation & Cloud Status Analysis
- **Google Plugin for Eclipse (GPE)**: Officially decommissioned and retired by Google in **January 2018**. Google deleted the underlying Cloud Storage bucket (`commondatastorage.googleapis.com/eclipse_toolreleases`).
- **Cloud Deployment (`https://appengine.google.com`)**: The legacy App Engine Admin Console (`appengine.google.com`) referenced in Step 5 of the manual was shut down by Google and redirected to Google Cloud Console (`console.cloud.google.com`). Direct unauthenticated command-line deployments without a paid GCP billing project are no longer accepted by Google servers.
- **Offline Local Development Server**: The standalone **App Engine Java SDK local dev server** (`dev_appserver.cmd`) remains 100% functional offline! It emulates Datastore, Memcache, Task Queues, and HTTP endpoints locally without needing internet or cloud credentials.

---

## 4. Included Project Structure
The repository includes the complete generated project structure matching Figure in the manual:
```
HelloWorld/
├── src/
│   └── com/mkyong/
│       └── HelloWorldServlet.java
└── war/
    ├── index.html
    └── WEB-INF/
        ├── appengine-web.xml
        ├── web.xml
        └── logging.properties
```

---

## 5. Execution Workflow

### Method 1: Running with App Engine Java SDK Local Server (Command Line)
Once `appengine-java-sdk-1.8.9.zip` is downloaded and unzipped (via `download_all.ps1` or manual download):
```powershell
# Extract SDK to tools folder
Expand-Archive .\appengine-java-sdk-1.8.9.zip -DestinationPath .\sdk\

# Run the local development server on the HelloWorld project:
.\sdk\appengine-java-sdk-1.8.9\bin\dev_appserver.cmd --port=8888 .\HelloWorld\war
```

### Method 2: Running via Eclipse Kepler / Luna
1. Extract and launch Eclipse Kepler.
2. Ensure Java 8/7 JRE is selected in **Window** > **Preferences** > **Java** > **Installed JREs**.
3. Import the included `HelloWorld` folder: **File** > **Import** > **Existing Projects into Workspace**.
4. Right-click the project > **Run As** > **Web Application**.
5. Console output will display:
   ```
   INFO: The server is running at http://localhost:8888/
   INFO: The admin console is running at http://localhost:8888/_ah/admin
   ```
6. Open your web browser and navigate to:
   - Web application root: `http://localhost:8888/`
   - Servlet endpoint: `http://localhost:8888/helloworld`
   - Local administrative console: `http://localhost:8888/_ah/admin`

---

## 6. Compatibility & Lab Notes
- **Internet Required During Experiment**: **NO** for local development. Only required if attempting cloud deployment to Google Cloud Platform.
- **Java Version Warning**: Legacy App Engine Java SDK 1.8.x and Eclipse Kepler **require Java 7 or Java 8**. Running with modern Java (Java 17, 21, etc.) will fail with `UnsupportedClassVersionError` or reflection access violations. Always use JDK 8.
