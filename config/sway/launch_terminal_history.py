import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')

# Saving the contents of history.txt to the ash_history file
subprocess.run(['cat' + '/' + team_name + '/' + workspace_name + '/temp/history.txt' + '>> ~/.ash_history'], shell=True)

# Reloading the ash_history file
subprocess.run(['source ~/.ash_history'], shell=True)
