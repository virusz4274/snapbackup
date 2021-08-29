#!/bin/bash
#defining directories
PWD=$(pwd)
SOURCEDIR=/var/lib/snapd
DESTDIR=$PWD/snapbackups
echo "deleting old snap saves"
sudo  rm -r $SOURCEDIR/snapshots/
#deleting  backup folder
echo "deleting old snap backups"
sudo rm -r $DESTDIR
#creating directories
echo "creating directories at user home named snapbackups"
mkdir $PWD/snapbackups
#removing local install snap files
echo "removing local snap files from snap directory"
sudo rm -r $SOURCEDIR/snaps/.local-*

read -p "You need to have latest snap packages in order to work. This is going  to update all snap packages. Press Enter to continue" -n 1 -r
echo    # (optional) move to a new line
#snap refresh
echo "updating snap packages to latest version"
sudo snap refresh
echo "backing up snap packages"
sudo cp -a $SOURCEDIR/snaps/. $DESTDIR/snaps/
#list of snaps  to  download assert for
echo "taking  list of snaps"
snap list | awk '{print $1}' > $DESTDIR/raw.txt
#removing first line from txt file
awk NR\>1 $DESTDIR/raw.txt > $DESTDIR/snapslist.txt
echo "fetching asserts"
input="$DESTDIR/snapslist.txt"
while IFS= read -r line
do
  cd $DESTDIR/snaps
  sudo snap download $line > $DESTDIR/raw.txt
  awk NR\>3 $DESTDIR/raw.txt > $DESTDIR/install.txt
  awk '{print}' $DESTDIR/install.txt >> $DESTDIR/snapsinstall_list.txt
done < "$input"
input="$DESTDIR/snapsinstall_list.txt"
sudo chown -R $USER $DESTDIR


#taking snap snapshot
echo "saving snaps"
sudo snap save
echo "backing up snapshots"
sudo cp -a $SOURCEDIR/snapshots/. $DESTDIR/snapshots/
sudo chown -R $USER $DESTDIR
