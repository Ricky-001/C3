
# REVERSE_SHELL AND HANDLER 


------------------------------------------------------------------------------------------------------------------------------------------------

## Update for the Sainya Ranakshetram Level III SDR Challenge
The included EXE file has been created during the demonstration, where the target and the attacker machine were part of the same 192.168.0.X network
* The EXE file will work unmodified if used in a similar environment with the attacker machine bearing Local IP address of 192.168.0.104

To execute in a clean environment:- 
* The attacker machine is supposed to run a Linux environment (Debian distro), where the REQUIRED_INSTALLATIONS.sh and C3.sh scripts can be run in order to set up the exploit EXE for a Windows based target.
* For a Windows attacker, the system must support Python and Pyinstaller, with the respective dependencies from modules.list available. Thereafter, the exploit binary can be created with the command given in C3.sh lines 101, 102, 103

------------------------------------------------------------------------------------------------------------------------------------------------

1) handler.py HANDLES THE CONTROLS OF THE PAYLOAD
2) CORRESPONDING reverse_shell.py SCRIPT
3) DEPENDEDNT AND INCLUDED SCRIPTS - keyLogger.py ; soundRecorder.py

* This set of scripts - the handler; Command and Control Center (C3) along with its reverse shell (and other dependednt utility scripts) allows a basic remote connection to a target machine

* C3.py is the controller - to be deployed on the attacker machine
* reverse_shell.py - "Online_Safety_Guide.png.exe" is the payload (to be injected into the victim machine and needs to be run by the user)

------------------------------------------------------------------------------------------------------------------------------------------------

# MANDATORY REQUIREMENTS:-

* python2.7

PYTHON MODULE DEPENDENCY LIST:-

	> socket
	> termcolor
	> os
	> sys
	> json
	> base64
	> subprocess
	> datetime
	> time
	> shutil
	> threading
	> requests
	> mss (4.0.2)
	> PyAudio
	> wave
	> Pynput

* A 'modules.list' file has been provided for easy installation of the python modules through pip
* A "REQUIRED_INSTALLATIONS.sh" file has been provided to automate setting up the required dependencies, like 
	- Python2
	- All required packages 
	- And their corresponding dependencies
* This script can be run prior to running the original script as a one-time setup of the environment.

------------------------------------------------------------------------------------------------------------------------------------------------


- Once connected, the handler replicates a CLI of the victim machine
- Command Line/ Terminal/ Shell commands can be issued from this handler CLI to be executed in the compromised victim machine

- The handler can also UPLOAD (INJECT FILES FROM ATTACKER MACHINE TO VICTIM)
- or DOWNLOAD (PULL FILES FROM VICTIM TO ATTACKER) files to and from the victim machine
* (relevant commands can be seen by issuing the HELP command)


- Once connected, the attacker gains access to the victim machine and can carry out the following:-
	* Recording audio from Microphone
	* Capturing image/ video from the Default Webcam
	* Log keystrokes (keylogger)
	* Taking a screenshot of the victim's current screen

-> These records can then be sent back to the attacker machine

- To get a full list of possible commands that can be issued, the handler can issue the HELP command
	- Note that this overrides the command line 'help' command available in most systems.

------------------------------------------------------------------------------------------------------------------------------------------------

* The complete usage guides are provided in the USAGE GUIDES directory
* PLEASE START WITH READING THE "README_FIRST.txt" FILE AND PROCEED AS INSTRUCTED
* Most of the process has been automated with a self explanatory bash script C3.sh, which takes care of executing the handler code and creating the payload based on a pre-defined rule.
* Once the script confirms that the payload has been created, it can be injected into the victim machine via various Social Engineering techniques.
