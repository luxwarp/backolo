#!/bin/bash

# Itilialize global variables.
APPNAME="backolo"
APPVERSION=0.0.1
RUNLOG="./$APPNAME-run.log"  # Log file for script run creates in same folder as script is running from. resets on new run.

backupdest="/$APPNAME-backups"
backupname="backup"
excludes="$backupdest"
includes="/"
backuplog="$backupdest/$backupname-$(date "+%F-%H-%M-%S").log"

# Function for logging to scripts run log.
logger() {
  echo "$(date "+%F-%H-%M-%S") : $1" >> $RUNLOG
}

# Reset and initialize run log file
echo "Initialize log">$RUNLOG

logger "Starting $APPNAME"

# Clearing terminal
clear

# Printing 'interface'
echo -e "\e[1;36m#\e[0m"
echo -e "\e[1;36m# $APPNAME v$APPVERSION\e[0m"
echo -e "\e[1;36m#\e[0m"

# Check if running with sudo or root priviliges.
if [ $UID != 0 ]; then
  echo -e "\e[1;31mNeeds to be running with sudo or as root.\e[0m"
  echo -e "Quiting"
  logger "No sudo or root privileges"
  exit 1
fi

# function for checking if a command got error if so print out custom error message and logg.
checkError() {
  if [ $2 -gt 0 ]; then
    echo -e "\e[1;31m$1\e[0m"
    logger "$1"
    exit $2
  fi
}

# Checks if backup destination folder exists.
if [ ! -d $backupdest ]; then
  echo -e "\e[1;33mBackup destination folder '$backupdest' does not exist. Creating it now.\e[0m"
  logger "Backup destination folder '$backupdest' does not exist. Creating it now."
  mkdir -p $backupdest 2>/dev/null
  checkError "Could not create folder '$backupdest'" $?
fi

# print some information about the backup that is goind to start.
echo -e "\e[1;32mBackup destination folder is: '$backupdest'\e[0m"
logger "Backup destination folder is: '$backupdest'"

echo -e "\e[1;33mFollowing files and folders will be excluded from the backup: $excludes\e[0m"
logger "Following files and folders will be excluded from backup: $excludes"

echo -e "\e[1;33mFollowing files and folders will be included in the backup: $includes\e[0m"
logger "Following files and folders will be included in the backup: $includes"

# Ask user to start backup.
echo -e "\e[1;36mReady to start the backup? Y/n\e[0m"
read confirm

if [[ $confirm != "Y" ]]; then
  checkError "Aborted by user, no backup created" 1
fi

# Start the backup.
echo "Backup starts in 10 seconds. Abort with CTRL+C"
sleep 10 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  sleep 1
  echo -en "\b${sp:i++%${#sp}:1}"
done

echo -e "\n\e[1;36mBackup is running. Please hold!\e[0m"
logger "Backup started"
sleep 2
tar -cvpzf $backupdest/$backupname-$(date "+%F-%H-%M-%S").tar.gz --exclude=$excludes --one-file-system $includes 2>&1 | tee $backuplog

# Backup is complete.
echo -e "\n\e[1;32m#\e[0m"
echo -e "\e[1;32m# Backup is complete. Listing backup files below.\e[0m"
echo -e "\e[1;32m#\e[0m"
logger "Backup complete"

echo -e "\n\e[1;33mBackup destination folder is: '$backupdest'\e[0m"
ls -lh $backupdest

exit 0