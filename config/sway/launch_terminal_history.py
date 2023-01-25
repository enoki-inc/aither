# Updates needed on subprocess command and saving command should probably use cp

import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')

# Saving the contents of history.txt to the ash_history file
subprocess.run(['cat ' + '/' + team_name + '/' + workspace_name + '/tmp/history.txt' + '

# Reloading the ash_history file
subprocess.run(['source ~/.ash_history'], shell=True)
