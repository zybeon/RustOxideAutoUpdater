#!/bin/bash
#############
## Prerequisites
#############
## https://www.npmjs.com/package/webrcon
## npm i webrconjs
## 
#############

### Server RCON variables
serverip=127.0.0.1 #ip of game server
serverport=28016
serverrconpass=ChangeME 

#########
# START #
#########
echo "Starting . . ."
echo "Downloading Latest Oxide version info"
curl -s https://umod.org/games/rust/latest.json | jq .version > latestOxide.txt

if [ -f installedOxide.txt ]
then
  echo "installedOxide.txt already exists, checking for update"
else
  touch installedOxide.txt
  echo "installedOxide.txt does not exist, created empty installedOxide.txt"
fi

if cmp -s installedOxide.txt latestOxide.txt
then 
 echo "No update required"
else
 echo "New update is available!"
#######################
#Run Server Update here using webrcon.
#######################
node rustrconsend.js "say Server restart in 3 minutes!!\nRust Server Update is available.\nUpdate your client before reconnecting." ${serverip} ${serverport} ${rconpass}
sleep 1m
node rustrconsend.js "say Server restarting in 2 minute!!\nRust Server Update is available.\nUpdate your client before reconnecting." ${serverip} ${serverport} ${rconpass}
sleep 1m
node rustrconsend.js "say Server restarting in 1 minute!!\nRust Server Update is available.\nUpdate your client before reconnecting." ${serverip} ${serverport} ${rconpass}
sleep 30s
node rustrconsend.js "say Server restarting in 30 seconds!!\nRust Server Update is available.\nUpdate your client before reconnecting." ${serverip} ${serverport} ${rconpass}
sleep 25s
node rustrconsend.js "say Server restarting in 5 seconds!!\nRust Server Update is available.\nUpdate your client before reconnecting." ${serverip} ${serverport} ${rconpass}
sleep 5s
node rustrconsend.js "quit" ${serverip} ${serverport} ${rconpass}

# Later incorporate checking for first Thursday of the month to notify players server is wiping. include wiping all on that day 'rustserver wa'

bash ~/rustserver sp
bash ~/rustserver u
bash ~/rustserver ma
bash ~/rustserver st
echo "Rust, Oxide and installedOxide.txt has been updated"
cp latestOxide.txt installedOxide.txt
fi

exit
