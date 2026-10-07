#!/usr/bin/env python
"""
Experiment 06: Method 4 Alternate - Simple Local HTTP File Transfer Server
Compatible with Python 2.7 and Python 3.x.
Run this script inside the source VM to share files; open http://<source_vm_ip>:8000/ on the target VM.
"""
import sys

PORT = 8000

if sys.version_info[0] < 3:
    import SimpleHTTPServer
    import SocketServer
    Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
    httpd = SocketServer.TCPServer(("", PORT), Handler)
else:
    import http.server
    import socketserver
    Handler = http.server.SimpleHTTPRequestHandler
    httpd = socketserver.TCPServer(("", PORT), Handler)

print("[*] Serving local files on port %d..." % PORT)
print("[*] On the target virtual machine, access: http://<this_vm_ip>:%d" % PORT)
print("[*] Or download via curl/wget: wget http://<this_vm_ip>:%d/<filename>" % PORT)
print("[*] Press Ctrl+C to stop.")

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    print("\n[*] Server stopped.")
    httpd.server_close()
