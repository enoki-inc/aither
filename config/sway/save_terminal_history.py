import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')

subprocess.run(['history', '-a', '>', '/' + team_name + '/' + workspace_name + '/temp/history.txt'])
