#!/bin/bash

# ASSUMPTION : ALL COMMANDS RUNWITHOUT  ERROR

# adds i386 (x86) architecture
dpkg --add-architecture i386 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] dpkg ran into an error while trying to add i386 architecture'
	echo '[**] Make sure dpkg is available'
	echo '[!] Exiting setup.'
	exit 1
fi


# updates repository list based on new architecture
apt-get update && apt-get upgrade -y 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] Could not update package lists using apt-get'
	echo '[**] Make sure you have apt package manager installed and available in your PATH'
	echo '     Or you are connected to the internet'
	echo '[!] Exiting setup.'
	exit 1
fi


# install wine32 (without prompts) - windows virtual env
apt-get install wine32 -y 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] Could not install wine32 using apt-get'
	echo '[**] Make sure you have apt package manager installed and available in your PATH'
	echo '     Or you are connected to the internet'
	echo '[!] Exiting setup.'
	exit 1
fi


# do any other necessary updates
apt-get upgrade -y 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] Could not upgrade packages using apt-get'
	echo '[**] Make sure you have apt package manager installed and available in your PATH'
	echo '     Or you are connected to the internet'
	echo '[!] Exiting setup.'
	exit 1
fi

# do any other necessary updates
apt-get clean -y 2> /dev/null
apt-get autoclean 2> /dev/null
apt-get autoremove -y 2> /dev/null
# Creates /.wine hidden folder serving as the virtual environment

# Installing required dependencies for other package files
# wget - to download python.msi for installing in Windows environment
# portaudio19-dev - for PyAudio module (sound recording)
# python-dev & python3-dev - python module dependencies and pip
apt-get install wget portaudio19-dev python-dev python3-dev 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] Could not install one or more dependencies using apt-get'
	echo '[*] Dependencies required:-'
	echo '1. wget'
	echo '2. python-dev   [requires Python2 installed]'
	echo '3. python3-dev  [requires Python3 installed]'
	echo '4. portaudio19-dev'
	echo '[**] Make sure you have apt package manager installed and available in your PATH'
	echo '     Or you are connected to the internet'
	echo '[!] Exiting setup.'
	exit 1
fi

# download https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi to install into the virtual env
wget -P $(dirname "$0") https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi 2> /dev/null
retval=$?
if [ $retval -ne 0 ]
then
	echo '[-] wget ran into an error and cannot download Python2.7'
	echo '[**] Make sure you are connected to the internet'
	echo '[!] Exiting setup.'
	exit 1
fi


# Python installation command - simple Windows command (/i to install)
wine msiexec /i "$(dirname "$0")/python-2.7.18.msi" /qn

# install PyInstaller for Wine Python27
wine /root/.wine/drive_c/Python27/python.exe -m pip install -r $(dirname "$0")/modules.list

# dirname "$0" shows the current directory path of the script
# $0 is the name of the script itself - so it returns the current directory
python2 -m pip install -r $(dirname "$0")/modules.list

echo "[+] Basic environment has been setup!"
echo "Cleared to proceed!"

