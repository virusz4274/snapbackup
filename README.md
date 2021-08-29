# disclaimer
I reuploaded this script, i deleted old repo and reuploaded here.
I wrote this script very long time ago, it still works. 
There script is made using inefficient ways but it will  work as expected. 
This is  my first time writing a script

# snapbackup

This script allows a person to backup and restore their snaps.
Move snaps between distros or backup before reinstalling of  your linux distro
This script works on ubuntu where snap is stored in /var/lib/snapd
For other linux distribution with snap location  different you can change the SOURCEDIR variable on the  snapbackup.sh to  your snap location and for changing the DESTDIR variable on restoresnap.sh

# snapbackup.sh
This script does the following
  deletes existing snapshots
  create a folder named snapbackups where the script is placed
  copies  the snapshot to the snapbackups folder
  updates current snap packages to latest
  copies the snap packages to snapbackups folder
  downloads assert files for the snap packages that are backuped

#  restoresnap.sh
  This script  does the following
    installs the snap packages from the backup
    restores the copy of snapshots
    restores the snapshots 
    
    
#USAGE
run snapbackup.sh first
copy the snapbackups folder 
to restore
run restoresnap.sh
Thats it the snaps  are now  restored
Make sure the script and snapbackups folder are in  the same directory


  
