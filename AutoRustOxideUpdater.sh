#!/bin/bash
#############
## Prerequisites
#############
## https://www.npmjs.com/package/webrcon
## npm i webrconjs
#############

### Server RCON variables
serverip=0.0.0.0 #ip of game server
serverport=28016
rconpass=ChangeME

### Variables
rustsend=/opt/RustOxideUpdater/rustrconsend.js
installed=/opt/RustOxideUpdater/installedOxide.txt
latest=/opt/RustOxideUpdater/latestOxide.txt

#########
# START #
#########
echo "Starting . . ."
echo "Downloading Latest Oxide version info"
curl -s https://umod.org/games/rust/latest.json | jq .version > $latest

if [ -f $installed ]
then
  echo "installedOxide.txt already exists, checking for update"
else
  touch $installed
  echo "installedOxide.txt does not exist, created empty installedOxide.txt"
fi

if cmp -s $installed $latest
then
 echo "No update required"
else
 echo "New update is available!"
#######################
#Run Server Update here using webrcon.
#######################
node $rustsend "say Server restart in 3 minutes!! Rust Server Update is available. Update your Client before reconnecting" ${serverip} ${serverport} ${rconpass}
echo "Sleeping for 3m"
sleep 1m
node $rustsend "say Server restarting in 2 minutes!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 1m
node $rustsend "say Server restarting in 1 minute!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 30s
node $rustsend "say Server restarting in 30 seconds!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 24s
node $rustsend "say Server restarting in 5 seconds!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 1s
node $rustsend "say Server restarting in 4 seconds!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 1s
node $rustsend "say Server restarting in 3 seconds!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 1s
node $rustsend "say Server restarting in 2 seconds!! Rust Server Update is available." ${serverip} ${serverport} ${rconpass}
sleep 1s
node $rustsend "say Server restarting in 1 second!! Rust Server Update is available. Update your client before reconnecting." ${serverip} ${serverport} ${rconpass}
node $rustsend "quit" ${serverip} ${serverport} ${rconpass}
echo "######## Waiting for server to stop gracefully"
sleep 30s
# Later incorporate checking for first Thursday of the month to notify players server is wiping. include wiping all on that day 'rustserver wa'

echo "######## Shuting down server ########"
bash ~/rustserver sp
echo "######## Updating server ############"
bash ~/rustserver u
bash ~/rustserver mu
echo "######## Starting Server ############"
bash ~/rustserver st
echo "######## Rust, Oxide and installedOxide.txt has been updated"
cp $latest $installed
fi

exit
