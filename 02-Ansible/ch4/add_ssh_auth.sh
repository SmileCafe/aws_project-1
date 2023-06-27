#! /usr/bin/env bash

# Creating SSH Key
sshpass -p vagrant ssh -T -o StrictHostkeyChecking=no vagrant@192.168.56.11
sshpass -p vagrant ssh -T -o StrictHostkeyChecking=no vagrant@192.168.56.12
sshpass -p vagrant ssh -T -o StrictHostkeyChecking=no vagrant@192.168.56.13