import subprocess
import os

# Read the urls.txt file and store the URLs in an array
if os.path.isfile("/Users/sergionahas/enoki/storage/urls.txt"):
    with open("/Users/sergionahas/enoki/storage/urls.txt", "r") as file:
        urls = file.readlines()

    subprocess.run(['firefox'] + urls)