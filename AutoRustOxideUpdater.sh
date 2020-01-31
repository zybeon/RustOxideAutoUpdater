#!/bin/bash
#########
# START #
#########
echo "Starting . . ."
echo "Downloading Latest Oxide version info"
latestOxide = "~/latestOxide.txt" 
installedOxide = "~/installedOxide.txt"
curl https://umod.org/games/rust/latest.json | jq .version > latestOxide

if -f installedOxide
then
  echo "installed.json already exists, checking for update"
else
  touch installedOxide
  echo "installed does not exist, created empty installed"
fi

if cmp -s installedOxide latestOxide
then 
 echo "No update required"
else
 echo "Starting Update, make sure your server is turned off before continuing!"
#######################
#Run Server Update here
#######################

#Run command to inform player there is a new client update
# and to exit to install. Later incorporate checking for
# first Thursday of the month to notify players server is
# wiping. include wiping all on that day 'rustserver wa'
bash ~/rustserver sp
bash ~/rustserver u
bash ~/rustserver ma
bash ~/rustserver st
echo "Rust, Oxide and installed.json has been updated"
cat latestOxide > installedOxide
fi

exit
