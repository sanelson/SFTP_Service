#!/usr/bin/bash

# This script deploys the cloud-init configuration and then launches an Ubuntu VM on WSL2.

# Set up cloud-init configuration
USERPROFILE=`wslpath "$(powershell.exe '$env:USERPROFILE')" | tr -d '\r'`
mkdir -p "$USERPROFILE/.cloud-init"
cp wsl-cloud-init.yaml "$USERPROFILE/.cloud-init/Ubuntu-24.04.user-data"

# Install and start the Ubuntu VM
wsl.exe --install --distribution Ubuntu-24.04