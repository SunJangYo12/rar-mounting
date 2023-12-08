#!/bin/bash
UNRAR_VERSION=6.2.1
RAR2FS_VERSION=1.29.5
WORKDIR=`mktemp -d` && cd $WORKDIR

# Get deps
sudo apt-get -q update
sudo apt-get -qy install make libfuse-dev g++

# Get, make and install unrar
wget https://www.rarlab.com/rar/unrarsrc-${UNRAR_VERSION}.tar.gz
tar zxvf unrarsrc-${UNRAR_VERSION}.tar.gz
cd unrar
make && sudo make install
make lib && sudo make install-lib
cd ..

# Get, make and install rar2fs
wget https://github.com/hasse69/rar2fs/releases/download/v${RAR2FS_VERSION}/rar2fs-${RAR2FS_VERSION}.tar.gz -O rar2fs-${RAR2FS_VERSION}.tar.gz
tar zxvf rar2fs-${RAR2FS_VERSION}.tar.gz
cd rar2fs-${RAR2FS_VERSION}
./configure --with-unrar=../unrar --with-unrar-lib=/usr/lib/
make && sudo make install
cd ..

cd ..

# Cleanup
rm -rf $WORKDIR
