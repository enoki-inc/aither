import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')
filepath='/' + team_name + '/' + workspace_name + '/tmp/urls.txt'
# Read the urls.txt file and store the URLs in an array
if os.path.isfile(filepath):
    with open(filepath, 'r') as file:
        urls = file.readlines()

    subprocess.run(['firefox'] + urls)
