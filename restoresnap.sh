#!/bin/bash
#defining directories
PWD=$(pwd)
DESTDIR=/var/lib/snapd
SOURCEDIR=$PWD/snapbackups
echo "dont worry about the errors"
echo "classic snaps will be installed"
input="$SOURCEDIR/snapsinstall_list.txt"
while IFS= read -r line
do
  cd $SOURCEDIR/snaps
  sudo $line
done < "$input"
echo "installing snaps with --classic"
input="$SOURCEDIR/snapsinstall_list.txt"
while IFS= read -r line
do
  cd $SOURCEDIR/snaps
  sudo $line --classic
done < "$input"
sudo rm -rf $DESTDIR/snapshots
echo "copying snapshots"
sudo cp -a $SOURCEDIR/snapshots/. $DESTDIR/snapshots/
sudo chown -R root $DESTDIR
echo "restore your snapshot manually"
echo  "snap saved"
SET=$(snap saved | awk 'FNR==2{print $1}')
sudo snap restore $SET
