#!/bin/sh
sh -c "ls"
sh -c "cd /root/"
sh -c "mkdir /root/test"
sh -c "cd /root/test"
sh -c "mount -t nfs 10.0.5.86:/root/.kube/ /root/test"
