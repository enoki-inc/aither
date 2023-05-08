import os
import subprocess

port = os.getenv("SSH_PORT")
user = os.getenv("SSH_USER")
ngrok_num = os.getenv("SSH_NGROK_NUM")

if port is not None and user is not None and ngrok_num is not None:
    command = 'ssh -p ' + port + ' ' + user + '@' + ngrok_num +'.tcp.ngrok.io'
    subprocess.run([command], shell=True)

else:
    print("Environment variables for locall ssh are not set")