#!/bin/bash
#############
## Prerequisites
#############
## https://www.npmjs.com/package/webrcon
## npm i webrconjs
#############

## Script install location
dir=/opt/RustOxideAutoUpdater

### Checking if script is already running
PIDFILE=$dir/updatecheck.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Job is already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi

### Server RCON variables
serverip=0.0.0.0 #ip of game server
serverport=28016
rconpass=ChangeME

### Variables
rustsend=$dir/rustrconsend.js
installed=$dir/installedOxide.txt
latest=$dir/latestOxide.txt
rustserver=~/rustserver ##Location of your lgsm rustserver script

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
 bash $rustserver m
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
sleep 20s
for ((i=10; i>=1; i--))
do
  node $rustsend "say Server restarting in $i seconds!!" ${serverip} ${serverport} ${rconpass}
  sleep 1s
done
node $rustsend "quit" ${serverip} ${serverport} ${rconpass}
## Waiting for server to save and start to shutdown, if conditional could be added to skip this step if it is a forced wipe day
echo "######## Waiting 30s for server to stop gracefully"
sleep 30s
# Later incorporate checking for first Thursday of the month to notify players server is force wiping. include wiping all command on that day 'rustserver wa'

echo "######## Shuting down server ########"
bash $rustserver sp
echo "######## Updating server ############"
bash $rustserver u
bash $rustserver mu
echo "######## Starting Server ############"
bash $rustserver st
echo "######## Rust, Oxide and installedOxide.txt has been updated"
cp $latest $installed
fi

rm $PIDFILE
exit 0
