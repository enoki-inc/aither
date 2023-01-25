import os
import subprocess

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')
filepath = '/' + team_name + '/' + workspace_name + '/tmp/history.txt'
command = "cp ~/.ash_history " + filepath

if not os.path.exists(os.path.dirname(filepath)):
    os.makedirs(os.path.dirname(filepath), exist_ok=True)

#shutil.copyfile("~/.ash_history", filepath)
subprocess.run([command], shell=True)
