#!/bin/sh
rm /opt/brcm-arm
mkdir /data
cd /data
git clone https://bitbucket.org/jackysi/advancedtomato-arm.git
cd /data/advancedtomato-arm/release/src-rt-6.x.4708
git clean -dfx && git checkout .
ln -s /data/advancedtomato-arm/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
echo "To compile, do something like:"
echo "make dir868l V1=VZPRVPN V2=2.6-XXX"
echo ""
echo "But first, if you didn't make it yet:"
echo 'echo "export PATH=$PATH:/opt/brcm-arm/bin:/sbin/" >> ~/.profile && source ~/.profile'
