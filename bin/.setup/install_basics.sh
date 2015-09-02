#!/bin/bash
cd ~/bin
# Install ack
unlink ack
curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 !#:3
# Install text-adept
unlink ta
curl http://foicica.com/textadept/download/textadept_LATEST.x86_64.tgz | tar xz
ln -s ./textadept_*/textadeptjit-curses ta
