import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')

# Saving the contents of history.txt to the ash_history file
save_command = "cp " + '/' + team_name + '/' + workspace_name + '/tmp/history.txt ' + '~/.ash_history'
subprocess.run([save_command], shell=True)

# Reloading the ash_history file

subprocess.run(['history -a'], shell=True)
subprocess.run(['history -r'], shell=True)
