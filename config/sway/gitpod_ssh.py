import os
import subprocess

gitpod = os.getenv("GITPOD_SSH_CMD")

if gitpod is not None:
    subprocess.run([gitpod], shell=True)

else:
    print("Environment variables for Gitpod command not set")