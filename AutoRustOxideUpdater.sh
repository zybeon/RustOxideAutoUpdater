#!/bin/bash
#########
# START #
#########
echo "Starting . . ."
echo "Downloading Latest Oxide version info"
curl https://umod.org/games/rust/latest.json | jq .version > latestOxide.txt
if [ -f installedOxide.txt ]
then
  echo "installed.txt already exists, checking for update"
else
  touch installedOxide.txt
  echo "installed does not exist, created empty installed.txt"
fi

if cmp -s installedOxide.txt latestOxide.txt
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
cp latestOxide.txt installedOxide.txt
fi

exit
