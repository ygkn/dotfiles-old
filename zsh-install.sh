#!/bin/bash
if [ ! ${EUID:-${UID}} = 0 ]; then
    echo "Please run in SuperUser."
    exit
fi

apt-get install zsh

echo "Please type to use shell." 
cat /etc/shells

chsh

echo "You need log out or reboot."
echo -n "Do you want to reboot? [y/n]"
read ans
if [ ${ans} = y ];then
    reboot
fi
