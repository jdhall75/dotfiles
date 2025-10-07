#!/bin/bash

BUILD_DIR=/tmp/tmux
DEST_DIR=/opt/tmux
DEPS="libevent-dev libncurses-dev wget build-essential git \
    ca-certificates autotools-dev automake pkg-config bison" 

sudo apt-get update \
&& sudo apt-get install $DEPS -y --no-install-recommends \
&& sudo rm -rf /var/lib/apt/lists/*

if [ -d $DEST_DIR ]; then
    sudo rm -fr $DEST_DIR
fi

git clone https://github.com/tmux/tmux --depth=1 $BUILD_DIR
cd $BUILD_DIR

sh autogen.sh \
    && ./configure --prefix $DEST_DIR \
    && make \
    && sudo make install

cd

rm -fr $BUILD_DIR

OMT_HOME=$HOME/.oh-my-tmux
if [ ! -d $OMT_HOME ]; then
    git clone --single-branch https://github.com/gpakosz/.tmux.git $OMT_HOME
fi
if [ ! -d $HOME/.config/tmux ]; then
    mkdir -p ~/.config/tmux
    ln -s $OMT_HOME/.tmux.conf ~/.config/tmux/tmux.conf
fi

