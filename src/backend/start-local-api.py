import subprocess
import os

if __name__ == '__main__':
    os.chdir('src')
    command = 'sam local start-api'
    process = subprocess.run(command, shell=True, capture_output=True, text=True)
    print('stdout:' + process.stdout)
    print('stderr:' + process.stderr)