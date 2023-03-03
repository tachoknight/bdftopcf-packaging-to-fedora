#!/bin/bash

MYDIR=$PWD

START_TS=`date`

SPEC_FILE=bdftopcf.spec

rm -rf $HOME/rpmbuild
rm $MYDIR/build-output.txt
mkdir -p $HOME/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp $PWD/*.patch $HOME/rpmbuild/SOURCES
cp $PWD/$SPEC_FILE $HOME/rpmbuild/SPECS

pushd $HOME/rpmbuild/SPECS
spectool -g -R ./$SPEC_FILE
# Get the dependencies
dnf builddep -y ./$SPEC_FILE
# Now do the actual build
rpmbuild -ba ./$SPEC_FILE 2>&1 | tee $MYDIR/build-output.txt
#rpmbuild -bc ./$SPEC_FILE 2>&1 | tee $MYDIR/build-output.txt
popd

echo Started:_____$START_TS
echo Ended:_______`date`
