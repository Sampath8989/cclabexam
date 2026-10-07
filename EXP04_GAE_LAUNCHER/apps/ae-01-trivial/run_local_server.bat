@echo off
echo ==============================================================================
echo Experiment 04: Google App Engine Local Server Launcher
echo ==============================================================================

rem Check if GoogleAppEngine installation exists
if exist "C:\Program Files (x86)\Google\google_appengine\dev_appserver.py" (
    echo [*] Found Google App Engine SDK in default installation path.
    python "C:\Program Files (x86)\Google\google_appengine\dev_appserver.py" --port=8080 .
    goto end
)

if exist "C:\Program Files\Google\google_appengine\dev_appserver.py" (
    echo [*] Found Google App Engine SDK in 64-bit Program Files.
    python "C:\Program Files\Google\google_appengine\dev_appserver.py" --port=8080 .
    goto end
)

echo [!] Standalone GoogleAppEngine installation not detected in Program Files.
echo [*] Launching Python local HTTP simulation on port 8080 for verification:
python -c "import SimpleHTTPServer, SocketServer; Handler = SimpleHTTPServer.SimpleHTTPRequestHandler; httpd = SocketServer.TCPServer(('', 8080), Handler); print 'Serving HTTP on localhost port 8080...'; httpd.serve_forever()" 2>nul || python -m http.server 8080

:end
pause
