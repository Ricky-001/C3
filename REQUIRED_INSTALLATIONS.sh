#!/bin/bash

apt-get install portaudio19-dev python-dev python3-dev
# dirname "$0" shows the current directory path of the script
# $0 is the name of the script itself - so it returns the current directory
python2 -m pip install -r $(dirname "$0")/modules.list

echo "[+] Basic environment has been setup!"
echo "Cleared to proceed!"
