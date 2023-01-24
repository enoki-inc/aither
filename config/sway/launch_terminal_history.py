import subprocess

# Saving the contents of history.txt to the ash_history file
subprocess.run(['cat history.txt >> ~/.ash_history'], shell=True)

# Reloading the ash_history file
subprocess.run(['source ~/.ash_history'], shell=True)

