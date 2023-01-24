import subprocess
import os

team_name = os.getenv('TEAM_NAME')
workspace_name = os.getenv('WORKSPACE_NAME')

# Read the urls.txt file and store the URLs in an array
if os.path.isfile('/' + team_name + '/' + workspace_name + '/temp/urls.txt'):
    with open('/' + team_name + '/' + workspace_name + '/temp/urls.txt', 'r') as file:
        urls = file.readlines()

    subprocess.run(['firefox'] + urls)
